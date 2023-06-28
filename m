Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF0741100
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjF1MgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:30942 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbjF1MgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBBj0W032212;
        Wed, 28 Jun 2023 12:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z/38/L7Qb4rY0gn24IqUDEH0xFQsfWB9pSUqCcrV3P8=;
 b=HNt/zEUQKPRanF5fARYX0Inv7LCG2imfF6HYWksc/Eli2gqIe2VjIiOwyMrLlCPlZq19
 l7bZCVuDQIuguhcfQV4LBj2QX6OqqTet7/YZqtdc9aRZ4ZfFrnMzqqGdEOOe0454ugB3
 2gHE8oIBdGiJ06ixILlRJyde0MVBVa/Wno6UPBe81pLh74ci9+r1ej5jdcEDUxdB/e+m
 D9e6DFlPygSCp1mGmaDrpB+oe0G5Nr265ncA/pUoLUCtmh0Dhq1lbmGQSHVzMV6xCzWK
 g1PFLDK/ezpJc9LCowsl1GwG81f0kMZS0Wwb2aDUM5/GqYYYjdeDIWHLrTdPBU6stiFJ gw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpgw4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZRr3025624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:27 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:20 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
Date:   Wed, 28 Jun 2023 18:04:29 +0530
Message-ID: <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cdOZ3jlYYRrz3hYIl8DadVmQZGPwRH6s
X-Proofpoint-GUID: cdOZ3jlYYRrz3hYIl8DadVmQZGPwRH6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module like minidump providing debugging support will need to
get the symbol information from the core kernel e.g to get
the linux_banner, kernel section addresses bss, data, ro etc.

commit 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name()
 and kallsyms_on_each_symbol()") unexports kallsyms_lookup_name
due to lack of in-tree user of the symbol. Now, that minidump
will one of its user, export it.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b..34a074f58736 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -283,7 +283,7 @@ unsigned long kallsyms_lookup_name(const char *name)
 
 	return module_kallsyms_lookup_name(name);
 }
-
+EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 /*
  * Iterate over all symbols in vmlinux.  For symbols from modules use
  * module_kallsyms_on_each_symbol instead.
-- 
2.7.4

