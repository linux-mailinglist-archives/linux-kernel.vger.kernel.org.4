Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391557171CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjE3XhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3XhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:37:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09EF9;
        Tue, 30 May 2023 16:36:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UN5ACG014126;
        Tue, 30 May 2023 23:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BnKFAV9+C/6aBw4MDNRYTAckbflTdeJa6d+pxoJogoY=;
 b=Naw1/tHll8dN0eqt+UCXqnj73USVK9+XTWiTkJsNj3dfl/Va38U3aUMySHVC1ghDwmS0
 o2tMjJ4XHjO3x+ct5czhcVybKC45gswdk7YH5x6quCQs+cWTAgWDKaJpBwwhhGO0HG81
 XYAIOOSzU5yG+bKLjg+n2Bj0XS5uYYxoE8CesWyFmsjjzCpBgXX0dmIKF2IM6PYzlRMr
 y6BkZcTYR6bBzmnWHezGOYjhz/j7lI0B0vnUy/wZXeUfVpVGkMlYPdOQRlCYCEtOH20e
 uTyXhbVIs1wDqFZWi/KjjFWdtBhzcHujnz+lwsT7WmkOWOF1tCui4HtVKZSz3cgcjeH0 Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwryer6g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 23:36:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UNancr001337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 23:36:49 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 16:36:49 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] soc: qcom: rmtfs: Support discarding guard pages
Date:   Tue, 30 May 2023 16:36:42 -0700
Message-ID: <20230530233643.4044823-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
References: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3hs9piWICMgKRhBLfS3yFAs2VMeEKVE0
X-Proofpoint-ORIG-GUID: 3hs9piWICMgKRhBLfS3yFAs2VMeEKVE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_17,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations, the exact placement of the rmtfs shared memory
region isn't so strict. The DeviceTree author can then choose to use the
"size" property and rely on the OS for placement (in combination with
"alloc-ranges", if desired).

But on some platforms the rmtfs memory region may not be allocated
adjacent to regions allocated by other clients. Add support for
discarding the first and last 4k block in the region, if
qcom,use-guard-pages is specified in DeviceTree.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Drop the dma_alloc_coherent() based approach and just add support for
  the guard pages.

 drivers/soc/qcom/rmtfs_mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index f83811f51175..28238974d913 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -213,6 +213,16 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
+	/*
+	 * If requested, discard the first and last 4k block in order to ensure
+	 * that the rmtfs region isn't adjacent to other protected regions.
+	 */
+	if (of_property_present(node, "qcom,use-guard-pages")) {
+		rmtfs_mem->addr += SZ_4K;
+		rmtfs_mem->base += SZ_4K;
+		rmtfs_mem->size -= 2 * SZ_4K;
+	}
+
 	cdev_init(&rmtfs_mem->cdev, &qcom_rmtfs_mem_fops);
 	rmtfs_mem->cdev.owner = THIS_MODULE;
 
-- 
2.25.1

