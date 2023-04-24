Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE46ED8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjDXXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:33:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14087E9;
        Mon, 24 Apr 2023 16:33:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ON8Dh7013158;
        Mon, 24 Apr 2023 23:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gq8sFae/gLJSVbiNgJt9dV5xtlaSoQW/JFJ5Xx4FpYo=;
 b=giJ7cxHIKUjwwPH/nYvmDZja8CCodn4clQZbxpKz9J/CURjM1CXY+MK+I7umZxyLOal3
 3r5JvM6VlefYwWHZR08EzNpE5+/fQHbqBqT1WYr6ENAfMGOtTDwVTpYAeCzxzhhRAPVD
 Q9Ww7ysVs/9dcIfL0bVW3+XMTjrZTS7dA9AbD6Gu0OqiZMiN52pJpRplWMGGbLSJ0DnQ
 xgi3rN3ttb9aMhhJ8oFM8AzPIlze9zHLjzsub1rpVxDwZGeZhDsBk7dSYtb+C/L0cnFP
 BMVpMPrWOqQ8dwqqj8amZmpv4UAnAgYqJK0LiU3sl1cHCwDsGSgK8YrGt3gBOg/tDatV mQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q61jdr5mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:17:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONH10i007184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:17:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:17:00 -0700
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 22/25] virt: gunyah: Add hypercalls for sending doorbell
Date:   Mon, 24 Apr 2023 16:15:55 -0700
Message-ID: <20230424231558.70911-23-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424231558.70911-1-quic_eberman@quicinc.com>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Em1gEnaUgrKFPQcO7PZybagtx2W8_P2Z
X-Proofpoint-GUID: Em1gEnaUgrKFPQcO7PZybagtx2W8_P2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=822 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah doorbells allow two virtual machines to signal each other using
interrupts. Add the hypercalls needed to assert the interrupt.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/gunyah/gunyah_hypercall.c | 25 +++++++++++++++++++++++++
 include/linux/gunyah.h               |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index 5f33f53e05a9..3d48c8650851 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -33,6 +33,8 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
 						   fn)
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
+#define GH_HYPERCALL_BELL_SEND			GH_HYPERCALL(0x8012)
+#define GH_HYPERCALL_BELL_SET_MASK		GH_HYPERCALL(0x8015)
 #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
 #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
 #define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x8065)
@@ -55,6 +57,29 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
 
+enum gh_error gh_hypercall_bell_send(u64 capid, u64 new_flags, u64 *old_flags)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_BELL_SEND, capid, new_flags, 0, &res);
+
+	if (res.a0 == GH_ERROR_OK && old_flags)
+		*old_flags = res.a1;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_bell_send);
+
+enum gh_error gh_hypercall_bell_set_mask(u64 capid, u64 enable_mask, u64 ack_mask)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_BELL_SET_MASK, capid, enable_mask, ack_mask, 0, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_bell_set_mask);
+
 enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready)
 {
 	struct arm_smccc_res res;
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index cd5704a82c6a..1f1685518bf3 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -171,6 +171,9 @@ static inline u16 gh_api_version(const struct gh_hypercall_hyp_identify_resp *gh
 
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+enum gh_error gh_hypercall_bell_send(u64 capid, u64 new_flags, u64 *old_flags);
+enum gh_error gh_hypercall_bell_set_mask(u64 capid, u64 enable_mask, u64 ack_mask);
+
 #define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
 
 enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready);
-- 
2.40.0

