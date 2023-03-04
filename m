Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4846AA712
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCDBIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCDBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:08:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4445C6781A;
        Fri,  3 Mar 2023 17:07:50 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3240F8Vi019324;
        Sat, 4 Mar 2023 01:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=DfRy3GvvyBk78GUTsKcTklgcl7kKoNmh7DRjvVFD040=;
 b=S79rfEXV4pdWh98610HCh6N3yO9svZkP15hDoFKYqLShwEjFgleT0rUk/YfrQmgXReSq
 0VrqkIpN/s8iUmMG0VLwvs2CmMTkfP9Y3BTbRtihotXil4iU5Pdic786+yFOxu15FDSA
 nfTNKZVwHaIjHk1To1K7PxMlnJZZbej6zCnC5aqK/q5Pw7ZRKDJQ968IKk3GIDJ/UQlr
 3RI3y+5/ktS36mI65kTqADynbIeegD8KFcFJJHiD9SHWKyQzXlv4KUxjGtcxfySqkmNG
 hVovQ+2WP5I0TksM2g852i4ctoIWB98iSHWRt6aEIb7DORdgKq9sOGVTty1vGQL0yCa4 ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3c8htrd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:07:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32417JOT029048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:07:19 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:07:18 -0800
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
Subject: [PATCH v11 23/26] virt: gunyah: Add hypercalls for sending doorbell
Date:   Fri, 3 Mar 2023 17:06:29 -0800
Message-ID: <20230304010632.2127470-24-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IiboxbtkbH4HJrmtSGSyH0Ln5QlJ8zUO
X-Proofpoint-ORIG-GUID: IiboxbtkbH4HJrmtSGSyH0Ln5QlJ8zUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=766
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303040004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index f01f5cec4d23..0f1cdb706e91 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -41,6 +41,8 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
 						   fn)
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
+#define GH_HYPERCALL_BELL_SEND			GH_HYPERCALL(0x8012)
+#define GH_HYPERCALL_BELL_SET_MASK		GH_HYPERCALL(0x8015)
 #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
 #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
 #define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x8065)
@@ -63,6 +65,29 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
 
+enum gh_error gh_hypercall_bell_send(u64 capid, u64 new_flags, u64 *old_flags)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_BELL_SEND, capid, new_flags, 0, &res);
+
+	if (res.a0 == GH_ERROR_OK)
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
 enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, int tx_flags, bool *ready)
 {
 	struct arm_smccc_res res;
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 37f1e2c822ce..63395dacc1a8 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -169,6 +169,9 @@ struct gh_hypercall_hyp_identify_resp {
 
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+enum gh_error gh_hypercall_bell_send(u64 capid, u64 new_flags, u64 *old_flags);
+enum gh_error gh_hypercall_bell_set_mask(u64 capid, u64 enable_mask, u64 ack_mask);
+
 #define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
 
 enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, int tx_flags, bool *ready);
-- 
2.39.2

