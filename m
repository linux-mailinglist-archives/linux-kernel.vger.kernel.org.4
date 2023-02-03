Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCDF688EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBCFCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBCFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:02:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC474C0C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:02:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130Ndv3020583;
        Fri, 3 Feb 2023 05:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=j/lEJg/ReXobH4hd+iLRobue9kWLN1CWVWeI2l8aOjc=;
 b=GfrQljOiRNBZeD3+uEcY2KviulHljO+Emjo4VX8gdhaHCe2Hcnv46cHe6YupEyYrXqyF
 NSU18R56RP/Y+uP4fZjWXykxJYgOqWKJ/eSxqapv64o1oV26VgrzpTgP/IclMFRp8jvg
 OZIRQ9WoG7vDwPnt+hqZosqCG+tnVJxVEATg8f0FWYJ28WM8JVtk6DMIteGPqK5zsqxN
 Yo+YW4luX5pLfBBTAXufIeTvLCSVdDiRMlz/Ped5oYkqgXYUSLMFWCSZcOwbDGkeVlYo
 7XdVQBv5g9JFP2jHBNANMIx82+aOsULIlDwB0lhSvej8Xa2pW9nAR7kUeEAxv5lpstDZ NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfmbg4uqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 05:02:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31340RuM006053;
        Fri, 3 Feb 2023 05:02:22 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5a2tm8-2;
        Fri, 03 Feb 2023 05:02:22 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] vdpa: fix improper error message when adding vdpa dev
Date:   Thu,  2 Feb 2023 21:01:58 -0800
Message-Id: <1675400523-12519-2-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: l4IR-6dWlbopkxxcNf_lkb5xt0N3O2r6
X-Proofpoint-GUID: l4IR-6dWlbopkxxcNf_lkb5xt0N3O2r6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In below example, before the fix, mtu attribute is supported
by the parent mgmtdev, but the error message showing "All
provided are not supported" is just misleading.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: All provided attributes are not supported.
kernel answers: Operation not supported

After fix, the relevant error message will be like:

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: Some provided attributes are not supported: 0x1000.
kernel answers: Operation not supported

Fixes: d8ca2fa5be1b ("vdpa: Enable user to set mac and mtu of vdpa device")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1..3a82ca78 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -622,9 +622,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
+
 	if ((config.mask & mdev->config_attr_mask) != config.mask) {
-		NL_SET_ERR_MSG_MOD(info->extack,
-				   "All provided attributes are not supported");
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "Some provided attributes are not supported: 0x%llx",
+				       config.mask & ~mdev->config_attr_mask);
 		err = -EOPNOTSUPP;
 		goto err;
 	}
-- 
1.8.3.1

