Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D94615F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKBJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiKBJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645065A4;
        Wed,  2 Nov 2022 02:20:08 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A29990c030472;
        Wed, 2 Nov 2022 09:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8t3Pf/NQ7jw7ilzTMw4nTYP73OJ+qCrhGikkz2+HR6A=;
 b=C6+p5PIFY+i6Q4OAnm7Fi6ocaD4I46DrD5ItQKF4tWE54LewFTPzksSDtuyweLuAjMzf
 +fT59nKhUPEhp4te1Djko9Yn2DibRd73D7OCkQIrUj+VNC5k6wIgd+MjyMlZkXP4nxG0
 Vm6r7u/nE8aFvFzRZX77gNym/Icm7RWazFehiiVfTgSlTq3Z0azR2JYVFK67cfFeeXtm
 ojq652u+nZl6uGTD7yybs5v69y/WswYE2+2jFN1mQGYnasNmxqGzipC9cGe7uZy69An0
 GAS9VFHTwsBgXTOjaaIoWd/8GigxSi0RW1A8wKpYer5cLuMu/zZSUD04h0Z1ob7tm8Ap Gg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj7u8fpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:19:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29JeYu018375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:19:40 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 02:19:36 -0700
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
Subject: [PATCH v14 1/9] coresight: core: Use IDR for non-cpu bound sources' paths.
Date:   Wed, 2 Nov 2022 17:19:07 +0800
Message-ID: <20221102091915.15281-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
References: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EjH95YWcd-k7FkIDwcJEU09It8GgCZLz
X-Proofpoint-GUID: EjH95YWcd-k7FkIDwcJEU09It8GgCZLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=858 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020055
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

