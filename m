Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657966282F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKNOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiKNOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:41:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4823B2C139;
        Mon, 14 Nov 2022 06:41:15 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEW1hj002034;
        Mon, 14 Nov 2022 14:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8t3Pf/NQ7jw7ilzTMw4nTYP73OJ+qCrhGikkz2+HR6A=;
 b=Iw0EEdz5iFaG/ni1zKeswdO6NzYBnHBNe/nxdirn+QPOucF3k1MzcfL2f4rslzhb/ojt
 ocToIhXFSJo8MuVUnMcuEW/zLykTslaqwqOR4/1vcXaGhbcoBPs27E6eanLDJy4Nf90n
 hveeBYnO5RZ4tM4EDXLxFB3+EOcMN4welDLJfo55JJFnzEnet39kNBcNg3uCm5dTGvFA
 TqkHWGhNH1MNQTwlvgue1GIWEKcba6nFP00Pwcti5WVv0tyadBx7bCK+ptJlVy+yqQSL
 /PNHd7pfg2G2V4dtHU+AN0joMoa2nEEPNru9GrwrYW/PscGONUVkJ0mzx/djNeMfFd/4 dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kugs40v2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:41:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEEerOx006602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:40:53 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 06:40:49 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v15 1/8] coresight: core: Use IDR for non-cpu bound sources' paths.
Date:   Mon, 14 Nov 2022 22:40:20 +0800
Message-ID: <20221114144027.14365-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
References: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: adHhjsy5sd8JB35R1EmyMVzKT0X5MsOd
X-Proofpoint-GUID: adHhjsy5sd8JB35R1EmyMVzKT0X5MsOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=868 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except stm, there could be other sources which are not associated
with cpus. Use IDR to store and search these sources' paths.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 45828564f0c8..1fee4cc2a77b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -27,6 +28,13 @@
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
+/*
+ * Use IDR to map the hash of the source's device name
+ * to the pointer of path for the source. The idr is for
+ * the sources which aren't associated with CPU.
+ */
+static DEFINE_IDR(path_idr);
+
 /**
  * struct coresight_node - elements of a path, from source to sink
  * @csdev:	Address of an element.
@@ -43,14 +51,6 @@ struct coresight_node {
  */
 static DEFINE_PER_CPU(struct list_head *, tracer_path);
 
-/*
- * As of this writing only a single STM can be found in CS topologies.  Since
- * there is no way to know if we'll ever see more and what kind of
- * configuration they will enact, for the time being only define a single path
- * for STM.
- */
-static struct list_head *stm_path;
-
 /*
  * When losing synchronisation a new barrier packet needs to be inserted at the
  * beginning of the data collected in a buffer.  That way the decoder knows that
@@ -1076,6 +1076,7 @@ int coresight_enable(struct coresight_device *csdev)
 	struct coresight_device *sink;
 	struct list_head *path;
 	enum coresight_dev_subtype_source subtype;
+	u32 hash;
 
 	subtype = csdev->subtype.source_subtype;
 
@@ -1130,7 +1131,14 @@ int coresight_enable(struct coresight_device *csdev)
 		per_cpu(tracer_path, cpu) = path;
 		break;
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		stm_path = path;
+		/*
+		 * Use the hash of source's device name as ID
+		 * and map the ID to the pointer of the path.
+		 */
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+		ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
+		if (ret)
+			goto err_source;
 		break;
 	default:
 		/* We can't be here */
@@ -1154,6 +1162,7 @@ void coresight_disable(struct coresight_device *csdev)
 {
 	int cpu, ret;
 	struct list_head *path = NULL;
+	u32 hash;
 
 	mutex_lock(&coresight_mutex);
 
@@ -1171,14 +1180,20 @@ void coresight_disable(struct coresight_device *csdev)
 		per_cpu(tracer_path, cpu) = NULL;
 		break;
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		path = stm_path;
-		stm_path = NULL;
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+		/* Find the path by the hash. */
+		path = idr_find(&path_idr, hash);
+		if (path == NULL) {
+			pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
+			goto out;
+		}
 		break;
 	default:
 		/* We can't be here */
 		break;
 	}
 
+	idr_remove(&path_idr, hash);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
-- 
2.17.1

