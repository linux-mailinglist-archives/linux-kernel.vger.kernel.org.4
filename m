Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F236B4703
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjCJOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjCJOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:26 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9BA402D;
        Fri, 10 Mar 2023 06:47:08 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17671fb717cso6048527fac.8;
        Fri, 10 Mar 2023 06:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Mxp++3M/xdGxspwUzy62aP4jiUX2gCDYtnUV4UMARw=;
        b=iJK/N6/O8xD7aaHFusbGb5htfxET0MkMS1lnWZegz9LbMrG2Tzs2yYdHGSSQp7TYH/
         z6rlW4jR4vaF1AGUQJh5Ci3wcs519t1oqhCQd2TCMEbnChJ+7IHpPhRvysWSndf7IjPJ
         n8a6NbxfTBzk/TDDRrmwDAq6kx8iz+ulEGFyVAGEP9CZv6N5MP16BpAJMjHHFDoA6muf
         yGhB4WvKVfWxfi2nNlcj3s7Znm+XJ7PmmAZaqvUB2vUfSj3oOFv8a2w3Xts13I0SO7Ah
         BN+eZDY7SPcqV8YS8A4ZUNdRngrB0QfGdT2mO6W92+fDirni00u+1szR4Av3lP0+FYxv
         zZXg==
X-Gm-Message-State: AO0yUKWu1Dl7AJ/vr6bbQeh7M4Fb16mwQsOjz9Bw5Js/QiXPQVNrvApH
        w5lhJ8JPKLz8Nqnkq2TL4TNKizGFJQ==
X-Google-Smtp-Source: AK7set9VvIYu2/mX/Ddsr37S3WO3p4+3gpV8Esm/Df+5J5CGsGTCA212TN+8lbj1lvu+O700qeh1ew==
X-Received: by 2002:a05:6870:560a:b0:176:448f:4ccd with SMTP id m10-20020a056870560a00b00176448f4ccdmr17022548oao.51.1678459625853;
        Fri, 10 Mar 2023 06:47:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d44-20020a056870d2ac00b001727d62899bsm95690oae.26.2023.03.10.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:05 -0800 (PST)
Received: (nullmailer pid 1541302 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:46:59 -0600
Message-Id: <20230310144659.1541247-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/of_device_32.c     | 4 ++--
 arch/sparc/kernel/of_device_64.c     | 6 +++---
 arch/sparc/kernel/of_device_common.c | 2 +-
 arch/sparc/kernel/prom_64.c          | 2 +-
 arch/sparc/kernel/time_32.c          | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78e..b60f58e04164 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -29,7 +29,7 @@ static int of_bus_pci_match(struct device_node *np)
 		 * parent as-is, not with the PCI translate
 		 * method which chops off the top address cell.
 		 */
-		if (!of_find_property(np, "ranges", NULL))
+		if (!of_property_present(np, "ranges"))
 			return 0;
 
 		return 1;
@@ -223,7 +223,7 @@ static int __init build_one_resource(struct device_node *parent,
 static int __init use_1to1_mapping(struct device_node *pp)
 {
 	/* If we have a ranges property in the parent, use it.  */
-	if (of_find_property(pp, "ranges", NULL) != NULL)
+	if (of_property_present(pp, "ranges"))
 		return 0;
 
 	/* Some SBUS devices use intermediate nodes to express
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7..5b5143e17ba3 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -58,7 +58,7 @@ static int of_bus_pci_match(struct device_node *np)
 		 * parent as-is, not with the PCI translate
 		 * method which chops off the top address cell.
 		 */
-		if (!of_find_property(np, "ranges", NULL))
+		if (!of_property_present(np, "ranges"))
 			return 0;
 
 		return 1;
@@ -78,7 +78,7 @@ static int of_bus_simba_match(struct device_node *np)
 	 * simba.
 	 */
 	if (of_node_name_eq(np, "pci")) {
-		if (!of_find_property(np, "ranges", NULL))
+		if (!of_property_present(np, "ranges"))
 			return 1;
 	}
 
@@ -283,7 +283,7 @@ static int __init build_one_resource(struct device_node *parent,
 static int __init use_1to1_mapping(struct device_node *pp)
 {
 	/* If we have a ranges property in the parent, use it.  */
-	if (of_find_property(pp, "ranges", NULL) != NULL)
+	if (of_property_present(pp, "ranges"))
 		return 0;
 
 	/* If the parent is the dma node of an ISA bus, pass
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index e717a56efc5d..60f86b837658 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -162,7 +162,7 @@ int of_bus_sbus_match(struct device_node *np)
 		 * don't have some intervening real bus that provides
 		 * ranges based translations.
 		 */
-		if (of_find_property(dp, "ranges", NULL) != NULL)
+		if (of_property_present(dp, "ranges"))
 			break;
 
 		dp = dp->parent;
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index f883a50fa333..998aa693d491 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -502,7 +502,7 @@ static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 	struct device_node *portid_parent = NULL;
 	int portid = -1;
 
-	if (of_find_property(dp, "cpuid", NULL)) {
+	if (of_property_present(dp, "cpuid")) {
 		int limit = 2;
 
 		portid_parent = dp;
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 8a08830e4a65..958c2cf4479b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -277,7 +277,7 @@ static int clock_probe(struct platform_device *op)
 		return -ENODEV;
 
 	/* Only the primary RTC has an address property */
-	if (!of_find_property(dp, "address", NULL))
+	if (!of_property_present(dp, "address"))
 		return -ENODEV;
 
 	m48t59_rtc.resource = &op->resource[0];
-- 
2.39.2

