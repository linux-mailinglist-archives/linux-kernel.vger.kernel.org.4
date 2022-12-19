Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72665165D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiLSXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiLSXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:02:10 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3812ACE;
        Mon, 19 Dec 2022 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490858; x=1703026858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYweQv3PzZF7Arr6/aTL5AojEd8q8UfNKCO0tinlKwU=;
  b=cLfMLaGPiVLRASxlmDtaNkILDRz9fMsBa+ne0Db2n1O2jBjrvF6JURaR
   uCMODnPlD6QvQaVBrwvkIuL5/5qyPMC7Yjb6hA/Vc3gvc6BBxaY6cX8UV
   7n7U6c5H+9l6vJeTaZ7VwjFCovxqsfpbJHhDCXG22Owv7/XloM4EejD0k
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 15:00:54 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:54 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:53 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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
Subject: [PATCH v8 26/28] virt: gunyah: Add hypercalls for sending doorbell
Date:   Mon, 19 Dec 2022 14:58:47 -0800
Message-ID: <20221219225850.2397345-27-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah doorbells allow two virtual machines to signal each other using
interrupts. Add the hypercalls needed to assert the interrupt.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/gunyah/gunyah_hypercall.c | 27 +++++++++++++++++++++++++++
 include/linux/gunyah.h               |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index dc42a4e6bd7c..00c5f91b96fd 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -26,6 +26,8 @@
 						   GH_FN_ID(GH_CALL_TYPE_HYPERCALL, fn))
 
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
+#define GH_HYPERCALL_DBL_SEND			GH_HYPERCALL(0x0012)
+#define GH_HYPERCALL_DBL_SET_MASK		GH_HYPERCALL(0x0015)
 #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
 #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
 #define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x0065)
@@ -68,6 +70,31 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
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
index 42160b4de834..2c2b498a792d 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -163,6 +163,9 @@ static inline u16 gh_api_version(void)
 void gh_hypercall_get_uid(u32 uid[4]);
 void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
 
+int gh_hypercall_dbl_send(u64 capid, u64 new_flags, u64 *old_flags);
+int gh_hypercall_dbl_set_mask(u64 capid, u64 enable_mask, u64 ack_mask);
+
 #define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
 
 int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready);
-- 
2.25.1

