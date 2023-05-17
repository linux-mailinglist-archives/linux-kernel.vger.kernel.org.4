Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874CC706EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjEQQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:56:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1011BD0;
        Wed, 17 May 2023 09:56:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HGVB3I000606;
        Wed, 17 May 2023 16:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=XughtEUspHfgU669yLfCX1SyL04SgRLhqAMGwN/BM2Y=;
 b=C61BbnKU+JzQHa3bHhf75+ebiV7CRZjKiD7VCuczrUP0uZoKzyLwZl7tQiZ0tgaYcoH0
 nRuQi2H2ovIWPX+yGCTPYa6RTjymtht7WgrJfvGWn0O7eWvP61lRtOq8lWBenEtMqOgT
 YGx1LWxCO3Nj/Pj2E9AyJrj/r1nmjfFDSGn8DmpQSSGBd5xpCSGNbdNX656KtPXkMCWt
 TO+F/jPY7HaLOCjp+MMngBSSM8oFkiYDEAfak5oz/LAQEwL4bqkor9XckVSqcrJgqYDj
 +6pde4MqgqHnOx4nRCA0eneTsINcWV4lU0CHQhaNOzx+8o6exZbrYQp522fDPp/z7I0/ VA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk7b4b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:56:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HGuUkU002903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:56:30 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 09:56:29 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <trix@redhat.com>, <ogabbay@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <jacek.lawrynowicz@linux.intel.com>,
        <quic_carlv@quicinc.com>, <stanislaw.gruszka@linux.intel.com>,
        <quic_pkanojiy@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2] accel/qaic: initialize ret variable to 0
Date:   Wed, 17 May 2023 10:56:05 -0600
Message-ID: <20230517165605.16770-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IagSNZbJVzCCjD0k8azwN8yeQiIQfR7F
X-Proofpoint-ORIG-GUID: IagSNZbJVzCCjD0k8azwN8yeQiIQfR7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports
drivers/accel/qaic/qaic_data.c:610:2: warning: Undefined or garbage
  value returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~

From a code analysis of the function, the ret variable is only set some
of the time but is always returned.  This suggests ret can return
uninitialized garbage. However BO allocation will ensure ret is always
set in reality.

Initialize ret to 0 to silence the warning.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Tom Rix <trix@redhat.com>
[jhugo: Reword commit text]
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/accel/qaic/qaic_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 8ab26e64b231..e42c1f9ffff8 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -591,7 +591,7 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
 	struct qaic_bo *bo = to_qaic_bo(obj);
 	unsigned long offset = 0;
 	struct scatterlist *sg;
-	int ret;
+	int ret = 0;
 
 	if (obj->import_attach)
 		return -EINVAL;
-- 
2.40.1

