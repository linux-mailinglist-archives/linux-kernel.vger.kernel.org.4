Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9369DECB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjBUL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjBUL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:27:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788926867;
        Tue, 21 Feb 2023 03:26:47 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L9lasu013842;
        Tue, 21 Feb 2023 11:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YGKDvxRdX84ObfDEJmxXQZDtKg1Ik+7klLgTt5oEQtQ=;
 b=LjyjvlpZlRzKYIUGjHL7VuoOEEQ7aFYV72x7RtmeCIBWY+0JVEqzYknqYaxDCbuE2enw
 yoFHdjqgjmjhUNStY0qKj510XV3VpQRfP3aAl6A4qWHE6A1oJFFbBLWAk02Ayau81fWc
 5ZxTd5po3nq+VYTN/X6zZSdR2fJUjloWBYbTyzDiGk1QJahHEi6+aIbGObfA3viSi8Xe
 HMY5FOES/Ox1Rn/+ZATXMdhfLpuWeZEgHccEVjVJ82t59WepnaBBQS8bpV9IOVTcXVIS
 Q0IacJXl5LnXRi0NA07oYv9xy9XvNVYoNPoE4LvOV+IgULYywNiH0i1qcZL/fB4O7Df8 dw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvp4v0y6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:26:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LBQWqE019224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:26:32 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 03:26:27 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [RFC PATCH 6/6] pstore/ram: Register context with minidump
Date:   Tue, 21 Feb 2023 16:55:13 +0530
Message-ID: <1676978713-7394-7-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 39Q1ejLA4uIACmh6IhozW6TddRXj8vlA
X-Proofpoint-GUID: 39Q1ejLA4uIACmh6IhozW6TddRXj8vlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are system which does not uses pstore directly but
may have the interest in the context saved by pstore.
Register pstore regions with minidump so that it get
dumped on minidump collection.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/ram.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66db..038da1a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <soc/qcom/minidump.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -714,6 +715,74 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
+static int ramoops_qcom_minidump_register(struct ramoops_context *cxt)
+{
+	struct qcom_minidump_region pstore_entry;
+	struct persistent_ram_zone *prz;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < cxt->max_dump_cnt; i++) {
+		prz = cxt->dprzs[i];
+		scnprintf(pstore_entry.name, sizeof(pstore_entry.name),
+				"KDMESG%d", i);
+		pstore_entry.virt_addr = prz->vaddr;
+		pstore_entry.phys_addr = prz->paddr;
+		pstore_entry.size = prz->size;
+		ret = qcom_minidump_region_register(&pstore_entry);
+		if (ret < 0) {
+			pr_err("failed to add dmesg in minidump: err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (cxt->console_size) {
+		prz = cxt->cprz;
+		strlcpy(pstore_entry.name, "KCONSOLE", sizeof(pstore_entry.name));
+		pstore_entry.virt_addr = prz->vaddr;
+		pstore_entry.phys_addr = prz->paddr;
+		pstore_entry.size = prz->size;
+		ret = qcom_minidump_region_register(&pstore_entry);
+		if (ret < 0) {
+			pr_err("failed to add console in minidump: err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < cxt->max_ftrace_cnt; i++) {
+		prz = cxt->fprzs[i];
+		scnprintf(pstore_entry.name, sizeof(pstore_entry.name),
+					"KFTRACE%d", i);
+		pstore_entry.virt_addr = prz->vaddr;
+		pstore_entry.phys_addr = prz->paddr;
+		pstore_entry.size = prz->size;
+		ret = qcom_minidump_region_register(&pstore_entry);
+		if (ret < 0) {
+			pr_err("failed to add ftrace in minidump: err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (cxt->pmsg_size) {
+		prz = cxt->mprz;
+		strlcpy(pstore_entry.name, "KPMSG", sizeof(pstore_entry.name));
+		pstore_entry.virt_addr = prz->vaddr;
+		pstore_entry.phys_addr = prz->paddr;
+		pstore_entry.size = prz->size;
+		ret = qcom_minidump_region_register(&pstore_entry);
+		if (ret < 0) {
+			pr_err("failed to add pmsg in minidump: err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+#else
+static int ramoops_qcom_minidump_register(struct ramoops_context *cxt) { return 0; }
+#endif
+
 static int ramoops_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -724,6 +793,10 @@ static int ramoops_probe(struct platform_device *pdev)
 	phys_addr_t paddr;
 	int err = -EINVAL;
 
+	err = qcom_minidump_ready();
+	if (err && err != -ENODEV)
+		return -EPROBE_DEFER;
+
 	/*
 	 * Only a single ramoops area allowed at a time, so fail extra
 	 * probes.
@@ -841,6 +914,10 @@ static int ramoops_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = ramoops_qcom_minidump_register(cxt);
+	if (err < 0)
+		goto fail_buf;
+
 	err = pstore_register(&cxt->pstore);
 	if (err) {
 		pr_err("registering with pstore failed\n");
-- 
2.7.4

