Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985F965164B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiLSXDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiLSXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD752626B;
        Mon, 19 Dec 2022 15:00:45 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLm22Q002378;
        Mon, 19 Dec 2022 23:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LaXGD1Ji20/92Kosv5wZDMWkkXiKv3o9E6QOZ2ghcxg=;
 b=Z13J3hdXXDAzKqiZnUE5JiKvLqUpVxZSTjPLDeUx6wdahVW0SwkxNQvBKwiBwVhL3+Rc
 XUbmPyhphhXyQsSVnY/pYWe6IKDe4R1b1M/auuVLELTn5qYdn8Bo3j4bGG4sQ/RNotr5
 uFQIgRy9aRtqjuAjDhhRfbHVSt/ELV7ubHZM95lNwJNpF/DDT9KeVwA+yft6bxB8Sdxw
 WOgnof3AH9bGayKGBl9Au7k6FxACTu7/Pk5HphOp9UakGg0NM6PJ238+vulslHTwWJQK
 phkrx4eBL3qBKhyRr766btBvr9zOqGl4vBQEHNG6hKfdckvNbMK4nSfl7F81dcY97hiv Wg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh34udrej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:26 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0Pg6030669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:25 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:24 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 08/28] virt: gunyah: msgq: Add hypercalls to send and receive messages
Date:   Mon, 19 Dec 2022 14:58:29 -0800
Message-ID: <20221219225850.2397345-9-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7eLuPziOBBl151QpQ_4xX2lWbMTdRlEH
X-Proofpoint-GUID: 7eLuPziOBBl151QpQ_4xX2lWbMTdRlEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
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
 arch/arm64/gunyah/gunyah_hypercall.c | 33 ++++++++++++++++++++++++++++
 include/linux/gunyah.h               |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index 0beb3123d650..d28600909be4 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -26,6 +26,8 @@
 						   GH_FN_ID(GH_CALL_TYPE_HYPERCALL, fn))
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
+#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
+#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
 
 /**
  * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
@@ -65,5 +67,36 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
 
+int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, buff, tx_flags, 0, &res);
+
+	if (res.a0)
+		return res.a0;
+
+	*ready = res.a1;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
+
+int gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size, bool *ready)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, buff, size, 0, &res);
+
+	if (res.a0)
+		return res.a0;
+
+	*recv_size = res.a1;
+	*ready = res.a2;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 166156f69df9..c863cac4a3cf 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -102,4 +102,9 @@ static inline u16 gh_api_version(void)
 void gh_hypercall_get_uid(u32 uid[4]);
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
+
+int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready);
+int gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size, bool *ready);
+
 #endif
-- 
2.25.1

