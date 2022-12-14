Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85064CB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiLNNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiLNNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:36:36 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5832613B;
        Wed, 14 Dec 2022 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671024996; x=1702560996;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=zsIf6fMmGrA6HPgd11/NKhffPf9edGm/f/8PsrgH+Fo=;
  b=JcWpmKa+0jzmv2P5MU1vp7XUsintz6aGs/onVIiyCLqDPTd0k88kN3cS
   JRTqzehGJ3niR9M8DEn0i26s03I/MPt+RQeehPDHnf0GuZxgNN/jEhnrM
   vs2Gz7B8XpDYY9uXWSpt7bhxTxTOIGowzI8ChAP61b/VCw6EtIiRw81zF
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Dec 2022 05:36:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 05:36:36 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 05:36:33 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] remoteproc: qcom: pas: Fix subdevice add order
Date:   Wed, 14 Dec 2022 19:06:23 +0530
Message-ID: <1671024983-22634-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the notification like QCOM_SSR_BEFORE_SHUTDOWN is not exactly
sent before starting shutdown activity on remote subsystem but it is
getting sent after sysmon shutdown request to remote.

On getting QCOM_SSR_BEFORE_SHUTDOWN, some client want remote subsystem
to be alive to communicate but as sysmon shutdown request is getting
sent to remote before QCOM_SSR_BEFORE_SHUTDOWN notification sent to
kernel client due to which remote is not in a condition to communicate
with kernel clients.

Fixing the subdevice ordering will fix this as ssr subdevice will be
first one to get triggered in shutdown/stop path.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd094..5e34d59 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -538,7 +538,6 @@ static int adsp_probe(struct platform_device *pdev)
 
 	qcom_add_glink_subdev(rproc, &adsp->glink_subdev, desc->ssr_name);
 	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
-	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
 	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
 					      desc->sysmon_name,
 					      desc->ssctl_id);
@@ -547,6 +546,7 @@ static int adsp_probe(struct platform_device *pdev)
 		goto detach_proxy_pds;
 	}
 
+	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
 	ret = rproc_add(rproc);
 	if (ret)
 		goto detach_proxy_pds;
-- 
2.7.4

