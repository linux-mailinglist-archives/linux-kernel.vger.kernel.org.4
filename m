Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6164FEF4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 14:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiLRNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 08:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiLRNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 08:11:17 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA98B21AF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 05:11:15 -0800 (PST)
Received: from dslb-178-004-201-210.178.004.pools.vodafone-ip.de ([178.4.201.210] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p6tRa-0006i3-Gw; Sun, 18 Dec 2022 14:11:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Alpine: add missing of_node_put call
Date:   Sun, 18 Dec 2022 14:10:26 +0100
Message-Id: <20221218131025.394179-1-martin@kaiser.cx>
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

Add a missing of_node_put call in function alpine_cpu_pm_init.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only, I don't have this hardware

 arch/arm/mach-alpine/alpine_cpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
index 13ae8412e9ce..fc5b9732ccb7 100644
--- a/arch/arm/mach-alpine/alpine_cpu_pm.c
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -50,6 +50,7 @@ void __init alpine_cpu_pm_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "al,alpine-cpu-resume");
 	al_cpu_resume_regs = of_iomap(np, 0);
+	of_node_put(np);
 
 	wakeup_supported = !IS_ERR(al_sysfabric) && al_cpu_resume_regs;
 
-- 
2.30.2

