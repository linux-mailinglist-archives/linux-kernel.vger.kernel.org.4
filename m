Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8253C655616
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiLWXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiLWXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:33:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084911147;
        Fri, 23 Dec 2022 15:33:10 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNTkUF005599;
        Fri, 23 Dec 2022 23:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VDTU3XTvrpxIwL9qSgdsrGb/DCechmiUc86IBF326RE=;
 b=ik0uMp9XBeifrLb4j+xHORc3/viVy0uPBlSEQ6YlTEik6YZl4JPlddxPq33h3xe5zPBw
 YOT7XkZgb8hls3Vcl/LSopViFaQjQ/hM26u987RGI6ovHsaDH598aNGp336vbKAcd2Et
 +gm7tsFxKfTyQmA1FQ+o3sXSzcZjOFWnZGuEzcjbMXV6ySPF5f3GScpDu3JJShlRvYjt
 GF2PrzcSw4mKEJ/3Mq6CA8N1UCwmap43ZW3L2NqIYZSvOhxlzArD5+dsyHGEdKLqXBM8
 gqI2PIaXvN9HgBOL5T82S7Nba85EpF7aEnxMgQoFtYKf3pYzstP1/hPuiAEu/lb3HSnK lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mn2pga503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWiSp001844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:44 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:44 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op callbacks
Date:   Fri, 23 Dec 2022 15:31:50 -0800
Message-ID: <20221223233200.26089-5-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kfEueJdQT5jZwiwFMYsDioxhTJ9T-uCV
X-Proofpoint-GUID: kfEueJdQT5jZwiwFMYsDioxhTJ9T-uCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=906 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for different vendors to be notified on USB SND connect/disconnect
seqeunces.  This allows for vendor USB SND modules to properly initialize
and populate internal structures with references to the USB SND chip
device.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 22 ++++++++++++++++++++++
 sound/usb/card.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 26268ffb8274..212f55a7683c 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -117,6 +117,21 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
 static DEFINE_MUTEX(register_mutex);
 static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
 static struct usb_driver usb_audio_driver;
+static struct snd_usb_vendor_ops *vendor_ops;
+
+int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops)
+{
+	vendor_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_usb_register_vendor_ops);
+
+int snd_usb_unregister_vendor_ops(void)
+{
+	vendor_ops = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_usb_unregister_vendor_ops);
 
 /*
  * disconnect streams
@@ -910,6 +925,10 @@ static int usb_audio_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, chip);
 	atomic_dec(&chip->active);
 	mutex_unlock(&register_mutex);
+
+	if (vendor_ops->connect_cb)
+		vendor_ops->connect_cb(intf, chip);
+
 	return 0;
 
  __error:
@@ -943,6 +962,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	if (chip == USB_AUDIO_IFACE_UNUSED)
 		return;
 
+	if (vendor_ops->disconnect_cb)
+		vendor_ops->disconnect_cb(intf);
+
 	card = chip->card;
 
 	mutex_lock(&register_mutex);
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 40061550105a..a785bb256b0d 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -206,4 +206,11 @@ struct snd_usb_stream {
 	struct list_head list;
 };
 
+struct snd_usb_vendor_ops {
+	void (*connect_cb)(struct usb_interface *intf, struct snd_usb_audio *chip);
+	void (*disconnect_cb)(struct usb_interface *intf);
+};
+
+int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops);
+int snd_usb_unregister_vendor_ops(void);
 #endif /* __USBAUDIO_CARD_H */
