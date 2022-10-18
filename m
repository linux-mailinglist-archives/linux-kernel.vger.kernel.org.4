Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C95603752
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJSA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJSA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:56:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC142CA8B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:56:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INiEL4015089;
        Wed, 19 Oct 2022 00:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=4nx+iApfvHRVvMFxSVa+tU7zlotqTeZHlPcdBrN2+4E=;
 b=tUnxhwi7kZotAbWL+FVUdF8HK/MdvBOEe/hK4a124Ih3AWAqpJp3aTXzAuK9gOmMHdWG
 r0kSgOPn1wm9UyS4iwUZF1fft++lJzMJtGdNfnCQtzrU8O7+5saGAKonyLhy1GaFFgGT
 TgHg4iVY218J0JUYdau0ly8MQ2fruWL5J4uYpH1PGm1kNVV/qAmhrQrllAYqt5ebzlni
 L4rG0RBx3yF6C8j6vm/gMl0y46Cb70kFtcR+aIA6X3vzvfABbl5Ex6SPH/Kff/CnhScL
 a7NRDI4ckPcQMcNsEuqKnNaS8FkSl3e+hDzXsu6REH52ygR0ve5Nk7/srdLRyKAMd7Kl Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7skyym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 00:56:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ILnUhJ016678;
        Wed, 19 Oct 2022 00:56:12 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8htgrhfm-4;
        Wed, 19 Oct 2022 00:56:12 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show" output
Date:   Tue, 18 Oct 2022 16:50:31 -0700
Message-Id: <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190003
X-Proofpoint-GUID: 9cpqheKdIGEWX87YA7drLLE3qIvH6cMb
X-Proofpoint-ORIG-GUID: 9cpqheKdIGEWX87YA7drLLE3qIvH6cMb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Live migration of vdpa would typically require re-instate vdpa
device with an idential set of configs on the destination node,
same way as how source node created the device in the first
place. In order to save orchestration software from memorizing
and keeping track of vdpa config, it will be helpful if the vdpa
tool provides the aids for exporting the initial configs from
which vdpa device was created as-is. The "vdpa dev show" command
seems to be the right vehicle for that. It is unlike the "vdpa dev
config show" command output that usually goes with the live value
in the device config space, which is not quite reliable subject to
the dynamics of feature negotiation and possible change in device
config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
$ vdpa dev show vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
$ vdpa dev -jp show vdpa0
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
        }
    }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
  virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
            "virtio_config": {
                "mac": "e4:11:c6:d3:45:f0",
                "max_vq_pairs": 4
            }
        }
    }
}

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 566c1c6..91eca6d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 }
 
 static int
+vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
+{
+	struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
+	int err = -EMSGSIZE;
+
+	if (!cfg->mask)
+		return 0;
+
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
+		    nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
+			    sizeof(cfg->net.mac), cfg->net.mac))
+			return err;
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
+		    nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
+			return err;
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
+		    nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
+				cfg->net.max_vq_pairs))
+			return err;
+		break;
+	default:
+		break;
+	}
+
+	if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
+	    nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
+			      cfg->device_features, VDPA_ATTR_PAD))
+		return err;
+
+	return 0;
+}
+
+static int
 vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
 	      int flags, struct netlink_ext_ack *extack)
 {
@@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
 		goto msg_err;
 
+	err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
+	if (err)
+		goto msg_err;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
-- 
1.8.3.1

