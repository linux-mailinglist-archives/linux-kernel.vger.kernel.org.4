Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CC71412E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjE1XEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjE1XEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:04:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D47BB;
        Sun, 28 May 2023 16:04:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1611990f8f.0;
        Sun, 28 May 2023 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685315044; x=1687907044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXXOj/WxBursAt+SroE46HOhqrUXWg10qiGZcCYvUj4=;
        b=H9tdt5PWRw2leEWcbaesCa3bt+m0ZS6PRbj+cGCGA6yyc4QHMdxLYq4WLeoZXzhsDE
         CK8m/fn8d+yWQw6qerxdnj7IPWERHsW/e8WqaLOAooSJjf8Ao3vPI4dNC2d4ykAEQ43C
         qLKVFT6m7sLAQ6Rjo75NRJjHfTS+V1xNOoShwM+9flKqbig+8cN1G+XfHuQRVP4W1sjh
         4Syx826DCJRZ+muA4gmlI7kp6+ZCPNqKcD6zhdiAebQwNK9fXtVbjSYWZ38gtveqhMBp
         yXKjKwmglAz31MFj9LIm6L9possLzYWagE9TNI1ADJw6Y5DXVkK0Ci9MVDoAEWuf+27f
         DrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315044; x=1687907044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXXOj/WxBursAt+SroE46HOhqrUXWg10qiGZcCYvUj4=;
        b=G0HzvxP3nt0jATZzaFnqnvMeSFN6zWBuWpW39SNmkisQPRgOJQl4hD7VBz13rd4zpQ
         Z9jmKcmp3apSJC/GdC0DYXAdWt/vPaEVlOzODEqRb9LrFKTBglhuMNM4F9tVjm3pIHx6
         ugtBqYdJl2ymzkslxGhhjvZvo9CO07Y1JzNuI/4w37L44AS4mskJCG+/6HKABUTwuOnm
         hIj54Hq1zCTl1PToOU0lj0cHbk1zIRwhXthUO0QvZmCPfmoRLr1PljC+6dibmmvpVm1H
         nPl7rjb4dNmezKms7qRB92ZyljGc2cHkiKz470ogE+P825EEb4Xkji5cDW7Q0u5hjJJ0
         CzLw==
X-Gm-Message-State: AC+VfDx6b/hSdF/ABGp2eHafucSvvppGEmVe75ukk7fVA2KPLQnK4WMq
        52fsvyhRV2hpYNNcXqiEWqM=
X-Google-Smtp-Source: ACHHUZ4kwDafdY091ow0cOUn8mWhLQ3maUbamZ06DIBo5rW0zs8u4gCXM8xPFNTNHpmwdlQw+Mwgsw==
X-Received: by 2002:a05:6000:1374:b0:306:3731:f73b with SMTP id q20-20020a056000137400b003063731f73bmr8545184wrz.43.1685315043610;
        Sun, 28 May 2023 16:04:03 -0700 (PDT)
Received: from xws.localdomain (pd9ea3c90.dip0.t-ipconnect.de. [217.234.60.144])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm15995411wmg.21.2023.05.28.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:04:03 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Mon, 29 May 2023 01:03:51 +0200
Message-Id: <20230528230351.168210-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528230351.168210-1-luzmaximilian@gmail.com>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
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

Changes in v4:
 - Adapt to changes in DMA allocation in patch 3.
 - Rework alignment: Use native alignment of types instead of a general
   8 byte alignment. While the windows driver uses 8 byte alignment for
   GUIDs, the native (4 byte) alignment seems to work fine here.
 - Add a helper macro for determining size and layout of request and
   response buffers, taking care of proper alignment.
 - Implement support for EFI's query_variable_info() call, which is now
   supported by the kernel (and expected by efivarfs).
 - Move UCS-2 string helpers to lib/ucs2_string.c

Changes in v3:
 - No functional changes.

Changes in v2:
 - Rename (qctree -> qseecom) to allow differentiation between old
   (qseecom) and new (smcinvoke) interfaces to the trusted execution
   environment.

---
 MAINTAINERS                                |   6 +
 drivers/firmware/Kconfig                   |  17 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/qcom_qseecom_uefisecapp.c | 885 +++++++++++++++++++++
 drivers/firmware/qcom_scm.c                |   4 +-
 5 files changed, 912 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 332db39d3ca8..b6a5b4ad441c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17515,6 +17515,12 @@ S:	Maintained
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
index ad59a0ba1f48..f5885fdeddd5 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -242,6 +242,23 @@ config QCOM_SCM_QSEECOM
 
 	  Select Y here to enable the QSEECOM interface.
 
+config QCOM_QSEECOM_UEFISECAPP
+	tristate "Qualcomm SEE UEFI Secure App client driver"
+	select QCOM_SCM
+	select QCOM_SCM_QSEECOM
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
index 28fcddcd688f..2acb9711b2d5 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom_qseecom_uefisecapp.c
new file mode 100644
index 000000000000..bd3686d5ea1b
--- /dev/null
+++ b/drivers/firmware/qcom_qseecom_uefisecapp.c
@@ -0,0 +1,885 @@
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
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/ucs2_string.h>
+
+#include <linux/firmware/qcom/qcom_scm.h>
+
+/* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
+
+/* Maximum length of name string with null-terminator */
+#define QSEE_MAX_NAME_LEN			1024
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
+/* -- Alighment helpers ----------------------------------------------------- */
+
+/*
+ * Helper macro to ensure proper alignment of types (fields and arrays) when
+ * stored in some (contiguous) buffer.
+ *
+ * Note: The driver from which this one has been reverse-engineered expects an
+ * alignment of 8 bytes (64 bits) for GUIDs. Our definition of efi_guid_t,
+ * however, has an alignment of 4 byte (32 bits). So far, this seems to work
+ * fine here. See also the comment on the typedef of efi_guid_t.
+ */
+#define qcuefi_buf_align_fields(fields...)					\
+	({									\
+		size_t __len = 0;						\
+		fields								\
+		__len;								\
+	})
+
+#define __field_impl(size, align, offset)					\
+	({									\
+		size_t *__offset = (offset);					\
+		size_t __aligned;						\
+										\
+		__aligned = ALIGN(__len, align);				\
+		__len = __aligned + (size);					\
+										\
+		if (__offset)							\
+			*__offset = __aligned;					\
+	});
+
+#define __array_offs(type, count, offset)					\
+	__field_impl(sizeof(type) * (count), __alignof__(type), offset)
+
+#define __array(type, count)		__array_offs(type, count, NULL)
+#define __field_offs(type, offset)	__array_offs(type, 1, offset)
+#define __field(type)			__array_offs(type, 1, NULL)
+
+/* -- UEFI app interface. --------------------------------------------------- */
+
+struct qcuefi_client {
+	struct qseecom_client *client;
+	struct efivars efivars;
+};
+
+struct device *qcuefi_dev(struct qcuefi_client *qcuefi)
+{
+	return &qcuefi->client->aux_dev.dev;
+}
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
+	unsigned long buffer_size = *data_size;
+	efi_status_t efi_status = EFI_SUCCESS;
+	unsigned long name_length;
+	size_t guid_offs;
+	size_t name_offs;
+	size_t req_size;
+	size_t rsp_size;
+	int status;
+
+	/* Validation: We need a name and GUID. */
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* Get length of name and ensure that the name is not truncated. */
+	name_length = ucs2_strnlen(name, QSEE_MAX_NAME_LEN) + 1;
+	if (name_length > QSEE_MAX_NAME_LEN)
+		return EFI_INVALID_PARAMETER;
+
+	/* Validation: We need a buffer if the buffer_size is nonzero. */
+	if (buffer_size && !data)
+		return EFI_INVALID_PARAMETER;
+
+	/* Compute required buffer size for request. */
+	req_size = qcuefi_buf_align_fields(
+		__field(*req_data)
+		__array_offs(*name, name_length, &name_offs)
+		__field_offs(*guid, &guid_offs)
+	);
+
+	/* Compute required buffer size for response. */
+	rsp_size = qcuefi_buf_align_fields(
+		__field(*rsp_data)
+		__array(u8, buffer_size)
+	);
+
+	/* Allocate request buffer. */
+	req_data = kzalloc(req_size, GFP_KERNEL);
+	if (!req_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	/* Allocate response buffer. */
+	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
+	if (!rsp_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out_free_req;
+	}
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
+	req_data->data_size = buffer_size;
+	req_data->name_offset = name_offs;
+	req_data->name_size = name_length * sizeof(*name);
+	req_data->guid_offset = guid_offs;
+	req_data->guid_size = sizeof(*guid);
+	req_data->length = req_size;
+
+	/* Copy request parameters. */
+	ucs2_strlcpy(((void *)req_data) + req_data->name_offset, name, name_length);
+	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
+
+	/* Perform SCM call. */
+	status = qcom_scm_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
+
+	/* Check for errors and validate. */
+	if (status) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->length < sizeof(*rsp_data)) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
+			__func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+
+		/* Update size and attributes in case buffer is too small. */
+		if (efi_status == EFI_BUFFER_TOO_SMALL) {
+			*data_size = rsp_data->data_size;
+			if (attributes)
+				*attributes = rsp_data->attributes;
+		}
+
+		goto out_free;
+	}
+
+	if (rsp_data->length > rsp_size) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
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
+	if (buffer_size == 0 && !data) {
+		efi_status = EFI_SUCCESS;
+		goto out_free;
+	}
+
+	/* Validate output buffer size. */
+	if (buffer_size < rsp_data->data_size) {
+		efi_status = EFI_BUFFER_TOO_SMALL;
+		goto out_free;
+	}
+
+	/* Copy to output buffer. Note: We're guaranteed to have one at this point. */
+	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
+
+out_free:
+	kfree(rsp_data);
+out_free_req:
+	kfree(req_data);
+out:
+	return efi_status;
+}
+
+static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
+					   const efi_guid_t *guid, u32 attributes,
+					   unsigned long data_size, const void *data)
+{
+	struct qsee_req_uefi_set_variable *req_data;
+	struct qsee_rsp_uefi_set_variable *rsp_data;
+	efi_status_t efi_status = EFI_SUCCESS;
+	unsigned long name_length;
+	size_t name_offs;
+	size_t guid_offs;
+	size_t data_offs;
+	size_t req_size;
+	int status;
+
+	/* Validate inputs. */
+	if (!name || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	/* Get length of name and ensure that the name is not truncated. */
+	name_length = ucs2_strnlen(name, QSEE_MAX_NAME_LEN) + 1;
+	if (name_length > QSEE_MAX_NAME_LEN)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * Make sure we have some data if data_size is nonzero. Note: Using a
+	 * size of zero is valid and deletes the variable.
+	 */
+	if (data_size && !data)
+		return EFI_INVALID_PARAMETER;
+
+	/* Compute required buffer size for request. */
+	req_size = qcuefi_buf_align_fields(
+		__field(*req_data)
+		__array_offs(*name, name_length, &name_offs)
+		__field_offs(*guid, &guid_offs)
+		__array_offs(u8, data_size, &data_offs)
+	);
+
+	/* Allocate request buffer */
+	req_data = kzalloc(req_size, GFP_KERNEL);
+	if (!req_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	/* Allocate response buffer */
+	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
+	if (!rsp_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out_free_req;
+	}
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
+	req_data->attributes = attributes;
+	req_data->name_offset = name_offs;
+	req_data->name_size = name_length * sizeof(*name);
+	req_data->guid_offset = guid_offs;
+	req_data->guid_size = sizeof(*guid);
+	req_data->data_offset = data_offs;
+	req_data->data_size = data_size;
+	req_data->length = req_size;
+
+	/* Copy request parameters. */
+	ucs2_strlcpy(((void *)req_data) + req_data->name_offset, name, name_length);
+	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
+
+	if (data_size)
+		memcpy(((void *)req_data) + req_data->data_offset, data, req_data->data_size);
+
+	/* Perform SCM call. */
+	status = qcom_scm_qseecom_app_send(qcuefi->client, req_data, req_size,
+					   rsp_data, sizeof(*rsp_data));
+
+	/* Check for errors and validate. */
+	if (status) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->length != sizeof(*rsp_data)) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
+			__func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+	}
+
+out_free:
+	kfree(rsp_data);
+out_free_req:
+	kfree(req_data);
+out:
+	return efi_status;
+}
+
+static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
+						unsigned long *name_size, efi_char16_t *name,
+						efi_guid_t *guid)
+{
+	struct qsee_req_uefi_get_next_variable *req_data;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data;
+	efi_status_t efi_status = EFI_SUCCESS;
+	size_t guid_offs;
+	size_t name_offs;
+	size_t req_size;
+	size_t rsp_size;
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
+	/* Compute required buffer size for request. */
+	req_size = qcuefi_buf_align_fields(
+		__field(*req_data)
+		__field_offs(*guid, &guid_offs)
+		__array_offs(*name, *name_size / sizeof(*name), &name_offs)
+	);
+
+	/* Compute required buffer size for response. */
+	rsp_size = qcuefi_buf_align_fields(
+		__field(*rsp_data)
+		__field(*guid)
+		__array(*name, *name_size / sizeof(*name))
+	);
+
+	/* Allocate request buffer. */
+	req_data = kzalloc(req_size, GFP_KERNEL);
+	if (!req_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	/* Allocate response buffer. */
+	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
+	if (!rsp_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out_free_req;
+	}
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
+	req_data->guid_offset = guid_offs;
+	req_data->guid_size = sizeof(*guid);
+	req_data->name_offset = name_offs;
+	req_data->name_size = *name_size;
+	req_data->length = req_size;
+
+	/* Copy request parameters. */
+	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
+	ucs2_strlcpy(((void *)req_data) + req_data->name_offset, name, *name_size / sizeof(*name));
+
+	/* Perform SCM call. */
+	status = qcom_scm_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
+
+	/* Check for errors and validate. */
+	if (status) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->length < sizeof(*rsp_data)) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
+			__func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+
+		/* Update size with required size in case buffer is too small. */
+		if (efi_status == EFI_BUFFER_TOO_SMALL)
+			*name_size = rsp_data->name_size;
+
+		goto out_free;
+	}
+
+	if (rsp_data->length > rsp_size) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->name_size > *name_size) {
+		*name_size = rsp_data->name_size;
+		efi_status = EFI_BUFFER_TOO_SMALL;
+		goto out_free;
+	}
+
+	if (rsp_data->guid_size != sizeof(*guid)) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	/* Copy response fields. */
+	memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
+	ucs2_strlcpy(name, ((void *)rsp_data) + rsp_data->name_offset,
+		     rsp_data->name_size / sizeof(*name));
+	*name_size = rsp_data->name_size;
+
+out_free:
+	kfree(rsp_data);
+out_free_req:
+	kfree(req_data);
+out:
+	return efi_status;
+}
+
+static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi, u32 attr,
+						  u64 *storage_space, u64 *remaining_space,
+						  u64 *max_variable_size)
+{
+	struct qsee_req_uefi_query_variable_info *req_data;
+	struct qsee_rsp_uefi_query_variable_info *rsp_data;
+	efi_status_t efi_status = EFI_SUCCESS;
+	int status;
+
+	/* Allocate request buffer. */
+	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	/* Allocate response buffer. */
+	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
+	if (!rsp_data) {
+		efi_status = EFI_OUT_OF_RESOURCES;
+		goto out_free_req;
+	}
+
+	/* Set up request data. */
+	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
+	req_data->attributes = attr;
+	req_data->length = sizeof(*req_data);
+
+	/* Perform SCM call. */
+	status = qcom_scm_qseecom_app_send(qcuefi->client, req_data, sizeof(*req_data),
+					   rsp_data, sizeof(*rsp_data));
+
+	/* Check for errors and validate. */
+	if (status) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->command_id != QSEE_CMD_UEFI_QUERY_VARIABLE_INFO) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->length != sizeof(*rsp_data)) {
+		efi_status = EFI_DEVICE_ERROR;
+		goto out_free;
+	}
+
+	if (rsp_data->status) {
+		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
+			__func__, rsp_data->status);
+		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+		goto out_free;
+	}
+
+	/* Copy response fields. */
+	if (storage_space)
+		*storage_space = rsp_data->storage_space;
+
+	if (remaining_space)
+		*remaining_space = rsp_data->remaining_space;
+
+	if (max_variable_size)
+		*max_variable_size = rsp_data->max_variable_size;
+
+out_free:
+	kfree(rsp_data);
+out_free_req:
+	kfree(req_data);
+out:
+	return efi_status;
+}
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
+	__acquires(&__qcuefi_lock)
+{
+	mutex_lock(&__qcuefi_lock);
+	return __qcuefi;
+}
+
+static void qcuefi_release(void)
+	__releases(&__qcuefi_lock)
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
+static efi_status_t qcuefi_query_variable_info(u32 attr, u64 *storage_space, u64 *remaining_space,
+					       u64 *max_variable_size)
+{
+	struct qcuefi_client *qcuefi;
+	efi_status_t status;
+
+	qcuefi = qcuefi_acquire();
+	if (!qcuefi)
+		return EFI_NOT_READY;
+
+	status = qsee_uefi_query_variable_info(qcuefi, attr, storage_space, remaining_space,
+					       max_variable_size);
+
+	qcuefi_release();
+	return status;
+}
+
+static const struct efivar_operations qcom_efivar_ops = {
+	.get_variable = qcuefi_get_variable,
+	.set_variable = qcuefi_set_variable,
+	.get_next_variable = qcuefi_get_next_variable,
+	.query_variable_info = qcuefi_query_variable_info,
+};
+
+/* -- Driver setup. --------------------------------------------------------- */
+
+static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
+				 const struct auxiliary_device_id *aux_dev_id)
+{
+	struct qcuefi_client *qcuefi;
+	int status;
+
+	/* Allocate driver data. */
+	qcuefi = devm_kzalloc(&aux_dev->dev, sizeof(*qcuefi), GFP_KERNEL);
+	if (!qcuefi)
+		return -ENOMEM;
+
+	qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
+
+	/* Register global reference. */
+	auxiliary_set_drvdata(aux_dev, qcuefi);
+	status = qcuefi_set_reference(qcuefi);
+	if (status)
+		return status;
+
+	/* Register efivar ops. */
+	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
+	if (status)
+		qcuefi_set_reference(NULL);
+
+	return status;
+}
+
+static void qcom_uefisecapp_remove(struct auxiliary_device *aux_dev)
+{
+	struct qcuefi_client *qcuefi = auxiliary_get_drvdata(aux_dev);
+
+	/* Unregister efivar ops. */
+	efivars_unregister(&qcuefi->efivars);
+
+	/* Block on pending calls and unregister global reference. */
+	qcuefi_set_reference(NULL);
+}
+
+static const struct auxiliary_device_id qcom_uefisecapp_id_table[] = {
+	{ .name = "qcom_scm.uefisecapp" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, qcom_uefisecapp_id_table);
+
+static struct auxiliary_driver qcom_uefisecapp_driver = {
+	.probe = qcom_uefisecapp_probe,
+	.remove = qcom_uefisecapp_remove,
+	.id_table = qcom_uefisecapp_id_table,
+	.driver = {
+		.name = "qcom_qseecom_uefisecapp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_auxiliary_driver(qcom_uefisecapp_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Client driver for Qualcomm SEE UEFI Secure App");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 1fa846d48795..92fad47635ae 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1693,7 +1693,9 @@ static bool qcom_scm_qseecom_device_allowed(void)
 	return match;
 }
 
-static const struct qseecom_app_desc qcom_scm_qseecom_apps[] = {};
+static const struct qseecom_app_desc qcom_scm_qseecom_apps[] = {
+	{ "qcom.tz.uefisecapp", "uefisecapp" },
+};
 
 static int qcom_scm_qseecom_init(void)
 {
-- 
2.40.1

