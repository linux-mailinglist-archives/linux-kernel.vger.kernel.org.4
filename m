Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD66F7372
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEDTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjEDTnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02847900D;
        Thu,  4 May 2023 12:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A7A663718;
        Thu,  4 May 2023 19:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF8C4339C;
        Thu,  4 May 2023 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229350;
        bh=AOFh1WhfR4xsMJ/bfPiml5mDJj6P2fKPo6om/hQdRh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU23oHb2yVWXAQm9vgd9i0Reo2ltlX1a0LPSD8jNpYb2fBpU3yU87mjoaCUglzYT+
         0JurWF5Zx7PI3xUE7Km9v/xzUQ9p4kvSGYnIC0FNfpfGAMFxgKrQyMMyMUYxUCwpVK
         7N1zr6vg0nDv1Fqtd6Jmm16h13+Hn3hLDdL0qJszLPQQUKSpao6oOZLcKFN4zbRFXU
         UMPfVLaAknOkgxNOjWYOhEhdt2hjkSLq4SXB7yl2WFU2IvN7XIbILDcoL4rMxHn0r6
         IWbQGHMDjPqwljcNMrbAUNbSfKmDeAEpUpKE1gBzVce4tTDAgwG1wPq44fD81a3z2P
         TWXX1hqOnQNCw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, ndesaulniers@google.com,
        mkl@pengutronix.de, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 15/59] net: pasemi: Fix return type of pasemi_mac_start_tx()
Date:   Thu,  4 May 2023 15:40:58 -0400
Message-Id: <20230504194142.3805425-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit c8384d4a51e7cb0e6587f3143f29099f202c5de1 ]

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  drivers/net/ethernet/pasemi/pasemi_mac.c:1665:21: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          .ndo_start_xmit         = pasemi_mac_start_tx,
                                    ^~~~~~~~~~~~~~~~~~~
  1 error generated.

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int'. Adjust the return type of
pasemi_mac_start_tx() to match the prototype's to resolve the warning.
While PowerPC does not currently implement support for kCFI, it could in
the future, which means this warning becomes a fatal CFI failure at run
time.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Link: https://lore.kernel.org/r/20230319-pasemi-incompatible-pointer-types-strict-v1-1-1b9459d8aef0@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index aaab590ef548d..ed7dd0a042355 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1423,7 +1423,7 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 	write_dma_reg(PAS_DMA_TXCHAN_INCR(txring->chan.chno), 2);
 }
 
-static int pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pasemi_mac * const mac = netdev_priv(dev);
 	struct pasemi_mac_txring * const txring = tx_ring(mac);
-- 
2.39.2

