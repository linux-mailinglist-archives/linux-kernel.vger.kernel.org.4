Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464A95B8AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiINOoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiINOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:44:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF7647FA;
        Wed, 14 Sep 2022 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663166646; x=1694702646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+rOJ0/dnmnQiWen6y/bUAIOKbNtkilLeWVV8HTPrr5w=;
  b=So+cXxJOqAWqbi1YhY7tKYZ2jAPB7isto463s4jQ9Buh5rYd5uvfNSJq
   LGhmwOtGK0r8S7pjpr7n2iU/Pu8eC5TJcz4QjIQN2L/zC6hZncv8kELf0
   ioz4gj6Knm8Bmb2bkHUNqfyvlFvMbCLxjsKuNvS+208HDuatdTupdqjfR
   fY458zYPheAuDU7k7R+5P79v7FXXorFKeqQwfqZldXAlTau94AnwfeuXR
   sNom8+3Ss7GBkqyNPaWfs5hIUFdJlmoBxKPp+w49LAJTtBbEt4DGGXZBx
   9cAVlSGU8Zfxe+hQYEjCHiyS7+GTEQ78APhCQhLvLNgA9bF7DK7ybtZEM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278833347"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278833347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720608466"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2022 07:44:02 -0700
From:   wen.ping.teh@intel.com
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Teh Wen Ping <wen.ping.teh@intel.com>
Subject: [PATCH 1/2] crypto: intel-fcs: crypto service driver for Intel SoCFPGA family
Date:   Wed, 14 Sep 2022 22:43:20 +0800
Message-Id: <20220914144320.605421-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Support crypto services on Intel SoCFPGA platforms. The crypto services
include security certificate, image boot validation, security key
cancellation, get provision data, random number generation and secure
data object storage services.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
---
 drivers/crypto/Kconfig               |  11 +
 drivers/crypto/Makefile              |   1 +
 drivers/crypto/intel_fcs.c           | 726 +++++++++++++++++++++++++++
 include/uapi/linux/intel_fcs-ioctl.h | 211 ++++++++
 4 files changed, 949 insertions(+)
 create mode 100644 drivers/crypto/intel_fcs.c
 create mode 100644 include/uapi/linux/intel_fcs-ioctl.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3e6aa319920b..f307f6f159f9 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -240,6 +240,17 @@ config CRYPTO_DEV_TALITOS2
 	  Say 'Y' here to use the Freescale Security Engine (SEC)
 	  version 2 and following as found on MPC83xx, MPC85xx, etc ...
 
+config CRYPTO_DEV_INTEL_FCS
+	tristate "Intel FPGA Crypto Service support"
+	depends on INTEL_STRATIX10_SERVICE
+	help
+	 Support crypto services on Intel SoCFPGA platforms. The crypto
+	 services include security certificate, image boot validation,
+	 security key cancellation, get provision data, random number
+	 generation and secure data object storage services.
+
+	 Say Y here if you want Intel FCS support
+
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
 	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index f81703a86b98..997f48ee4db5 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM_COMMON) += caam/
 obj-$(CONFIG_CRYPTO_DEV_GEODE) += geode-aes.o
 obj-$(CONFIG_CRYPTO_DEV_HIFN_795X) += hifn_795x.o
 obj-$(CONFIG_CRYPTO_DEV_IMGTEC_HASH) += img-hash.o
+obj-$(CONFIG_CRYPTO_DEV_INTEL_FCS) += intel_fcs.o
 obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
 obj-$(CONFIG_CRYPTO_DEV_MARVELL) += marvell/
 obj-$(CONFIG_CRYPTO_DEV_MXS_DCP) += mxs-dcp.o
diff --git a/drivers/crypto/intel_fcs.c b/drivers/crypto/intel_fcs.c
new file mode 100644
index 000000000000..7b2fdcc4c604
--- /dev/null
+++ b/drivers/crypto/intel_fcs.c
@@ -0,0 +1,726 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Intel Corporation
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/intel/stratix10-svc-client.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/intel_fcs-ioctl.h>
+
+#define RANDOM_NUMBER_SIZE	32
+#define FILE_NAME_SIZE		32
+#define PS_BUF_SIZE		64
+#define INVALID_STATUS		0xff
+
+#define DEC_MIN_SZ		72
+#define DEC_MAX_SZ		32712
+#define ENC_MIN_SZ		128
+#define ENC_MAX_SZ		32768
+
+
+#define FCS_REQUEST_TIMEOUT (msecs_to_jiffies(SVC_FCS_REQUEST_TIMEOUT_MS))
+#define FCS_COMPLETED_TIMEOUT (msecs_to_jiffies(SVC_COMPLETED_TIMEOUT_MS))
+
+typedef void (*fcs_callback)(struct stratix10_svc_client *client,
+			     struct stratix10_svc_cb_data *data);
+
+struct intel_fcs_priv {
+	struct stratix10_svc_chan *chan;
+	struct stratix10_svc_client client;
+	struct completion completion;
+	struct mutex lock;
+	struct miscdevice miscdev;
+	unsigned int status;
+	void *kbuf;
+	unsigned int size;
+};
+
+static void fcs_data_callback(struct stratix10_svc_client *client,
+			      struct stratix10_svc_cb_data *data)
+{
+	struct intel_fcs_priv *priv = client->priv;
+
+	if ((data->status == BIT(SVC_STATUS_OK)) ||
+	    (data->status == BIT(SVC_STATUS_COMPLETED))) {
+		priv->status = 0;
+		priv->kbuf = data->kaddr2;
+		priv->size = *((unsigned int *)data->kaddr3);
+	} else if (data->status == BIT(SVC_STATUS_ERROR)) {
+		priv->status = *((unsigned int *)data->kaddr1);
+		dev_err(client->dev, "error, mbox_error=0x%x\n", priv->status);
+		priv->kbuf = data->kaddr2;
+		priv->size = (data->kaddr3) ?
+			*((unsigned int *)data->kaddr3) : 0;
+	} else {
+		dev_warn(client->dev, "rejected, invalid param\n");
+		priv->status = -EINVAL;
+		priv->kbuf = NULL;
+		priv->size = 0;
+	}
+
+	complete(&priv->completion);
+}
+
+static void fcs_vab_callback(struct stratix10_svc_client *client,
+			     struct stratix10_svc_cb_data *data)
+{
+	struct intel_fcs_priv *priv = client->priv;
+
+	if (data->status == BIT(SVC_STATUS_ERROR)) {
+		priv->status = *((unsigned int *)data->kaddr1);
+		dev_err(client->dev, "mbox_error=0x%x\n", priv->status);
+	} else if (data->status == BIT(SVC_STATUS_BUSY)) {
+		priv->status = -ETIMEDOUT;
+		dev_err(client->dev, "timeout to get completed status\n");
+	} else if (data->status == BIT(SVC_STATUS_OK)) {
+		priv->status = 0;
+	} else {
+		priv->status = -EINVAL;
+		dev_err(client->dev, "rejected, invalid param\n");
+	}
+
+	complete(&priv->completion);
+}
+
+static int fcs_request_service(struct intel_fcs_priv *priv,
+			       void *msg, unsigned long timeout)
+{
+	struct stratix10_svc_client_msg *p_msg =
+			(struct stratix10_svc_client_msg *)msg;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	reinit_completion(&priv->completion);
+
+	ret = stratix10_svc_send(priv->chan, p_msg);
+	if (ret)
+		return -EINVAL;
+
+	ret = wait_for_completion_timeout(&priv->completion,
+							timeout);
+	if (!ret) {
+		dev_err(priv->client.dev,
+			"timeout waiting for SMC call\n");
+		ret = -ETIMEDOUT;
+	} else
+		ret = 0;
+
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static void fcs_close_services(struct intel_fcs_priv *priv,
+			       void *sbuf, void *dbuf)
+{
+	if (sbuf)
+		stratix10_svc_free_memory(priv->chan, sbuf);
+
+	if (dbuf)
+		stratix10_svc_free_memory(priv->chan, dbuf);
+
+	stratix10_svc_done(priv->chan);
+}
+
+static long fcs_ioctl(struct file *file, unsigned int cmd,
+		      unsigned long arg)
+{
+	struct intel_fcs_dev_ioctl *data;
+	struct intel_fcs_priv *priv;
+	struct device *dev;
+	struct stratix10_svc_client_msg *msg;
+	const struct firmware *fw;
+	char filename[FILE_NAME_SIZE];
+	size_t tsz, datasz;
+	void *s_buf;
+	void *d_buf;
+	void *ps_buf;
+	unsigned int buf_sz;
+	int ret = 0;
+	int i;
+
+	priv = container_of(file->private_data, struct intel_fcs_priv, miscdev);
+	dev = priv->client.dev;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	msg = devm_kzalloc(dev, sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	switch (cmd) {
+	case INTEL_FCS_DEV_VALIDATION_REQUEST:
+		if (copy_from_user(data, (void __user *)arg, sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		/* for bitstream */
+		dev_dbg(dev, "file_name=%s, status=%d\n",
+			 (char *)data->com_paras.s_request.src, data->status);
+		scnprintf(filename, FILE_NAME_SIZE, "%s",
+				(char *)data->com_paras.s_request.src);
+		ret = request_firmware(&fw, filename, priv->client.dev);
+		if (ret) {
+			dev_err(dev, "error requesting firmware %s\n",
+				(char *)data->com_paras.s_request.src);
+			return -EFAULT;
+		}
+
+		dev_dbg(dev, "FW size=%ld\n", fw->size);
+		s_buf = stratix10_svc_allocate_memory(priv->chan, fw->size);
+		if (!s_buf) {
+			dev_err(dev, "failed to allocate VAB buffer\n");
+			release_firmware(fw);
+			return -ENOMEM;
+		}
+
+		memcpy(s_buf, fw->data, fw->size);
+
+		msg->payload_length = fw->size;
+		release_firmware(fw);
+
+		msg->command = COMMAND_FCS_REQUEST_SERVICE;
+		msg->payload = s_buf;
+		priv->client.receive_cb = fcs_vab_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+		dev_dbg(dev, "fcs_request_service ret=%d\n", ret);
+		if (!ret && !priv->status) {
+			/* to query the complete status */
+			msg->command = COMMAND_POLL_SERVICE_STATUS;
+			priv->client.receive_cb = fcs_data_callback;
+			ret = fcs_request_service(priv, (void *)msg,
+						  FCS_COMPLETED_TIMEOUT);
+			dev_dbg(dev, "fcs_request_service ret=%d\n", ret);
+			if (!ret && !priv->status)
+				data->status = 0;
+			else
+				data->status = priv->status;
+		} else
+			data->status = priv->status;
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, s_buf, NULL);
+			ret = -EFAULT;
+		}
+
+		fcs_close_services(priv, s_buf, NULL);
+		break;
+
+	case INTEL_FCS_DEV_SEND_CERTIFICATE:
+		if (copy_from_user(data, (void __user *)arg, sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		dev_dbg(dev, "Test=%d, Size=%d; Address=0x%p\n",
+			data->com_paras.c_request.test.test_bit,
+			data->com_paras.c_request.size,
+			data->com_paras.c_request.addr);
+
+		/* Allocate memory for certificate + test word */
+		tsz = sizeof(struct intel_fcs_cert_test_word);
+		datasz = data->com_paras.s_request.size + tsz;
+
+		s_buf = stratix10_svc_allocate_memory(priv->chan, datasz);
+		if (!s_buf) {
+			dev_err(dev, "failed to allocate VAB buffer\n");
+			return -ENOMEM;
+		}
+
+		ps_buf = stratix10_svc_allocate_memory(priv->chan, PS_BUF_SIZE);
+		if (!ps_buf) {
+			dev_err(dev, "failed to allocate p-status buf\n");
+			stratix10_svc_free_memory(priv->chan, s_buf);
+			return -ENOMEM;
+		}
+
+		/* Copy the test word */
+		memcpy(s_buf, &data->com_paras.c_request.test, tsz);
+
+		/* Copy in the certificate data (skipping over the test word) */
+		ret = copy_from_user(s_buf + tsz,
+				     data->com_paras.c_request.addr,
+				     data->com_paras.s_request.size);
+		if (ret) {
+			dev_err(dev, "failed copy buf ret=%d\n", ret);
+			fcs_close_services(priv, s_buf, ps_buf);
+			return -EFAULT;
+		}
+
+		msg->payload_length = datasz;
+		msg->command = COMMAND_FCS_SEND_CERTIFICATE;
+		msg->payload = s_buf;
+		priv->client.receive_cb = fcs_vab_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+		dev_dbg(dev, "fcs_request_service ret=%d\n", ret);
+		if (!ret && !priv->status) {
+			/* to query the complete status */
+			msg->payload = ps_buf;
+			msg->payload_length = PS_BUF_SIZE;
+			msg->command = COMMAND_POLL_SERVICE_STATUS;
+			priv->client.receive_cb = fcs_data_callback;
+			ret = fcs_request_service(priv, (void *)msg,
+						  FCS_COMPLETED_TIMEOUT);
+			dev_dbg(dev, "request service ret=%d\n", ret);
+			if (!ret && !priv->status)
+				data->status = 0;
+			else {
+				if (priv->kbuf)
+					data->com_paras.c_request.c_status =
+						(*(u32 *)priv->kbuf);
+				else
+					data->com_paras.c_request.c_status =
+						INVALID_STATUS;
+			}
+		} else
+			data->status = priv->status;
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, s_buf, NULL);
+			ret = -EFAULT;
+		}
+
+		fcs_close_services(priv, s_buf, ps_buf);
+		break;
+
+	case INTEL_FCS_DEV_RANDOM_NUMBER_GEN:
+		if (copy_from_user(data, (void __user *)arg, sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		s_buf = stratix10_svc_allocate_memory(priv->chan,
+						      RANDOM_NUMBER_SIZE);
+		if (!s_buf) {
+			dev_err(dev, "failed to allocate RNG buffer\n");
+			return -ENOMEM;
+		}
+
+		msg->command = COMMAND_FCS_RANDOM_NUMBER_GEN;
+		msg->payload = s_buf;
+		msg->payload_length = RANDOM_NUMBER_SIZE;
+		priv->client.receive_cb = fcs_data_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+
+		if (!ret && !priv->status) {
+			if (!priv->kbuf) {
+				dev_err(dev, "failure on kbuf\n");
+				fcs_close_services(priv, s_buf, NULL);
+				return -EFAULT;
+			}
+
+			for (i = 0; i < 8; i++)
+				dev_dbg(dev, "output_data[%d]=%d\n", i,
+					 *((int *)priv->kbuf + i));
+
+			for (i = 0; i < 8; i++)
+				data->com_paras.rn_gen.rndm[i] =
+					*((int *)priv->kbuf + i);
+			data->status = priv->status;
+
+		} else {
+			/* failed to get RNG */
+			data->status = priv->status;
+		}
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, s_buf, NULL);
+			ret = -EFAULT;
+		}
+
+		fcs_close_services(priv, s_buf, NULL);
+		break;
+	case INTEL_FCS_DEV_GET_PROVISION_DATA:
+		if (copy_from_user(data, (void __user *)arg,
+				   sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		s_buf = stratix10_svc_allocate_memory(priv->chan,
+					data->com_paras.gp_data.size);
+		if (!s_buf) {
+			dev_err(dev, "failed allocate provision buffer\n");
+			return -ENOMEM;
+		}
+
+		msg->command = COMMAND_FCS_GET_PROVISION_DATA;
+		msg->payload = s_buf;
+		msg->payload_length = data->com_paras.gp_data.size;
+		priv->client.receive_cb = fcs_data_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+		if (!ret && !priv->status) {
+			if (!priv->kbuf) {
+				dev_err(dev, "failure on kbuf\n");
+				fcs_close_services(priv, s_buf, NULL);
+				return -EFAULT;
+			}
+			data->com_paras.gp_data.size = priv->size;
+			ret = copy_to_user(data->com_paras.gp_data.addr,
+					   priv->kbuf, priv->size);
+			if (ret) {
+				dev_err(dev, "failure on copy_to_user\n");
+				fcs_close_services(priv, s_buf, NULL);
+				return -EFAULT;
+			}
+			data->status = 0;
+		} else {
+			data->com_paras.gp_data.addr = NULL;
+			data->com_paras.gp_data.size = 0;
+			data->status = priv->status;
+		}
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, s_buf, NULL);
+			return -EFAULT;
+		}
+
+		fcs_close_services(priv, s_buf, NULL);
+		break;
+	case INTEL_FCS_DEV_DATA_ENCRYPTION:
+		if (copy_from_user(data, (void __user *)arg, sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		if (data->com_paras.d_encryption.src_size < DEC_MIN_SZ ||
+		    data->com_paras.d_encryption.src_size > DEC_MAX_SZ) {
+			dev_err(dev, "Invalid SDOS Buffer src size:%d\n",
+				data->com_paras.d_encryption.src_size);
+			return -EFAULT;
+		}
+
+		if (data->com_paras.d_encryption.dst_size < ENC_MIN_SZ ||
+		    data->com_paras.d_encryption.dst_size > ENC_MAX_SZ) {
+			dev_err(dev, "Invalid SDOS Buffer dst size:%d\n",
+				data->com_paras.d_encryption.dst_size);
+			return -EFAULT;
+		}
+
+		/* allocate buffer for both source and destination */
+		s_buf = stratix10_svc_allocate_memory(priv->chan,
+						      DEC_MAX_SZ);
+		if (!s_buf) {
+			dev_err(dev, "failed allocate encrypt src buf\n");
+			return -ENOMEM;
+		}
+		d_buf = stratix10_svc_allocate_memory(priv->chan,
+						      ENC_MAX_SZ);
+		if (!d_buf) {
+			dev_err(dev, "failed allocate encrypt dst buf\n");
+			stratix10_svc_free_memory(priv->chan, s_buf);
+			return -ENOMEM;
+		}
+		ps_buf = stratix10_svc_allocate_memory(priv->chan, PS_BUF_SIZE);
+		if (!ps_buf) {
+			dev_err(dev, "failed allocate p-status buffer\n");
+			fcs_close_services(priv, s_buf, d_buf);
+			return -ENOMEM;
+		}
+		ret = copy_from_user(s_buf,
+				     data->com_paras.d_encryption.src,
+				     data->com_paras.d_encryption.src_size);
+		if (ret) {
+			dev_err(dev, "failure on copy_from_user\n");
+			fcs_close_services(priv, ps_buf, NULL);
+			fcs_close_services(priv, s_buf, d_buf);
+			return -ENOMEM;
+		}
+
+		msg->command = COMMAND_FCS_DATA_ENCRYPTION;
+		msg->payload = s_buf;
+		msg->payload_length =
+			data->com_paras.d_encryption.src_size;
+		msg->payload_output = d_buf;
+		msg->payload_length_output =
+			data->com_paras.d_encryption.dst_size;
+		priv->client.receive_cb = fcs_vab_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+		if (!ret && !priv->status) {
+			msg->payload = ps_buf;
+			msg->payload_length = PS_BUF_SIZE;
+			msg->command = COMMAND_POLL_SERVICE_STATUS;
+
+			priv->client.receive_cb = fcs_data_callback;
+			ret = fcs_request_service(priv, (void *)msg,
+						  FCS_COMPLETED_TIMEOUT);
+			dev_dbg(dev, "request service ret=%d\n", ret);
+
+			if (!ret && !priv->status) {
+				if (!priv->kbuf) {
+					dev_err(dev, "failure on kbuf\n");
+					fcs_close_services(priv, ps_buf, NULL);
+					fcs_close_services(priv, s_buf, d_buf);
+					return -EFAULT;
+				}
+				buf_sz = *(unsigned int *)priv->kbuf;
+				data->com_paras.d_encryption.dst_size = buf_sz;
+				data->status = 0;
+				ret = copy_to_user(data->com_paras.d_encryption.dst,
+						   d_buf, buf_sz);
+				if (ret) {
+					dev_err(dev, "failure on copy_to_user\n");
+					fcs_close_services(priv, ps_buf, NULL);
+					fcs_close_services(priv, s_buf, d_buf);
+					return -EFAULT;
+				}
+			} else {
+				data->com_paras.d_encryption.dst = NULL;
+				data->com_paras.d_encryption.dst_size = 0;
+				data->status = priv->status;
+			}
+		} else {
+			data->com_paras.d_encryption.dst = NULL;
+			data->com_paras.d_encryption.dst_size = 0;
+			data->status = priv->status;
+		}
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, ps_buf, NULL);
+			fcs_close_services(priv, s_buf, d_buf);
+			ret = -EFAULT;
+		}
+
+		fcs_close_services(priv, ps_buf, NULL);
+		fcs_close_services(priv, s_buf, d_buf);
+		break;
+	case INTEL_FCS_DEV_DATA_DECRYPTION:
+		if (copy_from_user(data, (void __user *)arg, sizeof(*data))) {
+			dev_err(dev, "failure on copy_from_user\n");
+			return -EFAULT;
+		}
+
+		if (data->com_paras.d_encryption.src_size < ENC_MIN_SZ ||
+		    data->com_paras.d_encryption.src_size > ENC_MAX_SZ) {
+			dev_err(dev, "Invalid SDOS Buffer src size:%d\n",
+				data->com_paras.d_encryption.src_size);
+			return -EFAULT;
+		}
+
+		if (data->com_paras.d_encryption.dst_size < DEC_MIN_SZ ||
+		    data->com_paras.d_encryption.dst_size > DEC_MAX_SZ) {
+			dev_err(dev, "Invalid SDOS Buffer dst size:%d\n",
+				data->com_paras.d_encryption.dst_size);
+			return -EFAULT;
+		}
+
+		/* allocate buffer for both source and destination */
+		s_buf = stratix10_svc_allocate_memory(priv->chan,
+						      ENC_MAX_SZ);
+		if (!s_buf) {
+			dev_err(dev, "failed allocate decrypt src buf\n");
+			return -ENOMEM;
+		}
+		d_buf = stratix10_svc_allocate_memory(priv->chan,
+						      DEC_MAX_SZ);
+		if (!d_buf) {
+			dev_err(dev, "failed allocate decrypt dst buf\n");
+			stratix10_svc_free_memory(priv->chan, s_buf);
+			return -ENOMEM;
+		}
+
+		ps_buf = stratix10_svc_allocate_memory(priv->chan,
+						       PS_BUF_SIZE);
+		if (!ps_buf) {
+			dev_err(dev, "failed allocate p-status buffer\n");
+			fcs_close_services(priv, s_buf, d_buf);
+			return -ENOMEM;
+		}
+
+		ret = copy_from_user(s_buf,
+				     data->com_paras.d_decryption.src,
+				     data->com_paras.d_decryption.src_size);
+		if (ret) {
+			dev_err(dev, "failure on copy_from_user\n");
+			fcs_close_services(priv, ps_buf, NULL);
+			fcs_close_services(priv, s_buf, d_buf);
+			return -EFAULT;
+		}
+
+		msg->command = COMMAND_FCS_DATA_DECRYPTION;
+		msg->payload = s_buf;
+		msg->payload_length =
+				data->com_paras.d_decryption.src_size;
+		msg->payload_output = d_buf;
+		msg->payload_length_output =
+				data->com_paras.d_decryption.dst_size;
+		priv->client.receive_cb = fcs_vab_callback;
+
+		ret = fcs_request_service(priv, (void *)msg,
+					  FCS_REQUEST_TIMEOUT);
+		if (!ret && !priv->status) {
+			msg->command = COMMAND_POLL_SERVICE_STATUS;
+			msg->payload = ps_buf;
+			msg->payload_length = PS_BUF_SIZE;
+			priv->client.receive_cb = fcs_data_callback;
+			ret = fcs_request_service(priv, (void *)msg,
+						  FCS_COMPLETED_TIMEOUT);
+			dev_dbg(dev, "request service ret=%d\n", ret);
+			if (!ret && !priv->status) {
+				if (!priv->kbuf) {
+					dev_err(dev, "failure on kbuf\n");
+					fcs_close_services(priv, ps_buf, NULL);
+					fcs_close_services(priv, s_buf, d_buf);
+					return -EFAULT;
+				}
+				buf_sz = *((unsigned int *)priv->kbuf);
+				data->com_paras.d_decryption.dst_size = buf_sz;
+				data->status = 0;
+				ret = copy_to_user(data->com_paras.d_decryption.dst,
+						   d_buf, buf_sz);
+				if (ret) {
+					dev_err(dev, "failure on copy_to_user\n");
+					fcs_close_services(priv, ps_buf, NULL);
+					fcs_close_services(priv, s_buf, d_buf);
+					return -EFAULT;
+				}
+			} else {
+				data->com_paras.d_decryption.dst = NULL;
+				data->com_paras.d_decryption.dst_size = 0;
+				data->status = priv->status;
+			}
+		} else {
+			data->com_paras.d_decryption.dst = NULL;
+			data->com_paras.d_decryption.dst_size = 0;
+			data->status = priv->status;
+		}
+
+		if (copy_to_user((void __user *)arg, data, sizeof(*data))) {
+			dev_err(dev, "failure on copy_to_user\n");
+			fcs_close_services(priv, ps_buf, NULL);
+			fcs_close_services(priv, s_buf, d_buf);
+			ret = -EFAULT;
+		}
+
+		fcs_close_services(priv, ps_buf, NULL);
+		fcs_close_services(priv, s_buf, d_buf);
+		break;
+	default:
+		dev_warn(dev, "shouldn't be here [0x%x]\n", cmd);
+		break;
+	}
+
+	return ret;
+}
+
+static int fcs_open(struct inode *inode, struct file *file)
+{
+	pr_debug("%s\n", __func__);
+
+	return 0;
+}
+
+static int fcs_close(struct inode *inode, struct file *file)
+{
+
+	pr_debug("%s\n", __func__);
+
+	return 0;
+}
+
+static const struct file_operations fcs_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = fcs_ioctl,
+	.open = fcs_open,
+	.release = fcs_close,
+};
+
+static int fcs_driver_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_fcs_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client.dev = dev;
+	priv->client.receive_cb = NULL;
+	priv->client.priv = priv;
+	priv->status = INVALID_STATUS;
+
+	mutex_init(&priv->lock);
+	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
+							  SVC_CLIENT_FCS);
+	if (IS_ERR(priv->chan)) {
+		dev_err(dev, "couldn't get service channel %s\n",
+			SVC_CLIENT_FCS);
+		return PTR_ERR(priv->chan);
+	}
+
+	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+	priv->miscdev.name = "fcs";
+	priv->miscdev.fops = &fcs_fops;
+
+	init_completion(&priv->completion);
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = misc_register(&priv->miscdev);
+	if (ret) {
+		dev_err(dev, "can't register on minor=%d\n",
+			MISC_DYNAMIC_MINOR);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fcs_driver_remove(struct platform_device *pdev)
+{
+	struct intel_fcs_priv *priv = platform_get_drvdata(pdev);
+
+	misc_deregister(&priv->miscdev);
+	stratix10_svc_free_channel(priv->chan);
+
+	return 0;
+}
+
+static struct platform_driver fcs_driver = {
+	.probe = fcs_driver_probe,
+	.remove = fcs_driver_remove,
+	.driver = {
+		.name = "intel-fcs",
+	},
+};
+
+module_platform_driver(fcs_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel FGPA Crypto Services Driver");
+MODULE_AUTHOR("Teh Wen Ping <wen.ping.teh@intel.com>");
+
diff --git a/include/uapi/linux/intel_fcs-ioctl.h b/include/uapi/linux/intel_fcs-ioctl.h
new file mode 100644
index 000000000000..a0483480d22a
--- /dev/null
+++ b/include/uapi/linux/intel_fcs-ioctl.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020, Intel Corporation
+ */
+
+#ifndef __INTEL_FCS_IOCTL_H
+#define __INTEL_FCS_IOCTL_H
+
+#include <linux/types.h>
+
+/* the value may need be changed when upstream */
+#define INTEL_FCS_IOCTL		0xC0
+
+/**
+ * enum fcs_vab_img_type - enumeration of image types
+ * @INTEL_FCS_IMAGE_HPS: Image to validate is HPS image
+ * @INTEL_FCS_IMAGE_BITSTREAM: Image to validate is bitstream
+ */
+enum fcs_vab_img_type {
+	INTEL_FCS_IMAGE_HPS = 0,
+	INTEL_FCS_IMAGE_BITSTREAM = 1
+};
+
+/**
+ * enum fcs_certificate_test - enumeration of certificate test
+ * @INTEL_FCS_NO_TEST: Write to eFuses
+ * @INTEL_FCS_TEST: Write to cache, do not write eFuses
+ */
+enum fcs_certificate_test {
+	INTEL_FCS_NO_TEST = 0,
+	INTEL_FCS_TEST = 1
+};
+
+/**
+ * struct intel_fcs_cert_test_word - certificate test word
+ * @test_bit: if set, do not write fuses, write to cache only.
+ * @rsvd: write as 0
+ */
+struct intel_fcs_cert_test_word {
+	uint32_t test_bit:1;
+	uint32_t rsvd:31;
+};
+
+/**
+ * struct fcs_validation_request - validate HPS or bitstream image
+ * @so_type: the type of signed object, 0 for HPS and 1 for bitstream
+ * @src: the source of signed object,
+ *       for HPS, this is the virtual address of the signed source
+ *	 for Bitstream, this is path of the signed source, the default
+ *       path is /lib/firmware
+ * @size: the size of the signed object
+ */
+struct fcs_validation_request {
+	enum fcs_vab_img_type so_type;
+	void *src;
+	uint32_t size;
+};
+
+/**
+ * struct fcs_key_manage_request - Request key management from SDM
+ * @addr: the virtual address of the signed object,
+ * @size: the size of the signed object
+ */
+struct fcs_key_manage_request {
+	void *addr;
+	uint32_t size;
+};
+
+/**
+ * struct fcs_certificate_request - Certificate request to SDM
+ * @test: test bit (1 if want to write to cache instead of fuses)
+ * @addr: the virtual address of the signed object,
+ * @size: the size of the signed object
+ * @c_status: returned certificate status
+ */
+struct fcs_certificate_request {
+	struct intel_fcs_cert_test_word test;
+	void *addr;
+	uint32_t size;
+	uint32_t c_status;
+};
+
+/**
+ * struct fcs_data_encryption - aes data encryption command layout
+ * @src: the virtual address of the input data
+ * @src_size: the size of the unencrypted source
+ * @dst: the virtual address of the output data
+ * @dst_size: the size of the encrypted result
+ */
+struct fcs_data_encryption {
+	void *src;
+	uint32_t src_size;
+	void *dst;
+	uint32_t dst_size;
+};
+
+/**
+ * struct fcs_data_decryption - aes data decryption command layout
+ * @src: the virtual address of the input data
+ * @src_size: the size of the encrypted source
+ * @dst: the virtual address of the output data
+ * @dst_size: the size of the decrypted result
+ */
+struct fcs_data_decryption {
+	void *src;
+	uint32_t src_size;
+	void *dst;
+	uint32_t dst_size;
+};
+
+/**
+ * struct fcs_random_number_gen
+ * @rndm: 8 words of random data.
+ */
+struct fcs_random_number_gen {
+	uint32_t rndm[8];
+};
+
+/**
+ * struct intel_fcs_dev_ioct: common structure passed to Linux
+ *	kernel driver for all commands.
+ * @status: Used for the return code.
+ *      -1 -- operation is not started
+ *       0 -- operation is successfully completed
+ *      non-zero -- operation failed
+ * @s_request: Validation of a bitstream.
+ * @c_request: Certificate request.
+ *      hps_vab: validation of an HPS image
+ *	counter set: burn fuses for new counter values
+ * @gp_data: view the eFuse provisioning state.
+ * @d_encryption: AES encryption (SDOS)
+ * @d_decryption: AES decryption (SDOS)
+ * @rn_gen: random number generator result
+ */
+struct intel_fcs_dev_ioctl {
+	/* used for return status code */
+	int status;
+
+	/* command parameters */
+	union {
+		struct fcs_validation_request	s_request;
+		struct fcs_certificate_request	c_request;
+		struct fcs_key_manage_request	gp_data;
+		struct fcs_data_encryption	d_encryption;
+		struct fcs_data_decryption	d_decryption;
+		struct fcs_random_number_gen	rn_gen;
+	} com_paras;
+};
+
+/**
+ * intel_fcs_command_code - support fpga crypto service commands
+ *
+ * Values are subject to change as a result of upstreaming.
+ *
+ * @INTEL_FCS_DEV_VERSION_CMD:
+ *
+ * @INTEL_FCS_DEV_CERTIFICATE_CMD:
+ *
+ * @INTEL_FCS_DEV_VALIDATE_REQUEST_CMD:
+ *
+ * @INTEL_FCS_DEV_COUNTER_SET_CMD:
+ *
+ * @INTEL_FCS_DEV_SVN_COMMIT_CMD:
+ *
+ * @INTEL_FCS_DEV_DATA_ENCRYPTION_CMD:
+ *
+ * @INTEL_FCS_DEV_DATA_DECRYPTION_CMD:
+ *
+ * @INTEL_FCS_DEV_RANDOM_NUMBER_GEN_CMD:
+ */
+enum intel_fcs_command_code {
+	INTEL_FCS_DEV_COMMAND_NONE = 0,
+	INTEL_FCS_DEV_VERSION_CMD = 1,
+	INTEL_FCS_DEV_CERTIFICATE_CMD = 0xB,
+	INTEL_FCS_DEV_VALIDATE_REQUEST_CMD = 0x78,
+	INTEL_FCS_DEV_COUNTER_SET_CMD,
+	INTEL_FCS_DEV_GET_PROVISION_DATA_CMD = 0x7B,
+	INTEL_FCS_DEV_DATA_ENCRYPTION_CMD = 0x7E,
+	INTEL_FCS_DEV_DATA_DECRYPTION_CMD,
+	INTEL_FCS_DEV_RANDOM_NUMBER_GEN_CMD
+};
+
+#define INTEL_FCS_DEV_VERSION_REQUEST \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_VERSION_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_VALIDATION_REQUEST \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_VALIDATE_REQUEST_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_SEND_CERTIFICATE \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_CERTIFICATE_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_GET_PROVISION_DATA \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_GET_PROVISION_DATA_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_DATA_ENCRYPTION \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_DATA_ENCRYPTION_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_DATA_DECRYPTION \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_DATA_DECRYPTION_CMD, struct intel_fcs_dev_ioctl)
+
+#define INTEL_FCS_DEV_RANDOM_NUMBER_GEN \
+	_IOWR(INTEL_FCS_IOCTL, \
+	      INTEL_FCS_DEV_RANDOM_NUMBER_GEN_CMD, struct intel_fcs_dev_ioctl)
+#endif
+
-- 
2.25.1

