Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CAE71412F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjE1XEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjE1XEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:04:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628DBD;
        Sun, 28 May 2023 16:04:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso1607718f8f.1;
        Sun, 28 May 2023 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685315042; x=1687907042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEhh0NyxvpBsK+GaM5U5lUifwGOryDP/TSOlRpxg2/s=;
        b=KOT8RzXfHFuzoqEfsmrHVcBQmZTPPYcIqV3U/KQge2Y0tq9Sl/jW7/PiSivKHhvKrU
         CNBlCwxiO7Ig23VdGFlaX/eauMp9a7cMGEdvuyowteCFis4jQRcSrgYXRuoqAZwwXvlw
         YKGH49SkUdo51Fr+MLP1HSO02YT4tqeZ/Um1/O4IMniTSZ46l6b8QrdZD3WfekhSB23q
         FzFmyMmDw+42reSHyjZ8gB/qHLujfUT2/M7w5580DKiW1pMhg/gTEXd+4AUy4Z23PQxB
         NC1SU8c3f52z8phyCUkxZhbcAwMf00hG10apg8OaHuXg0RQDSZP/mJcQNIVKzKE2A3OL
         mOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315042; x=1687907042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEhh0NyxvpBsK+GaM5U5lUifwGOryDP/TSOlRpxg2/s=;
        b=cPb0h99fhCKHjy4FubwrsjgT3gOnWGXKRycsWCNtuid4o1xwePbrqS8SyOwVLp/W9a
         lDABq+GPTg5q7zJrx15hMjlzREi9MMBoztnyj4YIgYCfRRPyt2/vJpMwL59gdf28oj+i
         T9qntja60lPId02S2+69jf3/mzYcharxxOIojVI9ZvpueCM69ek+R4qvgQwkPFVRvLxb
         KZs+8N4a1u39e940t2Q+movP+DPUAve4bwuQ64Lp1G0kKHz6cVJfPepNAqc44Rl6p60s
         0U7XD2W8Srhzp07T9KyKMFuW3/LE5E/6ispFXU19EDIfG84xgA9mmgIXL/xfYT01L8+4
         mePw==
X-Gm-Message-State: AC+VfDx93WxOvqujTc7fgxyz0mxfOEjLcogO60VNQshv03V2zOTt4OUE
        u5YmXM3Q6+Bxbm4n4a0MXJc=
X-Google-Smtp-Source: ACHHUZ5XhH24LYwswDK/cQYcnzrE8a6AV+q4Aio935aEEe8tCZ3BZp3soMJP2hwUKZKnYj9+AWiMOw==
X-Received: by 2002:adf:fbc1:0:b0:309:3a1e:fc54 with SMTP id d1-20020adffbc1000000b003093a1efc54mr7716165wrs.7.1685315042372;
        Sun, 28 May 2023 16:04:02 -0700 (PDT)
Received: from xws.localdomain (pd9ea3c90.dip0.t-ipconnect.de. [217.234.60.144])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm15995411wmg.21.2023.05.28.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:04:01 -0700 (PDT)
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
Subject: [PATCH v4 3/4] firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface
Date:   Mon, 29 May 2023 01:03:50 +0200
Message-Id: <20230528230351.168210-4-luzmaximilian@gmail.com>
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

Add support for SCM calls to Secure OS and the Secure Execution
Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
interface. This allows communication with Secure/TZ applications, for
example 'uefisecapp' managing access to UEFI variables.

The added interface attempts to automatically detect known and supported
applications, creating a client (auxiliary) device for each one. The
respective client/auxiliary driver is then responsible for managing and
communicating with the application.

While this patch introduces only a very basic interface without the more
advanced features (such as re-entrant and blocking SCM calls and
listeners/callbacks), this is enough to talk to the aforementioned
'uefisecapp'.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v4:
 - Remove instantiation of dedicated QSEECOM device and load the driver
   via qcom_scm instead. In particular:
   - Add a list of tested devices to ensure that we don't run into any
     issues with the currently unimplemented re-entrant calls.
   - Use the QSEECOM version to check for general availability of the
     interface.
   - Attempt to automatically detect available QSEECOM applications
     (and instantiate respective clients) based on a fixed list.
 - Use auxiliary bus and devices for clients instead of MFD.
 - Restructure DMA allocations: Use dma_map_single() directly inside 
   qcom_scm_qseecom_app_send() instead of requiring clients to allocate
   DMA memory themselves.

Changes in v3:
 - Rebase ontop of latest qcom_scm changes (qcom_scm.h moved).
 - Move qcom_qseecom.h in accordance with qcom_scm.

Changes in v2:
 - Bind the interface to a device.
 - Establish a device link to the SCM device to ensure proper ordering.
 - Register client apps as child devices instead of requiring them to be
   specified in the device tree.
 - Rename (qctree -> qseecom) to allow differentiation between old
   (qseecom) and new (smcinvoke) interfaces to the trusted execution
   environment.

---
 drivers/firmware/Kconfig               |  16 +
 drivers/firmware/qcom_scm.c            | 413 +++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  27 ++
 3 files changed, 456 insertions(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..ad59a0ba1f48 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,22 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config QCOM_SCM_QSEECOM
+	bool "Qualcomm QSEECOM interface"
+	depends on QCOM_SCM
+	help
+	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
+	  in the Trust Zone. This module provides an interface to that via the
+	  QSEECOM mechanism, using SCM calls.
+
+	  The QSEECOM interface allows, among other things, access to applications
+	  running in the SEE. An example of such an application is 'uefisecapp',
+	  which is required to access UEFI variables on certain systems. If
+	  selected, the interface will also attempt to detect and register client
+	  devices for supported applications.
+
+	  Select Y here to enable the QSEECOM interface.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index d0070b833889..1fa846d48795 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  */
+#include <linux/auxiliary_bus.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -59,6 +60,49 @@ struct qcom_scm_mem_map_info {
 	__le64 mem_size;
 };
 
+/**
+ * struct qcom_scm_qseecom_resp - QSEECOM SCM call response.
+ * @result:    Result or status of the SCM call. See &enum qcom_scm_qseecom_result.
+ * @resp_type: Type of the response. See &enum qcom_scm_qseecom_resp_type.
+ * @data:      Response data. The type of this data is given in @resp_type.
+ */
+struct qcom_scm_qseecom_resp {
+	u64 result;
+	u64 resp_type;
+	u64 data;
+};
+
+enum qcom_scm_qseecom_result {
+	QSEECOM_RESULT_SUCCESS			= 0,
+	QSEECOM_RESULT_INCOMPLETE		= 1,
+	QSEECOM_RESULT_BLOCKED_ON_LISTENER	= 2,
+	QSEECOM_RESULT_FAILURE			= 0xFFFFFFFF,
+};
+
+enum qcom_scm_qseecom_resp_type {
+	QSEECOM_SCM_RES_APP_ID			= 0xEE01,
+	QSEECOM_SCM_RES_QSEOS_LISTENER_ID	= 0xEE02,
+};
+
+enum qcom_scm_qseecom_tz_owner {
+	QSEECOM_TZ_OWNER_SIP			= 2,
+	QSEECOM_TZ_OWNER_TZ_APPS		= 48,
+	QSEECOM_TZ_OWNER_QSEE_OS		= 50
+};
+
+enum qcom_scm_qseecom_tz_svc {
+	QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER	= 0,
+	QSEECOM_TZ_SVC_APP_MGR			= 1,
+	QSEECOM_TZ_SVC_INFO			= 6,
+};
+
+struct qseecom_app_desc {
+	const char *app_name;
+	const char *dev_name;
+};
+
+#define QSEECOM_MAX_APP_NAME_SIZE		64
+
 /* Each bit configures cold/warm boot address for one of the 4 CPUs */
 static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	0, BIT(0), BIT(3), BIT(5)
@@ -1325,6 +1369,369 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 	return 0;
 }
 
+#ifdef CONFIG_QCOM_SCM_QSEECOM
+
+/* Lock for QSEECOM SCM call executions */
+DEFINE_MUTEX(qcom_scm_qseecom_call_lock);
+
+static int __qcom_scm_qseecom_call(const struct qcom_scm_desc *desc,
+				   struct qcom_scm_qseecom_resp *res)
+{
+	struct qcom_scm_res scm_res = {};
+	int status;
+
+	/*
+	 * QSEECOM SCM calls should not be executed concurrently. Therefore, we
+	 * require the respective call lock to be held.
+	 */
+	lockdep_assert_held(&qcom_scm_qseecom_call_lock);
+
+	status = qcom_scm_call(__scm->dev, desc, &scm_res);
+
+	res->result = scm_res.result[0];
+	res->resp_type = scm_res.result[1];
+	res->data = scm_res.result[2];
+
+	if (status)
+		return status;
+
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_call() - Perform a QSEECOM SCM call.
+ * @desc: SCM call descriptor.
+ * @res:  SCM call response (output).
+ *
+ * Performs the QSEECOM SCM call described by @desc, returning the response in
+ * @rsp.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+static int qcom_scm_qseecom_call(const struct qcom_scm_desc *desc,
+				 struct qcom_scm_qseecom_resp *res)
+{
+	int status;
+
+	/*
+	 * Note: Multiple QSEECOM SCM calls should not be executed same time,
+	 * so lock things here. This needs to be extended to callback/listener
+	 * handling when support for that is implemented.
+	 */
+
+	mutex_lock(&qcom_scm_qseecom_call_lock);
+	status = __qcom_scm_qseecom_call(desc, res);
+	mutex_unlock(&qcom_scm_qseecom_call_lock);
+
+	dev_dbg(__scm->dev, "%s: owner=%x, svc=%x, cmd=%x, result=%lld, type=%llx, data=%llx\n",
+		__func__, desc->owner, desc->svc, desc->cmd, res->result,
+		res->resp_type, res->data);
+
+	if (status) {
+		dev_err(__scm->dev, "qseecom: scm call failed with error %d\n", status);
+		return status;
+	}
+
+	/*
+	 * TODO: Handle incomplete and blocked calls:
+	 *
+	 * Incomplete and blocked calls are not supported yet. Some devices
+	 * and/or commands require those, some don't. Let's warn about them
+	 * prominently in case someone attempts to try these commands with a
+	 * device/command combination that isn't supported yet.
+	 */
+	WARN_ON(res->result == QSEECOM_RESULT_INCOMPLETE);
+	WARN_ON(res->result == QSEECOM_RESULT_BLOCKED_ON_LISTENER);
+
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_get_version() - Query the QSEECOM version.
+ * @version: Pointer where the QSEECOM version will be stored.
+ *
+ * Performs the QSEECOM SCM querying the QSEECOM version currently running in
+ * the TrustZone.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+static int qcom_scm_qseecom_get_version(u32 *version)
+{
+	struct qcom_scm_desc desc = {};
+	struct qcom_scm_qseecom_resp res = {};
+	u32 feature = 10;
+	int ret;
+
+	desc.owner = QSEECOM_TZ_OWNER_SIP;
+	desc.svc = QSEECOM_TZ_SVC_INFO;
+	desc.cmd = 0x03;
+	desc.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL);
+	desc.args[0] = feature;
+
+	ret = qcom_scm_qseecom_call(&desc, &res);
+	if (ret)
+		return ret;
+
+	*version = res.result;
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_app_get_id() - Query the app ID for a given QSEE app name.
+ * @app_name: The name of the app.
+ * @app_id:   The returned app ID.
+ *
+ * Query and return the application ID of the SEE app identified by the given
+ * name. This returned ID is the unique identifier of the app required for
+ * subsequent communication.
+ *
+ * Return: Returns zero on success, nonzero on failure. Returns -ENOENT if the
+ * app has not been loaded or could not be found.
+ */
+static int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
+{
+	unsigned long name_buf_size = QSEECOM_MAX_APP_NAME_SIZE;
+	unsigned long app_name_len = strlen(app_name);
+	struct qcom_scm_desc desc = {};
+	struct qcom_scm_qseecom_resp res = {};
+	dma_addr_t name_buf_phys;
+	char *name_buf;
+	int status;
+
+	if (app_name_len >= name_buf_size)
+		return -EINVAL;
+
+	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	if (!name_buf)
+		return -ENOMEM;
+
+	memcpy(name_buf, app_name, app_name_len);
+
+	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(__scm->dev, name_buf_phys)) {
+		kfree(name_buf);
+		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
+		return -EFAULT;
+	}
+
+	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
+	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
+	desc.cmd = 0x03;
+	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
+	desc.args[0] = name_buf_phys;
+	desc.args[1] = app_name_len;
+
+	status = qcom_scm_qseecom_call(&desc, &res);
+	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
+	kfree(name_buf);
+
+	if (status)
+		return status;
+
+	if (res.result == QSEECOM_RESULT_FAILURE)
+		return -ENOENT;
+
+	if (res.result != QSEECOM_RESULT_SUCCESS)
+		return -EINVAL;
+
+	if (res.resp_type != QSEECOM_SCM_RES_APP_ID)
+		return -EINVAL;
+
+	*app_id = res.data;
+	return 0;
+}
+
+/**
+ * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
+ * @client:   The QSEECOM client device corresponding to the target app.
+ * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req_size: Size of the request buffer.
+ * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp_size: Size of the response buffer.
+ *
+ * Sends a request to the QSEE app associated with the given client and read
+ * back its response. The caller must provide two DMA memory regions, one for
+ * the request and one for the response, and fill out the @req region with the
+ * respective (app-specific) request data. The QSEE app reads this and returns
+ * its response in the @rsp region.
+ *
+ * Return: Returns zero on success, nonzero error code on failure.
+ */
+int qcom_scm_qseecom_app_send(struct qseecom_client *client, void *req,
+			      size_t req_size, void *rsp, size_t rsp_size)
+{
+	struct qcom_scm_qseecom_resp res = {};
+	struct qcom_scm_desc desc = {};
+	dma_addr_t req_phys;
+	dma_addr_t rsp_phys;
+	int status;
+
+	/* Map request buffer */
+	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(__scm->dev, req_phys)) {
+		dev_err(__scm->dev, "qseecom: failed to map request buffer\n");
+		return -EFAULT;
+	}
+
+	/* Map response buffer */
+	rsp_phys = dma_map_single(__scm->dev, rsp, rsp_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(__scm->dev, rsp_phys)) {
+		dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
+		dev_err(__scm->dev, "qseecom: failed to map response buffer\n");
+		return -EFAULT;
+	}
+
+	/* Set up SCM call data */
+	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS,
+	desc.svc = QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER,
+	desc.cmd = 0x01,
+	desc.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_VAL,
+				     QCOM_SCM_RW, QCOM_SCM_VAL,
+				     QCOM_SCM_RW, QCOM_SCM_VAL),
+	desc.args[0] = client->app_id,
+	desc.args[1] = req_phys;
+	desc.args[2] = req_size;
+	desc.args[3] = rsp_phys;
+	desc.args[4] = rsp_size;
+
+	/* Perform call */
+	status = qcom_scm_qseecom_call(&desc, &res);
+
+	/* Unmap buffers */
+	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
+	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
+
+	if (status)
+		return status;
+
+	if (res.result != QSEECOM_RESULT_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qseecom_app_send);
+
+static void qseecom_client_release(struct device *dev)
+{
+	struct qseecom_client *client = container_of(dev, struct qseecom_client, aux_dev.dev);
+
+	kfree(client);
+}
+
+static void qseecom_client_remove(void *data)
+{
+	struct qseecom_client *client = data;
+
+	auxiliary_device_delete(&client->aux_dev);
+	auxiliary_device_uninit(&client->aux_dev);
+}
+
+static int qseecom_client_register(const struct qseecom_app_desc *desc)
+{
+	struct qseecom_client *client;
+	u32 app_id;
+	int ret;
+
+	/* Try to find the app ID, skip device if not found */
+	ret = qcom_scm_qseecom_app_get_id(desc->app_name, &app_id);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
+
+	dev_info(__scm->dev, "qseecom: setting up client for %s\n", desc->app_name);
+
+	/* Allocate and set-up the client device */
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->aux_dev.name = desc->dev_name;
+	client->aux_dev.dev.parent = __scm->dev;
+	client->aux_dev.dev.release = qseecom_client_release;
+	client->app_id = app_id;
+
+	ret = auxiliary_device_init(&client->aux_dev);
+	if (ret) {
+		kfree(client);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(&client->aux_dev);
+	if (ret) {
+		auxiliary_device_uninit(&client->aux_dev);
+		return ret;
+	}
+
+	/*
+	 * Ensure that the device is properly cleaned up in case of removal or
+	 * errors.
+	 */
+	ret = devm_add_action_or_reset(__scm->dev, qseecom_client_remove, client);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * We do not yet support re-entrant calls via the qseecom interface. To prevent
+ + any potential issues with this, only allow validated devices for now.
+ */
+static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
+	{ .compatible = "lenovo,thinkpad-x13s", },
+	{ }
+};
+
+static bool qcom_scm_qseecom_device_allowed(void)
+{
+	struct device_node *np;
+	bool match;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(qcom_scm_qseecom_allowlist, np);
+	of_node_put(np);
+
+	return match;
+}
+
+static const struct qseecom_app_desc qcom_scm_qseecom_apps[] = {};
+
+static int qcom_scm_qseecom_init(void)
+{
+	u32 version;
+	int ret, i;
+
+	/* Try to query the qseecom version, skip qseecom setup if this fails */
+	ret = qcom_scm_qseecom_get_version(&version);
+	if (ret)
+		return 0;
+
+	dev_info(__scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
+
+	/* Check against tested/verified devices */
+	if (!qcom_scm_qseecom_device_allowed()) {
+		dev_info(__scm->dev, "qseecom: untested device, skipping\n");
+		return 0;
+	}
+
+	/* Set up client devices for each base application */
+	for (i = 0; i < ARRAY_SIZE(qcom_scm_qseecom_apps); i++) {
+		ret = qseecom_client_register(&qcom_scm_qseecom_apps[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#else /* CONFIG_QCOM_SCM_QSEECOM */
+
+static int qcom_scm_qseecom_init(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_QCOM_SCM_QSEECOM */
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -1496,6 +1903,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	__get_convention();
 
+	ret = qcom_scm_qseecom_init();
+	if (ret < 0) {
+		__scm = NULL;
+		return dev_err_probe(scm->dev, ret, "Failed to initialize qseecom\n");
+	}
+
 	/*
 	 * If requested enable "download mode", from this point on warmboot
 	 * will cause the boot stages to enter download mode, unless
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..a168110ec55a 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -5,6 +5,7 @@
 #ifndef __QCOM_SCM_H
 #define __QCOM_SCM_H
 
+#include <linux/auxiliary_bus.h>
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -122,4 +123,30 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
+/**
+ * struct qseecom_client - QSEECOM client device.
+ * @aux_dev: Underlying auxiliary device.
+ * @app_id: ID of the loaded application.
+ */
+struct qseecom_client {
+	struct auxiliary_device aux_dev;
+	u32 app_id;
+};
+
+#ifdef CONFIG_QCOM_SCM_QSEECOM
+
+int qcom_scm_qseecom_app_send(struct qseecom_client *client, void *req,
+			      size_t req_size, void *rsp, size_t rsp_size);
+
+#else /* CONFIG_QCOM_SCM_QSEECOM */
+
+static inline int qcom_scm_qseecom_app_send(struct qseecom_client *client,
+					    void *req, size_t req_size,
+					    void *rsp, size_t rsp_size)
+{
+	return 0;
+}
+
+#endif /* CONFIG_QCOM_SCM_QSEECOM */
+
 #endif
-- 
2.40.1

