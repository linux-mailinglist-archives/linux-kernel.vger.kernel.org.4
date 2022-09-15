Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D25BA211
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIOU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOU4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:56:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A65B055;
        Thu, 15 Sep 2022 13:56:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FKMPQl016257;
        Thu, 15 Sep 2022 20:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+UOAMghdpyfQ0/bbz3voyO2a5SrI9Bp/JBVPB4M/43M=;
 b=kyDFM/jO5fQPr9U7BZWY8nvFJN2kxBAZYGOSJekjV1qdsiy1easyR1eDX6hsJYvznaRf
 bHDj38/RuojRWGSrLD1/iZmV5kxcMscmpQJ9WrdidCWclVtAuO73U0jTkg+CwRP7LYD9
 ouL3Qmcw3yOqNhyCheitGOHSFPWD8LQpckePO3YjBIP3zMc9lXJ/CoxYpbiGZCvxUw3G
 zvelPYyKtBHlGAb4xGZyGvPBCfs+0rVi01CBOPfD3czoq+N3FlWuWbeD6zcPvh/AAN/l
 UDpLCLWC3AUSbYS9XvjfeoDqg0odW2Dz8XQqsk8/AU/zggymRhpcOOFF+j2gN4XsN8Cv yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm950rgd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 20:56:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FKu7MX013779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 20:56:07 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 13:56:05 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] soc: qcom: rpmhpd: Use highest corner until sync_state
Date:   Thu, 15 Sep 2022 13:55:59 -0700
Message-ID: <20220915205559.14574-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jabfq9WxPO01X0iJR_C5tera4zgRhZAY
X-Proofpoint-ORIG-GUID: Jabfq9WxPO01X0iJR_C5tera4zgRhZAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209150130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

In some cases the hardware that the bootloader has left configured
depends on RPMH power domains for their operation up until the point
where the related Linux device driver probes and can inherit that
configuration, or power down the hardware gracefully.

Unfortunately as Linux probes the releavant drivers in sequence there
are periods during the Linux boot flow where either the genpd refcount
will reach 0, or worse where the active performance_state votes does not
meet the requirements of the state that the hardware was left in.

One specific example of this is during boot of e.g. SM8150/SC8180X,
where the display clock controller probes, without any particular
performance state needs (to access its registers). This will drop the
MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
that the later probing MDP is configured to. This results in an
unrecoverable system state.

Handle both these cases by keeping the RPMH power-domais that are
referenced voted for highest state, until sync_state indicates that all
devices referencing the RPMH power-domain driver has been probed.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[bjorn: Added print for sync_state errors]
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 092f6ab09acf..5f9b71588eda 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -39,6 +39,7 @@
  * @res_name:		Resource name used for cmd-db lookup
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
+ * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -54,6 +55,7 @@ struct rpmhpd {
 	bool		enabled;
 	const char	*res_name;
 	u32		addr;
+	bool		state_synced;
 };
 
 struct rpmhpd_desc {
@@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
 
-	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
+	if (pd->state_synced) {
+		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
+	} else {
+		/* Clamp to highest corner if sync_state hasn't happened */
+		this_active_corner = pd->level_count - 1;
+		this_sleep_corner = pd->level_count - 1;
+	}
 
 	if (peer && peer->enabled)
 		to_active_sleep(peer, peer->corner, &peer_active_corner,
@@ -708,11 +716,40 @@ static int rpmhpd_probe(struct platform_device *pdev)
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
 }
 
+static void rpmhpd_sync_state(struct device *dev)
+{
+	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
+	struct rpmhpd **rpmhpds = desc->rpmhpds;
+	unsigned int corner;
+	struct rpmhpd *pd;
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&rpmhpd_lock);
+	for (i = 0; i < desc->num_pds; i++) {
+		pd = rpmhpds[i];
+		if (!pd)
+			continue;
+
+		pd->state_synced = true;
+		if (pd->enabled)
+			corner = max(pd->corner, pd->enable_corner);
+		else
+			corner = 0;
+
+		ret = rpmhpd_aggregate_corner(pd, corner);
+		if (ret)
+			dev_err(dev, "failed to sync %s\n", pd->res_name);
+	}
+	mutex_unlock(&rpmhpd_lock);
+}
+
 static struct platform_driver rpmhpd_driver = {
 	.driver = {
 		.name = "qcom-rpmhpd",
 		.of_match_table = rpmhpd_match_table,
 		.suppress_bind_attrs = true,
+		.sync_state = rpmhpd_sync_state,
 	},
 	.probe = rpmhpd_probe,
 };
-- 
2.17.1

