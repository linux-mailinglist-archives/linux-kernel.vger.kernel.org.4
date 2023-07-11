Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2374F00F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGKNZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGKNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:25:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60118D;
        Tue, 11 Jul 2023 06:25:30 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BC933w015239;
        Tue, 11 Jul 2023 14:33:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=bZyrpsmbqDtckH2IvHk4LGejHt9ZGYj7tCxIp9TuL2s=;
 b=kxFrX+yubZp6WwlU9HtqXxBhiAtD9mJ2YofZRBbaQAfC1yiILOEzG/VKb3mN6p0Ez1GG
 Q/gyGiukohOfXqDgf5SfMh+IMhOXEGSZDnLPtxTKHlg32GU6RWLhnKYrJSvf/OBff9/8
 AaH5a4dMVCtU7oWpDLjLXXHJ+ZfvYgEP6+7xEythRVccCLC7Y8SDiPLJwGyoNQiUJGmN
 LG8gpJ0yrpmHda7/NRP3KD232dsbIoV3Mcq4R3VitiaUeF1ueCr4rEX/dR13yg7v5sC8
 5Jc0lFvEqGiMNgg6wcZ3hYffzHlQiW4377nGA+HhhIfeGV1PFFeGAjJ+ZzMCIWACfplV 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs6u684x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:33:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21ECA100058;
        Tue, 11 Jul 2023 14:33:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B936222CB6;
        Tue, 11 Jul 2023 14:33:09 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 14:33:09 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <alain.volmat@foss.st.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] media: i2c: st_mipid02: cascade s_stream call to the source subdev
Date:   Tue, 11 Jul 2023 14:32:09 +0200
Message-ID: <20230711123211.794838-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711123211.794838-1-alain.volmat@foss.st.com>
References: <20230711123211.794838-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cascade the s_stream call to the source subdev whenever the bridge
streaming is enable / disabled.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 906553a28676..703d2f06f552 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -547,6 +547,13 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
 	struct i2c_client *client = bridge->i2c_client;
 	int ret;
 
+	if (!bridge->s_subdev)
+		goto error;
+
+	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
+	if (ret)
+		goto error;
+
 	/* Disable all lanes */
 	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
 	if (ret)
@@ -633,6 +640,10 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
 	if (ret)
 		goto error;
 
+	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 1);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
-- 
2.25.1

