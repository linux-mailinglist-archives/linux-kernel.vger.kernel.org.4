Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFB6166FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKBQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiKBQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF42C662
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05CD1615A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45C7C433D6;
        Wed,  2 Nov 2022 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667404968;
        bh=cE8J5RGm2uXZylqKvBQig6sjIS1V9gX8rCNrulN+Ugw=;
        h=From:To:Cc:Subject:Date:From;
        b=ittyk1S/pCbtLTEwA1WG8/9J37IKVTfkkHUoRwy/OZQP0pwtJzF3i9d5AAjR/8oUm
         PcpkNLB74BuQU+LY8wpeaRHJut7XJEwD0uCGYnlEXzRo8QeX8lU0zanAIo6g6J2WVj
         Gx3qL4yx6kKICEMwcriT/DJjQpkp/SzgLEd+Xtz9ZvfMJm26yV4QvwNGR4MMGwiUz2
         RccoJAuM9VEKs0e4nZu7E0bBszQXyDjUd0ft3NLqCkR1GSh/zEOjVvTHaylUkqkNev
         UffjNZAs1mSWO9iol1yVVEjtzEvqRu7FBLOF0r0yl0a/sVHrZkNQ7qot+wf4zLifU1
         BCS1bL3BJiFkQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] HSI: ssi_protocol: Fix return type of ssip_pn_xmit()
Date:   Wed,  2 Nov 2022 09:02:33 -0700
Message-Id: <20221102160233.4042756-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
proposed warning in clang aims to catch these at compile time, which
reveals:

  drivers/hsi/clients/ssi_protocol.c:1053:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          .ndo_start_xmit = ssip_pn_xmit,
                            ^~~~~~~~~~~~
  1 error generated.

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int'. Adjust the return type of ssip_pn_xmit() to
match the prototype's to resolve the warning and CFI failure.
Additionally, use the enum 'NETDEV_TX_OK' instead of a raw '0' for the
return value of ssip_pn_xmit().

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 274ad8443f8c..38e572faff43 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -968,7 +968,7 @@ static void ssip_xmit_work(struct work_struct *work)
 	ssip_xmit(cl);
 }
 
-static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev->dev.parent);
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
@@ -1027,7 +1027,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return 0;
+	return NETDEV_TX_OK;
 drop2:
 	hsi_free_msg(msg);
 drop:
@@ -1035,7 +1035,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 inc_dropped:
 	dev->stats.tx_dropped++;
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 /* CMT reset event handler */

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.1

