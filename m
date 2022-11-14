Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278A62779D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiKNI1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiKNI11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:27:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AE1B7B1;
        Mon, 14 Nov 2022 00:27:20 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE7Ln7m027359;
        Mon, 14 Nov 2022 08:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i8NEIA51Y+BACgoqlHz+yMN8VjlrL6m02rR/Rfv9XwE=;
 b=A74KYFEanMSnSkAwa86jwPKIntwrLDtZkTxv32UaFrX+qGOK+hA1DPBtoMVwlgDFELSJ
 p20BFBGGizBtX6/mqaQdyi6IOzGyRgn6d5F/+i5kr3P6ry0PiE5pTe422aCG2mYQL704
 E2SzW/F6VLB8w5YaaslVeVKhYZr/GQq3208dXJf0jjusziBRka5m/PVSHmwVvyOniUwv
 oG1hJDFP9dCAHAUgoRRK9g0pwYPksmYjDaDygutvGnMKLfLsXqewVMCDOUCp5h1h4Doy
 ZN30sIaXr2Tnwz4zbEv2SZB6jGdLZm4kq3Dg9Qqy9ufYy2iqMz8DaoED7zyO1ejwZS6v zA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kuccw0pha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:27:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AE8RCdU029316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:27:12 GMT
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 00:27:08 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 2/2] firmware: qcom: scm: Add wait-queue handling logic
Date:   Mon, 14 Nov 2022 13:56:44 +0530
Message-ID: <20221114082644.28739-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114082644.28739-1-quic_sibis@quicinc.com>
References: <20221114082644.28739-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I-T8ZoDXb4dSWxdqwSNWFoBH52j2HgRH
X-Proofpoint-ORIG-GUID: I-T8ZoDXb4dSWxdqwSNWFoBH52j2HgRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guru Das Srinagesh <quic_gurus@quicinc.com>

When the firmware (FW) supports multiple requests per VM, multiple requests
from the same/different VM can reach the firmware at the same time. Since
the firmware currently being used has limited resources, it guards them
with a resource lock and puts requests on a wait-queue internally and
signals to HLOS that it is doing so. It does this by returning a new return
value in addition to success or error: SCM_WAITQ_SLEEP. A sleeping SCM call
can be woken up by an interrupt that the FW raises.

  1) SCM_WAITQ_SLEEP:

  	When an SCM call receives this return value instead of success
  	or error, FW has placed this call on a wait-queue and has signalled
	HLOS to put it to non-interruptible sleep.

	Along with this return value, FW also passes to HLOS `wq_ctx` -
	a unique number (UID) identifying the wait-queue that it has put
	the call on, internally. This is to help HLOS with its own
	bookkeeping to wake this sleeping call later.

	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
	identifying the SCM call thus being put to sleep. This is also
	for HLOS' bookkeeping to wake this call up later.

	These two additional values are passed via the a1 and a2
	registers.

	N.B.: The "ctx" in the above UID names = "context".

The handshake mechanism that HLOS uses to talk to FW about wait-queue
operations involves two new SMC calls.

  1) get_wq_ctx():

    	Arguments: 	None
    	Returns:	wq_ctx, flags, more_pending

    	Get the wait-queue context, and wake up either one or all of the
    	sleeping SCM calls associated with that wait-queue.

    	Additionally, repeat this if there are more wait-queues that are
    	ready to have their requests woken up (`more_pending`).

  2) wq_resume(smc_call_ctx):

  	Arguments:	smc_call_ctx

  	HLOS needs to issue this in response to receiving an
  	IRQ, passing to FW the same smc_call_ctx that FW
  	receives from HLOS via the get_wq_ctx() call.

(The mechanism to wake a SMC call back up is described in detail below)

 VM_1                     VM_2                            Firmware
   │                        │                                 │
   │                        │                                 │
   │                        │                                 │
   │                        │                                 │
   │      REQUEST_1         │                                 │
   ├────────────────────────┼─────────────────────────────────┤
   │                        │                                 │
   │                        │                              ┌──┼──┐
   │                        │                              │  │  │
   │                        │     REQUEST_2                │  │  │
   │                        ├──────────────────────────────┼──┤  │
   │                        │                              │  │  │Resource
   │                        │                              │  │  │is busy
   │                        │       {WQ_SLEEP}             │  │  │
   │                        │◄─────────────────────────────┼──┤  │
   │                        │  wq_ctx, smc_call_ctx        │  │  │
   │                        │                              └──┼──┘
   │   REQUEST_1 COMPLETE   │                                 │
   │◄───────────────────────┼─────────────────────────────────┤
   │                        │                                 │
   │                        │         IRQ                     │
   │                        │◄─-------------------------------│
   │                        │                                 │
   │                        │      get_wq_ctx()               │
   │                        ├────────────────────────────────►│
   │                        │                                 │
   │                        │                                 │
   │                        │◄────────────────────────────────┤
   │                        │   wq_ctx, flags, and            │
   │                        │        more_pending             │
   │                        │                                 │
   │                        │                                 │
   │                        │ wq_resume(smc_call_ctx)         │
   │                        ├────────────────────────────────►│
   │                        │                                 │
   │                        │                                 │
   │                        │      REQUEST_2 COMPLETE         │
   │                        │◄────────────────────────────────┤
   │                        │                                 │
   │                        │                                 │

With the exception of get_wq_ctx(), the other SMC call wq_resume() can
return WQ_SLEEP (these nested rounds of WQ_SLEEP are not shown in the
above diagram for the sake of simplicity). Therefore, introduce a new
do-while loop to handle multiple WQ_SLEEP return values for the same
parent SCM call.

Request Completion in the above diagram refers to either a success
return value (zero) or error (and not SMC_WAITQ_SLEEP)

Also add the interrupt handler that wakes up a sleeping SCM call.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
[sibis: warning fixes and irq handling]
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
- Use a single completion as it satisfies all of the current usecases [Bjorn]
- Misc. logic/style fixes [Bjorn]

v3:
- Fixup irq handling so as not to affect SoCs without the interrupt.
- Fix warnings reported by kernel test-bot.
- Squash patch 4 and 5 into 1 from v2.

 drivers/firmware/qcom_scm-smc.c |  94 ++++++++++++++++++++++++++---
 drivers/firmware/qcom_scm.c     | 102 +++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.h     |   9 +++
 3 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index d111833364ba..d74ddb2609d1 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -52,29 +52,105 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
 	} while (res->a0 == QCOM_SCM_INTERRUPTED);
 }
 
-static void __scm_smc_do(const struct arm_smccc_args *smc,
-			 struct arm_smccc_res *res, bool atomic)
+static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
 {
-	int retry_count = 0;
+	memset(resume->args, 0, sizeof(resume->args[0]) * ARRAY_SIZE(resume->args));
+
+	resume->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+					ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
+					SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_RESUME));
+
+	resume->args[1] = QCOM_SCM_ARGS(1);
+
+	resume->args[2] = smc_call_ctx;
+}
+
+int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
+{
+	int ret;
+	struct arm_smccc_args get_wq_ctx = {0};
+	struct arm_smccc_res get_wq_res;
+
+	get_wq_ctx.args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+				ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
+				SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_GET_WQ_CTX));
+
+	/* Guaranteed to return only success or error, no WAITQ_* */
+	__scm_smc_do_quirk(&get_wq_ctx, &get_wq_res);
+	ret = get_wq_res.a0;
+	if (ret)
+		return ret;
+
+	*wq_ctx = get_wq_res.a1;
+	*flags  = get_wq_res.a2;
+	*more_pending = get_wq_res.a3;
+
+	return 0;
+}
+
+static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *smc,
+					   struct arm_smccc_res *res)
+{
+	struct qcom_scm *scm;
+	struct completion *wq = NULL;
+	u32 wq_ctx, smc_call_ctx, flags;
+
+	do {
+		__scm_smc_do_quirk(smc, res);
+
+		if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
+			wq_ctx = res->a1;
+			smc_call_ctx = res->a2;
+			flags = res->a3;
+
+			if (!dev)
+				return -EPROBE_DEFER;
+
+			scm = dev_get_drvdata(dev);
+			wq = qcom_scm_lookup_wq(scm, wq_ctx);
+			if (IS_ERR_OR_NULL(wq)) {
+				dev_err(dev, "No waitqueue found for wq_ctx %d: %ld\n",
+					wq_ctx, PTR_ERR(wq));
+				return PTR_ERR(wq);
+			}
+
+			wait_for_completion(wq);
+			fill_wq_resume_args(smc, smc_call_ctx);
+			wq = NULL;
+		}
+	} while (res->a0 == QCOM_SCM_WAITQ_SLEEP);
+
+	return 0;
+}
+
+static int __scm_smc_do(struct device *dev, struct arm_smccc_args *smc,
+			struct arm_smccc_res *res, bool atomic)
+{
+	int ret, retry_count = 0;
 
 	if (atomic) {
 		__scm_smc_do_quirk(smc, res);
-		return;
+		return 0;
 	}
 
 	do {
 		mutex_lock(&qcom_scm_lock);
 
-		__scm_smc_do_quirk(smc, res);
+		ret = __scm_smc_do_quirk_handle_waitq(dev, smc, res);
 
 		mutex_unlock(&qcom_scm_lock);
 
+		if (ret)
+			return ret;
+
 		if (res->a0 == QCOM_SCM_V2_EBUSY) {
 			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
 				break;
 			msleep(QCOM_SCM_EBUSY_WAIT_MS);
 		}
 	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
+
+	return 0;
 }
 
 
@@ -83,7 +159,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		   struct qcom_scm_res *res, bool atomic)
 {
 	int arglen = desc->arginfo & 0xf;
-	int i;
+	int i, ret;
 	dma_addr_t args_phys = 0;
 	void *args_virt = NULL;
 	size_t alloc_len;
@@ -135,13 +211,17 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
 	}
 
-	__scm_smc_do(&smc, &smc_res, atomic);
+	/* ret error check follows after args_virt cleanup*/
+	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
 
 	if (args_virt) {
 		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
 		kfree(args_virt);
 	}
 
+	if (ret)
+		return ret;
+
 	if (res) {
 		res->result[0] = smc_res.a1;
 		res->result[1] = smc_res.a2;
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54c8146..a1c05e649266 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -3,7 +3,9 @@
  * Copyright (C) 2015 Linaro Ltd.
  */
 #include <linux/platform_device.h>
+#include <linux/idr.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/dma-mapping.h>
@@ -13,9 +15,12 @@
 #include <linux/qcom_scm.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/ktime.h>
 #include <linux/arm-smccc.h>
 
 #include "qcom_scm.h"
@@ -27,12 +32,20 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+struct qcom_scm_waitq {
+	struct idr idr;
+	/* control access to IDR */
+	spinlock_t idr_lock;
+	struct completion waitq_comp;
+};
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
 	struct clk *iface_clk;
 	struct clk *bus_clk;
 	struct icc_path *path;
+	struct qcom_scm_waitq waitq;
 	struct reset_controller_dev reset;
 
 	/* control access to the interconnect path */
@@ -63,6 +76,9 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	BIT(2), BIT(1), BIT(4), BIT(6)
 };
 
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
+
 static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_UNKNOWN] = "unknown",
 	[SMC_CONVENTION_ARM_32] = "smc arm 32",
@@ -1325,11 +1341,69 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
+{
+	int err;
+	unsigned long flags;
+	u32 wq_ctx_idr = wq_ctx;
+	struct completion *wq = NULL;
+
+	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
+	wq = idr_find(&scm->waitq.idr, wq_ctx);
+	if (wq)
+		goto out;
+
+	wq = &scm->waitq.waitq_comp;
+
+	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
+			    U32_MAX, GFP_ATOMIC);
+	if (err < 0)
+		wq = ERR_PTR(err);
+
+out:
+	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
+	return wq;
+}
+
+static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
+{
+	int ret;
+	struct qcom_scm *scm = data;
+	struct completion *wq_to_wake;
+	u32 wq_ctx, flags, more_pending = 0;
+
+	do {
+		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
+		if (ret) {
+			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
+			goto out;
+		}
+
+		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
+		if (IS_ERR_OR_NULL(wq_to_wake)) {
+			dev_err(scm->dev, "No waitqueue found for wq_ctx %d: %ld\n",
+				wq_ctx, PTR_ERR(wq_to_wake));
+			goto out;
+		}
+
+		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
+		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
+			dev_err(scm->dev, "Invalid Flags found for wq_ctx: %u\n", flags);
+			goto out;
+		}
+
+		complete(wq_to_wake);
+	} while (more_pending);
+
+out:
+	return IRQ_HANDLED;
+}
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
 	unsigned long clks;
-	int ret;
+	int irq, ret;
 
 	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
 	if (!scm)
@@ -1399,9 +1473,29 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, scm);
+
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	spin_lock_init(&__scm->waitq.idr_lock);
+	idr_init(&__scm->waitq.idr);
+	init_completion(&__scm->waitq.waitq_comp);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		if (irq != -ENXIO)
+			return irq;
+	} else {
+		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
+						IRQF_ONESHOT, "qcom-scm", __scm);
+		if (ret < 0) {
+			dev_err(scm->dev, "Failed to request qcom-scm irq: %d\n", ret);
+			idr_destroy(&__scm->waitq.idr);
+			return ret;
+		}
+	}
+
 	__get_convention();
 
 	/*
@@ -1417,6 +1511,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&__scm->waitq.idr_lock, flags);
+	idr_destroy(&__scm->waitq.idr);
+	spin_unlock_irqrestore(&__scm->waitq.idr_lock, flags);
+
 	/* Clean shutdown, disable download mode to allow normal restart */
 	if (download_mode)
 		qcom_scm_set_download_mode(false);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index db3d08a01209..323cb49d4976 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -60,6 +60,10 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
+struct qcom_scm;
+extern struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx);
+extern int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
+
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
 extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 			  enum qcom_scm_convention qcom_convention,
@@ -129,6 +133,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
 
+#define QCOM_SCM_SVC_WAITQ			0x24
+#define QCOM_SCM_WAITQ_RESUME			0x02
+#define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
@@ -137,6 +145,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_EINVAL_ARG	-2
 #define QCOM_SCM_ERROR		-1
 #define QCOM_SCM_INTERRUPTED	1
+#define QCOM_SCM_WAITQ_SLEEP	2
 
 static inline int qcom_scm_remap_error(int err)
 {
-- 
2.17.1

