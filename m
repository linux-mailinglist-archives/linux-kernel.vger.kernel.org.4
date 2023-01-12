Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1E666B99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjALHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjALHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:31:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4823D;
        Wed, 11 Jan 2023 23:31:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C77KTV011184;
        Thu, 12 Jan 2023 07:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JxSLuuwJdixLMUVDdjnyixo00L0lkVae3W4i6JzZ1xs=;
 b=d/LsU2Igs3TZy/cXwy5isBSis/by9EqmkrtCNP3s+4rkmJl7zL/z5NnHo26OVw/YbuhS
 pOZuCnotWtOdfOQ3HiZjvxzyhJ6lXCJSaFk+PqViTKlZgF3CB5ip0VUQmXeDqWYI3789
 D0IS7ri6I4jxyfG1790VA5BfWqlsHu/ZXwCLpTJDJ6sDGYDm14ub67fnrzKdqdkDg8u0
 SKESylFV9xiUZE4BgmMJm4W6y3h1tgQhE5dg1IcKVGdU4t0MkkTc2FzhKCdRQc+1TyzI
 bVcfnxBmIG1pfLe3UTuEKrVBW40Yc43L4pe7fkllemIf6oKyTMekJYZUnYxpNp6k2K8Y 2A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k5k37sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 07:30:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C7UXoN023815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 07:30:33 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 23:30:28 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] ASoC: qdsp6: audioreach: Add ADSP ready check
Date:   Thu, 12 Jan 2023 13:00:17 +0530
Message-ID: <1673508617-27410-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: elNRcLsPaMwYRWWPSUwy8R_nOuDkGfj2
X-Proofpoint-GUID: elNRcLsPaMwYRWWPSUwy8R_nOuDkGfj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for SPF readiness in prm driver probe to avoid race conditions
during ADSP pil loading.
This patch is to avoid, sending requests to ADSP before it's
power domains are up and ready.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Ratna Deepthi Kudaravalli <rkudarav@qti.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 13 +++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h |  2 ++
 sound/soc/qcom/qdsp6/q6prm.c |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 5beb898..8a7dfd2 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -27,6 +27,8 @@ struct apm_graph_mgmt_cmd {
 
 #define APM_GRAPH_MGMT_PSIZE(p, n) ALIGN(struct_size(p, sub_graph_id_list, n), 8)
 
+struct q6apm *g_apm;
+
 int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
 	gpr_device_t *gdev = apm->gdev;
@@ -143,6 +145,15 @@ static void q6apm_put_audioreach_graph(struct kref *ref)
 	kfree(graph);
 }
 
+bool q6apm_is_adsp_ready(void)
+{
+	if (g_apm && g_apm->state)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(q6apm_is_adsp_ready);
+
 static int q6apm_get_apm_state(struct q6apm *apm)
 {
 	struct gpr_pkt *pkt;
@@ -658,6 +669,8 @@ static int apm_probe(gpr_device_t *gdev)
 
 	idr_init(&apm->modules_idr);
 
+	g_apm = apm;
+
 	q6apm_get_apm_state(apm);
 
 	ret = devm_snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 273f978..7005be9 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -145,4 +145,6 @@ struct audioreach_module *q6apm_find_module_by_mid(struct q6apm_graph *graph,
 void q6apm_set_fe_dai_ops(struct snd_soc_dai_driver *dai_drv);
 int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
+bool q6apm_is_adsp_ready(void);
+
 #endif /* __APM_GRAPH_ */
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 8aa1a21..3aa63aa 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -12,6 +12,7 @@
 #include <linux/soc/qcom/apr.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include "q6apm.h"
 #include "q6prm.h"
 #include "audioreach.h"
 
@@ -226,6 +227,9 @@ static int prm_probe(gpr_device_t *gdev)
 	init_waitqueue_head(&cc->wait);
 	dev_set_drvdata(dev, cc);
 
+	if (!q6apm_is_adsp_ready())
+		return -EPROBE_DEFER;
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.7.4

