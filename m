Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0964FF10
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiLROLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLROLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:11:19 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25960C3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:11:18 -0800 (PST)
Received: from dslb-178-004-201-210.178.004.pools.vodafone-ip.de ([178.4.201.210] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p6uNa-00077a-1g; Sun, 18 Dec 2022 15:11:02 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Wei Xu <xuwei5@hisilicon.com>, Russell King <linux@armlinux.org.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: hisi: add missing of_node_put calls
Date:   Sun, 18 Dec 2022 15:10:29 +0100
Message-Id: <20221218141028.394543-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A node that is returned by of_find_compatible_node has its refcount
incremented. We have to call of_node_put when the node is no longer
needed.

For hip04_smp_init, the easiest option is to call of_node_put for all
nodes at the end of the function. If we jump to the end of the function
because of an error, unused local np... pointers are NULL by default
and of_node_put(NULL) just returns.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only, I don't have this hardware

 arch/arm/mach-hisi/platmcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 258586e31333..e4be6da07242 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -341,6 +341,9 @@ static int __init hip04_smp_init(void)
 err_reloc:
 	memblock_phys_free(hip04_boot_method[0], hip04_boot_method[1]);
 err:
+	of_node_put(np);
+	of_node_put(np_sctl);
+	of_node_put(np_fab);
 	return ret;
 }
 early_initcall(hip04_smp_init);
-- 
2.30.2

