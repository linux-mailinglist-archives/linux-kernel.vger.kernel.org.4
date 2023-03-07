Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060366AF61A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCGTtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:49:14 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C359B9513
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:40:08 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a2so15327608plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678217988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UOGTv/sy1Z+ufcDr3CebSp0hI8rsj2NGTtQtmuZSfA=;
        b=QIrfJlu6S37fKNAv22docAWgHY3owh5hjxGStkQD+zcP6y5HVNAOduzN3cqkwlT1Qb
         FVeZ8IeWE74wbr2IORGJ3Yxc2r0r6Q6FBVkg2aSDbWttcf1Spq14EoYLt7smmvODiMRp
         zEQdMdWFN9U9IrrSK4FbpZ9xLe/gl9NIe+1bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678217988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UOGTv/sy1Z+ufcDr3CebSp0hI8rsj2NGTtQtmuZSfA=;
        b=giy0HhnzqVQyrQ9/SW9WqGI9StBjxx23sFE+ULFxS46xEkYeN6lQIlek4qBicTWX8D
         WiNt+/pbQ/kW0NB8dQQWimI9NuFGx3+NZAdN21oGw3EGG3A/Oo4XyXUiIonSoUTCPFsj
         s3xKz09eVrSHPTfUSoZOWHSLTYFwKw9TlMvn307F1W8fDNTn56a3XWQzlugRHZM0ET2I
         xIB/mtNWlhDVkOczCUwndfE2o++tWGoNuwRs4XhuiiENdrimPWvDSKD2kNNebH0XxGuu
         1/70ZB7WtHh8gjW75iQnrgT2w6cj0WDvz8vBqe5XNBr2pzpqarCjF3mYy4KMjFEXpt4s
         HlIA==
X-Gm-Message-State: AO0yUKU1GzhENPLj1vS8NwbG1gAX8IVp/UMDTMnAfPwuLc1N2s/qTkok
        mQTgfBqccdMgIy4lsr2kRv/ooA==
X-Google-Smtp-Source: AK7set9g7oaRbQRae01HvxBX6jSuJS5skRqs3cOn0tc8nijeYP1Ulwxv0TauaSOBe1glLA52Kf66qA==
X-Received: by 2002:a17:903:1d2:b0:19d:19fb:55fd with SMTP id e18-20020a17090301d200b0019d19fb55fdmr20015596plh.20.1678217987896;
        Tue, 07 Mar 2023 11:39:47 -0800 (PST)
Received: from wafflehead.lan ([47.144.140.44])
        by smtp.gmail.com with ESMTPSA id kt4-20020a170903088400b00186cf82717fsm8811725plb.165.2023.03.07.11.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 11:39:47 -0800 (PST)
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
X-Google-Original-From: Jeffrey Kardatzke <jkardatzke@google.com>
To:     op-tee@lists.trustedfirmware.org
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] tee: optee: Add SMC for loading OP-TEE image
Date:   Tue,  7 Mar 2023 11:39:43 -0800
Message-Id: <20230307113921.v5.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an SMC call that will pass an OP-TEE binary image to EL3 and
instruct it to load it as the BL32 payload. This works in conjunction
with a feature added to Trusted Firmware for ARMv8 and above
architectures that supports this.

The main purpose of this change is to facilitate updating the OP-TEE
component on devices via a rootfs change rather than having to do a
firmware update. Further details are linked to in the Kconfig file.

Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
---

Changes in v5:
- Renamed config option
- Added runtime warning when config is used

Changes in v4:
- Update commit message
- Added more documentation
- Renamed config option, added ARM64 dependency

Changes in v3:
- Removed state tracking for driver reload
- Check UID of service to verify it needs image load

Changes in v2:
- Fixed compile issue when feature is disabled
- Addressed minor comments
- Added state tracking for driver reload

 drivers/tee/optee/Kconfig     | 13 +++++
 drivers/tee/optee/optee_msg.h | 12 +++++
 drivers/tee/optee/optee_smc.h | 24 +++++++++
 drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index f121c224e682..fc5b0d6fbf3a 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -7,3 +7,16 @@ config OPTEE
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
+
+config OPTEE_INSECURE_LOAD_IMAGE
+	bool "Load OP-TEE image as firmware"
+	default n
+	depends on OPTEE && ARM64
+	help
+	  This loads the BL32 image for OP-TEE as firmware when the driver is probed.
+	  This returns -EPROBE_DEFER until the firmware is loadable from the
+	  filesystem which is determined by checking the system_state until it is in
+	  SYSTEM_RUNNING. This also requires enabling the corresponding option in
+	  Trusted Firmware for Arm. The documentation there explains the security
+	  threat associated with enabling this as well as mitigations.
+	  https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 70e9cc2ee96b..e8840a82b983 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -241,11 +241,23 @@ struct optee_msg_arg {
  * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
  * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
  * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
+ *
+ * In the case where the OP-TEE image is loaded by the kernel, this will
+ * initially return an alternate UID to reflect that we are communicating with
+ * the TF-A image loading service at that time instead of OP-TEE. That UID is:
+ * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
+ * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
+ * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
+ * OPTEE_MSG_IMAGE_LOAD_UID_3.
  */
 #define OPTEE_MSG_UID_0			0x384fb3e0
 #define OPTEE_MSG_UID_1			0xe7f811e3
 #define OPTEE_MSG_UID_2			0xaf630002
 #define OPTEE_MSG_UID_3			0xa5d5c51b
+#define OPTEE_MSG_IMAGE_LOAD_UID_0	0xa3fbeab1
+#define OPTEE_MSG_IMAGE_LOAD_UID_1	0x1246315d
+#define OPTEE_MSG_IMAGE_LOAD_UID_2	0xc7c406b9
+#define OPTEE_MSG_IMAGE_LOAD_UID_3	0xc03cbea4
 #define OPTEE_MSG_FUNCID_CALLS_UID	0xFF01
 
 /*
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..7d9fa426505b 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
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
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+			   ARM_SMCCC_OWNER_TRUSTED_OS_END, \
+			   OPTEE_SMC_FUNCID_LOAD_IMAGE)
+
 /*
  * Call with struct optee_msg_arg as argument
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..00b6b69b6f79 100644
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
@@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
 	return false;
 }
 
+#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
+static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
+{
+	struct arm_smccc_res res;
+
+	invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 == OPTEE_MSG_IMAGE_LOAD_UID_0 &&
+	   res.a1 == OPTEE_MSG_IMAGE_LOAD_UID_1 &&
+	   res.a2 == OPTEE_MSG_IMAGE_LOAD_UID_2 &&
+	   res.a3 == OPTEE_MSG_IMAGE_LOAD_UID_3)
+		return true;
+	return false;
+}
+#endif
+
 static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 {
 	union {
@@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 }
 
+#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
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
+	int rc;
+
+	if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
+		return 0;
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
+	pr_warn("OP-TEE image loaded from kernel, this can be insecure");
+	invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
+		  data_pa_high, data_pa_low, 0, 0, 0, &res);
+	if (!rc)
+		rc = res.a0;
+	if (fw)
+		release_firmware(fw);
+	kfree(data_buf);
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
@@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_device *pdev)
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
2.40.0.rc0.216.gc4246ad0f0-goog

