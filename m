Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4E5F8AC4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJIKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJIKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:49:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C47310FE2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:49:56 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id hTsWoW2X5OizNhTsWoCyhu; Sun, 09 Oct 2022 12:49:54 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Oct 2022 12:49:54 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/sysdev: Remove some duplicate prefix in some messages
Date:   Sun,  9 Oct 2022 12:49:50 +0200
Message-Id: <7b8b5915a2c7c1616b33e8433ebe0a0bf07070a2.1665312579.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of the file, we have:
   #define pr_fmt(fmt) "xive: " fmt

So, there is no need to duplicate "XIVE:" in debug and error messages.

For the records, these useless prefix have been added in commit
5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt
controller")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/sysdev/xive/native.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 3925825954bc..19d880ebc5e6 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -535,13 +535,13 @@ static bool __init xive_parse_provisioning(struct device_node *np)
 static void __init xive_native_setup_pools(void)
 {
 	/* Allocate a pool big enough */
-	pr_debug("XIVE: Allocating VP block for pool size %u\n", nr_cpu_ids);
+	pr_debug("Allocating VP block for pool size %u\n", nr_cpu_ids);
 
 	xive_pool_vps = xive_native_alloc_vp_block(nr_cpu_ids);
 	if (WARN_ON(xive_pool_vps == XIVE_INVALID_VP))
-		pr_err("XIVE: Failed to allocate pool VP, KVM might not function\n");
+		pr_err("Failed to allocate pool VP, KVM might not function\n");
 
-	pr_debug("XIVE: Pool VPs allocated at 0x%x for %u max CPUs\n",
+	pr_debug("Pool VPs allocated at 0x%x for %u max CPUs\n",
 		 xive_pool_vps, nr_cpu_ids);
 }
 
-- 
2.34.1

