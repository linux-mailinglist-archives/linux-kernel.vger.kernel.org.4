Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B946A1070
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBWTRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjBWTQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:16:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59885D457
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:16:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q23so855344pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZmB3oxw0sEuwWH0AhTBpjzLgYhj9vuO5mfnqs5kkq4=;
        b=Z8h3WFffSkg/m3Yw6dFBIh9GS/LOH/777ZGIANndeXQzVa5fs041T+RsuZVSM6LqMc
         O9bMnb9aZDFhPkYCCKXPBxXTIT7GGTQRTGYxOCDkOVkFbEn0mTfI8U/gZNu6rlCevqTz
         4bw3947lHc0Pp72EU3sggNhGjtg3JgdTuPGrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZmB3oxw0sEuwWH0AhTBpjzLgYhj9vuO5mfnqs5kkq4=;
        b=0+9vgomatpqj3dFJTyLmXAkI5shnDP/9Tdt/L+2VZUm4i7o5oPEHMxg1NOiu+NXE8X
         /aMdrC7cebULEydYqN0bBxWnVi3Fptue2jVopHkWh3BIPbJ72msa9vrEenFIeCBiRm17
         SsM2kXE+8SQ5ivvZuXmSDGCVnlXCSC5loC6KFxS/QdrL6+IUzwFlQiVGNT4MlL5ViQ0I
         CwfGbzdpXraZBvBHJ0JQ6OnMEGl+FhLjYxYrua+gpKYdzqndUuMCSzFNR+H1Ie6XAhgU
         XlFuaC+/R6M5TsvzjpQzkC5Ht1XRfbkEZfulAh37s9dnutMPtdxV7s5vp/0nkUulVbtt
         GvDg==
X-Gm-Message-State: AO0yUKWn2YTgDBNY0tyPFDYZlvhoIiNvNr4ZXqHJr+8eM+KXvkewgv86
        kG2pclZUyy4hk9ab1w555x5xvA==
X-Google-Smtp-Source: AK7set/UCb33LbT2BQFVAqmpkqCOVSrKb5Sh3R0bpDfpZjQO0rZ4h31vFlaN35ZCxTtLvFkWJRk8IA==
X-Received: by 2002:a05:6a00:45:b0:5dd:3f84:7d32 with SMTP id i5-20020a056a00004500b005dd3f847d32mr2739171pfk.1.1677179686892;
        Thu, 23 Feb 2023 11:14:46 -0800 (PST)
Received: from wafflehead.lan ([47.144.140.44])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b005dd65169623sm1619572pfe.190.2023.02.23.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:14:46 -0800 (PST)
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
X-Google-Original-From: Jeffrey Kardatzke <jkardatzke@google.com>
To:     op-tee@lists.trustedfirmware.org
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tee: optee: Add SMC for loading OP-TEE image
Date:   Thu, 23 Feb 2023 11:14:40 -0800
Message-Id: <20230223111415.v2.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an SMC call that will pass an OP-TEE binary image to EL3 and
instruct it to load it as the BL32 payload. This works in conjunction
with a feature added to Trusted Firmware for ARM that supports this.

Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
---

Changes in v2:
- Fixed compile issue when feature is disabled
- Addressed minor comments
- Added state tracking for driver reload

 drivers/tee/optee/Kconfig     | 10 +++++
 drivers/tee/optee/optee_smc.h | 22 ++++++++++
 drivers/tee/optee/smc_abi.c   | 82 +++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index f121c224e682..f0f12b146add 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -7,3 +7,13 @@ config OPTEE
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
+
+config OPTEE_LOAD_IMAGE
+	bool "Load OP-TEE image as firmware"
+	default n
+	depends on OPTEE
+	help
+	  This loads the BL32 image for OP-TEE as firmware when the driver is probed.
+	  This returns -EPROBE_DEFER until the firmware is loadable from the
+	  filesystem which is determined by checking the system_state until it is in
+	  SYSTEM_RUNNING.
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..a24c524b44fa 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
 	unsigned long reserved1;
 };
 
+/*
+ * Load Trusted OS from optee/tee.bin in the Linux firmware.
+ *
+ * WARNING: Use this cautiously as it could lead to insecure loading of the
+ * Trusted OS.
+ * This SMC instructs EL3 to load a binary and execute it as the Trusted OS.
+ *
+ * Call register usage:
+ * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
+ * a1 Upper 32bit of a 64bit size for the payload
+ * a2 Lower 32bit of a 64bit size for the payload
+ * a3 Upper 32bit of the physical address for the payload
+ * a4 Lower 32bit of the physical address for the payload
+ *
+ * The payload is in the OP-TEE image format.
+ *
+ * Returns result in a0, 0 on success and an error code otherwise.
+ */
+#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
+#define OPTEE_SMC_CALL_LOAD_IMAGE \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
+
 /*
  * Call with struct optee_msg_arg as argument
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..79ddfb0f9aca 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -8,9 +8,11 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
+#include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1354,6 +1356,82 @@ static void optee_shutdown(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 }
 
+#ifdef CONFIG_OPTEE_LOAD_IMAGE
+
+#define OPTEE_FW_IMAGE "optee/tee.bin"
+
+static int optee_load_fw(struct platform_device *pdev,
+			 optee_invoke_fn *invoke_fn)
+{
+	const struct firmware *fw = NULL;
+	struct arm_smccc_res res;
+	phys_addr_t data_pa;
+	u8 *data_buf = NULL;
+	u64 data_size;
+	u32 data_pa_high, data_pa_low;
+	u32 data_size_high, data_size_low;
+	static int rc;
+	static bool already_loaded;
+
+	if (already_loaded)
+		return rc;
+
+	rc = request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
+	if (rc) {
+		/*
+		 * The firmware in the rootfs will not be accessible until we
+		 * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
+		 * that point.
+		 */
+		if (system_state < SYSTEM_RUNNING)
+			return -EPROBE_DEFER;
+		goto fw_err;
+	}
+
+	data_size = fw->size;
+	/*
+	 * This uses the GFP_DMA flag to ensure we are allocated memory in the
+	 * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
+	 */
+	data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
+	if (!data_buf) {
+		rc = -ENOMEM;
+		goto fw_err;
+	}
+	memcpy(data_buf, fw->data, fw->size);
+	data_pa = virt_to_phys(data_buf);
+	reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
+	reg_pair_from_64(&data_size_high, &data_size_low, data_size);
+	goto fw_load;
+
+fw_err:
+	pr_warn("image loading failed\n");
+	data_pa_high = data_pa_low = data_size_high = data_size_low = 0;
+
+fw_load:
+	/*
+	 * Always invoke the SMC, even if loading the image fails, to indicate
+	 * to EL3 that we have passed the point where it should allow invoking
+	 * this SMC.
+	 */
+	invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
+		  data_pa_high, data_pa_low, 0, 0, 0, &res);
+	if (!rc)
+		rc = res.a0;
+	if (fw)
+		release_firmware(fw);
+	kfree(data_buf);
+	already_loaded = true;
+
+	return rc;
+}
+#else
+static inline int optee_load_fw(struct platform_device *__unused1,
+		optee_invoke_fn *__unused2) {
+	return 0;
+}
+#endif
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1372,6 +1450,10 @@ static int optee_probe(struct platform_device *pdev)
 	if (IS_ERR(invoke_fn))
 		return PTR_ERR(invoke_fn);
 
+	rc = optee_load_fw(pdev, invoke_fn);
+	if (rc)
+		return rc;
+
 	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
 		pr_warn("api uid mismatch\n");
 		return -EINVAL;
-- 
2.39.2.637.g21b0678d19-goog

