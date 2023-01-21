Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB97D676604
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAUL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:29:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF93B3DC;
        Sat, 21 Jan 2023 03:29:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y11so9450891edd.6;
        Sat, 21 Jan 2023 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQtA9gnXbHiCVZ0cdHgz61/mVXx++tAhOoDuPrap8Z8=;
        b=IrfWZ6nnGNuKzRQyWZxpXbc/uAwXN43BQn8gO3yrJq2u3+D/z8GgtpgGunHjw7ig5o
         pbJ8RLv0KPCELe3aZpmvWDkSnx0R2vaOT0K8hMNZ9qONHT+Nz6pquv5j0JNGDSx0jLb8
         mlntWNQt3gvIbnQrVG+p6iOGnxyARi05vZnjC6aiPspZReA/kCrUlRI7scCaXJB9TdXO
         0RftYK4T6hdaTXHH86j+ZHaJtPB5WYueVscMBR3jz0io+Jof3qcYptT8dxBw762lYnTy
         d7+T8gctiDul0KmQVJ1s8ShAo9X5HKbNCHSIB7qGXhlkDl1vLVlMn2EobIfVzYXPGntD
         U2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQtA9gnXbHiCVZ0cdHgz61/mVXx++tAhOoDuPrap8Z8=;
        b=rI7//64ZdgKn9b1XfLm9YzUkJmDRBi9kQFbHZ7X62/V0g82KhIpSn3HQELIufuuOOI
         Q0mOkb3uOAgh49RkObKaV8z4X7A0yzY7yAusZmywN7qHz8fesYRz7N+1WXWxNpG75hPL
         4ePwNtZ3PvTEtEJ8/SEI8ImP8tVody0j3pXjUAoCKhmCBxVZs+xWthxsiDY249GPupRD
         ogDzOgmeodk3Jd9OeLFP6uBN6Mkxxl8FOxNsJMdYzvG17/2EFm0jpQDiAOYhWIHgbDsn
         3IZ5ozmiRiQfYb+tjxXLoC9zd9bngUFFypz9sS6EmYf9V+W++KQoik2azptFGeSeTMFz
         5mpg==
X-Gm-Message-State: AFqh2kqoVFpQ242MUI6HF3jS+SRKTXmPnP++e7x2++oJOVMu6ww/RUK6
        TGxgx3HtrHvYko9qMbGowx4=
X-Google-Smtp-Source: AMrXdXtMK0T0DTiO6dazvK4Gi14KKO6u4xEFwf3TbeONxFRnhsCY1K0ZzvDUaYtLmDLP9uhEZrVYRQ==
X-Received: by 2002:a05:6402:2055:b0:479:6c4f:40df with SMTP id bc21-20020a056402205500b004796c4f40dfmr16794615edb.18.1674300589520;
        Sat, 21 Jan 2023 03:29:49 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm5152151eda.17.2023.01.21.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:29:48 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/4] soc: qcom: socinfo: move SMEM item struct and defines to a header
Date:   Sat, 21 Jan 2023 12:29:44 +0100
Message-Id: <20230121112947.53433-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SMEM item struct and related defines to a header in order to be able
to reuse them in the Qualcomm NVMEM CPUFreq driver instead of duplicating
them.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/soc/qcom/socinfo.c       | 65 +-----------------------------
 include/linux/soc/qcom/socinfo.h | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 64 deletions(-)
 create mode 100644 include/linux/soc/qcom/socinfo.h

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 3b970a80f3aa..5919f863f369 100644
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
@@ -121,62 +113,7 @@ static const char *const pmic_models[] = {
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
-};
 
-#ifdef CONFIG_DEBUG_FS
 struct socinfo_params {
 	u32 raw_device_family;
 	u32 hw_plat_subtype;
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
new file mode 100644
index 000000000000..6a175d635617
--- /dev/null
+++ b/include/linux/soc/qcom/socinfo.h
@@ -0,0 +1,68 @@
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
+};
+
+#endif
-- 
2.39.1

