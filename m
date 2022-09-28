Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60655EE62A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiI1T5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiI1T5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:57:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465A543FF;
        Wed, 28 Sep 2022 12:57:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SIswDo014804;
        Wed, 28 Sep 2022 19:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NdBMegGfQRT3NVnpSimV4eMtuPXioAvn9GAQ6vw5iwE=;
 b=ERLMeh/ZTmpvYaqxXzeHc3+vR31zxhuuIfTo3mKl+MRXnM2X9NFiQi8z4MuECHIxDvH8
 mY4NrC2FMN49JPsHqcYW9uFcwWukojAnHUF1xi2ZjNc21E8EH5wN4DB6vqkV1h4znFv6
 uD7AxuqzBxhGX/N+9EzCHQahFCp6F58QmQjJLdsVRhmaRKC0zv7p23LyO/JzqVg8Pa7z
 rZe4rBOVsXC1YmXtr38JAAgvEQH8lvteFCpqbjfS1djcu1xu7Ukrnu71eT1Vw164pdF3
 7wCWYphetNg/uUzSZ6l+zV41TNOopKv+7FOjUefChRvmUvRrpxjAzuWfJ8NIlUFteXJ9 aw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvuxtr5u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SJvRUO007498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:27 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:26 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 04/14] arm64: smccc: Include alternative-macros.h
Date:   Wed, 28 Sep 2022 12:56:23 -0700
Message-ID: <20220928195633.2348848-5-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QyF3LfcdhOkgXtEfd3BFQGpnmiSjA84g
X-Proofpoint-ORIG-GUID: QyF3LfcdhOkgXtEfd3BFQGpnmiSjA84g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_09,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=697 clxscore=1015 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_ARM64_SVE is selected and
asm/alternative-macros.h wasn't implicitly included by another header.

Fixes: cfa7ff959a78 ("arm64: smccc: Support SMCCC v1.3 SVE register saving hint")
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/arm-smccc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..6a627cdbbdec 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 /* nVHE hypervisor doesn't have a current thread so needs separate checks */
 #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
+#include <asm/alternative-macros.h>
 
 #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
 				    ARM64_SVE)
-- 
2.25.1

