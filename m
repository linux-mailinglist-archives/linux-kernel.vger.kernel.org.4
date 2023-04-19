Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A06E7841
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjDSLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDSLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103913FAE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a667067275so25322215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902633; x=1684494633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KIa9LYf0ODhdzKLybQD/gUKKX1O1GxO+uhQNo6blW0=;
        b=pUSEDOCWgGuTM6CKmcMbLe7K+VOkG5kdfv7sgvZJDVGFEauQg8GskJ5TTq2rw1I6ez
         a4gXs8myGV03gRZXVVqsyS/7/8DH7w0epDUQ3fvNC7tevtjQjX0gSYw70qXumUZaaFa6
         DH6lCMZCnrzOYMP0MppSRHS0q2PYutLF7G3iwmA9AWub3Qok28lGtTEQVcvehX88Kxzj
         U+7U70eWTaa3h+dXWUwmrKUrXXA+R4glloG/L9M30GuYrk6RwK0JTFwq/4BqBd86WiG4
         uowQOItfzun2u7UVpigFCvFhsY+Q4pjh4qafYnaUIgZfcaXOcwVTIOfBSzvLVMchFfCU
         MtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902633; x=1684494633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KIa9LYf0ODhdzKLybQD/gUKKX1O1GxO+uhQNo6blW0=;
        b=EbzmIGwVOeHMzWt8AddyLAli9L2irxT9VLZLvtGUtJBKrFQp3H0Fg5UKCXrz3DSY/n
         cAxJJVnMM8h711vfwUYVavvDCvBTxHalvcY6lqaVhO3tKXU3O62SiMn0kdYZg+K3s3F7
         ZtSmiudIJn0erSNf8OcqiuA4IyFGpZyTVru7wZIA9aUlCN9+bMkA1QcWXeTlQYCUDm0K
         4n26z0raHzlKf1QME03Ef1KaVR8qC/zt062UjReik1NlR3c/tFrYSP+af0KJY+xrT7z3
         PjgmC90wQkKKUDVOCOeIufhFUXK61+PJUXjHRAav1j0sb0J2WvZ1wqp+xptRsT10ckog
         XlXw==
X-Gm-Message-State: AAQBX9cvC5GprTW++emY12qb0478d1GHttw8QapZLDMP+iSdp0pxXTh6
        0odigTKCePdFUwbGGrkxL8wGrw==
X-Google-Smtp-Source: AKy350alD0YaRVGGNagBcrgS+2r6G4GIg0rKJmQJt7bkhxnweSuXRSxUzkixMdfbGE9ubu0LMJS1wQ==
X-Received: by 2002:a17:902:d4c6:b0:1a6:523c:8583 with SMTP id o6-20020a170902d4c600b001a6523c8583mr5718626plg.68.1681902633050;
        Wed, 19 Apr 2023 04:10:33 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:32 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 16/21] DO_NOT_MERGE soc: add Foobar SoC cache controller driver
Date:   Wed, 19 Apr 2023 04:11:06 -0700
Message-Id: <20230419111111.477118-17-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add example driver for a cache controller that implements CBQRI.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/foobar/foobar_cbqri_cache.c | 110 ++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 drivers/soc/foobar/foobar_cbqri_cache.c

diff --git a/drivers/soc/foobar/foobar_cbqri_cache.c b/drivers/soc/foobar/foobar_cbqri_cache.c
new file mode 100644
index 000000000000..e880488243d8
--- /dev/null
+++ b/drivers/soc/foobar/foobar_cbqri_cache.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Foobar Systems CBQRI cache controller
+ */
+
+#define pr_fmt(fmt) "foobar-cache: " fmt
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/riscv_qos.h>
+
+static const struct of_device_id foobar_cbqri_cache_ids[] = {
+	{ .compatible = "foobar,cache-controller" },
+	{ }
+};
+
+static int __init foobar_cbqri_cache_init(void)
+{
+	struct device_node *np;
+	int err;
+	u32 value;
+	struct cbqri_controller_info *ctrl_info;
+
+	for_each_matching_node(np, foobar_cbqri_cache_ids) {
+		if (!of_device_is_available(np)) {
+			of_node_put(np);
+			continue;
+		}
+
+		ctrl_info = kzalloc(sizeof(*ctrl_info), GFP_KERNEL);
+		if (!ctrl_info)
+			goto err_node_put;
+		ctrl_info->type = CBQRI_CONTROLLER_TYPE_CAPACITY;
+
+		err = of_property_read_u32_index(np, "reg", 1, &value);
+		if (err) {
+			pr_err("Failed to read reg base address (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->addr = value;
+
+		err = of_property_read_u32_index(np, "reg", 3, &value);
+		if (err) {
+			pr_err("Failed to read reg size (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->size = value;
+
+		err = of_property_read_u32(np, "cache-level", &value);
+		if (err) {
+			pr_err("Failed to read cache level (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->cache.cache_level = value;
+
+		err = of_property_read_u32(np, "cache-size", &value);
+		if (err) {
+			pr_err("Failed to read cache size (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->cache.cache_size = value;
+
+		err = of_property_read_u32(np, "riscv,cbqri-rcid", &value);
+		if (err) {
+			pr_err("Failed to read RCID count (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->rcid_count = value;
+
+		err = of_property_read_u32(np, "riscv,cbqri-mcid", &value);
+		if (err) {
+			pr_err("Failed to read MCID count (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+		ctrl_info->mcid_count = value;
+
+		/*
+		 * For CBQRI, any cpu (technically a hart in RISC-V terms)
+		 * can access the memory-mapped registers of any CBQRI
+		 * controller in the system. Therefore, set the CPU mask
+		 * to 'FF' to allow all 8 cores in the example Foobar SoC
+		 */
+		err = cpumask_parse("FF", &ctrl_info->cache.cpu_mask);
+		if (err) {
+			pr_err("Failed to convert cores mask string to cpumask (%d)", err);
+			goto err_kfree_ctrl_info;
+		}
+
+		of_node_put(np);
+
+		pr_debug("addr=0x%lx max-rcid=%u max-mcid=%u level=%d size=%u",
+			 ctrl_info->addr, ctrl_info->rcid_count, ctrl_info->mcid_count,
+			 ctrl_info->cache.cache_level, ctrl_info->cache.cache_size);
+
+		/* Fill the list shared with RISC-V QoS resctrl */
+		INIT_LIST_HEAD(&ctrl_info->list);
+		list_add_tail(&ctrl_info->list, &cbqri_controllers);
+	}
+
+	return 0;
+
+err_kfree_ctrl_info:
+	kfree(ctrl_info);
+
+err_node_put:
+	of_node_put(np);
+
+	return err;
+}
+device_initcall(foobar_cbqri_cache_init);
-- 
2.34.1

