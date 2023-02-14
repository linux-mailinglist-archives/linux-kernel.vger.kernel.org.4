Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5A696F41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBNVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBNVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:23:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A4A1AB;
        Tue, 14 Feb 2023 13:23:31 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EK86Dd004129;
        Tue, 14 Feb 2023 21:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RZZgoXchdGzg22qaEsGNOeO06XikKGMy+Ruu2BDs+Os=;
 b=i/kjE6q7pUrCouZFYDAv4d8rk/VGWtjicnERvYkOE7/2To9G3F486TsfbPngoCjKmfeL
 wSGBRsz69VIh7fXGrVlaYnSQDl/ZJ1e7ewsr8IYImyfIFP9oFxnv0oQ13tPa1jCgVLvf
 zS9Kot28ilru7eeqKI68RQ6Jcppq/+xSSpCpdqaUWMSyxv3mDhU4IhZDXBruo8VyChfe
 DeMRNWliaxHOIm8r6borSqbQOjoRQ5im1ujGhdsp0MmmrQIPQXqCEnm80wFnKAvlt5Is
 6hvfzieAew834dvvSa0faiNrwiUb19+14IFSwBMOIK0jY1TwyDtbtM/bp6hEkyclLUrU pA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr20vtkbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:23:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELNFWP006486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:23:15 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:23:14 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 06/26] virt: gunyah: msgq: Add hypercalls to send and receive messages
Date:   Tue, 14 Feb 2023 13:23:03 -0800
Message-ID: <20230214212303.3307536-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ciJ-F7i89QvW8o-lBdTRdBsAZTDiH2bt
X-Proofpoint-GUID: ciJ-F7i89QvW8o-lBdTRdBsAZTDiH2bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hypercalls to send and receive messages on a Gunyah message queue.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/gunyah/gunyah_hypercall.c | 32 ++++++++++++++++++++++++++++
 include/linux/gunyah.h               |  7 ++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index f30d06ee80cf..2ca9ab098ff6 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
 						   fn)
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
+#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
+#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
 
 /**
  * gh_hypercall_hyp_identify() - Returns build information and feature flags
@@ -57,5 +59,35 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
 
+enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags,
+					bool *ready)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, buff, tx_flags, 0, &res);
+
+	if (res.a0 == GH_ERROR_OK)
+		*ready = res.a1;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
+
+enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size,
+					bool *ready)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, buff, size, 0, &res);
+
+	if (res.a0 == GH_ERROR_OK) {
+		*recv_size = res.a1;
+		*ready = res.a2;
+	}
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 3fef2854c5e1..cb6df4eec5c2 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -112,4 +112,11 @@ struct gh_hypercall_hyp_identify_resp {
 
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
+
+enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags,
+					bool *ready);
+enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size,
+					bool *ready);
+
 #endif
-- 
2.39.1

