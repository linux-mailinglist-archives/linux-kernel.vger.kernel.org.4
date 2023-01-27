Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DB67EDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjA0SrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjA0SrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:47:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F33B761D7;
        Fri, 27 Jan 2023 10:47:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so4082275wmo.5;
        Fri, 27 Jan 2023 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4VhdspxWWSHGP3yOMJ0VuBU6Kq/U6ZEVwsSTq6j1VI=;
        b=mm9Xzpoo2Q3mKBOjQwDTYKCB5bqNsf7javpjLuvaheBSn9nNNggCNyCAM2+yzSvfaR
         RKPj1DeIyPyiLw7oH2sjh2N3pe3H0iFettUzNgOfESXn+ig2B6enie5RHgSN2SISnG6f
         0mJHn9YMhXuc7rkEI0bSU8mNGsQJiB9Qw/zYW7xLwOWUklqFQ5NITUXqbd5xLSkPfPS0
         0CiPxY15m68RSCyxV4RsXcMLeelw6573kZthuy/fMr81EmMaLajlXCl75TWm5OTBe0aH
         /MQyA+2JEX0Ztw/39bCpm6FUdZ6rGaQuS55Mi3Ks3j4pgdvp0rjtVl56FfVu++IU8jFK
         +GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4VhdspxWWSHGP3yOMJ0VuBU6Kq/U6ZEVwsSTq6j1VI=;
        b=xTv7jemoOgR9gYiL9JUxCvywumI91TTRBBJbodxPm3d09A8990AKe5kAvZ1zO6RJ9g
         u2xuKHTMVo8sNqRB+jA7NNSuXBBaanHYIJN/1AU7YTDLlExMTGIB5BW2AYckk2raitZw
         B8wZwRPUXXboS/v+4CegguoX4u75/YTYG9XUImkj66V49mCNev9dZAy2ry2Sgq6G+cQu
         2c+8pVk7/4LCzkyqRMerSFCYLgT4Bv5E+e4c1CNeILZQ8ph2Mrzsc5ngTPvHtrwW/VeU
         Qekr/Ca1dg8CDxCTHw6x0LH1whwazvm0SIwSu+nP5a/j/uuNM10IlyBDDEMU8pdpQ46n
         p3uQ==
X-Gm-Message-State: AFqh2kpyTYBES77EOr/7WFHa74JTccNCNWK0JT3W+vDTq0mRTp2TojWd
        CYuPGOAH6OL3Bxyaq5fOQnU=
X-Google-Smtp-Source: AMrXdXslDjUO4psN1hA2GZJ3qXmVgaQFwaZH6LQDBwJItUU9i/5Q30GvItJKkiOg9Ty6Cx7V2+BanQ==
X-Received: by 2002:a05:600c:4e05:b0:3c6:e61e:ae71 with SMTP id b5-20020a05600c4e0500b003c6e61eae71mr43137606wmq.1.1674845221484;
        Fri, 27 Jan 2023 10:47:01 -0800 (PST)
Received: from xws.localdomain (pd9ea339c.dip0.t-ipconnect.de. [217.234.51.156])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm16234208wmo.2.2023.01.27.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:47:00 -0800 (PST)
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
Subject: [PATCH v2 1/4] firmware: qcom_scm: Export SCM call functions
Date:   Fri, 27 Jan 2023 19:46:47 +0100
Message-Id: <20230127184650.756795-2-luzmaximilian@gmail.com>
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

Make qcom_scm_call, qcom_scm_call_atomic and associated types accessible
to other modules.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - No functional changes

---
 drivers/firmware/qcom_scm.c | 118 ++++++++++++++++++++++++------------
 drivers/firmware/qcom_scm.h |  47 --------------
 include/linux/qcom_scm.h    |  49 +++++++++++++++
 3 files changed, 128 insertions(+), 86 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 2000323722bf..7305756d02b0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -212,16 +212,17 @@ static enum qcom_scm_convention __get_convention(void)
 }
 
 /**
- * qcom_scm_call() - Invoke a syscall in the secure world
- * @dev:	device
+ * __qcom_scm_call() - Invoke a syscall in the secure world
+ * @dev:	Device. Depending on the command and number of arguments, this
+ *		is optional.
  * @desc:	Descriptor structure containing arguments and return values
  * @res:        Structure containing results from SMC/HVC call
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
  */
-static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
+static int __qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+			   struct qcom_scm_res *res)
 {
 	might_sleep();
 	switch (__get_convention()) {
@@ -236,18 +237,39 @@ static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
 	}
 }
 
+/**
+ * qcom_scm_call() - Invoke a syscall in the secure world
+ * @desc:	Descriptor structure containing arguments and return values
+ * @res:        Structure containing results from SMC/HVC call
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This should *only* be called in pre-emptible context.
+ *
+ * Returns zero on success, -ENODEV if the SCM device has not been set up yet,
+ * or other non-zero status codes on failure.
+ */
+int qcom_scm_call(const struct qcom_scm_desc *desc, struct qcom_scm_res *res)
+{
+	if (!__scm)
+		return -ENODEV;
+
+	return __qcom_scm_call(__scm->dev, desc, res);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_call);
+
 /**
  * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
- * @dev:	device
+ * @dev:	Device. Depending on the command and number of arguments, this
+ *		is optional.
  * @desc:	Descriptor structure containing arguments and return values
  * @res:	Structure containing results from SMC/HVC call
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This can be called in atomic context.
  */
-static int qcom_scm_call_atomic(struct device *dev,
-				const struct qcom_scm_desc *desc,
-				struct qcom_scm_res *res)
+static int __qcom_scm_call_atomic(struct device *dev,
+				  const struct qcom_scm_desc *desc,
+				  struct qcom_scm_res *res)
 {
 	switch (__get_convention()) {
 	case SMC_CONVENTION_ARM_32:
@@ -261,6 +283,26 @@ static int qcom_scm_call_atomic(struct device *dev,
 	}
 }
 
+/**
+ * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
+ * @desc:	Descriptor structure containing arguments and return values
+ * @res:	Structure containing results from SMC/HVC call
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This can be called in atomic context.
+ *
+ * Returns zero on success, -ENODEV if the SCM device has not been set up yet,
+ * or other non-zero status codes on failure.
+ */
+int qcom_scm_call_atomic(const struct qcom_scm_desc *desc, struct qcom_scm_res *res)
+{
+	if (!__scm)
+		return -ENODEV;
+
+	return __qcom_scm_call_atomic(__scm->dev, desc, res);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_call_atomic);
+
 static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 					 u32 cmd_id)
 {
@@ -287,7 +329,7 @@ static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 		return false;
 	}
 
-	ret = qcom_scm_call(dev, &desc, &res);
+	ret = __qcom_scm_call(dev, &desc, &res);
 
 	return ret ? false : !!res.result[0];
 }
@@ -312,7 +354,7 @@ static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
 	desc.args[0] = flags;
 	desc.args[1] = virt_to_phys(entry);
 
-	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+	return __qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 
 static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
@@ -334,7 +376,7 @@ static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
 	if (!__scm || __get_convention() == SMC_CONVENTION_LEGACY)
 		return -EOPNOTSUPP;
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return __qcom_scm_call(__scm->dev, &desc, NULL);
 }
 
 /**
@@ -384,7 +426,7 @@ void qcom_scm_cpu_power_down(u32 flags)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+	__qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_cpu_power_down);
 
@@ -401,7 +443,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -419,7 +461,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 
 	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
 
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 
 static void qcom_scm_set_download_mode(bool enable)
@@ -499,7 +541,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	desc.args[1] = mdata_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = __qcom_scm_call(__scm->dev, &desc, &res);
 
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
@@ -565,7 +607,7 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
@@ -600,7 +642,7 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
@@ -634,7 +676,7 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
@@ -666,7 +708,7 @@ bool qcom_scm_pas_supported(u32 peripheral)
 					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
 		return false;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = __qcom_scm_call(__scm->dev, &desc, &res);
 
 	return ret ? false : !!res.result[0];
 }
@@ -685,7 +727,7 @@ static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -725,8 +767,7 @@ int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 	struct qcom_scm_res res;
 	int ret;
 
-
-	ret = qcom_scm_call_atomic(__scm->dev, &desc, &res);
+	ret = qcom_scm_call_atomic(&desc, &res);
 	if (ret >= 0)
 		*val = res.result[0];
 
@@ -745,7 +786,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_io_writel);
 
@@ -775,7 +816,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -793,7 +834,7 @@ int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	if (size)
 		*size = res.result[0];
@@ -816,7 +857,7 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 	};
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = qcom_scm_call(&desc, NULL);
 
 	/* the pg table has been initialized already, ignore the error */
 	if (ret == -EPERM)
@@ -837,7 +878,7 @@ int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_iommu_set_cp_pool_size);
 
@@ -859,7 +900,7 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 	};
 	struct qcom_scm_res res;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -887,7 +928,7 @@ static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 	};
 	struct qcom_scm_res res;
 
-	ret = qcom_scm_call(dev, &desc, &res);
+	ret = __qcom_scm_call(dev, &desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -1004,7 +1045,7 @@ int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
 		.arginfo = QCOM_SCM_ARGS(4),
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_lock);
 
@@ -1027,7 +1068,7 @@ int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
 		.arginfo = QCOM_SCM_ARGS(3),
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_unlock);
 
@@ -1068,7 +1109,7 @@ int qcom_scm_ice_invalidate_key(u32 index)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
 
@@ -1129,7 +1170,7 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 	memcpy(keybuf, key, key_size);
 	desc.args[1] = key_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = qcom_scm_call(&desc, NULL);
 
 	memzero_explicit(keybuf, key_size);
 
@@ -1198,7 +1239,7 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	*resp = res.result[0];
 
 	qcom_scm_clk_disable();
@@ -1219,7 +1260,7 @@ int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_iommu_set_pt_format);
 
@@ -1234,8 +1275,7 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
 
@@ -1255,7 +1295,7 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
 
@@ -1290,7 +1330,7 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 
 	desc.args[0] = payload_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = __qcom_scm_call(__scm->dev, &desc, NULL);
 
 	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index e6e512bd57d1..87eb726be7d0 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -13,53 +13,6 @@ enum qcom_scm_convention {
 
 extern enum qcom_scm_convention qcom_scm_convention;
 
-#define MAX_QCOM_SCM_ARGS 10
-#define MAX_QCOM_SCM_RETS 3
-
-enum qcom_scm_arg_types {
-	QCOM_SCM_VAL,
-	QCOM_SCM_RO,
-	QCOM_SCM_RW,
-	QCOM_SCM_BUFVAL,
-};
-
-#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
-			   (((a) & 0x3) << 4) | \
-			   (((b) & 0x3) << 6) | \
-			   (((c) & 0x3) << 8) | \
-			   (((d) & 0x3) << 10) | \
-			   (((e) & 0x3) << 12) | \
-			   (((f) & 0x3) << 14) | \
-			   (((g) & 0x3) << 16) | \
-			   (((h) & 0x3) << 18) | \
-			   (((i) & 0x3) << 20) | \
-			   (((j) & 0x3) << 22) | \
-			   ((num) & 0xf))
-
-#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-
-/**
- * struct qcom_scm_desc
- * @arginfo:	Metadata describing the arguments in args[]
- * @args:	The array of arguments for the secure syscall
- */
-struct qcom_scm_desc {
-	u32 svc;
-	u32 cmd;
-	u32 arginfo;
-	u64 args[MAX_QCOM_SCM_ARGS];
-	u32 owner;
-};
-
-/**
- * struct qcom_scm_res
- * @result:	The values returned by the secure syscall
- */
-struct qcom_scm_res {
-	u64 result[MAX_QCOM_SCM_RETS];
-};
-
 int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
 int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
 
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 1e449a5d7f5c..162746467c22 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -11,6 +11,55 @@
 
 #include <dt-bindings/firmware/qcom,scm.h>
 
+#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
+			   (((a) & 0x3) << 4) | \
+			   (((b) & 0x3) << 6) | \
+			   (((c) & 0x3) << 8) | \
+			   (((d) & 0x3) << 10) | \
+			   (((e) & 0x3) << 12) | \
+			   (((f) & 0x3) << 14) | \
+			   (((g) & 0x3) << 16) | \
+			   (((h) & 0x3) << 18) | \
+			   (((i) & 0x3) << 20) | \
+			   (((j) & 0x3) << 22) | \
+			   ((num) & 0xf))
+
+#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+
+#define MAX_QCOM_SCM_ARGS 10
+#define MAX_QCOM_SCM_RETS 3
+
+enum qcom_scm_arg_types {
+	QCOM_SCM_VAL,
+	QCOM_SCM_RO,
+	QCOM_SCM_RW,
+	QCOM_SCM_BUFVAL,
+};
+
+/**
+ * struct qcom_scm_desc - SCM call descriptor.
+ * @arginfo:	Metadata describing the arguments in args[]
+ * @args:	The array of arguments for the secure syscall
+ */
+struct qcom_scm_desc {
+	u32 svc;
+	u32 cmd;
+	u32 arginfo;
+	u64 args[MAX_QCOM_SCM_ARGS];
+	u32 owner;
+};
+
+/**
+ * struct qcom_scm_res - SCM call response.
+ * @result:	The values returned by the secure syscall
+ */
+struct qcom_scm_res {
+	u64 result[MAX_QCOM_SCM_RETS];
+};
+
+int qcom_scm_call(const struct qcom_scm_desc *desc, struct qcom_scm_res *res);
+int qcom_scm_call_atomic(const struct qcom_scm_desc *desc, struct qcom_scm_res *res);
+
 #define QCOM_SCM_VERSION(major, minor)	(((major) << 16) | ((minor) & 0xFF))
 #define QCOM_SCM_CPU_PWR_DOWN_L2_ON	0x0
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
-- 
2.39.0

