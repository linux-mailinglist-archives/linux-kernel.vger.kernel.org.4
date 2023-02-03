Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FF688EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBCFC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBCFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:02:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148C74C19
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:02:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130NouW028457;
        Fri, 3 Feb 2023 05:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=zNHCg0bm+sv//yDfaYhZHGrfS2qHTDN9BuTwB00O5ag=;
 b=h6ZOheHJd1t0EKkMn2unqbzFwxB8l7aVb7BuEHBlHQyMJExSTR+IBerQlFB9SAVYQdQ4
 ot6et4872/ov9knVmADFD71LjAY0aBF8jARdaEYPNCf2dNy3nJEcJliKnmlZAcX7HfLj
 iQCM77qbn34W4/IlnRIhpyqMdKNpu6C3UMQ1uQWkxRDdyleDfeHdTNiiuvDaLU9YZnGe
 gLm8F1NZKo9B9LdlUlrCiz9/UmtCI7XgF/FVZO5EGzKEwy9y4r/f7BUCENyjYuVx8z6l
 HreUvwWy4dETFKO61ATjlf/IZVWWdOSKgEqeTb/8dSnJ1X+6eRQpP0Zgn5p3z9HmtC8F jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfn9ymrqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 05:02:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31340RuO006053;
        Fri, 3 Feb 2023 05:02:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5a2tm8-4;
        Fri, 03 Feb 2023 05:02:24 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] vdpa: validate provisioned device features against specified attribute
Date:   Thu,  2 Feb 2023 21:02:00 -0800
Message-Id: <1675400523-12519-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030044
X-Proofpoint-ORIG-GUID: lbRc_IPHDLIyWlPENHCDMtjeop61vsAO
X-Proofpoint-GUID: lbRc_IPHDLIyWlPENHCDMtjeop61vsAO
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

