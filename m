Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29C7304E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjFNQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjFNQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC41FF5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 221DE61868
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BFC433C8;
        Wed, 14 Jun 2023 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760209;
        bh=9llC9DY9BE1LH+xc2pnl/22XEd3kSEENXwtBayoRpmc=;
        h=From:To:Cc:Subject:Date:From;
        b=Fnq/3Nj4MccrkPzv3Rq/CX3+iFa7JOQNucgcVaZ391g94TPoDfPbOxu6HRJquclaF
         nj/Rn8QMm+L+klMX8LFuwwsCcLyMWfPMyWDCJbDaxe5uUDr8Ftm8dksbP4M+LMRVhs
         pYNLBDGTt24/m+eKyUAuDVDcQXT+wavNLkvybREsquzx/IHQ7nmZSxnTpB7jkluVPG
         v5LIE6KhNkXhG6ih0rPOUHFykTdBAEFULWkxdzuuQeJEsxRVtdsr6SOHY+pKxuZdtM
         s3JEAGXFOJ6MvSlznDY6hb8PeFwPBTuRlonB8JNYzWJ2TiL4TzK4lxVQT6mg72eyGU
         gn4vGFfOPvLCg==
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
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] net: stmmac: fix & improve driver statistics
Date:   Thu, 15 Jun 2023 00:18:44 +0800
Message-Id: <20230614161847.4071-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch1 and patch2 fix two issues in net driver statistics:
1. network driver statistics are cleared in .ndo_close() and
.ndo_open() cycle
2. some network driver statistics overflow on 32 bit platforms

patch3 use pcpu statistics where necessary to remove frequent
cacheline ping pongs.

Jisheng Zhang (3):
  net: stmmac: don't clear network statistics in .ndo_open()
  net: stmmac: fix overflow of some network statistics
  net: stmmac: use pcpu statistics where necessary

 drivers/net/ethernet/stmicro/stmmac/common.h  |  54 +++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  15 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   7 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  13 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  10 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   9 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  12 +-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  15 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 100 ++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 190 +++++++++++++-----
 13 files changed, 304 insertions(+), 164 deletions(-)

-- 
2.40.1

