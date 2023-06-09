Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14F72A239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFISbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFISbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:31:07 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133435B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:31:05 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77acb944bdfso92160039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335465; x=1688927465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOkAktt4g0nx6LcgW7gCWAzTqQNaJuKZ2Hioy4cVgxI=;
        b=K5soMjKJqC7j+Qh8Hg22hmQRFyROcrQ6kwFOlqfgKFIGK0a3tay5vChR3mTzgINafv
         abefyvXFd0LudToK7acJJmbCJVfpLTBYgulU0S1b/pQfD1dyIzSd/5362ammvUhURO46
         MVFu7w1iiHn9ZAZV7td5CwjW9qofpJgjQRtK5fUG1nFlO6NycD5+kOIi1Tdt0sfa9NKM
         kiaLJVCsS647bUJBGxVjfUQXYDgFLjjDEvTJ8yVpfIw5E3E24UXnOnRj0XYIHMbNoakn
         gICJNpx3HuxHVwDO+veJeT69JDcTXXDcSdwb63mPFqGbEEO2qREvHxXFcwHrs8qr9tKr
         63Mw==
X-Gm-Message-State: AC+VfDxOMur5Aa/vMzJEWI19bcm+I3mWj6owoqUzGj0DCGejMRIEPRLR
        aHyt1L+fkRQmIfMDlcsyR6S83fr0GA==
X-Google-Smtp-Source: ACHHUZ7nTbRNJnOsOtHprZKubwHVeXF1QQw+95j/zccwXR3WE8Axvi3A8qsmXX2tP4aRcDxo8aJaTw==
X-Received: by 2002:a5e:dc45:0:b0:778:65fb:5e25 with SMTP id s5-20020a5edc45000000b0077865fb5e25mr2134840iop.4.1686335464768;
        Fri, 09 Jun 2023 11:31:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x6-20020a5e8306000000b0077a1b6f73b9sm1221722iom.41.2023.06.09.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:31:04 -0700 (PDT)
Received: (nullmailer pid 1765318 invoked by uid 1000);
        Fri, 09 Jun 2023 18:31:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:30:56 -0600
Message-Id: <20230609183056.1765183-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/fsi/fsi-core.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 0b927c9f4267..19c4d5b3bde9 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/cdev.h>
@@ -415,28 +416,18 @@ EXPORT_SYMBOL_GPL(fsi_slave_release_range);
 static bool fsi_device_node_matches(struct device *dev, struct device_node *np,
 		uint32_t addr, uint32_t size)
 {
-	unsigned int len, na, ns;
-	const __be32 *prop;
-	uint32_t psize;
+	u64 paddr, psize;
 
-	na = of_n_addr_cells(np);
-	ns = of_n_size_cells(np);
-
-	if (na != 1 || ns != 1)
-		return false;
-
-	prop = of_get_property(np, "reg", &len);
-	if (!prop || len != 8)
+	if (of_property_read_reg(np, 0, &paddr, &psize))
 		return false;
 
-	if (of_read_number(prop, 1) != addr)
+	if (paddr != addr)
 		return false;
 
-	psize = of_read_number(prop + 1, 1);
 	if (psize != size) {
 		dev_warn(dev,
-			"node %s matches probed address, but not size (got 0x%x, expected 0x%x)",
-			of_node_full_name(np), psize, size);
+			"node %pOF matches probed address, but not size (got 0x%llx, expected 0x%x)",
+			np, psize, size);
 	}
 
 	return true;
@@ -653,24 +644,12 @@ static void fsi_slave_release(struct device *dev)
 static bool fsi_slave_node_matches(struct device_node *np,
 		int link, uint8_t id)
 {
-	unsigned int len, na, ns;
-	const __be32 *prop;
-
-	na = of_n_addr_cells(np);
-	ns = of_n_size_cells(np);
-
-	/* Ensure we have the correct format for addresses and sizes in
-	 * reg properties
-	 */
-	if (na != 2 || ns != 0)
-		return false;
+	u64 addr;
 
-	prop = of_get_property(np, "reg", &len);
-	if (!prop || len != 8)
+	if (of_property_read_reg(np, 0, &addr, NULL))
 		return false;
 
-	return (of_read_number(prop, 1) == link) &&
-		(of_read_number(prop + 1, 1) == id);
+	return addr == (((u64)link << 32) | id);
 }
 
 /* Find a matching node for the slave at (link, id). Returns NULL if none
-- 
2.39.2

