Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9921F75017A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjGLI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGLI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:28:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028101993;
        Wed, 12 Jul 2023 01:23:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C3mOZR032181;
        Wed, 12 Jul 2023 08:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=40o+X8oKsX81WIYXOnfFG7rcPkNuQsSlDf08s1f+OFU=;
 b=lbf3kT8WLHSNf58d+2fYPsgT/rfIM4BtAjGJ57ivrWQTbA9emg/XLa4X1BnEpQEge76+
 YaaXlhf8J/eXsLXPJIlek2vuJRlUoyuHC0HnOu1twbU1yjzNuIKkEvNaj3BYFyBK6mLc
 2Y2nXnTDCcIMnrfc+eCR/eQmd7uCu++vvOCiMDae4DdQFGXslUReGzo+NCt7IIZtZliX
 OuwuBK8gnpuZIM3YsPEg5eE3lcXyWm73RbNgTM99gUHUv/lIW9X7AJsuUT/5PNcTRpb2
 /RCIxN7/1JzdJLwiWKxqvEIdOeTb4VoZsnJcDcuouaJc6STs9fVTOZi4xGD7+MWO+N9N Rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgd38tv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:23:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C8N7mo031890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:23:07 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 01:23:03 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 2/3] usb: misc: Add notifier call chain to Embedded USB Debug(EUD) driver
Date:   Wed, 12 Jul 2023 13:52:39 +0530
Message-ID: <18212c7abbb8c833cc07f8500d4905b79c49ec59.1689148711.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1689148711.git.quic_schowdhu@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SXiq8Dlvs04sZERfyLzjmvM9owT8ZG2m
X-Proofpoint-GUID: SXiq8Dlvs04sZERfyLzjmvM9owT8ZG2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=955 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the notifier call chain to EUD driver. The notifier call chain
is added to check the role-switch status of EUD. When multiple
modules are switching roles on the same port, they need to call this
notifier to check the role-switch status of EUD. If EUD is disabled,
then the modules can go for the role-switch, otherwise it needs to
be blocked. The notifier chain can be used to link multiple modules
switching roles on the same port and create a ordering, priority and
conflict resolution among them. The wrapper functions are defined here
which can be used to register a notifier block to the chain, deregister
it and also call the chain.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 drivers/usb/misc/qcom_eud.c | 52 +++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 7f371ea1248c..e6c97a2cf2df 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -11,10 +11,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/usb/role.h>
+#include "qcom_eud_notifier.h"
 
 #define EUD_REG_INT1_EN_MASK	0x0024
 #define EUD_REG_INT_STATUS_1	0x0044
@@ -22,14 +25,16 @@
 #define EUD_REG_VBUS_INT_CLR	0x0080
 #define EUD_REG_CSR_EUD_EN	0x1014
 #define EUD_REG_SW_ATTACH_DET	0x1018
-#define EUD_REG_EUD_EN2		0x0000
+#define EUD_REG_EUD_EN2        0x0000
 
 #define EUD_ENABLE		BIT(0)
-#define EUD_INT_PET_EUD		BIT(0)
+#define EUD_INT_PET_EUD	BIT(0)
 #define EUD_INT_VBUS		BIT(2)
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+static RAW_NOTIFIER_HEAD(eud_nh);
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
@@ -41,6 +46,42 @@ struct eud_chip {
 	bool				usb_attached;
 };
 
+int eud_register_notify(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&eud_nh, nb);
+}
+EXPORT_SYMBOL_GPL(eud_register_notify);
+
+void eud_unregister_notify(struct notifier_block *nb)
+{
+	raw_notifier_chain_unregister(&eud_nh, nb);
+}
+EXPORT_SYMBOL_GPL(eud_unregister_notify);
+
+void eud_notifier_call_chain(unsigned long role_switch_state)
+{
+	raw_notifier_call_chain(&eud_nh, role_switch_state, NULL);
+}
+EXPORT_SYMBOL_GPL(eud_notifier_call_chain);
+
+static int eud_vbus_spoof_attach_detach(struct notifier_block *nb, unsigned long event,
+					void *data)
+{
+	struct device_node *eud = of_find_compatible_node(NULL, NULL, "qcom,eud");
+	struct device *eud_device = bus_find_device_by_of_node(&platform_bus_type, eud);
+	struct eud_chip  *eud_data = dev_get_drvdata(eud_device);
+
+	if (eud_data->enabled  && event != USB_ROLE_DEVICE)
+		return NOTIFY_BAD;
+	else
+		return NOTIFY_OK;
+}
+
+static struct notifier_block eud_notifier = {
+	.notifier_call = eud_vbus_spoof_attach_detach,
+	.priority = 1,
+};
+
 static int enable_eud(struct eud_chip *priv)
 {
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
@@ -196,6 +237,10 @@ static int eud_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, ret,
 				"failed to add role switch release action\n");
 
+	ret = eud_register_notify(&eud_notifier);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "failed to register notifier\n");
+
 	chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
@@ -226,6 +271,9 @@ static void eud_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, false);
 	disable_irq_wake(chip->irq);
+	eud_unregister_notify(&eud_notifier);
+
+	return 0;
 }
 
 static const struct of_device_id eud_dt_match[] = {
-- 
2.17.1

