Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5B69FA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBVRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjBVRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:25:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3253E613
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:25:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso9734656pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/vKY8efXwJlWV2R5XdjcQCevxXyt2eDJIlAUvt74B8=;
        b=QzEPkHQCaEmfpk5TNUfwn52wB2AmAMdC2WYXj9o1BpFyISVIcuBp5QDG5/OIELWlmK
         4e/lqZlmn4dr1v8P/VYIFjvW8jGj6X0uY69dTsBCefagV1TSew5KggKNNm0LgpF02thl
         VjFwV8q9mmJurjUypPshBo/ENrJz5kETQaz9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/vKY8efXwJlWV2R5XdjcQCevxXyt2eDJIlAUvt74B8=;
        b=BL6v3ASfvkS2voVaAM4pe+atNrP6815sh9mThN2mEDmRQGz8BllRVMg5hAaQJtRQ03
         sMPYUmTE/vgvoPcTpvon0iVZPwXxCyOL5hE7EdK2Xx2suqNkjiZyluxb9P8nt5IBCHUI
         Jb7BKiLmgFF2K90r075BT84G0tbTOjAXEfWv1Ira309MB5B7YXL3BUZ4ORHAl/ixMzF5
         HrTDiDfrFqDPry8wQ+/HbiTA2MmJfLsoxvhidjhnHu4k/JVwCfEG9qHskQL24V/n7Jkg
         /8DO2oNrUppFo46zKcruHWI6p7og/CYWcoaXgUmU6XaLVb6skRo3JeAcXUZR6qYDhZ3P
         4DzA==
X-Gm-Message-State: AO0yUKV3CE15O9VqYztrGflAZ9b5mRM5Zw/Ahj238jmWdPSTuRgM9CIe
        r3CiMzoWJf9zLjFchsqWSYEVETTUt5NlirCL8tc=
X-Google-Smtp-Source: AK7set/CNBu5jxrwqBNQpw8Ix53VvIyyhmYP0muLIt4gsQXEPag9cyyQtaut5zrwX7+uXkPHfope8A==
X-Received: by 2002:a05:6a20:6910:b0:cb:ac6c:13d3 with SMTP id q16-20020a056a20691000b000cbac6c13d3mr5698779pzj.21.1677086693695;
        Wed, 22 Feb 2023 09:24:53 -0800 (PST)
Received: from wafflehead.lan ([47.144.140.44])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b005023496e339sm5186772pga.63.2023.02.22.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:24:53 -0800 (PST)
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
X-Google-Original-From: Jeffrey Kardatzke <jkardatzke@google.com>
To:     op-tee@lists.trustedfirmware.org
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date:   Wed, 22 Feb 2023 09:24:25 -0800
Message-Id: <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
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

 drivers/tee/optee/Kconfig     | 10 +++++
 drivers/tee/optee/optee_msg.h | 14 +++++++
 drivers/tee/optee/optee_smc.h | 22 ++++++++++
 drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index f121c224e682..5ffbeb3eaac0 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -7,3 +7,13 @@ config OPTEE
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
+
+config OPTEE_LOAD_IMAGE
+	bool "Load Op-Tee image as firmware"
+	default n
+	depends on OPTEE
+	help
+	  This loads the BL32 image for OP-TEE as firmware when the driver is probed.
+	  This returns -EPROBE_DEFER until the firmware is loadable from the
+	  filesystem which is determined by checking the system_state until it is in
+	  SYSTEM_RUNNING.
diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 70e9cc2ee96b..84c1b15032a9 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -284,6 +284,20 @@ struct optee_msg_arg {
  */
 #define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
 
+/*
+ * Load Trusted OS from optee/tee.bin in the Linux firmware.
+ *
+ * WARNING: Use this cautiously as it could lead to insecure loading of the
+ * Trusted OS.
+ * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
+ * The first two params are the high and low 32 bits of the size of the payload
+ * and the third and fourth params are the high and low 32 bits of the physical
+ * address of the payload. The payload is in the OP-TEE image format.
+ *
+ * Returns 0 on success and an error code otherwise.
+ */
+#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
+
 /*
  * Do a secure call with struct optee_msg_arg as argument
  * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..908b1005e9db 100644
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
+ * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
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
+#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
+#define OPTEE_SMC_CALL_LOAD_IMAGE \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
+
 /*
  * Call with struct optee_msg_arg as argument
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..c1abbee86b39 100644
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
@@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform_device *pdev)
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
+	int rc;
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
+
+	return rc;
+}
+#else
+static inline int optee_load_fw(struct platform_device *__unused,
+		optee_invoke_fn *__unused) {
+	return 0;
+}
+#endif
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
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

