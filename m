Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAC6ED892
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjDXXRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjDXXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:16:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67963126;
        Mon, 24 Apr 2023 16:16:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OLSKIu005015;
        Mon, 24 Apr 2023 23:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iChxHUwc1b8vxtzP0eqLNCTiVeQ5CJJAGkNRJGeoG5c=;
 b=fW0H5Vdl2UMIaQKlfvo9hgqrgPum0y89mBJtRUdLccH72wgEuWb2NMqZQejK0yxnwxhY
 b/MCtjttnA3EQ5Rp2Jfyh6jGmRS8fRDCaZt7XztujqUNk1edM8FP5IrDuzox71gwx5aL
 CeJOVbwgzFnaSKKuV5mFNYeywPd9qumn3qmGwS4xAcH4LYszCvHqDEe8+shV/otcK/gV
 Xt8dvA+dxQO+81NlaEMoW2a0xJITueZ97yGDyFyFHWL61CjiMAdoJ9FH1Th//eR7DFeG
 hJWieALEXImnjCgWvzTlg19cCriekBiA3F9N19AwUTe7kPlKCmVQ7tVMvLyYk+hZnMQO 4g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5uwj10f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGUfa029757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:30 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 03/25] gunyah: Common types and error codes for Gunyah hypercalls
Date:   Mon, 24 Apr 2023 16:15:36 -0700
Message-ID: <20230424231558.70911-4-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IW3rWyUoSzaex_EAJXMhshD2hmhAMvOy
X-Proofpoint-GUID: IW3rWyUoSzaex_EAJXMhshD2hmhAMvOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=712 classifier=spam adjust=0 reason=mlx scancount=1
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

Add architecture-independent standard error codes, types, and macros for
Gunyah hypercalls.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/gunyah.h | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 include/linux/gunyah.h

diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
new file mode 100644
index 000000000000..a4e8ec91961d
--- /dev/null
+++ b/include/linux/gunyah.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_GUNYAH_H
+#define _LINUX_GUNYAH_H
+
+#include <linux/errno.h>
+#include <linux/limits.h>
+
+/******************************************************************************/
+/* Common arch-independent definitions for Gunyah hypercalls                  */
+#define GH_CAPID_INVAL	U64_MAX
+#define GH_VMID_ROOT_VM	0xff
+
+enum gh_error {
+	GH_ERROR_OK			= 0,
+	GH_ERROR_UNIMPLEMENTED		= -1,
+	GH_ERROR_RETRY			= -2,
+
+	GH_ERROR_ARG_INVAL		= 1,
+	GH_ERROR_ARG_SIZE		= 2,
+	GH_ERROR_ARG_ALIGN		= 3,
+
+	GH_ERROR_NOMEM			= 10,
+
+	GH_ERROR_ADDR_OVFL		= 20,
+	GH_ERROR_ADDR_UNFL		= 21,
+	GH_ERROR_ADDR_INVAL		= 22,
+
+	GH_ERROR_DENIED			= 30,
+	GH_ERROR_BUSY			= 31,
+	GH_ERROR_IDLE			= 32,
+
+	GH_ERROR_IRQ_BOUND		= 40,
+	GH_ERROR_IRQ_UNBOUND		= 41,
+
+	GH_ERROR_CSPACE_CAP_NULL	= 50,
+	GH_ERROR_CSPACE_CAP_REVOKED	= 51,
+	GH_ERROR_CSPACE_WRONG_OBJ_TYPE	= 52,
+	GH_ERROR_CSPACE_INSUF_RIGHTS	= 53,
+	GH_ERROR_CSPACE_FULL		= 54,
+
+	GH_ERROR_MSGQUEUE_EMPTY		= 60,
+	GH_ERROR_MSGQUEUE_FULL		= 61,
+};
+
+/**
+ * gh_error_remap() - Remap Gunyah hypervisor errors into a Linux error code
+ * @gh_error: Gunyah hypercall return value
+ */
+static inline int gh_error_remap(enum gh_error gh_error)
+{
+	switch (gh_error) {
+	case GH_ERROR_OK:
+		return 0;
+	case GH_ERROR_NOMEM:
+		return -ENOMEM;
+	case GH_ERROR_DENIED:
+	case GH_ERROR_CSPACE_CAP_NULL:
+	case GH_ERROR_CSPACE_CAP_REVOKED:
+	case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
+	case GH_ERROR_CSPACE_INSUF_RIGHTS:
+	case GH_ERROR_CSPACE_FULL:
+		return -EACCES;
+	case GH_ERROR_BUSY:
+	case GH_ERROR_IDLE:
+		return -EBUSY;
+	case GH_ERROR_IRQ_BOUND:
+	case GH_ERROR_IRQ_UNBOUND:
+	case GH_ERROR_MSGQUEUE_FULL:
+	case GH_ERROR_MSGQUEUE_EMPTY:
+		return -EIO;
+	case GH_ERROR_UNIMPLEMENTED:
+	case GH_ERROR_RETRY:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif
-- 
2.40.0

