Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D486C0328
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCSQdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCSQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:32:59 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB281EFE3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:32:35 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id a13so5400927ilr.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3Su79vC800Qm2PaYyCCtYDxrAxfT8Q3fr1e8LvCXCk=;
        b=7pujaUfGcigB4QfgVMK2wCLDFtxRPAWKeCYBJuqwWuIZRMn1YqtKtgmPH42hMT4mcm
         g4VVtymcF7I2XNnlD/CjyXccIF6x7kjQCq5P/3bHabuQkjfeaGRr/IroH/ND5ejez/6d
         cTgPoBicGTD476giYxiLmTT3msGO+rBxLM8zEdFtVu/DLXhKHQF4ILbphF5Qb6s5zTcR
         C4/hPLWkQ34b85bneYGlTpU5Xkf1g3UbIh98ycukPABcyB4popX2KzNh+XR1DVp6U2lp
         s90CqqV8JZXBqEY2ggVaLb8x3HZfGjnCwDw7t+RDhQ3jywASRG489tMPZi3X60603A4B
         wxHA==
X-Gm-Message-State: AO0yUKXGmDPgNij/5C0LfeFo9ZiT90JpDFrqnjqqnmjW5ryb4Yo2TzsW
        KGvDK+lE1ly/+CdCmcTCRFERlrAziA==
X-Google-Smtp-Source: AK7set9Ni1WAv7e3eQE+jB+wY63erDS3RCmdcDmJhsxK41IhPMI4pFWsEJ0U6uFOi8ykGJJqg0jAQg==
X-Received: by 2002:a92:db07:0:b0:315:365d:5358 with SMTP id b7-20020a92db07000000b00315365d5358mr3360747iln.10.1679243553071;
        Sun, 19 Mar 2023 09:32:33 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id g13-20020a02270d000000b0040306bfd949sm2582678jaa.21.2023.03.19.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:32 -0700 (PDT)
Received: (nullmailer pid 226695 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:26 -0500
Message-Id: <20230319163226.226583-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded reading of "reg" and of_translate_address() calls with
single call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/via-cuda.c | 16 +++++-----------
 drivers/macintosh/via-pmu.c  | 23 ++++++++---------------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 5071289063f0..f8dd1e831530 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -235,8 +235,7 @@ int __init find_via_cuda(void)
 int __init find_via_cuda(void)
 {
     struct adb_request req;
-    phys_addr_t taddr;
-    const u32 *reg;
+    struct resource res;
     int err;
 
     if (vias)
@@ -245,17 +244,12 @@ int __init find_via_cuda(void)
     if (!vias)
 	return 0;
 
-    reg = of_get_property(vias, "reg", NULL);
-    if (reg == NULL) {
-	    printk(KERN_ERR "via-cuda: No \"reg\" property !\n");
-	    goto fail;
-    }
-    taddr = of_translate_address(vias, reg);
-    if (taddr == 0) {
-	    printk(KERN_ERR "via-cuda: Can't translate address !\n");
+    err = of_address_to_resource(vias, 0, &res);
+    if (err) {
+	    printk(KERN_ERR "via-cuda: Error getting \"reg\" property !\n");
 	    goto fail;
     }
-    via = ioremap(taddr, 0x2000);
+    via = ioremap(res.start, 0x2000);
     if (via == NULL) {
 	    printk(KERN_ERR "via-cuda: Can't map address !\n");
 	    goto fail;
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index e0cb8daf4f08..9d5703b60937 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -286,8 +286,9 @@ static char *pbook_type[] = {
 int __init find_via_pmu(void)
 {
 #ifdef CONFIG_PPC_PMAC
+	int err;
 	u64 taddr;
-	const u32 *reg;
+	struct resource res;
 
 	if (pmu_state != uninitialized)
 		return 1;
@@ -295,16 +296,12 @@ int __init find_via_pmu(void)
 	if (vias == NULL)
 		return 0;
 
-	reg = of_get_property(vias, "reg", NULL);
-	if (reg == NULL) {
-		printk(KERN_ERR "via-pmu: No \"reg\" property !\n");
-		goto fail;
-	}
-	taddr = of_translate_address(vias, reg);
-	if (taddr == OF_BAD_ADDR) {
-		printk(KERN_ERR "via-pmu: Can't translate address !\n");
+	err = of_address_to_resource(vias, 0, &res);
+	if (err) {
+		printk(KERN_ERR "via-pmu: Error getting \"reg\" property !\n");
 		goto fail;
 	}
+	taddr = res.start;
 
 	pmu_has_adb = 1;
 
@@ -324,7 +321,6 @@ int __init find_via_pmu(void)
 		 || of_device_is_compatible(vias->parent, "K2-Keylargo")) {
 		struct device_node *gpiop;
 		struct device_node *adbp;
-		u64 gaddr = OF_BAD_ADDR;
 
 		pmu_kind = PMU_KEYLARGO_BASED;
 		adbp = of_find_node_by_type(NULL, "adb");
@@ -338,11 +334,8 @@ int __init find_via_pmu(void)
 		
 		gpiop = of_find_node_by_name(NULL, "gpio");
 		if (gpiop) {
-			reg = of_get_property(gpiop, "reg", NULL);
-			if (reg)
-				gaddr = of_translate_address(gpiop, reg);
-			if (gaddr != OF_BAD_ADDR)
-				gpio_reg = ioremap(gaddr, 0x10);
+			if (!of_address_to_resource(gpiop, 0, &res))
+				gpio_reg = ioremap(res.start, 0x10);
 			of_node_put(gpiop);
 		}
 		if (gpio_reg == NULL) {
-- 
2.39.2

