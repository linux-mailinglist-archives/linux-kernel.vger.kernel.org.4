Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2496BBDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjCOUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCOUUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:20:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9732CED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:20:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rj10so9596665pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678911650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqbGZLWr0KWU9/UpJ1p6Wtn690UdoKWTdl+mI6+1h/g=;
        b=MQ6zSOw2gmsMOwFfpf4r3l/G1fZA22SNE8TY/K5QKefF2YtZNwrOU7lTn7/ZCdtRU8
         B9VAbAWqf0fYPah4eKmeZvNsB//eD0bVnNqyWRHUyB8EpbFJ+khfeHrsbg4UVYmUEaUA
         NnJBdm9J4ZjXQWUVT1GWpjCLvOxQ/3NrATbfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678911650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqbGZLWr0KWU9/UpJ1p6Wtn690UdoKWTdl+mI6+1h/g=;
        b=J+muB2SxJq6CzxzEPBVGuRH4MiTEKj9KaQIDY/qnheAKkwkX+5jLrmQqO3NJmf9Wqx
         muivxqZLGrxIMADY+0snnq6Dl6OneXQ4Q3/J3LeYCyv8XkLYWe+H6FBgFNUCJhd57AyJ
         YJvHRIIYePRQZ0wJAs61FXW043e6QRRxz6FQjwTCFGSwzbuxx3ng9VMN4BdhwjowHttn
         M8IQHsusGbHHkwNJ+2tN7vK5sOEnJwl6W8YKHPWa7YR8tkMfz4cexMP0DTrBdumVJYy5
         fi04JHAK3FEEtqddm3/DloPBdxKyCqg6gRlfqjfzJ1weiyK5Xw3bqIFVAWIprbunP4gx
         G3Xw==
X-Gm-Message-State: AO0yUKWNVUHA3jkNAAffhqGWkOsbuidS2Kju1NDNn/VQ5AaMY4ap7NCc
        wFEPNnVP9dl7cRHjMGHGv+kqZA==
X-Google-Smtp-Source: AK7set9flnCOGx5jJKAqIjXTLhZ+YNC0LrBnpJuxsUyfTyRh3EK7LeZ0S5oiWZpLc66m2a2BDF5yfw==
X-Received: by 2002:a17:902:cf48:b0:1a0:48ff:538d with SMTP id e8-20020a170902cf4800b001a048ff538dmr702135plg.36.1678911649905;
        Wed, 15 Mar 2023 13:20:49 -0700 (PDT)
Received: from wafflehead.lan ([47.144.140.44])
        by smtp.gmail.com with ESMTPSA id lg11-20020a170902fb8b00b0019f1205bdcbsm4029602plb.147.2023.03.15.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:20:49 -0700 (PDT)
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
X-Google-Original-From: Jeffrey Kardatzke <jkardatzke@google.com>
To:     op-tee@lists.trustedfirmware.org
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Garg <sumit.garg@linaro.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10] tee: optee: Add SMC for loading OP-TEE image
Date:   Wed, 15 Mar 2023 13:20:46 -0700
Message-Id: <20230315132040.v10.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

Changes in v10:
- Fixed tee.rst documentation formatting

Changes in v9:
- Add CPU hotplug callback to init on all cores at startup

Changes in v8:
- Renamed params and fixed alignment issue

Changes in v7:
- Added documentation to Documentation/staging/tee.rst

Changes in v6:
- Expanded Kconfig documentation

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

 Documentation/staging/tee.rst |  41 +++++++++++
 drivers/tee/optee/Kconfig     |  17 +++++
 drivers/tee/optee/optee_msg.h |  12 +++
 drivers/tee/optee/optee_smc.h |  24 ++++++
 drivers/tee/optee/smc_abi.c   | 134 ++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)

diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 498343c7ab08..6e90ee726880 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -214,6 +214,47 @@ call is done from the thread assisting the interrupt handler. This is a
 building block for OP-TEE OS in secure world to implement the top half and
 bottom half style of device drivers.
 
+OPTEE_INSECURE_LOAD_IMAGE Kconfig option
+----------------------------------------
+
+The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
+BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
+it from the firmware before the kernel boots. This also requires enabling the
+corresponding option in Trusted Firmware for Arm. The documentation there
+explains the security threat associated with enabling this as well as
+mitigations at the firmware and platform level.
+https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
+
+There are additional attack vectors/mitigations for the kernel that should be
+addressed when using this option.
+
+1. Boot chain security.
+   Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
+   the system.
+   Migitation: There must be boot chain security that verifies the kernel and
+   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
+   modifying it in the rootfs.
+2. Alternate boot modes.
+   Attack vector: Using an alternate boot mode (i.e. recovery mode), the OP-TEE
+   driver isn't loaded, leaving the SMC hole open.
+   Mitigation: If there are alternate methods of booting the device, such as a
+   recovery mode, it should be ensured that the same mitigations are applied in
+   that mode.
+3. Attacks prior to SMC invocation.
+   Attack vector: Code that is executed prior to issuing the SMC call to load
+   OP-TEE can be exploited to then load an alternate OS image.
+   Mitigation: The OP-TEE driver must be loaded before any potential attack
+   vectors are opened up. This should include mounting of any modifiable
+   filesystems, opening of network ports or communicating with external devices
+   (e.g. USB).
+4. Blocking SMC call to load OP-TEE.
+   Attack vector: Prevent the driver from being probed, so the SMC call to load
+   OP-TEE isn't executed when desired, leaving it open to being executed later
+   and loading a modified OS.
+   Mitigation: It is recommended to build the OP-TEE driver as an included
+   driver rather than a module to prevent exploits that may cause the module to
+   not be loaded.
+
 AMD-TEE driver
 ==============
 
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index f121c224e682..70898bbd5809 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -7,3 +7,20 @@ config OPTEE
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
+
+config OPTEE_INSECURE_LOAD_IMAGE
+	bool "Load OP-TEE image as firmware"
+	default n
+	depends on OPTEE && ARM64
+	help
+	  This loads the BL32 image for OP-TEE as firmware when the driver is
+	  probed. This returns -EPROBE_DEFER until the firmware is loadable from
+	  the filesystem which is determined by checking the system_state until
+	  it is in SYSTEM_RUNNING. This also requires enabling the corresponding
+	  option in Trusted Firmware for Arm. The documentation there explains
+	  the security threat associated with enabling this as well as
+	  mitigations at the firmware and platform level.
+	  https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
+
+	  Additional documentation on kernel security risks are at
+	  Documentation/staging/tee.rst.
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
index a1c1fa1a9c28..fcbcd0c0c3aa 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -7,10 +7,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/arm-smccc.h>
+#include <linux/cpuhotplug.h>
 #include <linux/errno.h>
+#include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1149,6 +1152,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
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
@@ -1354,6 +1373,117 @@ static void optee_shutdown(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 }
 
+#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
+
+#define OPTEE_FW_IMAGE "optee/tee.bin"
+
+static optee_invoke_fn *cpuhp_invoke_fn;
+
+static int optee_cpuhp_probe(unsigned int cpu)
+{
+	/*
+	 * Invoking a call on a CPU will cause OP-TEE to perform the required
+	 * setup for that CPU. Just invoke the call to get the UID since that
+	 * has no side effects.
+	 */
+	if (optee_msg_api_uid_is_optee_api(cpuhp_invoke_fn))
+		return 0;
+	else
+		return -EINVAL;
+}
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
+	int hp_state;
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
+	if (!rc) {
+		/*
+		 * We need to initialize OP-TEE on all other running cores as
+		 * well. Any cores that aren't running yet will get initialized
+		 * when they are brought up by the power management functions in
+		 * TF-A which are registered by the OP-TEE SPD. Due to that we
+		 * can un-register the callback right after registering it.
+		 */
+		cpuhp_invoke_fn = invoke_fn;
+		hp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "optee:probe",
+					     optee_cpuhp_probe, NULL);
+		if (hp_state < 0) {
+			pr_warn("Failed with CPU hotplug setup for OP-TEE");
+			return -EINVAL;
+		}
+		cpuhp_remove_state(hp_state);
+		cpuhp_invoke_fn = NULL;
+	}
+
+	return rc;
+}
+#else
+static inline int optee_load_fw(struct platform_device *pdev,
+				optee_invoke_fn *invoke_fn)
+{
+	return 0;
+}
+#endif
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1372,6 +1502,10 @@ static int optee_probe(struct platform_device *pdev)
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
2.40.0.rc1.284.g88254d51c5-goog

