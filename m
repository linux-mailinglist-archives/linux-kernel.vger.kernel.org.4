Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC866E59B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjAQSGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjAQR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:58:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735D530F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:48:11 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGncAB009058;
        Tue, 17 Jan 2023 17:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=d6us00CEK+nN684QtvKE/QfiRUkgw8JfegbQYyfJBZw=;
 b=nkq2L48g+E1imokISXszkMNqjtWdPFsMTATrVRuRvcfohz+ojU4LnT16O1HPZXPfWOJT
 HhOJO5I92f6vSkiN/gtleYeOrTIzo3XUVuyQrdAE6FDZoyJCGCYP7AA57lNh+vg3Ndvo
 mWiLZLpMPGq78/cyqwkMv+bNO9CC8iRwWnooz8sAIejOiophHY7ZlZLTag8DzdwUn/pN
 68hmSzcVsEOsK2mNpploWwE6173L9X5lQmXMcLkAZHXJbMfNolEM50EHdScEJ/Lt/Kil
 gUQ0eSC27gXhMeQgDeq9MnSXZZebl0fop6Kyg/ZPQ3DcnUCboqfYW481BExHz0H60eOA MA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5nkq9e0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 17:48:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HHm4am015996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 17:48:04 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 09:46:15 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <jacek.lawrynowicz@linux.intel.com>, <ogabbay@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>
Subject: [PATCH] accel: Add .mmap to DRM_ACCEL_FOPS
Date:   Tue, 17 Jan 2023 10:45:58 -0700
Message-ID: <1673977558-7648-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: __KSQ2Ct7qcPybeo9FtYMhBi9Ceb66Wk
X-Proofpoint-ORIG-GUID: __KSQ2Ct7qcPybeo9FtYMhBi9Ceb66Wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=985 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170141
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reviewing the ivpu driver, DEFINE_DRM_ACCEL_FOPS could have been used
if DRM_ACCEL_FOPS defined .mmap to be drm_gem_mmap.  Lets add that since
accel drivers are a variant of drm drivers, modern drm drivers are
expected to use GEM, and mmap() is a common operation that is expected
to be heavily used in accel drivers thus the common accel driver should
be able to just use DEFINE_DRM_ACCEL_FOPS() for convenience.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 include/drm/drm_accel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index 65c0affb..d495506 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -27,7 +27,8 @@
 	.compat_ioctl	= drm_compat_ioctl,\
 	.poll		= drm_poll,\
 	.read		= drm_read,\
-	.llseek		= noop_llseek
+	.llseek		= noop_llseek, \
+	.mmap		= drm_gem_mmap
 
 /**
  * DEFINE_DRM_ACCEL_FOPS() - macro to generate file operations for accelerators drivers
-- 
2.7.4

