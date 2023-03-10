Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DE6B408E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCJNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCJNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:37:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177910D33B;
        Fri, 10 Mar 2023 05:36:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AD6cbS022516;
        Fri, 10 Mar 2023 13:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=j+FcDSz+nP6gaAfpugOkP7gnAi4BScdpnJ2A+qJOhck=;
 b=dd/5tY+35EsaZ68QA8lAwBC9W5P+R7XrmGytEJtbCvePEv/IT8RwwFLCUTWpzFaMDvgX
 8yDkuCZPUsWfncTOjAnEp8NiHzIR6tQMJ0KE6qqMyikMNPD+BbV6EWiZQurwxreOHN7W
 cm4Lc7xEKvjjW+T6qX3BWfICL8P8t2xI2jIXJUC1vlGCs9Wpc4QKk2YFPR+iBDRTTFDg
 vxe6Fawg8Fcg1ZDbeDLsqGjPda1sFOvcU5YrOvNiKCC0g9mVjyaeIzdsPlnGx3djUcqo
 Kl2R6corS94uVyu8swOPrVoRqAtJI/1u7G9miUROjCpeMmQoMRDxsphMflKIpm7N58Td yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7juttp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:36:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32ADaqVY013514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:36:52 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 10 Mar 2023 05:36:50 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC v2] usb: gadget: ncm: Add support to configure wMaxSegmentSize
Date:   Fri, 10 Mar 2023 19:06:40 +0530
Message-ID: <20230310133640.11142-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HUc3zxlLxI84X6o8aWsjtd_K_pL_4s8m
X-Proofpoint-ORIG-GUID: HUc3zxlLxI84X6o8aWsjtd_K_pL_4s8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the NCM driver restricts wMaxSegmentSize that indicates
the datagram size coming from network layer to 1514. However the
spec doesn't have any limitation.

Add support to configure this value before configfs symlink is
created. Also since the NTB Out/In buffer sizes are fixed at 16384
bytes, limit the segment size to an upper cap of 15014. Set the
default MTU size for the ncm interface during function bind before
network interface is registered allowing MTU to be set in parity
with wMaxSegmentSize.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v1: https://lore.kernel.org/all/20230212175659.4480-1-quic_kriskura@quicinc.com/

Fixed the Max datagram size as per comments on v1.
As per the spec, there are no GSO related specifications present mentioned by Maintainer.
Pushing v2 to fix datagram length specification and take the discussion regarding GSO
forward.


 drivers/usb/gadget/function/f_ncm.c | 54 +++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ncm.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 424bb3b666db..a990f407d6c3 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -97,6 +97,11 @@ static inline unsigned ncm_bitrate(struct usb_gadget *g)
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Provide felxibility to change MTU upto 15000 (as the ETH_HLEN is 14 bytes)
+ */
+#define MAX_DATAGRAM_SIZE	15014
+
 /*
  * We cannot group frames so use just the minimal size which ok to put
  * one max-size ethernet frame.
@@ -1440,6 +1445,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	if (!ncm_opts->bound) {
 		mutex_lock(&ncm_opts->lock);
+		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
 		gether_set_gadget(ncm_opts->net, cdev->gadget);
 		status = gether_register_netdev(ncm_opts->net);
 		mutex_unlock(&ncm_opts->lock);
@@ -1484,6 +1490,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
+
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
@@ -1586,11 +1594,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
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
 
@@ -1633,6 +1686,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
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

