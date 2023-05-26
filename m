Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF50712E67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbjEZUsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjEZUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979518D;
        Fri, 26 May 2023 13:48:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso223940266b.0;
        Fri, 26 May 2023 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134085; x=1687726085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0R0NrTV6Cqbu4tkPLJTMsGVN13FV0cFn1qP/yJKlxmM=;
        b=X2rfpKXipfhG+PEUWJBDIQ1o5PogCoENlvEt+SGQ+7rF8iLBN7SFnV13wRnDdiXT2r
         NGXjedeOg+tIWRV5stWzQa3BSAAozyh3AzsH/FSAw74GAmCkvfBcJlYAdFockCIgeLyY
         dYGEp6v6D0GLNAOv5J5dg8XR5yXkpKP9SGDL+OqzS+PxMC2u9T9rVraYige205g+dtZt
         pmBNSpBVUdbjRp6AA9k6XhyvMLy8LJg4ypDXmkMaLHhEbKP7Yy5XfV+vB2aaEQz+eI/R
         Yx4YuvzAeRh1YCr4PkNRyTAj0mo6CJfDNjE2c+4pXYGZ3lWMy7HRCcg+UDZR2PJK2b5n
         wjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134085; x=1687726085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R0NrTV6Cqbu4tkPLJTMsGVN13FV0cFn1qP/yJKlxmM=;
        b=MHs1PYlZqemGFJ3laEajmlbC86p/ThusgY3bQv7UCfAYgp0iTiavJe28Zc/Ghn5+U3
         cAdh9HzAHhH54NbfePNnty2ZOBQeBCd0CgfZxWXL288YE09UjFBHveS9kre7JeOf3d4P
         CpqbjhBi67gbWaMMUrpPc5Rjb/vHj/8zXgnIZFtnKWgOJRRn79uC9D3m+Vy0B+Hhql3K
         wKRvLFVPlVr7RA0t1u2KtlAy2JuC5LIYTBtxMlOluFjRZpvaxd2zYWYQZMQ50KaQC8Vs
         JqhfhWsach1pF1tESj/25x59zDNbUZdkrtjhjhep31p0Fuxp1Pfo222L6ldfUoTyDNmD
         k42A==
X-Gm-Message-State: AC+VfDxVDTUjpW+2jLKpV5EZGoYsIC6GGfNsAAIXj4MwdMus8qOeTGlV
        z0LieD2ybMr40eMXZH7WUSg=
X-Google-Smtp-Source: ACHHUZ4tltghkDEs4H+WeAaNWWmoAVTk1B3YVlbFYjpOos6TovJcH77mpK7bVtLFFU/UdEgvlSV3eg==
X-Received: by 2002:a17:907:60c9:b0:96f:cde5:5f5e with SMTP id hv9-20020a17090760c900b0096fcde55f5emr3233901ejc.29.1685134084976;
        Fri, 26 May 2023 13:48:04 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906160d00b0095342bfb701sm2604413ejd.16.2023.05.26.13.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:48:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 1/5] soc: qcom: socinfo: move SMEM item struct and defines to a header
Date:   Fri, 26 May 2023 22:47:58 +0200
Message-Id: <20230526204802.3081168-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SMEM item struct and related defines to a header in order to be able
to reuse them in the SMEM driver instead of duplicating them.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/socinfo.c       | 67 +-----------------------------
 include/linux/soc/qcom/socinfo.h | 70 ++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/soc/qcom/socinfo.h

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index c2e4a57dd666..ee6bbf76d941 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -11,6 +11,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/sys_soc.h>
@@ -32,15 +33,6 @@
 #define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
 #define qcom_board_id_named(id, name) QCOM_ID_ ## id, (name)
 
-#define SMEM_SOCINFO_BUILD_ID_LENGTH           32
-#define SMEM_SOCINFO_CHIP_ID_LENGTH            32
-
-/*
- * SMEM item id, used to acquire handles to respective
- * SMEM region.
- */
-#define SMEM_HW_SW_BUILD_ID            137
-
 #ifdef CONFIG_DEBUG_FS
 #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
 #define SMEM_IMAGE_VERSION_SIZE                4096
@@ -126,64 +118,7 @@ static const char *const pmic_models[] = {
 	[58] = "PM8450",
 	[65] = "PM8010",
 };
-#endif /* CONFIG_DEBUG_FS */
-
-/* Socinfo SMEM item structure */
-struct socinfo {
-	__le32 fmt;
-	__le32 id;
-	__le32 ver;
-	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
-	/* Version 2 */
-	__le32 raw_id;
-	__le32 raw_ver;
-	/* Version 3 */
-	__le32 hw_plat;
-	/* Version 4 */
-	__le32 plat_ver;
-	/* Version 5 */
-	__le32 accessory_chip;
-	/* Version 6 */
-	__le32 hw_plat_subtype;
-	/* Version 7 */
-	__le32 pmic_model;
-	__le32 pmic_die_rev;
-	/* Version 8 */
-	__le32 pmic_model_1;
-	__le32 pmic_die_rev_1;
-	__le32 pmic_model_2;
-	__le32 pmic_die_rev_2;
-	/* Version 9 */
-	__le32 foundry_id;
-	/* Version 10 */
-	__le32 serial_num;
-	/* Version 11 */
-	__le32 num_pmics;
-	__le32 pmic_array_offset;
-	/* Version 12 */
-	__le32 chip_family;
-	__le32 raw_device_family;
-	__le32 raw_device_num;
-	/* Version 13 */
-	__le32 nproduct_id;
-	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
-	/* Version 14 */
-	__le32 num_clusters;
-	__le32 ncluster_array_offset;
-	__le32 num_defective_parts;
-	__le32 ndefective_parts_array_offset;
-	/* Version 15 */
-	__le32 nmodem_supported;
-	/* Version 16 */
-	__le32  feature_code;
-	__le32  pcode;
-	__le32  npartnamemap_offset;
-	__le32  nnum_partname_mapping;
-	/* Version 17 */
-	__le32 oem_variant;
-};
 
-#ifdef CONFIG_DEBUG_FS
 struct socinfo_params {
 	u32 raw_device_family;
 	u32 hw_plat_subtype;
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
new file mode 100644
index 000000000000..d1cbc49a2a2d
--- /dev/null
+++ b/include/linux/soc/qcom/socinfo.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_SOCINFO_H__
+#define __QCOM_SOCINFO_H__
+
+/*
+ * SMEM item id, used to acquire handles to respective
+ * SMEM region.
+ */
+#define SMEM_HW_SW_BUILD_ID		137
+
+#define SMEM_SOCINFO_BUILD_ID_LENGTH	32
+#define SMEM_SOCINFO_CHIP_ID_LENGTH	32
+
+/* Socinfo SMEM item structure */
+struct socinfo {
+	__le32 fmt;
+	__le32 id;
+	__le32 ver;
+	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
+	/* Version 2 */
+	__le32 raw_id;
+	__le32 raw_ver;
+	/* Version 3 */
+	__le32 hw_plat;
+	/* Version 4 */
+	__le32 plat_ver;
+	/* Version 5 */
+	__le32 accessory_chip;
+	/* Version 6 */
+	__le32 hw_plat_subtype;
+	/* Version 7 */
+	__le32 pmic_model;
+	__le32 pmic_die_rev;
+	/* Version 8 */
+	__le32 pmic_model_1;
+	__le32 pmic_die_rev_1;
+	__le32 pmic_model_2;
+	__le32 pmic_die_rev_2;
+	/* Version 9 */
+	__le32 foundry_id;
+	/* Version 10 */
+	__le32 serial_num;
+	/* Version 11 */
+	__le32 num_pmics;
+	__le32 pmic_array_offset;
+	/* Version 12 */
+	__le32 chip_family;
+	__le32 raw_device_family;
+	__le32 raw_device_num;
+	/* Version 13 */
+	__le32 nproduct_id;
+	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
+	/* Version 14 */
+	__le32 num_clusters;
+	__le32 ncluster_array_offset;
+	__le32 num_defective_parts;
+	__le32 ndefective_parts_array_offset;
+	/* Version 15 */
+	__le32 nmodem_supported;
+	/* Version 16 */
+	__le32  feature_code;
+	__le32  pcode;
+	__le32  npartnamemap_offset;
+	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
+};
+
+#endif
-- 
2.40.1

