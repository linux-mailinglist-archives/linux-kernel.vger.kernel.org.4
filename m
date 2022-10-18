Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F26034A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJRVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:11:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF317C187;
        Tue, 18 Oct 2022 14:11:03 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IF1CoE032457;
        Tue, 18 Oct 2022 21:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ySjEjvEXrKYOOY4ZOLI6Kl+I/1O7wWTHGGDSSI9z5+k=;
 b=cWo8RfJ2V5rRSBzQ2bK+LUWxWl0AIE1F6wjqbLajUe84M0guh3cdvsAqNcVFBfWtipRE
 nheYdEQaiyP8SY7p2Y+MLOymcniFs95su08d38iUeyB4GcTJqfs6bF9wxhmsI26YmxT4
 ySKnSqU81jUpF1nbNhOFp27Drxmi89jQfoOhQ4PW0TPad3nvm0Jfy5ojW5ece096GeOO
 JFi2FHCl76ISsvEvVZ2M2VGzJFjLVTLpNmmZxgT6Fsu9qweoxyFWoEo2a2V3nhZrOn0h
 tymIZB8r8L2AnLD7C3N4rrEK6+qYrr5fsQbbnlEbeNe7my7Barn2V+EiEcmvDQNduf5L YA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9bjvc846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:10:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ILAuG9014352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:10:56 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 14:10:55 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 1/1] drivers: remoteproc: Add bus scaling capability during bootup
Date:   Tue, 18 Oct 2022 14:10:46 -0700
Message-ID: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eubTSObGh5LMd3P9HH9yQRNk2PXIjBP4
X-Proofpoint-ORIG-GUID: eubTSObGh5LMd3P9HH9yQRNk2PXIjBP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup since remote processors cannot request for
additional bus bandwidth from the interconect framework,
platform driver should provide the proxy resources. Make
a proxy vote for maximizing the bus bandwidth during bootup
for a remote processor and remove it once processor is up.

Change-Id: I798b3b000aef4761a7ff8cb6390b7ecd98f925b7
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 106 ++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd094..b02a1dc 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -21,6 +21,7 @@
 #include <linux/qcom_scm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
+#include <linux/interconnect.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
@@ -30,8 +31,14 @@
 #include "qcom_q6v5.h"
 #include "remoteproc_internal.h"
 
+#define PIL_TZ_AVG_BW	UINT_MAX
+#define PIL_TZ_PEAK_BW	UINT_MAX
 #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
 
+static struct icc_path *scm_perf_client;
+static int scm_pas_bw_count;
+static DEFINE_MUTEX(scm_pas_bw_mutex);
+
 struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -67,6 +74,7 @@ struct qcom_adsp {
 
 	int pas_id;
 	unsigned int minidump_id;
+	struct icc_path *bus_client;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
 	bool decrypt_shutdown;
@@ -136,6 +144,44 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
 	}
 }
 
+static int scm_pas_enable_bw(void)
+{
+	int ret = 0;
+
+	if (IS_ERR(scm_perf_client))
+		return -EINVAL;
+
+	mutex_lock(&scm_pas_bw_mutex);
+	if (!scm_pas_bw_count) {
+		ret = icc_set_bw(scm_perf_client, PIL_TZ_AVG_BW,
+						PIL_TZ_PEAK_BW);
+		if (ret)
+			goto err_bus;
+	}
+
+	scm_pas_bw_count++;
+	mutex_unlock(&scm_pas_bw_mutex);
+	return ret;
+
+err_bus:
+	pr_err("scm-pas: Bandwidth request failed (%d)\n", ret);
+	icc_set_bw(scm_perf_client, 0, 0);
+
+	mutex_unlock(&scm_pas_bw_mutex);
+	return ret;
+}
+
+static void scm_pas_disable_bw(void)
+{
+	if (IS_ERR(scm_perf_client))
+		return;
+
+	mutex_lock(&scm_pas_bw_mutex);
+	if (scm_pas_bw_count-- == 1)
+		icc_set_bw(scm_perf_client, 0, 0);
+	mutex_unlock(&scm_pas_bw_mutex);
+}
+
 static int adsp_shutdown_poll_decrypt(struct qcom_adsp *adsp)
 {
 	unsigned int retry_num = 50;
@@ -174,15 +220,35 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	if (ret)
 		return ret;
 
+	scm_pas_enable_bw();
 	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, adsp->pas_id,
 				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
 				    &adsp->mem_reloc);
 	if (ret)
-		return ret;
+		goto exit;
 
 	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
+exit:
+	scm_pas_disable_bw();
+	return ret;
+}
 
-	return 0;
+static int do_bus_scaling(struct qcom_adsp *adsp, bool enable)
+{
+	int rc = 0;
+	u32 avg_bw = enable ? PIL_TZ_AVG_BW : 0;
+	u32 peak_bw = enable ? PIL_TZ_PEAK_BW : 0;
+
+	if (IS_ERR(adsp->bus_client))
+		dev_err(adsp->dev, "Bus scaling not setup for %s\n",
+			adsp->rproc->name);
+	else
+		rc = icc_set_bw(adsp->bus_client, avg_bw, peak_bw);
+
+	if (rc)
+		dev_err(adsp->dev, "bandwidth request failed(rc:%d)\n", rc);
+
+	return rc;
 }
 
 static int adsp_start(struct rproc *rproc)
@@ -194,10 +260,14 @@ static int adsp_start(struct rproc *rproc)
 	if (ret)
 		return ret;
 
-	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+	ret = do_bus_scaling(adsp, true);
 	if (ret < 0)
 		goto disable_irqs;
 
+	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+	if (ret < 0)
+		goto unscale_bus;
+
 	ret = clk_prepare_enable(adsp->xo);
 	if (ret)
 		goto disable_proxy_pds;
@@ -218,6 +288,8 @@ static int adsp_start(struct rproc *rproc)
 			goto disable_cx_supply;
 	}
 
+	scm_pas_enable_bw();
+
 	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
 	if (ret) {
 		dev_err(adsp->dev,
@@ -234,9 +306,10 @@ static int adsp_start(struct rproc *rproc)
 
 	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
 
-	return 0;
-
 disable_px_supply:
+	scm_pas_disable_bw();
+	if(!ret)
+		goto exit;
 	if (adsp->px_supply)
 		regulator_disable(adsp->px_supply);
 disable_cx_supply:
@@ -248,9 +321,11 @@ static int adsp_start(struct rproc *rproc)
 	clk_disable_unprepare(adsp->xo);
 disable_proxy_pds:
 	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+unscale_bus:
+	do_bus_scaling(adsp, false);
 disable_irqs:
 	qcom_q6v5_unprepare(&adsp->q6v5);
-
+exit:
 	return ret;
 }
 
@@ -265,6 +340,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
 	clk_disable_unprepare(adsp->aggre2_clk);
 	clk_disable_unprepare(adsp->xo);
 	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+	do_bus_scaling(adsp, false);
 }
 
 static int adsp_stop(struct rproc *rproc)
@@ -383,6 +459,22 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
 	return 0;
 }
 
+static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
+{
+	if (scm_perf_client)
+		goto get_rproc_client;
+
+	scm_perf_client = of_icc_get(adsp->dev, "crypto_ddr");
+	if (IS_ERR(scm_perf_client))
+		dev_warn(adsp->dev, "Crypto scaling not setup\n");
+
+get_rproc_client:
+	adsp->bus_client = of_icc_get(adsp->dev, "rproc_ddr");
+	if (IS_ERR(adsp->bus_client))
+		dev_warn(adsp->dev, "%s: No bus client\n", __func__);
+
+}
+
 static int adsp_pds_attach(struct device *dev, struct device **devs,
 			   char **pd_names)
 {
@@ -525,6 +617,8 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	adsp_init_bus_scaling(adsp);
+
 	ret = adsp_pds_attach(&pdev->dev, adsp->proxy_pds,
 			      desc->proxy_pd_names);
 	if (ret < 0)
-- 
2.7.4

