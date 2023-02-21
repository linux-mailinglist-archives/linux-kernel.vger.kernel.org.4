Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6635969E429
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjBUQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBUQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:04:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD310CA;
        Tue, 21 Feb 2023 08:04:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCaZfZ005726;
        Tue, 21 Feb 2023 16:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A0o0w2xE/qIQa6iSBQ3a3l0c352Skcgzo9QWGOcAbAs=;
 b=D9R7nJA948O/a4fgXy8YatHTnTWyF78gnoilg7CdSSbo5Bg0IOwgBwUxEyTNyzFizIX/
 b+0No+nPjBBFUumlpFF2NSubIggTOJmYg23Yz8YNSdYHyaH4sH/IZTsrjpQpExA3PbMW
 +cADEl99OgxNqzgSDZWxqbN2lhVHMKNxyXQ0Vz29Xzqw97lZQf2OTYkDIohfo6ccTnsA
 6T+UkE8ym48p2IbRXWBKp6ydyqHZPKlFALsOxpEQim1ie5F0Cb7Yr6NvrhNlOYnK6Jn4
 hP45LVaqsfmqq1MtOSsfNFVXKqN14QF738kUyT9M+mR/fhDzJWOe4H+NqE9uoGk4HO+J 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvw4s0jtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:04:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LG4OM9004720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:04:25 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 08:04:21 -0800
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH V5 1/3] rpmsg: core: Add signal API support
Date:   Tue, 21 Feb 2023 21:33:35 +0530
Message-ID: <1676995418-19358-2-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
References: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EfLmF6YyAgpbqmUdqLU9tntDS6z_h0ea
X-Proofpoint-ORIG-GUID: EfLmF6YyAgpbqmUdqLU9tntDS6z_h0ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210134
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some transports like Glink support the state notifications between
clients using flow control signals similar to serial protocol signals.
Local glink client drivers can send and receive flow control status
to glink clients running on remote processors.

Add APIs to support sending and receiving of flow control status by
rpmsg clients.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
---
 drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index d6dde00e..e96967a 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
 /**
+ * rpmsg_set_flow_control() - sets/clears serial flow control signals
+ * @ept:	the rpmsg endpoint
+ * @enable:	pause/resume incoming data flow
+ *
+ * Return: 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->set_flow_control)
+		return -ENXIO;
+
+	return ept->ops->set_flow_control(ept, enable);
+}
+EXPORT_SYMBOL(rpmsg_set_flow_control);
+
+/**
  * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
  * @ept: the rpmsg endpoint
  *
@@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
 
 		rpdev->ept = ept;
 		rpdev->src = ept->addr;
+
+		ept->flow_cb = rpdrv->flowcontrol;
 	}
 
 	err = rpdrv->probe(rpdev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 39b646d..4fea45a 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -55,6 +55,7 @@ struct rpmsg_device_ops {
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
  * @poll:		see @rpmsg_poll(), optional
+ * @set_flow_control:	see @rpmsg_set_flow_control(), optional
  * @get_mtu:		see @rpmsg_get_mtu(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
@@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
 	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

