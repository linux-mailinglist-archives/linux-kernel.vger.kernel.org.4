Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0779862464B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKJPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiKJPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:46:44 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166162DA98
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:46:42 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AAFbrE2011740;
        Thu, 10 Nov 2022 16:46:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=yOeh3RiZA3+txo8FSZDXOsHC1HecM76LGBbP5ku2mAU=;
 b=ouU+YerwtMOrKQWrMiOB/IFjCE+Ozn/7KvIFXhJy2citTIUz/ZgYob/ZL+2pZRZnCsGS
 Rz73ww0mIpjh0gCvSI1fGT5fI4gynD7n627ncmN10AVzhwhcpzsDB9zN1sfH+av5frMn
 NtJJ4Pb/80I2qjPGdZgGeKetW9cJla9Z0KCXIq63XPojkQ8vbHZW8oiXOCmTZUpEe+H5
 9KF8K2DYnKqaMrnO/k6gciLxPQ1dB4oWl9fwpFDX7Bn26W5W75Lg6FZFB46GNKxT5xB+
 8F6CAwfFDl2yHuIpTdLayg9OT7Id21Dc4j6x/EdOI2vXdaFbNTt0l47MebIJb98yY26X +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ks443g1sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 16:46:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02CB0100038;
        Thu, 10 Nov 2022 16:46:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED1C622AFED;
        Thu, 10 Nov 2022 16:46:15 +0100 (CET)
Received: from localhost (10.252.15.206) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 10 Nov
 2022 16:46:15 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Date:   Thu, 10 Nov 2022 16:45:48 +0100
Message-ID: <20221110164329.v2.2.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110154550.3220800-1-patrick.delaunay@foss.st.com>
References: <20221110154550.3220800-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.15.206]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For boot with OP-TEE on STM32MP13, the communication with the secure
world no more use STMicroelectronics SMC but communication with the
BSEC TA, for data access (read/write) or lock operation:
- all the request are sent to OP-TEE trusted application,
- for upper OTP with ECC protection and with word programming only
  each OTP are permanently locked when programmed to avoid ECC error
  on the second write operation

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- rebase series on linux-next/master
- minor update after V1 revue
- add missing sentinel in stm32_romem_of_match()
- reorder function and remove prototypes for stm32_bsec_pta... functions
- change stm32_bsec_pta_find to static
- add return value in dev_err()
- cleanups some comments, which can be on one line
- remove test on priv->ctx in stm32_bsec_pta_remove
- add missing tee_shm_free(shm) in stm32_bsec_pta_write() when
  tee_shm_get_va failed
- return error in stm32_bsec_pta_find when devm_add_action_or_reset failed
- handle driver_register error in stm32_romem_init

 drivers/nvmem/stm32-romem.c | 445 +++++++++++++++++++++++++++++++++++-
 1 file changed, 441 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index d1d03c2ad081..0a0e29d09b67 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
+#include <linux/tee_drv.h>
 
 /* BSEC secure service access from non-secure */
 #define STM32_SMC_BSEC			0x82001003
@@ -25,14 +26,401 @@
 struct stm32_romem_cfg {
 	int size;
 	u8 lower;
+	bool ta;
 };
 
 struct stm32_romem_priv {
 	void __iomem *base;
 	struct nvmem_config cfg;
 	u8 lower;
+	struct device *ta;
 };
 
+#if IS_ENABLED(CONFIG_OPTEE)
+/*
+ * Read OTP memory
+ *
+ * [in]		value[0].a		OTP start offset in byte
+ * [in]		value[0].b		Access type (0:shadow, 1:fuse, 2:lock)
+ * [out]	memref[1].buffer	Output buffer to store read values
+ * [out]	memref[1].size		Size of OTP to be read
+ *
+ * Return codes:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define PTA_BSEC_READ_MEM		0x0 /* Read OTP */
+
+/*
+ * Write OTP memory
+ *
+ * [in]		value[0].a		OTP start offset in byte
+ * [in]		value[0].b		Access type (0:shadow, 1:fuse, 2:lock)
+ * [in]		memref[1].buffer	Input buffer to read values
+ * [in]		memref[1].size		Size of OTP to be written
+ *
+ * Return codes:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define PTA_BSEC_WRITE_MEM		0x1	/* Write OTP */
+
+/* value of PTA_BSEC access type = value[in] b */
+#define SHADOW_ACCESS	0
+#define FUSE_ACCESS	1
+#define LOCK_ACCESS	2
+
+/* Bitfield definition for LOCK status */
+#define LOCK_PERM			BIT(30)
+
+/**
+ * struct stm32_bsec_pta_priv - OP-TEE BSEC TA private data
+ * @ctx:		OP-TEE context handler.
+ * @session_id:		TA session identifier.
+ */
+struct stm32_bsec_pta_priv {
+	struct tee_context *ctx;
+	u32 session_id;
+};
+
+/*
+ * Check whether this driver supports the BSEC TA in the TEE instance
+ * represented by the params (ver/data) to this function.
+ */
+static int stm32_bsec_pta_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* Currently this driver only supports GP compliant, OP-TEE based TA */
+	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
+		(ver->gen_caps & TEE_GEN_CAP_GP))
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * stm32_bsec_pta_probe() - initialize the PTA BSEC
+ * @dev: the platform_device description.
+ *
+ * Return:
+ *	On success, 0. On failure, -errno.
+ */
+static int stm32_bsec_pta_probe(struct device *dev)
+{
+	int rc;
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_client_device *tee_device = to_tee_client_device(dev);
+	struct stm32_bsec_pta_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Open context with TEE driver */
+	priv->ctx = tee_client_open_context(NULL, stm32_bsec_pta_match, NULL, NULL);
+	if (IS_ERR(priv->ctx)) {
+		rc = PTR_ERR(priv->ctx);
+		if (rc == -ENOENT)
+			return -EPROBE_DEFER;
+		dev_err(dev, "%s: tee_client_open_context failed (%d)\n", __func__, rc);
+
+		return rc;
+	}
+
+	/* Open a session with BSEC TA */
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	export_uuid(sess_arg.uuid, &tee_device->id.uuid);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params = 0;
+
+	rc = tee_client_open_session(priv->ctx, &sess_arg, NULL);
+	if ((rc < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "%s: tee_client_open_session failed err:%x, ret:%x\n",
+			__func__, sess_arg.ret, rc);
+		rc = -EINVAL;
+		goto out_tee_session;
+	}
+	priv->session_id = sess_arg.session;
+	dev_set_drvdata(dev, priv);
+
+	return 0;
+
+out_tee_session:
+	tee_client_close_context(priv->ctx);
+
+	return rc;
+}
+
+/**
+ * stm32_bsec_pta_remove() - remove the BSEC TEE device
+ * @dev: the platform_device description.
+ *
+ * Return:
+ *	0 always.
+ */
+static int stm32_bsec_pta_remove(struct device *dev)
+{
+	struct stm32_bsec_pta_priv *priv = dev_get_drvdata(dev);
+
+	tee_client_close_session(priv->ctx, priv->session_id);
+	tee_client_close_context(priv->ctx);
+
+	return 0;
+}
+
+/**
+ * stm32_bsec_pta_read() - nvmem read access using PTA client driver
+ * @context: nvmem context => romem privdate data
+ * @offset: nvmem offset
+ * @buf: buffer to fill with nvem values
+ * @bytes: number of bytes to read
+ *
+ * Return:
+ *	On success, 0. On failure, -errno.
+ */
+static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
+			       size_t bytes)
+{
+	struct stm32_romem_priv *romem_priv = context;
+	struct device *dev;
+	struct stm32_bsec_pta_priv *priv;
+	struct tee_shm *shm;
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[2];
+	u8 *shm_buf;
+	u32 start, num_bytes;
+	int ret;
+
+	dev = romem_priv->ta;
+	if (!dev) {
+		pr_err("TA_BSEC invoke without driver\n");
+		return -ENXIO;
+	}
+
+	priv = dev_get_drvdata(dev);
+
+	memset(&arg, 0, sizeof(arg));
+	memset(&param, 0, sizeof(param));
+
+	arg.func = PTA_BSEC_READ_MEM;
+	arg.session = priv->session_id;
+	arg.num_params = 2;
+
+	/* align access on 32bits */
+	start = ALIGN_DOWN(offset, 4);
+	num_bytes = round_up(offset + bytes - start, 4);
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = start;
+	param[0].u.value.b = SHADOW_ACCESS;
+
+	shm = tee_shm_alloc_kernel_buf(priv->ctx, num_bytes);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm = shm;
+	param[1].u.memref.size = num_bytes;
+
+	ret = tee_client_invoke_func(priv->ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(dev, "TA_BSEC invoke failed TEE err:%x, ret:%x\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+	if (!ret) {
+		shm_buf = tee_shm_get_va(shm, 0);
+		if (IS_ERR(shm_buf)) {
+			ret = PTR_ERR(shm_buf);
+			dev_err(dev, "tee_shm_get_va failed for transmit (%d)\n", ret);
+		} else {
+			/* read data from 32 bits aligned buffer */
+			memcpy(buf, &shm_buf[offset % 4], bytes);
+		}
+	}
+
+	tee_shm_free(shm);
+
+	return ret;
+}
+
+/**
+ * stm32_bsec_pta_write() - nvmem write access using PTA client driver
+ * @context: nvmem context => romem privdate data
+ * @offset: nvmem offset
+ * @buf: buffer with nvem values
+ * @bytes: number of bytes to write
+ *
+ * Return:
+ *	On success, 0. On failure, -errno.
+ */
+static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
+				size_t bytes)
+{
+	struct stm32_romem_priv *romem_priv = context;
+	struct device *dev;
+	struct stm32_bsec_pta_priv *priv;
+	struct tee_shm *shm;
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[2];
+	u8 *shm_buf;
+	int ret;
+
+	dev = romem_priv->ta;
+	if (!dev) {
+		pr_err("TA_BSEC invoke without driver\n");
+		return -ENXIO;
+	}
+
+	/* Allow only writing complete 32-bits aligned words */
+	if ((bytes % 4) || (offset % 4))
+		return -EINVAL;
+
+	priv = dev_get_drvdata(dev);
+
+	memset(&arg, 0, sizeof(arg));
+	memset(&param, 0, sizeof(param));
+
+	arg.func = PTA_BSEC_WRITE_MEM;
+	arg.session = priv->session_id;
+	arg.num_params = 2;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = offset;
+	param[0].u.value.b = FUSE_ACCESS;
+
+	shm = tee_shm_alloc_kernel_buf(priv->ctx, bytes);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[1].u.memref.shm = shm;
+	param[1].u.memref.size = bytes;
+
+	shm_buf = tee_shm_get_va(shm, 0);
+	if (IS_ERR(shm_buf)) {
+		ret = PTR_ERR(shm_buf);
+		dev_err(dev, "tee_shm_get_va failed for transmit (%d)\n", ret);
+		tee_shm_free(shm);
+
+		return ret;
+	}
+
+	memcpy(shm_buf, buf, bytes);
+
+	ret = tee_client_invoke_func(priv->ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(dev, "TA_BSEC invoke failed TEE err:%x, ret:%x\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+	dev_dbg(dev, "Write OTPs %d to %d, ret=%d\n",
+		offset / 4, (offset + bytes) / 4, ret);
+
+	/* Lock the upper OTPs with ECC protection, word programming only */
+	if (!ret && ((offset + bytes) >= (romem_priv->lower * 4))) {
+		u32 start, nb_lock;
+		u32 *lock = (u32 *)shm_buf;
+		int i;
+
+		/*
+		 * don't lock the lower OTPs, no ECC protection and incremental
+		 * bit programming, a second write is allowed
+		 */
+		start = max_t(u32, offset, romem_priv->lower * 4);
+		nb_lock = (offset + bytes - start) / 4;
+
+		param[0].u.value.a = start;
+		param[0].u.value.b = LOCK_ACCESS;
+		param[1].u.memref.size = nb_lock * 4;
+
+		for (i = 0; i < nb_lock; i++)
+			lock[i] = LOCK_PERM;
+
+		ret = tee_client_invoke_func(priv->ctx, &arg, param);
+		if (ret < 0 || arg.ret != 0) {
+			dev_err(dev, "TA_BSEC invoke failed TEE err:%x, ret:%x\n",
+				arg.ret, ret);
+			if (!ret)
+				ret = -EIO;
+		}
+		dev_dbg(dev, "Lock upper OTPs %d to %d, ret=%d\n",
+			start / 4, start / 4 + nb_lock, ret);
+	}
+
+	tee_shm_free(shm);
+
+	return ret;
+}
+
+static const struct tee_client_device_id stm32_bsec_id_table[] = {
+	{
+		UUID_INIT(0x94cf71ad, 0x80e6, 0x40b5,
+			  0xa7, 0xc6, 0x3d, 0xc5, 0x01, 0xeb, 0x28, 0x03)
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(tee, stm32_bsec_id_table);
+
+static struct tee_client_driver stm32_bsec_pta_driver = {
+	.id_table	= stm32_bsec_id_table,
+	.driver		= {
+		.name = "stm32-bsec-pta",
+		.bus = &tee_bus_type,
+		.probe = stm32_bsec_pta_probe,
+		.remove = stm32_bsec_pta_remove,
+	},
+};
+
+static void stm32_bsec_put_device(void *data)
+{
+	put_device(data);
+}
+
+static struct device *stm32_bsec_pta_find(struct device *dev)
+{
+	struct device *pta_dev;
+	int ret;
+
+	pta_dev = driver_find_next_device(&stm32_bsec_pta_driver.driver, NULL);
+
+	if (pta_dev) {
+		ret = devm_add_action_or_reset(dev, stm32_bsec_put_device, pta_dev);
+		if (ret)
+			dev_err(dev, "devm_add_action_or_reset() failed (%d)\n", ret);
+
+		return ERR_PTR(ret);
+	}
+
+	return pta_dev;
+}
+
+#else
+static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
+			       size_t bytes)
+{
+	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
+
+	return -ENXIO;
+}
+
+static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
+				size_t bytes)
+{
+	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
+
+	return -ENXIO;
+}
+
+static struct device *stm32_bsec_pta_find(struct device *dev)
+{
+	pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
+
+	return NULL;
+}
+#endif
+
 static int stm32_romem_read(void *context, unsigned int offset, void *buf,
 			    size_t bytes)
 {
@@ -173,15 +561,27 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	} else {
 		priv->cfg.size = cfg->size;
 		priv->lower = cfg->lower;
-		priv->cfg.reg_read = stm32_bsec_read;
-		priv->cfg.reg_write = stm32_bsec_write;
+		if (cfg->ta) {
+			priv->ta = stm32_bsec_pta_find(dev);
+			/* wait for OP-TEE client driver to be up and ready */
+			if (!priv->ta)
+				return -EPROBE_DEFER;
+			if (IS_ERR(priv->ta))
+				return PTR_ERR(priv->ta);
+
+			priv->cfg.reg_read = stm32_bsec_pta_read;
+			priv->cfg.reg_write = stm32_bsec_pta_write;
+		} else {
+			priv->cfg.reg_read = stm32_bsec_read;
+			priv->cfg.reg_write = stm32_bsec_write;
+		}
 	}
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
 }
 
 /*
- * STM32MP15 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
+ * STM32MP15/13 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
  * => 96 x 32-bits data words
  * - Lower: 1K bits, 2:1 redundancy, incremental bit programming
  *   => 32 (x 32-bits) lower shadow registers = words 0 to 31
@@ -191,6 +591,13 @@ static int stm32_romem_probe(struct platform_device *pdev)
 static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
 	.size = 384,
 	.lower = 32,
+	.ta = false,
+};
+
+static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
+	.size = 384,
+	.lower = 32,
+	.ta = true,
 };
 
 static const struct of_device_id stm32_romem_of_match[] = {
@@ -198,7 +605,10 @@ static const struct of_device_id stm32_romem_of_match[] = {
 		.compatible = "st,stm32mp15-bsec",
 		.data = (void *)&stm32mp15_bsec_cfg,
 	}, {
+		.compatible = "st,stm32mp13-bsec",
+		.data = (void *)&stm32mp13_bsec_cfg,
 	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
 
@@ -209,7 +619,34 @@ static struct platform_driver stm32_romem_driver = {
 		.of_match_table = of_match_ptr(stm32_romem_of_match),
 	},
 };
-module_platform_driver(stm32_romem_driver);
+
+static int __init stm32_romem_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&stm32_romem_driver);
+	if (rc)
+		return rc;
+
+#if IS_ENABLED(CONFIG_OPTEE)
+	rc = driver_register(&stm32_bsec_pta_driver.driver);
+	if (rc)
+		platform_driver_unregister(&stm32_romem_driver);
+#endif
+
+	return rc;
+}
+
+static void __exit stm32_romem_exit(void)
+{
+	platform_driver_unregister(&stm32_romem_driver);
+#if IS_ENABLED(CONFIG_OPTEE)
+	driver_unregister(&stm32_bsec_pta_driver.driver);
+#endif
+}
+
+module_init(stm32_romem_init);
+module_exit(stm32_romem_exit);
 
 MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
-- 
2.25.1

