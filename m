Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1113468CA44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBFXJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFXIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6138C32E5A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:08:26 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDrxR022748;
        Mon, 6 Feb 2023 23:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=0CriircPtC5ExQ5QJKfnKlayKOe8WG6ZDKh8VqSRLTw=;
 b=c42TLK9zAy5cH9RVcQ1WiD+YsAeZg4kqZvgt5KSATvuQIzJplBAW1dCbFg0MucMN2Jx8
 La7z1NvnfC+p9hEbp/6TCAUsR542KvW7h8WZntKfrhUvS6TP3Sr8Z5joU30ixcAEFFr5
 f0vPcb8mgWGnM8N5SFQSKoenC62av67uhWka9famS7bAXRkm0Yx77ah6+BiJlnAlZn41
 utF224U82cTEMgeiqQ016vNpMIm0iY49oAM1nlZLKhRXrGBYdKji7ixj3ewL7yEyFunk
 IJesq0g2YP2BXEoweEuk+i5G+UuYrvcVFRoZMSzYImdKmZfMcW0JJSjMDWUkRL8CkicK 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcc7yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:08:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316LbeUL040865;
        Mon, 6 Feb 2023 23:08:20 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtb99m7-4;
        Mon, 06 Feb 2023 23:08:20 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] vdpa: validate provisioned device features against specified attribute
Date:   Mon,  6 Feb 2023 15:07:57 -0800
Message-Id: <1675724880-7216-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
References: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060202
X-Proofpoint-GUID: sRrFU8Bv-7TT4wizrpanzkwostdS30vE
X-Proofpoint-ORIG-GUID: sRrFU8Bv-7TT4wizrpanzkwostdS30vE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With device feature provisioning, there's a chance for misconfiguration
that the vdpa feature attribute supplied in 'vdpa dev add' command doesn't
get selected on the device_features to be provisioned. For instance, when
a @mac attribute is specified, the corresponding feature bit _F_MAC in
device_features should be set for consistency. If there's conflict on
provisioned features against the attribute, it should be treated as an
error to fail the ambiguous command. Noted the opposite is not
necessarily true, for e.g. it's okay to have _F_MAC set in device_features
without providing a corresponding @mac attribute, in which case the vdpa
vendor driver could load certain default value for attribute that is not
explicitly specified.

Generalize this check in vdpa core so that there's no duplicate code in
each vendor driver.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 21c8aa3..1eba978 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -601,8 +601,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	}
 	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
+		u64 missing = 0x0ULL;
+
 		config.device_features =
 			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
+		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR] &&
+		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MAC)))
+			missing |= BIT_ULL(VIRTIO_NET_F_MAC);
+		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU] &&
+		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MTU)))
+			missing |= BIT_ULL(VIRTIO_NET_F_MTU);
+		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] &&
+		    config.net.max_vq_pairs > 1 &&
+		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MQ)))
+			missing |= BIT_ULL(VIRTIO_NET_F_MQ);
+		if (missing) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "Missing features 0x%llx for provided attributes",
+					       missing);
+			return -EINVAL;
+		}
 		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
 	}
 
-- 
1.8.3.1

