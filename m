Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63B67607E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjATWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjATWsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D237F09;
        Fri, 20 Jan 2023 14:47:50 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KM03ch024187;
        Fri, 20 Jan 2023 22:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ovIk7K18fTf8BAB1Q7TgDJbm1HCEqrh/BQIJHr0vR7Q=;
 b=aF/evuq0EMXoKA3Yr8jd5gdoFm9yEp3hfyCgGYnB06+oIzRodnukvdfk+8HpKpQLlsxI
 H/tasgrMptG1vC1JjUSLqQRLNsrez3j/JyiZMAUTSWaWf5l02wUjvrNlVd7JQLmg6Nux
 +LQ+g8bdaNSGuKP+sIanXo96UWFJUwaWi6y1bjhJpl2kApIGhMNApQs1Qs5z09Bb3HCk
 hAMaH82ff52MlO+KmlE63+mR1fZK+uLIqQbwg+U80VlbLihjsOVoqS2KRn24zL+LOcU5
 wbH5Lt1YEJg9LkmtJugneBrnJbgaSKZtcQqDdHcRwUdEcCSKrsj7k6Svh1Lk6T7xmCTo gA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28jrer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlcYK030181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:38 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:38 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 07/27] virt: gunyah: msgq: Add hypercalls to send and receive messages
Date:   Fri, 20 Jan 2023 14:46:06 -0800
Message-ID: <20230120224627.4053418-8-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -j1pKOQnNXgVbsFDIKQgxAlfSA6Hzwfc
X-Proofpoint-ORIG-GUID: -j1pKOQnNXgVbsFDIKQgxAlfSA6Hzwfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
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
index ffed4b71641f..d93ad2c08479 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -13,6 +13,8 @@ static const uint32_t gunyah_known_uuids[][4] = {
 };
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
+#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
+#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
 
 /**
  * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
@@ -71,5 +73,36 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
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
index 6724d1264d58..b5f61c14ec1e 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -104,4 +104,9 @@ struct gh_hypercall_hyp_identify_resp {
 
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
+
+int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready);
+int gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size, bool *ready);
+
 #endif
-- 
2.39.0

