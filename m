Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC86E7848
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjDSLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjDSLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090DA256
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so14849545ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902634; x=1684494634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VRpPNkDuAyz+Ft5imrcs9KDU5p5mtKUYR9cIj3QRd4=;
        b=x/8pGfsLNTo4M60IL76aQ5x040uI2InLj1/EScIFp6VYlhbjP5l3eNVgN+y4avjRTt
         H5fzYWvVhJT2Rq7bzjd2zo6SGa9b70+iPd7q+BYZOfnbxUKSB2gBI+v9EID/w220Xv6A
         ogg1jlEVmqJYIyFKd2qTHBIQq91+m87zuaTfEpDGjS4JjD5plCp7XDP57KjGuKZ+kOiN
         SVYdRu2DZSdcypVQLwcCpNb8l4lKH0jilJ++oP1hk4KiAaDnMtqJcq8eN39x6hZzCeaP
         j6FiQUn7+p1qacItyHJxcwZOT4dU4m7qvkAF3FVlQoqYsjD4V5HP3V7p3ikdeOowNAkl
         8kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902634; x=1684494634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VRpPNkDuAyz+Ft5imrcs9KDU5p5mtKUYR9cIj3QRd4=;
        b=UJDqwXHbQyurQINW5R0/7MTORD3H4DlttpBM9b8kk3HMN08fDkwfW1dKsBRbCH2dDB
         cqSStq8HzBDUqttLGn/Z+PI7g3k6a3nW91u98ZPUbRrTynjZeyT1Hc2PKMZGlJKgkEN1
         /RsN7xpD0PQygAO5i2a6RUwyDdk4K6IObXHAodeyst7dqLZYXYH87CZ5WdUiMvISIWpl
         yTg1Z4KoVLhU9K+2FDQ6I5TX5XcCAhGjAjx2JecsrNhF94bhnEA9WYktL/EFU97tu+im
         +16kDREF7nmRToPb+ZOy8MpMokdjhaUCwANuzujdjLZBGKZ+IwRvleXddqEHfvJrP0We
         3gWg==
X-Gm-Message-State: AAQBX9fImShDoODop+gI/LxVGChbBsmjewnvwMPCpq1HA1w2rwSEYKKO
        sNSVLvuJ6XXFbbFGElAV6evUFQ==
X-Google-Smtp-Source: AKy350boG05NBC+OyMdfVB4g1lkdqwK+pdBb8M8du2YV2tJ6Pxg4DvMv0hsz2y7ET8IQwFhAUURrrw==
X-Received: by 2002:a17:902:db0f:b0:1a1:a9a4:ba26 with SMTP id m15-20020a170902db0f00b001a1a9a4ba26mr5908976plx.8.1681902634412;
        Wed, 19 Apr 2023 04:10:34 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:33 -0700 (PDT)
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
Subject: [RFC PATCH 17/21] DO_NOT_MERGE soc: add Foobar SoC memory controller driver
Date:   Wed, 19 Apr 2023 04:11:07 -0700
Message-Id: <20230419111111.477118-18-dfustini@baylibre.com>
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

Add example driver for a SoC memory controller that implements CBQRI.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/soc/foobar/foobar_cbqri_memory.c | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 drivers/soc/foobar/foobar_cbqri_memory.c

diff --git a/drivers/soc/foobar/foobar_cbqri_memory.c b/drivers/soc/foobar/foobar_cbqri_memory.c
new file mode 100644
index 000000000000..0a0c542a25e1
--- /dev/null
+++ b/drivers/soc/foobar/foobar_cbqri_memory.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Foobar Systems CBQRI memory controller
+ */
+
+#define pr_fmt(fmt) "foobar-mem: " fmt
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/riscv_qos.h>
+
+static const struct of_device_id foobar_cbqri_memory_ids[] = {
+	{ .compatible = "foobar,memory-controller" },
+	{ }
+};
+
+static int __init foobar_cbqri_memory_init(void)
+{
+	struct device_node *np;
+	int err;
+	u32 value;
+	struct cbqri_controller_info *ctrl_info;
+
+	for_each_matching_node(np, foobar_cbqri_memory_ids) {
+		if (!of_device_is_available(np)) {
+			of_node_put(np);
+			continue;
+		}
+
+		ctrl_info = kzalloc(sizeof(*ctrl_info), GFP_KERNEL);
+		if (!ctrl_info)
+			goto err_node_put;
+		ctrl_info->type = CBQRI_CONTROLLER_TYPE_BANDWIDTH;
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
+		of_node_put(np);
+
+		pr_debug("addr=0x%lx max-rcid=%u max-mcid=%u", ctrl_info->addr,
+			 ctrl_info->rcid_count, ctrl_info->mcid_count);
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
+device_initcall(foobar_cbqri_memory_init);
-- 
2.34.1

