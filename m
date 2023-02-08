Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74968ED83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:08:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B584483;
        Wed,  8 Feb 2023 03:08:06 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Aax8E021576;
        Wed, 8 Feb 2023 11:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Sb7zAkRR2CPMYF37C7epY1KD9UDtT1p3N6QhMn2OlVk=;
 b=L8/Y3JLaXR+To0L6ufS/o63EjQFoejIQ0gH5P93mTV4vSwC8ez3l1n7/14ThpKd/BZWU
 xfYZ8pSUJmkFqeEhAVVo8iIaWRm4FxBNnWGWHxl2dQid5tBzNEG5Za5ix/rWxWUHMClb
 KmQqlVL+3ADN2L0N5X0MEOrsQaYzAFmu9ipggXEe21hTbzShEe/Aq9oLx2sCFl8mE+dV
 e7oacoxZnTw45TqRd5SIo1QSkA2cJfmeLS3l2g6YjSF1A1M/V5/ZZKMp7YsXmKYwAoT9
 Zw/mW0XMPWdOagzY4yvurTBjhls0QbAVtTIh90SXfWpz2lFYTAXspH9h252Seh4i/1O7 yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkgafkvy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 11:07:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318B7Xvv015324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 11:07:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 03:07:32 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH] coresight: core: Add coresight name support
Date:   Wed, 8 Feb 2023 03:07:16 -0800
Message-ID: <20230208110716.18321-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zCGaZ7m6sdCM-TRSKtyx8TUcQk_y6Jkw
X-Proofpoint-ORIG-GUID: zCGaZ7m6sdCM-TRSKtyx8TUcQk_y6Jkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_04,2023-02-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxlogscore=801 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from STM and ETM sources, there will be more sources added to
coresight components. For example, there are over 10 TPDM sources.
Add coresight name support for custom names which will be
easy to identify the source.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 34 +++++++++++---------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d3bf82c0de1d..5e95d9c7f256 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 {
 	int idx;
 	char *name = NULL;
+	const char *coresight_name = NULL;
 	struct fwnode_handle **list;
+	struct device_node *node = dev->of_node;
 
 	mutex_lock(&coresight_mutex);
 
-	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
-	if (idx < 0) {
-		/* Make space for the new entry */
-		idx = dict->nr_idx;
-		list = krealloc_array(dict->fwnode_list,
-				      idx + 1, sizeof(*dict->fwnode_list),
-				      GFP_KERNEL);
-		if (ZERO_OR_NULL_PTR(list)) {
-			idx = -ENOMEM;
-			goto done;
+	if (!of_property_read_string(node, "coresight-name", &coresight_name))
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s", coresight_name);
+	else {
+		idx = coresight_search_device_idx(dict, dev_fwnode(dev));
+		if (idx < 0) {
+			/* Make space for the new entry */
+			idx = dict->nr_idx;
+			list = krealloc_array(dict->fwnode_list,
+					      idx + 1, sizeof(*dict->fwnode_list),
+					      GFP_KERNEL);
+			if (ZERO_OR_NULL_PTR(list))
+				goto done;
+
+			list[idx] = dev_fwnode(dev);
+			dict->fwnode_list = list;
+			dict->nr_idx = idx + 1;
 		}
 
-		list[idx] = dev_fwnode(dev);
-		dict->fwnode_list = list;
-		dict->nr_idx = idx + 1;
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
 	}
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
 done:
 	mutex_unlock(&coresight_mutex);
 	return name;
-- 
2.39.0

