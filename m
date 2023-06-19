Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68C735CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFSRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFSRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C510C4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3289B60E55
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153AAC433C0;
        Mon, 19 Jun 2023 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687194224;
        bh=kZcG68CKxsF0yfm9NzXeng4kRKcnmTVTpToRWIdUohQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SbzA+ryt2mcqUhfBIGRUperz+RWLFvNbD4pn26hux6htCBKOPgyTdJ4+R/BjqdgIh
         1n8xFzLKDfA2RGRFwHVu+/DZ1e5VyxbjeJHQQ93/nRaUu9UJkz9OBtU3oxI1N6nHm7
         7wChsSxoA2pd20L7rcgzOp/aEoZoy9b/QZhmwxp2/DB5wjGEsfas2zCqLZoP6qv0Sn
         PdFUMyQcxOclIgdNhIpGXE1XEC3wfblY0LR72hR4qkKcfgi1YG7bC4vezTHIPb09rD
         Vx5tm4owkbVIIHI2s6qWtVLa7CoFVn54R9XCUEbUGtSUs2SrTS3ffB6O/kygjSs2EG
         /AgMeU2YU+kiA==
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
Subject: [PATCH net-next v3 0/2] net: stmmac: fix & improve driver statistics
Date:   Tue, 20 Jun 2023 00:52:18 +0800
Message-Id: <20230619165220.2501-1-jszhang@kernel.org>
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

NOTE: v1 and v2 are back ported from an internal LTS tree, I made
some mistakes when backporting and squashing. Now, net-next + v3
has been well tested with 'ethtool -s' and 'ip -s link show'.

Since v2:
  - fix ethtool .get_sset_count, .get_strings and per queue stats
    couting.
  - fix .ndo_get_stats64 only counts the last cpu's pcpu stats.
  - fix typo: s/iff/if in commit msg.
  - remove unnecessary if statement brackets since we have removed
    one LoC.

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
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  16 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  10 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  13 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  20 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  12 +-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  15 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 108 +++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 190 +++++++++++++-----
 13 files changed, 312 insertions(+), 169 deletions(-)

-- 
2.40.1

