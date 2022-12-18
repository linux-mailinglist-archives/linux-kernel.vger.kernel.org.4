Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D99264FEE9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 14:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLRNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 08:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 08:00:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D010F6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 05:00:55 -0800 (PST)
Received: from dslb-178-004-201-210.178.004.pools.vodafone-ip.de ([178.4.201.210] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p6tHV-0006ch-5i; Sun, 18 Dec 2022 14:00:41 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: actions: add missing of_node_put calls
Date:   Sun, 18 Dec 2022 14:00:21 +0100
Message-Id: <20221218130022.393749-1-martin@kaiser.cx>
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

Add the missing of_node_put calls in function s500_smp_prepare_cpus.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only, I don't have this hardware

 arch/arm/mach-actions/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index f26618b43514..9fe9a0bd0fd0 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -103,6 +103,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	timer_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!timer_base_addr) {
 		pr_err("%s: could not map timer registers\n", __func__);
 		return;
@@ -115,6 +116,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	sps_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!sps_base_addr) {
 		pr_err("%s: could not map sps registers\n", __func__);
 		return;
@@ -128,6 +130,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		scu_base_addr = of_iomap(node, 0);
+		of_node_put(node);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
 			return;
-- 
2.30.2

