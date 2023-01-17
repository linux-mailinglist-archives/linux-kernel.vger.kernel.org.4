Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC1666E178
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjAQO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAQO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:57:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9A359D;
        Tue, 17 Jan 2023 06:57:37 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEgI6O011831;
        Tue, 17 Jan 2023 14:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=V/bptrVcXVHFSDujslPeTwO4nzZz362HA58mkxTRXeE=;
 b=QPxtz+0NHNgFD3bxUYZ0FoBjnixlvZt+TOyaEkisYl6lnDPOPBdbEz233+kDehKXkS4I
 oit/tX8pe1TlUoc+XIOWol5ZqTwR6fVKZBJ2usUzbfBjnEcPKFgfoaH59bOQFW1KV+Y5
 q9AaLswyeV6ZcHdy/b4USNbqDnULrPpZj6+TpdQaL5HVQGMVH86yPEaulaPVeuJ3cdqf
 c9VqZmYAwnOIM4LTPXHQbJoALXHtMgD5lNR8pneIye//CO+E77KVdjpdIypQbz90Bj5g
 jPUB1wXuSdG1xhEK6Msm0QUb/cnVI+Kjk3AzvOB0GJXJj1dAJZCNsoO9PhzoxFx9RJAx sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nnrkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HEvKE4014581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 14:57:20 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 06:57:20 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v17 1/9] coresight: core: Use IDR for non-cpu bound sources' paths.
Date:   Tue, 17 Jan 2023 06:57:00 -0800
Message-ID: <20230117145708.16739-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WIAqCupJtgdOLOt-SA_5LD9bo6doiAf5
X-Proofpoint-ORIG-GUID: WIAqCupJtgdOLOt-SA_5LD9bo6doiAf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=925 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170121
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
index ce3aa845ecc2..5eb013f49a0d 100644
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
@@ -26,6 +27,13 @@
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
@@ -42,14 +50,6 @@ struct coresight_node {
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
@@ -1075,6 +1075,7 @@ int coresight_enable(struct coresight_device *csdev)
 	struct coresight_device *sink;
 	struct list_head *path;
 	enum coresight_dev_subtype_source subtype;
+	u32 hash;
 
 	subtype = csdev->subtype.source_subtype;
 
@@ -1129,7 +1130,14 @@ int coresight_enable(struct coresight_device *csdev)
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
@@ -1153,6 +1161,7 @@ void coresight_disable(struct coresight_device *csdev)
 {
 	int cpu, ret;
 	struct list_head *path = NULL;
+	u32 hash;
 
 	mutex_lock(&coresight_mutex);
 
@@ -1170,14 +1179,20 @@ void coresight_disable(struct coresight_device *csdev)
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
2.39.0

