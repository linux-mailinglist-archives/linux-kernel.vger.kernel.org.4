Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135B7750177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjGLI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjGLI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:28:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C22D6A;
        Wed, 12 Jul 2023 01:23:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6ScJ7013338;
        Wed, 12 Jul 2023 08:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hVzf/h1iQ+R3J36zD1MxGrCE/cAMVqwUd+PVOholWlg=;
 b=p04CaScvNvCruN5VQ4vqQxEKZlJNNUsceYXz+uq6aQKQDbK+aoqFVF7kV9+sAjeQ0C2g
 K4FYfliJLHC8A7uJOh2u+kJjf0KwFi+P1Vp+6V/2LibOcxwohwDjXDhGJNiPCeL87y5g
 NwkRq5nKKl+oxhY0ZgO4c0RPpoGq0Y7hcOUEXxu6KnTAtFTN9pSkOLifv78JRwhNqWNc
 DB3ZXHg4tbTZxBTaaSKziH+BHRYKsD7+Us/wp33l6z1r/UyB8OP2+ubeqbEBW0H5WtWe
 FvhwecTVEnKuO/5Yt16SpD3Tildd7T4AMvrCqZch9wVsINWc+YJjM1LDAkoDmmYOOZwO 1Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq0x7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:23:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C8N3lX014311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:23:03 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 01:22:59 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 1/3] usb: misc: Add the interface for notifier call for Embedded USB Debugger(EUD)
Date:   Wed, 12 Jul 2023 13:52:38 +0530
Message-ID: <a2b04d69396c9522327f6c0f22637a83161a5fe9.1689148711.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1689148711.git.quic_schowdhu@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HmumV-VRMaraD9yASJM1jw0BP7fj7PtJ
X-Proofpoint-GUID: HmumV-VRMaraD9yASJM1jw0BP7fj7PtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=599 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interface for notifier calls that can be made to check the role
switch status of EUD. An external module can import this file and use the
wrapper functions eud_register_notify to register a notifier to the EUD
notifier chain, eud_unregister_notify to unregister the notifier from the
chain, eud_notifier_call_chain to call the notifier chain to check the
status of role-switch. These interfaces are provided to handle the case
where multiple modules might go for a role-switch on the same port in which
case EUD will be given priority over the rest.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 drivers/usb/misc/qcom_eud_notifier.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 drivers/usb/misc/qcom_eud_notifier.h

diff --git a/drivers/usb/misc/qcom_eud_notifier.h b/drivers/usb/misc/qcom_eud_notifier.h
new file mode 100644
index 000000000000..0cae42a5f6bf
--- /dev/null
+++ b/drivers/usb/misc/qcom_eud_notifier.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Released under the GPLv2 only.
+ */
+
+#include <linux/notifier.h>
+
+extern int eud_register_notify(struct notifier_block *nb);
+extern void eud_unregister_notify(struct notifier_block *nb);
+extern void eud_notifier_call_chain(unsigned long role_switch_state);
-- 
2.17.1

