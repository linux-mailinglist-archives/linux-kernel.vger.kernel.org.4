Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9973412B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjFQNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3810FE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BA960C4E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EB6C433C8;
        Sat, 17 Jun 2023 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687008073;
        bh=Q+/MaNb9NjJqu/qD/8ir2QEc9bYxenlvnj0Sb209bl4=;
        h=From:To:Cc:Subject:Date:From;
        b=WWZmgbFcqSGe4RdMt/6EoAjh2pX4SGmd++uTNfeaTGx706C8fUSYGVoN2z5CJE75Y
         rOrQ93UEclzD2XhbrIyir1wJGZOw2CgqdvJs01kQWHfc8grm/HH6tVD88VbZxceTwc
         +Y1zP3J71PdC1fhntjjht14XWdX4zDxbuHb2DCRKjn75kYFm+U+E/AAyxHO6gUy1q5
         oSfHSqEhgUXJlxHPsppaC6RVSzs+NYTvZcnkcmDdJy6s5gJPGdcuc9gJVBsWzsnPPx
         Kid2Ir1eY2g45ubZokrA62W5GONdihNRgq2fBdb+LeG7meuPgqN7R+FMye2pS/4cQq
         K5QIJtbSubKIw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: fix & improve driver statistics
Date:   Sat, 17 Jun 2023 21:09:41 +0800
Message-Id: <20230617130943.2776-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

improve the stmmac driver statistics:

1. don't clear network driver statistics in .ndo_close() and
.ndo_open() cycle
2. avoid some network driver statistics overflow on 32 bit platforms
3. use pcpu statistics where necessary to remove frequent cacheline
ping pongs.

Since v1:
  - rebase on net-next
  - fold two original patches into one patch
  - fix issues found by lkp
  - update commit msg

Jisheng Zhang (2):
  net: stmmac: don't clear network statistics in .ndo_open()
  net: stmmac: use pcpu 64 bit statistics where necessary

 drivers/net/ethernet/stmicro/stmmac/common.h  |  54 +++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  15 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   7 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  13 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  10 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  13 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  12 +-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  15 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 101 +++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 190 +++++++++++++-----
 13 files changed, 305 insertions(+), 166 deletions(-)

-- 
2.40.1

