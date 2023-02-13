Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6F694BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjBMPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBMPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888D1C591;
        Mon, 13 Feb 2023 07:52:26 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8sLlp004336;
        Mon, 13 Feb 2023 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Yk4/9Stqk2Nvc63W1alP8zmhfZi7dnK3DenDIixDrCI=;
 b=CLlDS0NB/1WuU8WelbxL7IA1RMYAXOkJjD8oBiig1aXjimLZPqSzn1KKy2rxjKub5KgL
 ecykt+rqCIRS/snA7YhB7skgcNfzkk3qyEVpylrni50CWqAA6WkvlaktomCJgLbTr+pQ
 mOe9s5ji69E8qbU69C0XossfrBjY/gHrrffEClckwY0ruMRRIJu0M3omuGnvMgHyWvEl
 vESjpKZBArfeXLfVYpau/elHPXXYym99jNW1nNvlMpVms0VdJYO0RHsVdNzHhhqmBAjg
 3IOmkXICFyWdsoeLDpI0MqW0MEg/TrhGAmd3prpHUvLoL4FtI3P5NsicYaS6+qpbv60X nA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3npmvrk537-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqMID001588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 07:52:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] rpmsg: glink: rpm: Wrap driver context
Date:   Mon, 13 Feb 2023 07:52:12 -0800
Message-ID: <20230213155215.1237059-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Il2GrQG0dNN7KmWCSmWtJXr_coETl00Z
X-Proofpoint-GUID: Il2GrQG0dNN7KmWCSmWtJXr_coETl00Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with the SMEM driver update, wrap the RPM context in a struct to
facilitate the upcoming changes of moving IRQ and mailbox registration
to the driver.

Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

 drivers/rpmsg/qcom_glink_rpm.c | 44 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index f64f45d1a735..6443843df6ca 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -53,6 +53,13 @@ struct glink_rpm_pipe {
 	void __iomem *fifo;
 };
 
+struct glink_rpm {
+	struct qcom_glink *glink;
+
+	struct glink_rpm_pipe rx_pipe;
+	struct glink_rpm_pipe tx_pipe;
+};
+
 static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
 {
 	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
@@ -257,8 +264,7 @@ static int glink_rpm_parse_toc(struct device *dev,
 static int glink_rpm_probe(struct platform_device *pdev)
 {
 	struct qcom_glink *glink;
-	struct glink_rpm_pipe *rx_pipe;
-	struct glink_rpm_pipe *tx_pipe;
+	struct glink_rpm *rpm;
 	struct device_node *np;
 	void __iomem *msg_ram;
 	size_t msg_ram_size;
@@ -266,9 +272,8 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	struct resource r;
 	int ret;
 
-	rx_pipe = devm_kzalloc(&pdev->dev, sizeof(*rx_pipe), GFP_KERNEL);
-	tx_pipe = devm_kzalloc(&pdev->dev, sizeof(*tx_pipe), GFP_KERNEL);
-	if (!rx_pipe || !tx_pipe)
+	rpm = devm_kzalloc(&pdev->dev, sizeof(*rpm), GFP_KERNEL);
+	if (!rpm)
 		return -ENOMEM;
 
 	np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", 0);
@@ -283,36 +288,39 @@ static int glink_rpm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = glink_rpm_parse_toc(dev, msg_ram, msg_ram_size,
-				  rx_pipe, tx_pipe);
+				  &rpm->rx_pipe, &rpm->tx_pipe);
 	if (ret)
 		return ret;
 
 	/* Pipe specific accessors */
-	rx_pipe->native.avail = glink_rpm_rx_avail;
-	rx_pipe->native.peak = glink_rpm_rx_peak;
-	rx_pipe->native.advance = glink_rpm_rx_advance;
-	tx_pipe->native.avail = glink_rpm_tx_avail;
-	tx_pipe->native.write = glink_rpm_tx_write;
+	rpm->rx_pipe.native.avail = glink_rpm_rx_avail;
+	rpm->rx_pipe.native.peak = glink_rpm_rx_peak;
+	rpm->rx_pipe.native.advance = glink_rpm_rx_advance;
+	rpm->tx_pipe.native.avail = glink_rpm_tx_avail;
+	rpm->tx_pipe.native.write = glink_rpm_tx_write;
 
-	writel(0, tx_pipe->head);
-	writel(0, rx_pipe->tail);
+	writel(0, rpm->tx_pipe.head);
+	writel(0, rpm->rx_pipe.tail);
 
-	glink = qcom_glink_native_probe(&pdev->dev,
+	glink = qcom_glink_native_probe(dev,
 					0,
-					&rx_pipe->native,
-					&tx_pipe->native,
+					&rpm->rx_pipe.native,
+					&rpm->tx_pipe.native,
 					true);
 	if (IS_ERR(glink))
 		return PTR_ERR(glink);
 
-	platform_set_drvdata(pdev, glink);
+	rpm->glink = glink;
+
+	platform_set_drvdata(pdev, rpm);
 
 	return 0;
 }
 
 static int glink_rpm_remove(struct platform_device *pdev)
 {
-	struct qcom_glink *glink = platform_get_drvdata(pdev);
+	struct glink_rpm *rpm = platform_get_drvdata(pdev);
+	struct qcom_glink *glink = rpm->glink;
 
 	qcom_glink_native_remove(glink);
 
-- 
2.25.1

