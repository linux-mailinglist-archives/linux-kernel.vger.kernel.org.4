Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D467EDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjA0Sr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjA0SrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:47:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA487C722;
        Fri, 27 Jan 2023 10:47:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so4092316wms.2;
        Fri, 27 Jan 2023 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhE/sba/7+MJ7KSQEe7l9pdIXGfdbfeTrTTyOdFg190=;
        b=E+wqSE6AVWlfycu7BC06yb/UxQQWXFO4KrZPRMX0tCqYpOqrR/m8IWXOezpUlaihb/
         Keu5hE3SstXqcdXstEyznseMkb82TxAMRyoTEX+UN+GwOIydXZEOpCHWLMIO9M/yfmQd
         ANrrALrfwz6EWJ3viGLnEVUY/NJeaDiInqshOsbFR1yh5xIc9GeLWLDz9i8rXwGzxVYe
         XebJhT+MsVjhe/+jVfqmcRZiBZ3ndA7m8Vkj7vu3rJh0p5V1SdI7CS2HIbLMu2gCJtFj
         DFblcGNV+ZUrMhSH/oLG/ssUImCGMZ6VXS3ZXjbrpRU0nmKOA5ShvG+ShqZ7jqbn9KWy
         hPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhE/sba/7+MJ7KSQEe7l9pdIXGfdbfeTrTTyOdFg190=;
        b=rqR6SxRdYMWe/4kfv4jPZ6TD688cAOYc8HmMbwMgwGiPq7FI/T6kO5dL50ztNDQrg/
         bYDf85y8yN0Xcxjj0w57ZTmQOsfFUYtFF+sRGC2WVGkUNrJQ76NtkGSAfz8mxGtp0Sqa
         VntqoYmeieaOJKsp+ueIYPbs3amm6g9tWDnj5l8Xy9sYWvAeKoJyicxs3zEJ5ILytlIg
         wpY48DAYdReQSFQOaJYzGHatL/kK8XICp6SS4+UdsDpn2sp3046/Rhx5eCWh3/ravHAK
         yY4+crLNySlVeI5RcH+oAahX6YsZ7dEnKpMVjOl9x2038xWMJMnZGT+zf2cGjyiTQmdb
         uArQ==
X-Gm-Message-State: AO0yUKW8BWPLvqWXms+6wYUySOBJyC8b/7MI13yvkTbc7b/gDCxBIKcj
        lFN1TgPtAdYWqdRKnbA5DzY=
X-Google-Smtp-Source: AK7set8T/mOGxOYz/yloHk+2/H/tf2zGv9gXEgCrOatyuf4Wq864niUQXBj6l2PLZzXLk5NLkg7k/Q==
X-Received: by 2002:a05:600c:4f93:b0:3dc:2b62:ee9f with SMTP id n19-20020a05600c4f9300b003dc2b62ee9fmr6891769wmq.3.1674845226074;
        Fri, 27 Jan 2023 10:47:06 -0800 (PST)
Received: from xws.localdomain (pd9ea339c.dip0.t-ipconnect.de. [217.234.51.156])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm16234208wmo.2.2023.01.27.10.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:47:05 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Fri, 27 Jan 2023 19:46:50 +0100
Message-Id: <20230127184650.756795-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127184650.756795-1-luzmaximilian@gmail.com>
References: <20230127184650.756795-1-luzmaximilian@gmail.com>
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

On platforms using the Qualcomm UEFI Secure Application (uefisecapp),
EFI variables cannot be accessed via the standard interface in EFI
runtime mode. The respective functions return EFI_UNSUPPORTED. On these
platforms, we instead need to talk to uefisecapp. This commit provides
support for this and registers the respective efivars operations to
access EFI variables from the kernel.

Communication with uefisecapp follows the Qualcomm QSEECOM / Secure OS
conventions via the respective SCM call interface. This is also the
reason why variable access works normally while boot services are
active. During this time, said SCM interface is managed by the boot
services. When calling ExitBootServices(), the ownership is transferred
to the kernel. Therefore, UEFI must not use that interface itself (as
multiple parties accessing this interface at the same time may lead to
complications) and cannot access variables for us.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Rename (qctree -> qseecom) to allow differentiation between old
   (qseecom) and new (smcinvoke) interfaces to the trusted execution
   environment.

---
 MAINTAINERS                                |   6 +
 drivers/firmware/Kconfig                   |  16 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/qcom_qseecom.c            |  11 +-
 drivers/firmware/qcom_qseecom_uefisecapp.c | 746 +++++++++++++++++++++
 5 files changed, 779 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5493bcc5792c..51e4fb9a65f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17378,6 +17378,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM QSEECOM UEFISECAPP DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom_qseecom_uefisecapp.c
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
 M:	Sean Tranchetti <quic_stranche@quicinc.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 22eec0835abf..b9ad753a195b 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -241,6 +241,22 @@ config QCOM_QSEECOM
 
 	  Select M or Y here to enable the QSEECOM interface driver.
 
+config QCOM_QSEECOM_UEFISECAPP
+	tristate "Qualcomm SEE UEFI Secure App client driver"
+	depends on QCOM_QSEECOM
+	depends on EFI
+	help
+	  Various Qualcomm SoCs do not allow direct access to EFI variables.
+	  Instead, these need to be accessed via the UEFI Secure Application
+	  (uefisecapp), residing in the Secure Execution Environment (SEE).
+
+	  This module provides a client driver for uefisecapp, installing efivar
+	  operations to allow the kernel accessing EFI variables, and via that also
+	  provide user-space with access to EFI variables via efivarfs.
+
+	  Select M or Y here to provide access to EFI variables on the
+	  aforementioned platforms.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index aa48e0821b7d..d41b094a5e58 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
+obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom_qseecom.c
index 2553742ccc43..a57540199cd6 100644
--- a/drivers/firmware/qcom_qseecom.c
+++ b/drivers/firmware/qcom_qseecom.c
@@ -216,8 +216,17 @@ struct qseecom_data {
 	int num_cells;
 };
 
+static const struct mfd_cell qseecom_cells_sc8280xp[] = {
+	{ .name = "qcom_qseecom_uefisecapp", },
+};
+
+static const struct qseecom_data qseecom_data_sc8280xp = {
+	.cells = qseecom_cells_sc8280xp,
+	.num_cells = ARRAY_SIZE(qseecom_cells_sc8280xp),
+};
+
 static const struct of_device_id qseecom_dt_match[] = {
-	{ .compatible = "qcom,qseecom-sc8280xp", },
+	{ .compatible = "qcom,qseecom-sc8280xp", .data = &qseecom_data_sc8280xp },
 	{ .compatible = "qcom,qseecom", },
 	{ }
 };
diff --git a/drivers/firmware/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom_qseecom_uefisecapp.c
new file mode 100644
index 000000000000..3e9955639acc
--- /dev/null
+++ b/drivers/firmware/qcom_qseecom_uefisecapp.c
@@ -0,0 +1,746 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Client driver for Qualcomm UEFI Secure Application (qcom.tz.uefisecapp).
+ * Provides access to UEFI variables on platforms where they are secured by the
+ * aforementioned Secure Execution Environment (SEE) application.
+ *
+ * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/qcom_qseecom.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+
+/* -- UTF-16 helpers. ------------------------------------------------------- */
+
+static unsigned long utf16_strnlen(const efi_char16_t *str, unsigned long max)
+{
+	size_t i;
+
+	for (i = 0; *str != 0 && i < max; i++, str++) {
+		/* Do nothing, all is handled in the for statement. */
+	}
+
+	return i;
+}
+
+/**
+ * utf16_strsize() - Compute the number of bytes required to store a
+ * null-terminated UTF-16 string.
+ * @str: The string to compute the size for.
+ *
+ * Return: Returns the minimum number of bytes required to store the given
+ * null-terminated string, including its null-terminator.
+ */
+static unsigned long utf16_strsize(const efi_char16_t *str)
+{
+	return (utf16_strnlen(str, U32_MAX) + 1) * sizeof(str[0]);
+}
+
+static unsigned long utf16_strlcpy(efi_char16_t *dst, const efi_char16_t *src, unsigned long size)
+{
+	unsigned long actual = utf16_strnlen(src, size - 1);
+
+	memcpy(dst, src, actual * sizeof(src[0]));
+	dst[actual] = 0;
+
+	return actual;
+}
+
+/**
+ * utf16_copy_to_buf() - Copy the given UTF-16 string to a buffer.
+ * @dst:   Pointer to the output buffer
+ * @src:   Pointer to the null-terminated UTF-16 string to be copied.
+ * @bytes: Maximum number of bytes to copy.
+ *
+ * Copies the given string to the given buffer, ensuring that the output buffer
+ * is not overrun and that the string in the output buffer will always be
+ * null-terminated.
+ *
+ * Return: Returns the length of the copied string, without null-terminator.
+ */
+static unsigned long utf16_copy_to_buf(efi_char16_t *dst, const efi_char16_t *src,
+				       unsigned long bytes)
+{
+	return utf16_strlcpy(dst, src, bytes / sizeof(src[0]));
+}
+
+
+/* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
+
+#define QSEE_UEFISEC_APP_NAME			"qcom.tz.uefisecapp"
+
+#define QSEE_CMD_UEFI(x)			(0x8000 | (x))
+#define QSEE_CMD_UEFI_GET_VARIABLE		QSEE_CMD_UEFI(0)
+#define QSEE_CMD_UEFI_SET_VARIABLE		QSEE_CMD_UEFI(1)
+#define QSEE_CMD_UEFI_GET_NEXT_VARIABLE		QSEE_CMD_UEFI(2)
+#define QSEE_CMD_UEFI_QUERY_VARIABLE_INFO	QSEE_CMD_UEFI(3)
+
+/**
+ * struct qsee_req_uefi_get_variable - Request for GetVariable command.
+ * @command_id:  The ID of the command. Must be %QSEE_CMD_UEFI_GET_VARIABLE.
+ * @length:      Length of the request in bytes, including this struct and any
+ *               parameters (name, GUID) stored after it as well as any padding
+ *               thereof for alignment.
+ * @name_offset: Offset from the start of this struct to where the variable
+ *               name is stored (as utf-16 string), in bytes.
+ * @name_size:   Size of the name parameter in bytes, including null-terminator.
+ * @guid_offset: Offset from the start of this struct to where the GUID
+ *               parameter is stored, in bytes.
+ * @guid_size:   Size of the GUID parameter in bytes, i.e. sizeof(efi_guid_t).
+ * @data_size:   Size of the output buffer, in bytes.
+ */
+struct qsee_req_uefi_get_variable {
+	u32 command_id;
+	u32 length;
+	u32 name_offset;
+	u32 name_size;
+	u32 guid_offset;
+	u32 guid_size;
+	u32 data_size;
+} __packed;
+
+/**
+ * struct qsee_rsp_uefi_get_variable - Response for GetVariable command.
+ * @command_id:  The ID of the command. Should be %QSEE_CMD_UEFI_GET_VARIABLE.
+ * @length:      Length of the response in bytes, including this struct and the
+ *               returned data.
+ * @status:      Status of this command.
+ * @attributes:  EFI variable attributes.
+ * @data_offset: Offset from the start of this struct to where the data is
+ *               stored, in bytes.
+ * @data_size:   Size of the returned data, in bytes. In case status indicates
+ *               that the buffer is too small, this will be the size required
+ *               to store the EFI variable data.
+ */
+struct qsee_rsp_uefi_get_variable {
+	u32 command_id;
+	u32 length;
+	u32 status;
+	u32 attributes;
+	u32 data_offset;
+	u32 data_size;
+} __packed;
+
+/**
+ * struct qsee_req_uefi_set_variable - Request for the SetVariable command.
+ * @command_id:  The ID of the command. Must be %QSEE_CMD_UEFI_SET_VARIABLE.
+ * @length:      Length of the request in bytes, including this struct and any
+ *               parameters (name, GUID, data) stored after it as well as any
+ *               padding thereof required for alignment.
+ * @name_offset: Offset from the start of this struct to where the variable
+ *               name is stored (as utf-16 string), in bytes.
+ * @name_size:   Size of the name parameter in bytes, including null-terminator.
+ * @guid_offset: Offset from the start of this struct to where the GUID
+ *               parameter is stored, in bytes.
+ * @guid_size:   Size of the GUID parameter in bytes, i.e. sizeof(efi_guid_t).
+ * @attributes:  The EFI variable attributes to set for this variable.
+ * @data_offset: Offset from the start of this struct to where the EFI variable
+ *               data is stored, in bytes.
+ * @data_size:   Size of EFI variable data, in bytes.
+ *
+ */
+struct qsee_req_uefi_set_variable {
+	u32 command_id;
+	u32 length;
+	u32 name_offset;
+	u32 name_size;
+	u32 guid_offset;
+	u32 guid_size;
+	u32 attributes;
+	u32 data_offset;
+	u32 data_size;
+} __packed;
+
+/**
+ * struct qsee_rsp_uefi_set_variable - Response for the SetVariable command.
+ * @command_id:  The ID of the command. Should be %QSEE_CMD_UEFI_SET_VARIABLE.
+ * @length:      The length of this response, i.e. the size of this struct in
+ *               bytes.
+ * @status:      Status of this command.
+ * @_unknown1:   Unknown response field.
+ * @_unknown2:   Unknown response field.
+ */
+struct qsee_rsp_uefi_set_variable {
+	u32 command_id;
+	u32 length;
+	u32 status;
+	u32 _unknown1;
+	u32 _unknown2;
+} __packed;
+
+/**
+ * struct qsee_req_uefi_get_next_variable - Request for the
+ * GetNextVariableName command.
+ * @command_id:  The ID of the command. Must be
+ *               %QSEE_CMD_UEFI_GET_NEXT_VARIABLE.
+ * @length:      Length of the request in bytes, including this struct and any
+ *               parameters (name, GUID) stored after it as well as any padding
+ *               thereof for alignment.
+ * @guid_offset: Offset from the start of this struct to where the GUID
+ *               parameter is stored, in bytes.
+ * @guid_size:   Size of the GUID parameter in bytes, i.e. sizeof(efi_guid_t).
+ * @name_offset: Offset from the start of this struct to where the variable
+ *               name is stored (as utf-16 string), in bytes.
+ * @name_size:   Size of the name parameter in bytes, including null-terminator.
+ */
+struct qsee_req_uefi_get_next_variable {
+	u32 command_id;
+	u32 length;
+	u32 guid_offset;
+	u32 guid_size;
+	u32 name_offset;
+	u32 name_size;
+} __packed;
+
+/**
+ * struct qsee_rsp_uefi_get_next_variable - Response for the
+ * GetNextVariableName command.
+ * @command_id:  The ID of the command. Should be
+ *               %QSEE_CMD_UEFI_GET_NEXT_VARIABLE.
+ * @length:      Length of the response in bytes, including this struct and any
+ *               parameters (name, GUID) stored after it as well as any padding
+ *               thereof for alignment.
+ * @status:      Status of this command.
+ * @guid_size:   Size of the GUID parameter in bytes, i.e. sizeof(efi_guid_t).
+ * @name_offset: Offset from the start of this struct to where the variable
+ *               name is stored (as utf-16 string), in bytes.
+ * @name_size:   Size of the name parameter in bytes, including null-terminator.
+ */
+struct qsee_rsp_uefi_get_next_variable {
+	u32 command_id;
+	u32 length;
+	u32 status;
+	u32 guid_offset;
+	u32 guid_size;
+	u32 name_offset;
+	u32 name_size;
+} __packed;
+
+/**
+ * struct qsee_req_uefi_query_variable_info - Response for the
+ * GetNextVariableName command.
+ * @command_id: The ID of the command. Must be
+ *              %QSEE_CMD_UEFI_QUERY_VARIABLE_INFO.
+ * @length:     The length of this request, i.e. the size of this struct in
+ *              bytes.
+ * @attributes: The storage attributes to query the info for.
+ */
+struct qsee_req_uefi_query_variable_info {
+	u32 command_id;
+	u32 length;
+	u32 attributes;
+} __packed;
+
+/**
+ * struct qsee_rsp_uefi_query_variable_info - Response for the
+ * GetNextVariableName command.
+ * @command_id:        The ID of the command. Must be
+ *                     %QSEE_CMD_UEFI_QUERY_VARIABLE_INFO.
+ * @length:            The length of this response, i.e. the size of this
+ *                     struct in bytes.
+ * @status:            Status of this command.
+ * @_pad:              Padding.
+ * @storage_space:     Full storage space size, in bytes.
+ * @remaining_space:   Free storage space available, in bytes.
+ * @max_variable_size: Maximum variable data size, in bytes.
+ */
+struct qsee_rsp_uefi_query_variable_info {
+	u32 command_id;
+	u32 length;
+	u32 status;
+	u32 _pad;
+	u64 storage_space;
+	u64 remaining_space;
+	u64 max_variable_size;
+} __packed;
+
+
+/* -- UEFI app interface. --------------------------------------------------- */
+
+struct qcuefi_client {
+	struct device *dev;
+	struct qseecom_device *qsee;
+	struct qseecom_dma dma;
+	struct efivars efivars;
+	u32 app_id;
+};
+
+static efi_status_t qsee_uefi_status_to_efi(u32 status)
+{
+	u64 category = status & 0xf0000000;
+	u64 code = status & 0x0fffffff;
+
+	return category << (BITS_PER_LONG - 32) | code;
+}
+
+static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
+					   const efi_guid_t *guid, u32 *attributes,
+					   unsigned long *data_size, void *data)
+{
+	struct qsee_req_uefi_get_variable *req_data;
+	struct qsee_rsp_uefi_get_variable *rsp_data;
+	struct qseecom_dma dma_req;
+	struct qseecom_dma dma_rsp;
+	unsigned long name_size = utf16_strsize(name);
+	unsigned long buffer_size = *data_size;
+	unsigned long size;
+	efi_status_t efi_status;
+	int status;
+
+	/* Validation: We need a name and GUID. */
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* Validation: We need a buffer if the buffer_size is nonzero. */
+	if (buffer_size && !data)
+		return EFI_INVALID_PARAMETER;
+
+	/* Compute required size (upper limit with alignments). */
+	size = sizeof(*req_data) + sizeof(*guid) + name_size  /* Inputs. */
+	       + sizeof(*rsp_data) + buffer_size              /* Outputs. */
+	       + 2 * (QSEECOM_DMA_ALIGNMENT - 1)              /* Input parameter alignments. */
+	       + 1 * (QSEECOM_DMA_ALIGNMENT - 1);             /* Output parameter alignments. */
+
+	/* Make sure we have enough DMA memory. */
+	status = qseecom_dma_realloc(qcuefi->dev, &qcuefi->dma, size, GFP_KERNEL);
+	if (status)
+		return EFI_OUT_OF_RESOURCES;
+
+	/* Align request struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_req, 0);
+	req_data = dma_req.virt;
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
+	req_data->data_size = buffer_size;
+	req_data->name_offset = sizeof(*req_data);
+	req_data->name_size = name_size;
+	req_data->guid_offset = QSEECOM_DMA_ALIGN(req_data->name_offset + name_size);
+	req_data->guid_size = sizeof(*guid);
+	req_data->length = req_data->guid_offset + req_data->guid_size;
+
+	dma_req.size = req_data->length;
+
+	/* Copy request parameters. */
+	utf16_copy_to_buf(dma_req.virt + req_data->name_offset, name, name_size);
+	memcpy(dma_req.virt + req_data->guid_offset, guid, req_data->guid_size);
+
+	/* Align response struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_rsp, req_data->length);
+	rsp_data = dma_rsp.virt;
+
+	/* Perform SCM call. */
+	status = qseecom_app_send(qcuefi->qsee, qcuefi->app_id, &dma_req, &dma_rsp);
+
+	/* Check for errors and validate. */
+	if (status)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->length < sizeof(*rsp_data) || rsp_data->length > dma_rsp.size)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi->dev, "%s: uefisecapp error: 0x%x\n", __func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+
+		/* Update size and attributes in case buffer is too small. */
+		if (efi_status == EFI_BUFFER_TOO_SMALL) {
+			*data_size = rsp_data->data_size;
+			if (attributes)
+				*attributes = rsp_data->attributes;
+		}
+
+		return efi_status;
+	}
+
+	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
+
+	/* Set attributes and data size even if buffer is too small. */
+	*data_size = rsp_data->data_size;
+	if (attributes)
+		*attributes = rsp_data->attributes;
+
+	/*
+	 * If we have a buffer size of zero and no buffer, just return
+	 * attributes and required size.
+	 */
+	if (buffer_size == 0 && !data)
+		return EFI_SUCCESS;
+
+	/* Validate output buffer size. */
+	if (buffer_size < rsp_data->data_size)
+		return EFI_BUFFER_TOO_SMALL;
+
+	/* Copy to output buffer. Note: We're guaranteed to have one at this point. */
+	memcpy(data, dma_rsp.virt + rsp_data->data_offset, rsp_data->data_size);
+	return EFI_SUCCESS;
+}
+
+static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
+					   const efi_guid_t *guid, u32 attributes,
+					   unsigned long data_size, const void *data)
+{
+	struct qsee_req_uefi_set_variable *req_data;
+	struct qsee_rsp_uefi_set_variable *rsp_data;
+	struct qseecom_dma dma_req;
+	struct qseecom_dma dma_rsp;
+	unsigned long name_size = utf16_strsize(name);
+	unsigned long size;
+	int status;
+
+	/* Validate inputs. */
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * Make sure we have some data if data_size is nonzero. Note: Using a
+	 * size of zero is valid and deletes the variable.
+	 */
+	if (data_size && !data)
+		return EFI_INVALID_PARAMETER;
+
+	/* Compute required size (upper limit with alignments). */
+	size = sizeof(*req_data) + name_size + sizeof(*guid) + data_size  /* Inputs. */
+	       + sizeof(*rsp_data)                            /* Outputs. */
+	       + 2 * (QSEECOM_DMA_ALIGNMENT - 1)              /* Input parameter alignments. */
+	       + 1 * (QSEECOM_DMA_ALIGNMENT - 1);             /* Output parameter alignments. */
+
+	/* Make sure we have enough DMA memory. */
+	status = qseecom_dma_realloc(qcuefi->dev, &qcuefi->dma, size, GFP_KERNEL);
+	if (status)
+		return EFI_OUT_OF_RESOURCES;
+
+	/* Align request struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_req, 0);
+	req_data = dma_req.virt;
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
+	req_data->attributes = attributes;
+	req_data->name_offset = sizeof(*req_data);
+	req_data->name_size = name_size;
+	req_data->guid_offset = QSEECOM_DMA_ALIGN(req_data->name_offset + name_size);
+	req_data->guid_size = sizeof(*guid);
+	req_data->data_offset = req_data->guid_offset + req_data->guid_size;
+	req_data->data_size = data_size;
+	req_data->length = req_data->data_offset + data_size;
+
+	/* Copy request parameters. */
+	utf16_copy_to_buf(dma_req.virt + req_data->name_offset, name, req_data->name_size);
+	memcpy(dma_req.virt + req_data->guid_offset, guid, req_data->guid_size);
+
+	if (data_size)
+		memcpy(dma_req.virt + req_data->data_offset, data, req_data->data_size);
+
+	/* Align response struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_rsp, req_data->length);
+	rsp_data = dma_rsp.virt;
+
+	/* Perform SCM call. */
+	dma_req.size = req_data->length;
+	dma_rsp.size = sizeof(*rsp_data);
+
+	status = qseecom_app_send(qcuefi->qsee, qcuefi->app_id, &dma_req, &dma_rsp);
+
+	/* Check for errors and validate. */
+	if (status)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->length < sizeof(*rsp_data) || rsp_data->length > dma_rsp.size)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi->dev, "%s: uefisecapp error: 0x%x\n", __func__, rsp_data->status);
+		return qsee_uefi_status_to_efi(rsp_data->status);
+	}
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
+						unsigned long *name_size, efi_char16_t *name,
+						efi_guid_t *guid)
+{
+	struct qsee_req_uefi_get_next_variable *req_data;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data;
+	struct qseecom_dma dma_req;
+	struct qseecom_dma dma_rsp;
+	unsigned long size;
+	efi_status_t efi_status;
+	int status;
+
+	/* We need some buffers. */
+	if (!name_size || !name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* There needs to be at least a single null-character. */
+	if (*name_size == 0)
+		return EFI_INVALID_PARAMETER;
+
+	/* Compute required size (upper limit with alignments). */
+	size = sizeof(*req_data) + sizeof(*guid) + *name_size    /* Inputs. */
+	       + sizeof(*rsp_data) + sizeof(*guid) + *name_size  /* Outputs. */
+	       + 2 * (QSEECOM_DMA_ALIGNMENT - 1)                 /* Input parameter alignments. */
+	       + 1 * (QSEECOM_DMA_ALIGNMENT - 1);                /* Output parameter alignments. */
+
+	/* Make sure we have enough DMA memory. */
+	status = qseecom_dma_realloc(qcuefi->dev, &qcuefi->dma, size, GFP_KERNEL);
+	if (status)
+		return EFI_OUT_OF_RESOURCES;
+
+	/* Align request struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_req, 0);
+	req_data = dma_req.virt;
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
+	req_data->guid_offset = QSEECOM_DMA_ALIGN(sizeof(*req_data));
+	req_data->guid_size = sizeof(*guid);
+	req_data->name_offset = req_data->guid_offset + req_data->guid_size;
+	req_data->name_size = *name_size;
+	req_data->length = req_data->name_offset + req_data->name_size;
+
+	dma_req.size = req_data->length;
+
+	/* Copy request parameters. */
+	memcpy(dma_req.virt + req_data->guid_offset, guid, req_data->guid_size);
+	utf16_copy_to_buf(dma_req.virt + req_data->name_offset, name, *name_size);
+
+	/* Align response struct. */
+	qseecom_dma_aligned(&qcuefi->dma, &dma_rsp, req_data->length);
+	rsp_data = dma_rsp.virt;
+
+	/* Perform SCM call. */
+	status = qseecom_app_send(qcuefi->qsee, qcuefi->app_id, &dma_req, &dma_rsp);
+
+	/* Check for errors and validate. */
+	if (status)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->length < sizeof(*rsp_data) || rsp_data->length > dma_rsp.size)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi->dev, "%s: uefisecapp error: 0x%x\n", __func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+
+		/* Update size with required size in case buffer is too small. */
+		if (efi_status == EFI_BUFFER_TOO_SMALL)
+			*name_size = rsp_data->name_size;
+
+		return efi_status;
+	}
+
+	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
+
+	if (rsp_data->name_size > *name_size) {
+		*name_size = rsp_data->name_size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	if (rsp_data->guid_size != sizeof(*guid))
+		return EFI_DEVICE_ERROR;
+
+	/* Copy response fields. */
+	memcpy(guid, dma_rsp.virt + rsp_data->guid_offset, rsp_data->guid_size);
+	utf16_copy_to_buf(name, dma_rsp.virt + rsp_data->name_offset, rsp_data->name_size);
+	*name_size = rsp_data->name_size;
+
+	return 0;
+}
+
+
+/* -- Global efivar interface. ---------------------------------------------- */
+
+static struct qcuefi_client *__qcuefi;
+static DEFINE_MUTEX(__qcuefi_lock);
+
+static int qcuefi_set_reference(struct qcuefi_client *qcuefi)
+{
+	mutex_lock(&__qcuefi_lock);
+
+	if (qcuefi && __qcuefi) {
+		mutex_unlock(&__qcuefi_lock);
+		return -EEXIST;
+	}
+
+	__qcuefi = qcuefi;
+
+	mutex_unlock(&__qcuefi_lock);
+	return 0;
+}
+
+static struct qcuefi_client *qcuefi_acquire(void)
+{
+	mutex_lock(&__qcuefi_lock);
+	return __qcuefi;
+}
+
+static void qcuefi_release(void)
+{
+	mutex_unlock(&__qcuefi_lock);
+}
+
+static efi_status_t qcuefi_get_variable(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+					unsigned long *data_size, void *data)
+{
+	struct qcuefi_client *qcuefi;
+	efi_status_t status;
+
+	qcuefi = qcuefi_acquire();
+	if (!qcuefi)
+		return EFI_NOT_READY;
+
+	status = qsee_uefi_get_variable(qcuefi, name, vendor, attr, data_size, data);
+
+	qcuefi_release();
+	return status;
+}
+
+static efi_status_t qcuefi_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+					u32 attr, unsigned long data_size, void *data)
+{
+	struct qcuefi_client *qcuefi;
+	efi_status_t status;
+
+	qcuefi = qcuefi_acquire();
+	if (!qcuefi)
+		return EFI_NOT_READY;
+
+	status = qsee_uefi_set_variable(qcuefi, name, vendor, attr, data_size, data);
+
+	qcuefi_release();
+	return status;
+}
+
+static efi_status_t qcuefi_get_next_variable(unsigned long *name_size, efi_char16_t *name,
+					     efi_guid_t *vendor)
+{
+	struct qcuefi_client *qcuefi;
+	efi_status_t status;
+
+	qcuefi = qcuefi_acquire();
+	if (!qcuefi)
+		return EFI_NOT_READY;
+
+	status = qsee_uefi_get_next_variable(qcuefi, name_size, name, vendor);
+
+	qcuefi_release();
+	return status;
+}
+
+static const struct efivar_operations qcom_efivar_ops = {
+	.get_variable = qcuefi_get_variable,
+	.set_variable = qcuefi_set_variable,
+	.get_next_variable = qcuefi_get_next_variable,
+};
+
+
+/* -- Driver setup. --------------------------------------------------------- */
+
+static int qcom_uefisecapp_probe(struct platform_device *pdev)
+{
+	struct qcuefi_client *qcuefi;
+	int status;
+
+	/* Allocate driver data. */
+	qcuefi = devm_kzalloc(&pdev->dev, sizeof(*qcuefi), GFP_KERNEL);
+	if (!qcuefi)
+		return -ENOMEM;
+
+	qcuefi->dev = &pdev->dev;
+
+	/* We expect the parent to be the QSEECOM device. */
+	qcuefi->qsee = dev_get_drvdata(pdev->dev.parent);
+	if (!qcuefi->qsee)
+		return -EINVAL;
+
+	/* Get application id for uefisecapp. */
+	status = qseecom_app_get_id(qcuefi->qsee, QSEE_UEFISEC_APP_NAME, &qcuefi->app_id);
+	if (status) {
+		dev_err(&pdev->dev, "failed to query app ID: %d\n", status);
+		return status;
+	}
+
+	/* Set up DMA. One page should be plenty to start with. */
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		dev_warn(&pdev->dev, "no suitable DMA available\n");
+		return -EFAULT;
+	}
+
+	status = qseecom_dma_alloc(&pdev->dev, &qcuefi->dma, PAGE_SIZE, GFP_KERNEL);
+	if (status)
+		return status;
+
+	/* Register global reference. */
+	platform_set_drvdata(pdev, qcuefi);
+	status = qcuefi_set_reference(qcuefi);
+	if (status)
+		goto free;
+
+	/* Register efivar ops. */
+	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
+	if (status)
+		goto clear_reference;
+
+	return 0;
+
+clear_reference:
+	qcuefi_set_reference(NULL);
+free:
+	qseecom_dma_free(qcuefi->dev, &qcuefi->dma);
+	return status;
+}
+
+static int qcom_uefisecapp_remove(struct platform_device *pdev)
+{
+	struct qcuefi_client *qcuefi = platform_get_drvdata(pdev);
+
+	/* Unregister efivar ops. */
+	efivars_unregister(&qcuefi->efivars);
+
+	/* Block on pending calls and unregister global reference. */
+	qcuefi_set_reference(NULL);
+
+	/* Free remaining resources. */
+	qseecom_dma_free(qcuefi->dev, &qcuefi->dma);
+
+	return 0;
+}
+
+static struct platform_driver qcom_uefisecapp_driver = {
+	.probe = qcom_uefisecapp_probe,
+	.remove = qcom_uefisecapp_remove,
+	.driver = {
+		.name = "qcom_qseecom_uefisecapp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(qcom_uefisecapp_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Client driver for Qualcomm SEE UEFI Secure App");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:qcom_qseecom_uefisecapp");
-- 
2.39.0

