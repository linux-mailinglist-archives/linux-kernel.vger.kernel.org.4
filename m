Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E52668ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbjAMHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAMHFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:05:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890576EFD;
        Thu, 12 Jan 2023 22:54:18 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D6qVsH007456;
        Fri, 13 Jan 2023 06:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MvAlTnWICUhlG8UnW2p/bQMSxewnMEEdKXAiwo7Os90=;
 b=ZTNGmteYY9xRh/2Q3Xme2In16sps4nMcN6fxvaR6JuxxKtXXXMyJySvngw+8jvLqKWK9
 2WMLidJGc9PlbZJa475epXWRhOWVJsHEd6yZkt5shnenCd7TU6dW3qwJpOi9THJgMwmu
 3x6WyCoxU/OR3a2W1cMemKsn9ixUKQcUw7O2jeWpGTSkCuGBacgNpJAZ+1no3Yh2yt/f
 GJOdtohCQ0QAKShPqP7mPOQdc/qBoGu6pwolwczdCBxdy8F2Ef4Lr07zasDHrFNGMVon
 RhIBIz3Zz6veySS/Zcb0NX/Ot5FAESnmFxVcnRTJWRz9bLk49rTid+AAbXBFIPFs3xkm 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2edutf8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D6sAtU017314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:10 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 22:54:06 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V9 2/2] firmware: qcom: scm: Add wait-queue handling logic
Date:   Fri, 13 Jan 2023 12:23:02 +0530
Message-ID: <20230113065303.17727-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113065303.17727-1-quic_sibis@quicinc.com>
References: <20230113065303.17727-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oCZqDRs49vICk_UFNHQrgWUi53AjZKIT
X-Proofpoint-ORIG-GUID: oCZqDRs49vICk_UFNHQrgWUi53AjZKIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_02,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v9:
- Drop unused complete_all [Srini]

v8:
- Rename qcom_scm_lookup_wq to qcom_scm_assert_valid_wq_ctx [Bjorn] 
- Document wq_ctx limitations [Guru]
- Drop dev check and add include completion header [Srini]
- Rename qcom_scm_lookup_completion to qcom_scm_wait_for_wq_completion.

v7:
- Move lookup + wait_for_completion into a single function in qcom_scm [Bjorn]
- Simplify completion retrieval [Bjorn]

v6:
- Fix misc. nits in the scm driver [Krzysztof]

v5:
- Handle the wake_one/wake_all flags [Guru]
- Rename flag handler to qcom_scm_waitq_wakeup [Bjorn]
- Resume scm call can return ebusy as well handle that scenario by retrying
  the original smc call and not the resume call

v4:
- platform_set_drvdata will be used by __scm_smc_do_quirk_handle_waitq to
  get access to scm struct from device so retain it
- Use a single completion as it satisfies all of the current usecases [Bjorn]
- Inline scm_get_wq_ctx [Bjorn]
- Convert all pr_err to dev_err [Bjorn]
- Handle idr_destroy in a thread safe manner [Bjorn]
- Misc. Style fixes [Bjorn]

v3:
- Fixup irq handling so as not to affect SoCs without the interrupt.
- Fix warnings reported by kernel test-bot.

 drivers/firmware/qcom_scm-smc.c | 87 ++++++++++++++++++++++++++++---
 drivers/firmware/qcom_scm.c     | 90 ++++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.h     |  8 +++
 3 files changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index d111833364ba..726b9330155e 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -52,29 +52,98 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
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
+static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_args *waitq,
+					   struct arm_smccc_res *res)
+{
+	int ret;
+	struct arm_smccc_args resume;
+	u32 wq_ctx, smc_call_ctx, flags;
+	struct arm_smccc_args *smc = waitq;
+
+	do {
+		__scm_smc_do_quirk(smc, res);
+
+		if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
+			wq_ctx = res->a1;
+			smc_call_ctx = res->a2;
+			flags = res->a3;
+
+			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
+			if (ret)
+				return ret;
+
+			fill_wq_resume_args(&resume, smc_call_ctx);
+			smc = &resume;
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
 
 
@@ -83,7 +152,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		   struct qcom_scm_res *res, bool atomic)
 {
 	int arglen = desc->arginfo & 0xf;
-	int i;
+	int i, ret;
 	dma_addr_t args_phys = 0;
 	void *args_virt = NULL;
 	size_t alloc_len;
@@ -135,13 +204,17 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
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
index cdbfe54c8146..2000323722bf 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -4,6 +4,8 @@
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/dma-mapping.h>
@@ -13,6 +15,7 @@
 #include <linux/qcom_scm.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
@@ -33,6 +36,7 @@ struct qcom_scm {
 	struct clk *iface_clk;
 	struct clk *bus_clk;
 	struct icc_path *path;
+	struct completion waitq_comp;
 	struct reset_controller_dev reset;
 
 	/* control access to the interconnect path */
@@ -63,6 +67,9 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	BIT(2), BIT(1), BIT(4), BIT(6)
 };
 
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
+
 static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_UNKNOWN] = "unknown",
 	[SMC_CONVENTION_ARM_32] = "smc arm 32",
@@ -1325,11 +1332,79 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
+{
+	/* FW currently only supports a single wq_ctx (zero).
+	 * TODO: Update this logic to include dynamic allocation and lookup of
+	 * completion structs when FW supports more wq_ctx values.
+	 */
+	if (wq_ctx != 0) {
+		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
+{
+	int ret;
+
+	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&__scm->waitq_comp);
+
+	return 0;
+}
+
+static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
+{
+	int ret;
+
+	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
+	if (ret)
+		return ret;
+
+	complete(&__scm->waitq_comp);
+
+	return 0;
+}
+
+static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
+{
+	int ret;
+	struct qcom_scm *scm = data;
+	u32 wq_ctx, flags, more_pending = 0;
+
+	do {
+		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
+		if (ret) {
+			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
+			goto out;
+		}
+
+		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
+		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
+			dev_err(scm->dev, "Invalid flags found for wq_ctx: %u\n", flags);
+			goto out;
+		}
+
+		ret = qcom_scm_waitq_wakeup(scm, wq_ctx);
+		if (ret)
+			goto out;
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
@@ -1402,6 +1477,19 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	init_completion(&__scm->waitq_comp);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		if (irq != -ENXIO)
+			return irq;
+	} else {
+		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
+						IRQF_ONESHOT, "qcom-scm", __scm);
+		if (ret < 0)
+			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+	}
+
 	__get_convention();
 
 	/*
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index db3d08a01209..e6e512bd57d1 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -60,6 +60,9 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
+int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
+int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
+
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
 extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 			  enum qcom_scm_convention qcom_convention,
@@ -129,6 +132,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
 
+#define QCOM_SCM_SVC_WAITQ			0x24
+#define QCOM_SCM_WAITQ_RESUME			0x02
+#define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
@@ -137,6 +144,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_EINVAL_ARG	-2
 #define QCOM_SCM_ERROR		-1
 #define QCOM_SCM_INTERRUPTED	1
+#define QCOM_SCM_WAITQ_SLEEP	2
 
 static inline int qcom_scm_remap_error(int err)
 {
-- 
2.17.1

