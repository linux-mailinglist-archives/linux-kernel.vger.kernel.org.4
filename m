Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58B97118B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEYVCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEYVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:02:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C7E4A;
        Thu, 25 May 2023 14:02:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so5337770a12.3;
        Thu, 25 May 2023 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048537; x=1687640537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcZFua0EILx4UgL94m890/UaW7590iqXfYJZcRYRhjI=;
        b=plLBOrfRRrLKTFd8DM3UtUZCksznD4j1oAjH6MqevOs+L5cZ2wiRB2GqjLwGlXX6CU
         zlq/wrvABrF5J+hz83++55KphZPp8sE7CdQAoSm6FT+PUVOpVjXnir2nZdeFGvPughRg
         2MLlfji2K6QX1B0vrgTYGxLV1yAdNcLbFgurysJcCEWMjybmRxOLooanzucfImdJy61S
         WgTOOkrglebpKpewgbAxJMEMq7DBol+G1d9VWWnhXzXcOc5BW6kYJ39/QJfUsx8U4kEc
         UTgZ3r/cYSyJ2PCM0eiEBZMzVK3OF77T/TZu2noiU+jDMOXoyjKjDh5oX2LxBB56sB2K
         XAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048537; x=1687640537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcZFua0EILx4UgL94m890/UaW7590iqXfYJZcRYRhjI=;
        b=lV333o6mHMOrPW48H/hsrfZndG3VdhWJWSgAhz+46Ph4uOdut/DvG1egE+t4DJKYl+
         5GdGJxufL1aYt64TlxgpnTzpXaam2H9PTgd0fnguYuoGozzI+3qlNZc0jFW0Ehmq794H
         0xt9Izf3fNXJX3f3H4/irPV7E8rQvBut+w1Vjn/B2GJOXJNUVr6kdzQyFZ8HswW2OXli
         J1TWkDwRsacOrGLi47pCLrEtHQSVwu7xYNPozaHZqMNIpCDWGD45Wchr7C021JdvmELr
         PIndDBvLGQ5iVP6dklqXBCnqyVlaExiFRq4akMV4slT24ZWyAb0iUnhf8wB3KeMXxekx
         Ab0g==
X-Gm-Message-State: AC+VfDxYqRWQ0QxBqY/sgrrmptY5VgDWpNTbk0dSlHhfLvYPFUnl+dpm
        BYT1/Xoc+5kCqJxwAbjF7bvpBi/bkPA0Ag==
X-Google-Smtp-Source: ACHHUZ4MAbNqROgew6250c1ibcAAraJFBK02li4jq/olWHmtGNQk+ySTPiowvkaMBK/HGQZ9q4HS5Q==
X-Received: by 2002:aa7:d451:0:b0:50b:caac:d25 with SMTP id q17-20020aa7d451000000b0050bcaac0d25mr5303932edr.34.1685048536956;
        Thu, 25 May 2023 14:02:16 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id c25-20020aa7df19000000b0050e04125a46sm913010edy.10.2023.05.25.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:02:16 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/5] soc: qcom: socinfo: move SMEM item struct and defines to a header
Date:   Thu, 25 May 2023 23:02:10 +0200
Message-Id: <20230525210214.78235-1-robimarko@gmail.com>
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

