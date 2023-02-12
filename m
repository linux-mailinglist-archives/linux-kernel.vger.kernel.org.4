Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2B693937
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBLR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 12:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBLR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 12:57:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FCBDDE;
        Sun, 12 Feb 2023 09:57:20 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CHvI92026860;
        Sun, 12 Feb 2023 17:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=u4CrzYM17ps5RxQQZYz8Hzad/nALC78BEWVZhD6asao=;
 b=px9LvwXR9NATtFV0ngMLPLSeFtXtKYiKk9B3ZA5WwGFD+XHtSfF9uSDdUcMQrL6o0Q0T
 qRCQNeNbCWrwCznKbbxlqMttad5ax6TMcxexxlBiocRZVD7kGILsFnhoLYsFuXExxe0a
 zpo9wFhENQfpVVx8ladUizzJggbfLgHd0zTaR/LWcM2eIT6x8ykNyGdXnse0LFEZO3ek
 sFa7AlIRdG12ZHZ/aY1aLNrElr3koKlWTZMxXHMpXjJW3py4ou1QOfRlTT6wcSD1Ey5D
 KTtauOeePnLoO/7vuarD459RdjtwEXRD5SBgTlCuLrtoyo/5zxt8dxznBKmENzUJtuf8 Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3detd88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 17:57:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31CHvGbC003885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 17:57:16 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 12 Feb 2023 09:57:14 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC] usb: gadget: ncm: Add support to configure wMaSegmentSize
Date:   Sun, 12 Feb 2023 23:26:59 +0530
Message-ID: <20230212175659.4480-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5PLi-V00T40iaUWVtlMvy76AL5ZE5Ge6
X-Proofpoint-ORIG-GUID: 5PLi-V00T40iaUWVtlMvy76AL5ZE5Ge6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the NCM driver restricts wMasxSegmentSize that indicates
the datagram size coming from network layer to 1514. However the
spec doesn't have any limitation.

Add support to configure this value before configfs symlink is
created. Also since the NTB Out/In buffer sizes are fixed at 16384
bytes, limit the segment size to an upper cap of 8192 bytes so that
at least 2 packets can be aggregated.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/gadget/function/f_ncm.c | 55 +++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ncm.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 424bb3b666db..1969e276017f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -118,6 +118,12 @@ static inline unsigned ncm_bitrate(struct usb_gadget *g)
 /* Delay for the transmit to wait before sending an unfilled NTB frame. */
 #define TX_TIMEOUT_NSECS	300000
 
+/*
+ * Currently the max NTB Buffer size is set to 16384. For atleast 2 packets
+ * to be aggregated, the size of datagram must at max be 8192.
+ */
+#define MAX_DATAGRAM_SIZE	8192
+
 #define FORMATS_SUPPORTED	(USB_CDC_NCM_NTB16_SUPPORTED |	\
 				 USB_CDC_NCM_NTB32_SUPPORTED)
 
@@ -1440,6 +1446,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	if (!ncm_opts->bound) {
 		mutex_lock(&ncm_opts->lock);
+		ncm_opts->net->mtu = (ncm_opts->max_segment_size - 14);
 		gether_set_gadget(ncm_opts->net, cdev->gadget);
 		status = gether_register_netdev(ncm_opts->net);
 		mutex_unlock(&ncm_opts->lock);
@@ -1484,6 +1491,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
+
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
@@ -1586,11 +1595,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
 /* f_ncm_opts_ifname */
 USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
 
+static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
+						char *page)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	u32 segment_size;
+
+	mutex_lock(&opts->lock);
+	segment_size = opts->max_segment_size;
+	mutex_unlock(&opts->lock);
+
+	return sprintf(page, "%u\n", segment_size);
+}
+
+static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
+						const char *page, size_t len)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	int ret;
+	u32 segment_size;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = kstrtou32(page, 0, &segment_size);
+	if (ret)
+		goto out;
+
+	if (segment_size > MAX_DATAGRAM_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	opts->max_segment_size = segment_size;
+	ret = len;
+out:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(ncm_opts_, max_segment_size);
+
 static struct configfs_attribute *ncm_attrs[] = {
 	&ncm_opts_attr_dev_addr,
 	&ncm_opts_attr_host_addr,
 	&ncm_opts_attr_qmult,
 	&ncm_opts_attr_ifname,
+	&ncm_opts_attr_max_segment_size,
 	NULL,
 };
 
@@ -1633,6 +1687,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
+	opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
 	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
 
 	descs[0] = &opts->ncm_os_desc;
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 5408854d8407..fab99d997476 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -31,6 +31,7 @@ struct f_ncm_opts {
 	 */
 	struct mutex			lock;
 	int				refcnt;
+	u32				max_segment_size;
 };
 
 #endif /* U_NCM_H */
-- 
2.39.0

