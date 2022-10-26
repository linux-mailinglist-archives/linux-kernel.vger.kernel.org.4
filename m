Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D882A60E7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiJZTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiJZTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC84DF11;
        Wed, 26 Oct 2022 11:59:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIoin1008148;
        Wed, 26 Oct 2022 18:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yXlqNXMWAdjwAdJIaYWHWJwPCld5jvDJM7JbTJUhsTs=;
 b=XylTMNvATBwOJYq+CsmQKTjrAPAXGmATZqTzMp6hMO89d75ybKQW826SLx0qFemAs68N
 J2d74W/7sQxNzxu+hPMEP7ieF+7oEwAyz+O/cwgDf13QPtukDEuPkjF6gnmWNgJFaoY4
 GHCe2puDj+ik5MpshQIQNBYv/UYyXl0xN3st/48BXJ//CvX/RBV9M5mCMYODDEOYtN5b
 OyzThtnVPWiwVvQ5Lc+H5zdR92eT/Jmj91V3hN9cqXU2FLrqOAHPG3fGvCnvDHhLYJRf
 mfpX6KsKGjf5KA8d42OEkzXApiazjvRzFtRyS+RVw9RtxG0mv2xw+C582f/Vd0KPKgJ4 xA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahc80tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxSXU002207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:28 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:27 -0700
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
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 04/21] arm64: smccc: Include alternative-macros.h
Date:   Wed, 26 Oct 2022 11:58:29 -0700
Message-ID: <20221026185846.3983888-5-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Q55uuQIiKBgsUhGIyxSRQA4xD-usOHi
X-Proofpoint-GUID: _Q55uuQIiKBgsUhGIyxSRQA4xD-usOHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=608 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_ARM64_SVE is selected and
asm/alternative-macros.h wasn't implicitly included by another header.

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

