Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F4616A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKBRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKBRMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:12:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F221707A;
        Wed,  2 Nov 2022 10:12:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2Gk4S3026130;
        Wed, 2 Nov 2022 17:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kztBA4QgpFO/OFQcyw3N+l1k3F3fC0peD9KXSrCAEAc=;
 b=L3Z6ka0kxQndRgy4suU1p0Zlio6jddaHmc+LUTv+CcBRmLp+5wKjDQYi/IaGnclnqVdT
 /us8utMuuUCGrRMzMAC2dx9IGN5pAxNN3BONA/vtgqmlmXXkFFrASdCVDkvu1epMtSHm
 5niLvPiV7pQ/ND596yw0wIrNNMpTQu5HUkj9FQM9l/beS5URWvnf9m86aM02brHDeiDg
 Yn5uXtL6nGbPzUQZghzgIUcNTN+g/5s+Ip9UVnF8QGGgQ7jYwzXrJUZSSFZGBi5Re/C5
 dVGM672f92u3Yhbx57qHsdyexDx3DvjEq5CT21MpPqorCcXvExGO031DC9imE+Yw8eQD uA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkvbg84ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 17:12:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2HCJlj029459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 17:12:19 GMT
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 10:12:16 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [PATCH V3] remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
Date:   Wed, 2 Nov 2022 22:42:09 +0530
Message-ID: <1667409129-6254-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fl_d_oZe-8U5zlScz1bQwcGBKxeP-2M_
X-Proofpoint-ORIG-GUID: fl_d_oZe-8U5zlScz1bQwcGBKxeP-2M_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minidump table in the toc contains physical addresses that may lie
before the physical address of the first elf segment in relocatable
images. This change adds a custom dump function for minidumps which
calculates the offset into the carveout region using the start of
the physical address instead of the start of the first elf segment.

Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_common.c   | 13 +++++++++----
 drivers/remoteproc/qcom_common.h   |  5 ++++-
 drivers/remoteproc/qcom_q6v5_pas.c | 20 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c..db8d72e 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -101,7 +101,9 @@ static void qcom_minidump_cleanup(struct rproc *rproc)
 	}
 }
 
-static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem)
+static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
+			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
+				void *dest, size_t offset, size_t size))
 {
 	struct minidump_region __iomem *ptr;
 	struct minidump_region region;
@@ -131,7 +133,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 			}
 			da = le64_to_cpu(region.address);
 			size = le32_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
+			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
 		}
 	}
 
@@ -139,7 +141,10 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 	return 0;
 }
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
 {
 	int ret;
 	struct minidump_subsystem *subsystem;
@@ -169,7 +174,7 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
 		return;
 	}
 
-	ret = qcom_add_minidump_segments(rproc, subsystem);
+	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
 		goto clean_minidump;
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index c35adf7..c3cc619 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -33,7 +33,10 @@ struct qcom_rproc_ssr {
 	struct qcom_ssr_subsystem *info;
 };
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+			void (*rproc_dumpfn_t)(struct rproc *rproc,
+				struct rproc_dump_segment *segment, void *dest, size_t offset,
+				size_t size));
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 			   const char *ssr_name);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 401b1ec..785e2d1 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -83,11 +83,29 @@ struct qcom_adsp {
 	struct qcom_sysmon *sysmon;
 };
 
+void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
+						void *dest, size_t offset, size_t size)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+	int total_offset;
+
+	total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
+	if (total_offset < 0 || total_offset + size > adsp->mem_size) {
+		dev_err(adsp->dev,
+			"invalid copy request for segment %pad with offset %zu and size %zu)\n",
+			&segment->da, offset, size);
+		memset(dest, 0xff, size);
+		return;
+	}
+
+	memcpy_fromio(dest, adsp->mem_region + total_offset, size);
+}
+
 static void adsp_minidump(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = rproc->priv;
 
-	qcom_minidump(rproc, adsp->minidump_id);
+	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
 }
 
 static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
-- 
2.7.4

