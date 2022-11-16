Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550C62C5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiKPRDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiKPRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:03:43 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C7D15A18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:42 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso699198wml.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsByD/1OWs5bmI3/YxWCflrJ7cqAVuJs4R5P7alGmUk=;
        b=QoU3RUBrlX9icO2dBhb6xT8ANjfdw6gOsVnj2i4jZQGlnEJcwKPMnervPHQ8xN+Pzw
         7AtUz87S38OOgpIC4BTOqXRnTfPRvnp48oowyc3nzBJfbuqKCUrpY9WlLSjBiLrqpVaU
         f2XN4bangieJMnKPXg+XrvsQyEoS7qbESoIvuFkTxWdiPyth/KE6O2OHkL3Rs+59tiPk
         VI238RrgqonL4ZhsrHQc+O8gZc8jI6YKIxiqPcoIJtwrNxG2GRWdB2llqA3og7JBRgny
         eKLCkBDyhKfu0CuIOALc08cqrscrphH3zAANhtdFsmSr/L4VO+2N4O29VviyRchyh+Rr
         jDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsByD/1OWs5bmI3/YxWCflrJ7cqAVuJs4R5P7alGmUk=;
        b=ZUgy/fxm+WwVRFMFOC6U9eBv/i3/R5IYXYURiTBKrsnWDCDJ1s7eD+Im1FnzQxQ7gj
         MGqZtJO/8qXeBLDIOQ6vuqoxkOYYA6p3ie9mGAAhQ16vJEKq3fXf297+i9e96PYUYlLg
         aJkBCxx9p3nSxnBQtW2phVRKXyYKTtqXMsqftdMd8XnXCfRw6xODy6RooWYgV0oWZVa5
         5s2e/RQUb2MYBWk48vj/jWiNM87eqTMKG+ihOr99EnbCZTPr/KX5LEjqaNznzX67uMA/
         +HCjqGV6iDkGlCKEJlXTUPaUz97SITtq2eNIHaDeh4m8JuT/oMm0tRWrby/xuaPpSJ96
         CyRA==
X-Gm-Message-State: ANoB5pkkiLS4l+ASZGm6N4+nwj+au/NO9W/Y3p/k1YrJWDCbRZAt9Rew
        tOMmXvfpLTRmLQzFdn8a4NSfqZ+0TEdK
X-Google-Smtp-Source: AA0mqf5ufR4hbciycDKUL0HlWb01ySkclL1nx8lUzdbC20+AxX1htABnFLyA1M8XBGED6AMm2DCaEkTPFDL4
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a5d:5707:0:b0:236:8130:56e3 with SMTP id
 a7-20020a5d5707000000b00236813056e3mr14904159wrv.371.1668618220591; Wed, 16
 Nov 2022 09:03:40 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:24 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-2-qperret@google.com>
Subject: [PATCH 01/12] firmware: arm_ffa: Move constants to header file
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

FF-A function IDs and error codes will be needed in the hypervisor too,
so move to them to the header file where they can be shared. Rename the
version constants with an "FFA_" prefix so that they are less likely
to clash with other code in the tree.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 101 +++---------------------------
 include/linux/arm_ffa.h           |  83 ++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 91 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index d5e86ef40b89..fa85c64d3ded 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -36,81 +36,6 @@
 #include "common.h"
 
 #define FFA_DRIVER_VERSION	FFA_VERSION_1_0
-
-#define FFA_SMC(calling_convention, func_num)				\
-	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, (calling_convention),	\
-			   ARM_SMCCC_OWNER_STANDARD, (func_num))
-
-#define FFA_SMC_32(func_num)	FFA_SMC(ARM_SMCCC_SMC_32, (func_num))
-#define FFA_SMC_64(func_num)	FFA_SMC(ARM_SMCCC_SMC_64, (func_num))
-
-#define FFA_ERROR			FFA_SMC_32(0x60)
-#define FFA_SUCCESS			FFA_SMC_32(0x61)
-#define FFA_INTERRUPT			FFA_SMC_32(0x62)
-#define FFA_VERSION			FFA_SMC_32(0x63)
-#define FFA_FEATURES			FFA_SMC_32(0x64)
-#define FFA_RX_RELEASE			FFA_SMC_32(0x65)
-#define FFA_RXTX_MAP			FFA_SMC_32(0x66)
-#define FFA_FN64_RXTX_MAP		FFA_SMC_64(0x66)
-#define FFA_RXTX_UNMAP			FFA_SMC_32(0x67)
-#define FFA_PARTITION_INFO_GET		FFA_SMC_32(0x68)
-#define FFA_ID_GET			FFA_SMC_32(0x69)
-#define FFA_MSG_POLL			FFA_SMC_32(0x6A)
-#define FFA_MSG_WAIT			FFA_SMC_32(0x6B)
-#define FFA_YIELD			FFA_SMC_32(0x6C)
-#define FFA_RUN				FFA_SMC_32(0x6D)
-#define FFA_MSG_SEND			FFA_SMC_32(0x6E)
-#define FFA_MSG_SEND_DIRECT_REQ		FFA_SMC_32(0x6F)
-#define FFA_FN64_MSG_SEND_DIRECT_REQ	FFA_SMC_64(0x6F)
-#define FFA_MSG_SEND_DIRECT_RESP	FFA_SMC_32(0x70)
-#define FFA_FN64_MSG_SEND_DIRECT_RESP	FFA_SMC_64(0x70)
-#define FFA_MEM_DONATE			FFA_SMC_32(0x71)
-#define FFA_FN64_MEM_DONATE		FFA_SMC_64(0x71)
-#define FFA_MEM_LEND			FFA_SMC_32(0x72)
-#define FFA_FN64_MEM_LEND		FFA_SMC_64(0x72)
-#define FFA_MEM_SHARE			FFA_SMC_32(0x73)
-#define FFA_FN64_MEM_SHARE		FFA_SMC_64(0x73)
-#define FFA_MEM_RETRIEVE_REQ		FFA_SMC_32(0x74)
-#define FFA_FN64_MEM_RETRIEVE_REQ	FFA_SMC_64(0x74)
-#define FFA_MEM_RETRIEVE_RESP		FFA_SMC_32(0x75)
-#define FFA_MEM_RELINQUISH		FFA_SMC_32(0x76)
-#define FFA_MEM_RECLAIM			FFA_SMC_32(0x77)
-#define FFA_MEM_OP_PAUSE		FFA_SMC_32(0x78)
-#define FFA_MEM_OP_RESUME		FFA_SMC_32(0x79)
-#define FFA_MEM_FRAG_RX			FFA_SMC_32(0x7A)
-#define FFA_MEM_FRAG_TX			FFA_SMC_32(0x7B)
-#define FFA_NORMAL_WORLD_RESUME		FFA_SMC_32(0x7C)
-
-/*
- * For some calls it is necessary to use SMC64 to pass or return 64-bit values.
- * For such calls FFA_FN_NATIVE(name) will choose the appropriate
- * (native-width) function ID.
- */
-#ifdef CONFIG_64BIT
-#define FFA_FN_NATIVE(name)	FFA_FN64_##name
-#else
-#define FFA_FN_NATIVE(name)	FFA_##name
-#endif
-
-/* FFA error codes. */
-#define FFA_RET_SUCCESS            (0)
-#define FFA_RET_NOT_SUPPORTED      (-1)
-#define FFA_RET_INVALID_PARAMETERS (-2)
-#define FFA_RET_NO_MEMORY          (-3)
-#define FFA_RET_BUSY               (-4)
-#define FFA_RET_INTERRUPTED        (-5)
-#define FFA_RET_DENIED             (-6)
-#define FFA_RET_RETRY              (-7)
-#define FFA_RET_ABORTED            (-8)
-
-#define MAJOR_VERSION_MASK	GENMASK(30, 16)
-#define MINOR_VERSION_MASK	GENMASK(15, 0)
-#define MAJOR_VERSION(x)	((u16)(FIELD_GET(MAJOR_VERSION_MASK, (x))))
-#define MINOR_VERSION(x)	((u16)(FIELD_GET(MINOR_VERSION_MASK, (x))))
-#define PACK_VERSION_INFO(major, minor)			\
-	(FIELD_PREP(MAJOR_VERSION_MASK, (major)) |	\
-	 FIELD_PREP(MINOR_VERSION_MASK, (minor)))
-#define FFA_VERSION_1_0		PACK_VERSION_INFO(1, 0)
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 
 #define SENDER_ID_MASK		GENMASK(31, 16)
@@ -120,12 +45,6 @@
 #define PACK_TARGET_INFO(s, r)		\
 	(FIELD_PREP(SENDER_ID_MASK, (s)) | FIELD_PREP(RECEIVER_ID_MASK, (r)))
 
-/*
- * FF-A specification mentions explicitly about '4K pages'. This should
- * not be confused with the kernel PAGE_SIZE, which is the translation
- * granule kernel is configured and may be one among 4K, 16K and 64K.
- */
-#define FFA_PAGE_SIZE		SZ_4K
 /*
  * Keeping RX TX buffer size as 4K for now
  * 64K may be preferred to keep it min a page in 64K PAGE_SIZE config
@@ -178,9 +97,9 @@ static struct ffa_drv_info *drv_info;
  */
 static u32 ffa_compatible_version_find(u32 version)
 {
-	u16 major = MAJOR_VERSION(version), minor = MINOR_VERSION(version);
-	u16 drv_major = MAJOR_VERSION(FFA_DRIVER_VERSION);
-	u16 drv_minor = MINOR_VERSION(FFA_DRIVER_VERSION);
+	u16 major = FFA_MAJOR_VERSION(version), minor = FFA_MINOR_VERSION(version);
+	u16 drv_major = FFA_MAJOR_VERSION(FFA_DRIVER_VERSION);
+	u16 drv_minor = FFA_MINOR_VERSION(FFA_DRIVER_VERSION);
 
 	if ((major < drv_major) || (major == drv_major && minor <= drv_minor))
 		return version;
@@ -204,16 +123,16 @@ static int ffa_version_check(u32 *version)
 
 	if (ver.a0 < FFA_MIN_VERSION) {
 		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
-		       MAJOR_VERSION(ver.a0), MINOR_VERSION(ver.a0),
-		       MAJOR_VERSION(FFA_MIN_VERSION),
-		       MINOR_VERSION(FFA_MIN_VERSION));
+		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(FFA_MIN_VERSION),
+		       FFA_MINOR_VERSION(FFA_MIN_VERSION));
 		return -EINVAL;
 	}
 
-	pr_info("Driver version %d.%d\n", MAJOR_VERSION(FFA_DRIVER_VERSION),
-		MINOR_VERSION(FFA_DRIVER_VERSION));
-	pr_info("Firmware version %d.%d found\n", MAJOR_VERSION(ver.a0),
-		MINOR_VERSION(ver.a0));
+	pr_info("Driver version %d.%d\n", FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
+		FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
+	pr_info("Firmware version %d.%d found\n", FFA_MAJOR_VERSION(ver.a0),
+		FFA_MINOR_VERSION(ver.a0));
 	*version = ffa_compatible_version_find(ver.a0);
 
 	return 0;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 5f02d2e6b9d9..daff44d777fa 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -11,6 +11,89 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 
+#define FFA_SMC(calling_convention, func_num)				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, (calling_convention),	\
+			   ARM_SMCCC_OWNER_STANDARD, (func_num))
+
+#define FFA_SMC_32(func_num)	FFA_SMC(ARM_SMCCC_SMC_32, (func_num))
+#define FFA_SMC_64(func_num)	FFA_SMC(ARM_SMCCC_SMC_64, (func_num))
+
+#define FFA_ERROR			FFA_SMC_32(0x60)
+#define FFA_SUCCESS			FFA_SMC_32(0x61)
+#define FFA_INTERRUPT			FFA_SMC_32(0x62)
+#define FFA_VERSION			FFA_SMC_32(0x63)
+#define FFA_FEATURES			FFA_SMC_32(0x64)
+#define FFA_RX_RELEASE			FFA_SMC_32(0x65)
+#define FFA_RXTX_MAP			FFA_SMC_32(0x66)
+#define FFA_FN64_RXTX_MAP		FFA_SMC_64(0x66)
+#define FFA_RXTX_UNMAP			FFA_SMC_32(0x67)
+#define FFA_PARTITION_INFO_GET		FFA_SMC_32(0x68)
+#define FFA_ID_GET			FFA_SMC_32(0x69)
+#define FFA_MSG_POLL			FFA_SMC_32(0x6A)
+#define FFA_MSG_WAIT			FFA_SMC_32(0x6B)
+#define FFA_YIELD			FFA_SMC_32(0x6C)
+#define FFA_RUN				FFA_SMC_32(0x6D)
+#define FFA_MSG_SEND			FFA_SMC_32(0x6E)
+#define FFA_MSG_SEND_DIRECT_REQ		FFA_SMC_32(0x6F)
+#define FFA_FN64_MSG_SEND_DIRECT_REQ	FFA_SMC_64(0x6F)
+#define FFA_MSG_SEND_DIRECT_RESP	FFA_SMC_32(0x70)
+#define FFA_FN64_MSG_SEND_DIRECT_RESP	FFA_SMC_64(0x70)
+#define FFA_MEM_DONATE			FFA_SMC_32(0x71)
+#define FFA_FN64_MEM_DONATE		FFA_SMC_64(0x71)
+#define FFA_MEM_LEND			FFA_SMC_32(0x72)
+#define FFA_FN64_MEM_LEND		FFA_SMC_64(0x72)
+#define FFA_MEM_SHARE			FFA_SMC_32(0x73)
+#define FFA_FN64_MEM_SHARE		FFA_SMC_64(0x73)
+#define FFA_MEM_RETRIEVE_REQ		FFA_SMC_32(0x74)
+#define FFA_FN64_MEM_RETRIEVE_REQ	FFA_SMC_64(0x74)
+#define FFA_MEM_RETRIEVE_RESP		FFA_SMC_32(0x75)
+#define FFA_MEM_RELINQUISH		FFA_SMC_32(0x76)
+#define FFA_MEM_RECLAIM			FFA_SMC_32(0x77)
+#define FFA_MEM_OP_PAUSE		FFA_SMC_32(0x78)
+#define FFA_MEM_OP_RESUME		FFA_SMC_32(0x79)
+#define FFA_MEM_FRAG_RX			FFA_SMC_32(0x7A)
+#define FFA_MEM_FRAG_TX			FFA_SMC_32(0x7B)
+#define FFA_NORMAL_WORLD_RESUME		FFA_SMC_32(0x7C)
+
+/*
+ * For some calls it is necessary to use SMC64 to pass or return 64-bit values.
+ * For such calls FFA_FN_NATIVE(name) will choose the appropriate
+ * (native-width) function ID.
+ */
+#ifdef CONFIG_64BIT
+#define FFA_FN_NATIVE(name)	FFA_FN64_##name
+#else
+#define FFA_FN_NATIVE(name)	FFA_##name
+#endif
+
+/* FFA error codes. */
+#define FFA_RET_SUCCESS            (0)
+#define FFA_RET_NOT_SUPPORTED      (-1)
+#define FFA_RET_INVALID_PARAMETERS (-2)
+#define FFA_RET_NO_MEMORY          (-3)
+#define FFA_RET_BUSY               (-4)
+#define FFA_RET_INTERRUPTED        (-5)
+#define FFA_RET_DENIED             (-6)
+#define FFA_RET_RETRY              (-7)
+#define FFA_RET_ABORTED            (-8)
+
+/* FFA version encoding */
+#define FFA_MAJOR_VERSION_MASK	GENMASK(30, 16)
+#define FFA_MINOR_VERSION_MASK	GENMASK(15, 0)
+#define FFA_MAJOR_VERSION(x)	((u16)(FIELD_GET(FFA_MAJOR_VERSION_MASK, (x))))
+#define FFA_MINOR_VERSION(x)	((u16)(FIELD_GET(FFA_MINOR_VERSION_MASK, (x))))
+#define FFA_PACK_VERSION_INFO(major, minor)			\
+	(FIELD_PREP(FFA_MAJOR_VERSION_MASK, (major)) |		\
+	 FIELD_PREP(FFA_MINOR_VERSION_MASK, (minor)))
+#define FFA_VERSION_1_0		FFA_PACK_VERSION_INFO(1, 0)
+
+/**
+ * FF-A specification mentions explicitly about '4K pages'. This should
+ * not be confused with the kernel PAGE_SIZE, which is the translation
+ * granule kernel is configured and may be one among 4K, 16K and 64K.
+ */
+#define FFA_PAGE_SIZE		SZ_4K
+
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
 	int vm_id;
-- 
2.38.1.431.g37b22c650d-goog

