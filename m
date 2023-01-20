Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D65676143
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATXJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjATXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:08:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1085E515;
        Fri, 20 Jan 2023 15:08:49 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KLAU7O022403;
        Fri, 20 Jan 2023 22:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+z0xlUlEWhGDHObbmbwPzHrQHX6Yp1OolxLxSjxGCHk=;
 b=NKEGv+dyCkLx4R4NImhfxqLObWHfEokgkG+G26vuRoQBPbPGdRBBqeECm1mrm01zoaPX
 uEnkgMcvyDMgI0AI4G7xqtQbJZ3/nVsGrGTCLHQxCPs7N8s+UKXlIGkiR4mM2sZrCYCk
 ywGHj4sA6luFOsPzuSksUz0IU31zW/SiGop5gELpmJGxVqvam73uUQsdA7ME5977JexD
 IWQYigACJKTREtvW9O3kyC7bhXQlggnlUw42AoNxZ5o37s0tH3JteVS1ln3282upnwi/
 WVXwXN8t+VATmhAghzEvrZBJdgczmWG9hLyz7XFSCib8M/TzRA6B0IW+DjRUzJdjL+G6 0Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7xt7rjwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMm9w7029470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:09 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:08 -0800
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
Subject: [PATCH v9 25/27] virt: gunyah: Add hypercalls for sending doorbell
Date:   Fri, 20 Jan 2023 14:46:24 -0800
Message-ID: <20230120224627.4053418-26-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: PEWX8HQrH9KTkKaoy7akz9laQMWtl8eX
X-Proofpoint-ORIG-GUID: PEWX8HQrH9KTkKaoy7akz9laQMWtl8eX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=964 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
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
 arch/arm64/gunyah/gunyah_hypercall.c | 39 ++++++++++++++++++----------
 include/linux/gunyah.h               |  3 +++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index 17d87a130a3e..057e127f2b4d 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -12,19 +12,7 @@ static const uint32_t gunyah_known_uuids[][4] = {
 	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
 };
 
-#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
-#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
-#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
-#define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x0065)
-
-/**
- * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
- * @uid: An array of 4 u32's (u32 uid[4];)
- *
- * Caller should compare the resulting UID to a list of known Gunyah UIDs to
- * confirm that Linux is running as a guest of Gunyah.
- */
-void gh_hypercall_get_uid(u32 uid[4])
+bool arch_is_gunyah_guest(void)
 {
 	struct arm_smccc_res res;
 	u32 uid[4];
@@ -74,6 +62,31 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
 
+int gh_hypercall_dbl_send(u64 capid, u64 new_flags, u64 *old_flags)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_DBL_SEND, capid, new_flags, 0, &res);
+
+	if (res.a0)
+		return res.a0;
+
+	*old_flags = res.a1;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_dbl_send);
+
+int gh_hypercall_dbl_set_mask(u64 capid, u64 enable_mask, u64 ack_mask)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GH_HYPERCALL_DBL_SET_MASK, capid, enable_mask, ack_mask, 0, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_dbl_set_mask);
+
 int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready)
 {
 	struct arm_smccc_res res;
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index feeab01bff30..ac4879940c10 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -164,6 +164,9 @@ struct gh_hypercall_hyp_identify_resp {
 
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+int gh_hypercall_dbl_send(u64 capid, u64 new_flags, u64 *old_flags);
+int gh_hypercall_dbl_set_mask(u64 capid, u64 enable_mask, u64 ack_mask);
+
 #define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
 
 int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready);
-- 
2.39.0

