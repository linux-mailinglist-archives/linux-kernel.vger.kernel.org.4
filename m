Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE77304B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjFNQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFNQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:15:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C671FFF;
        Wed, 14 Jun 2023 09:15:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EFGRid006379;
        Wed, 14 Jun 2023 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=Cxu80qYLWBN6CGaM9a2GrYS5uFWXPH5qjpPWb0qWyWk=;
 b=ComPqdflkC/tVcHLZshoOE+t0MDAkUSB+Nrh452o3CNQZq0+kTtKh1sQbRTNomQJGmQ/
 2RX/rs7l0AzlutwIdE8oAwjdOeQpACV0J3sTtKG9+aDtGcPoZOrMmpGaZiskMVFiau6K
 9llkGNjNhr0WoTl4DAhvS/Tv/R+Cy6/8VJf19jWfL2om5zWtkgh9dschObIvQcKEfMtS
 5KhFiJGq0hoVkZrCwxnScghXuDN+YkMTHSeHR25XpP4aHvCL0xLwslgZGEWwSOouU4r+
 F6YyONm5POqxLNSs7TbPYrNCJpWyVxRLtmabhIjnizgVVUYDBc31jJYVhZjolpD65wKO qA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7fae89n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 16:15:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EGFkIZ030883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 16:15:46 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 09:15:45 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <quic_carlv@quicinc.com>, <quic_pkanojiy@quicinc.com>,
        <christian.koenig@amd.com>, <sukrut.bellary@linux.com>,
        <sumit.semwal@linaro.org>
CC:     <ogabbay@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] accel/qaic: Call DRM helper function to destroy prime GEM
Date:   Wed, 14 Jun 2023 10:15:28 -0600
Message-ID: <20230614161528.11710-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _TxUpOz9a1M8vH5LZlHsuEqnI2pQAC2f
X-Proofpoint-GUID: _TxUpOz9a1M8vH5LZlHsuEqnI2pQAC2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_11,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

smatch warning:
	drivers/accel/qaic/qaic_data.c:620 qaic_free_object() error:
		dereferencing freed memory 'obj->import_attach'

obj->import_attach is detached and freed using dma_buf_detach().
But used after free to decrease the dmabuf ref count using
dma_buf_put().

drm_prime_gem_destroy() handles this issue and performs the proper clean
up instead of open coding it in the driver.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Reported-by: Sukrut Bellary <sukrut.bellary@linux.com>
Closes: https://lore.kernel.org/all/20230610021200.377452-1-sukrut.bellary@linux.com/
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/accel/qaic/qaic_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index e42c1f9ffff8..e9a1cb779b30 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -23,6 +23,7 @@
 #include <linux/wait.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 #include <uapi/drm/qaic_accel.h>
 
@@ -616,8 +617,7 @@ static void qaic_free_object(struct drm_gem_object *obj)
 
 	if (obj->import_attach) {
 		/* DMABUF/PRIME Path */
-		dma_buf_detach(obj->import_attach->dmabuf, obj->import_attach);
-		dma_buf_put(obj->import_attach->dmabuf);
+		drm_prime_gem_destroy(obj, NULL);
 	} else {
 		/* Private buffer allocation path */
 		qaic_free_sgt(bo->sgt);
-- 
2.40.1

