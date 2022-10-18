Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52060374C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJSA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJSA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:56:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5DC97FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:56:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INi8vU005567;
        Wed, 19 Oct 2022 00:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Vceponq7eAFUqTu6CGWdqDZyJ21Mh5Eod4o60p5T6SU=;
 b=eUxo+IE8H9VexyDBEWzD3uKw939uGXWeg+9S6CL3G/e5ypgEpMJP3CME+Ck6echR7xx9
 nB6yl++raR8m7qfYgxSoDt6uCI+QsDZSrumF4+KjueyeNYz3lQTQWTVRIhRme4j4r9l6
 0IWFYipweABlxyWyeKZbiQtShJ6glPxTsTUFdXU11/YXSFVS/IiPrU2skZ+9cOoIC+V3
 iz7bIts5NZAR5rYYTFwsSQL/xZnfR6RAAcDb+KLZLAFHtocvUJ7a7zM11hAG45EXOQNt
 89ONmtKHivP90JL1GIA3Bxj03PiU/droXcwV4n/5MooLVwc/58k6U0Joa/HLCzNa+sLg Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu00ka4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 00:56:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ILnUhH016678;
        Wed, 19 Oct 2022 00:56:11 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8htgrhfm-2;
        Wed, 19 Oct 2022 00:56:11 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] vdpa: save vdpa_dev_set_config in struct vdpa_device
Date:   Tue, 18 Oct 2022 16:50:29 -0700
Message-Id: <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: lrfdVwc3WsuiaWtj3PwmOzSJ3D1pqDll
X-Proofpoint-GUID: lrfdVwc3WsuiaWtj3PwmOzSJ3D1pqDll
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query. This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

This commit attempts to make struct vdpa_device contain the struct
vdpa_dev_set_config, where all config attributes upon vdpa creation
are carried over. Which will be used in subsequent commits.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4..f1838f5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -58,6 +58,16 @@ struct vdpa_vq_state {
 	};
 };
 
+struct vdpa_dev_set_config {
+	u64 device_features;
+	struct {
+		u8 mac[ETH_ALEN];
+		u16 mtu;
+		u16 max_vq_pairs;
+	} net;
+	u64 mask;
+};
+
 struct vdpa_mgmt_dev;
 
 /**
@@ -77,6 +87,8 @@ struct vdpa_vq_state {
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
+ * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
+ *            the exact same config is needed.
  */
 struct vdpa_device {
 	struct device dev;
@@ -91,6 +103,7 @@ struct vdpa_device {
 	struct vdpa_mgmt_dev *mdev;
 	unsigned int ngroups;
 	unsigned int nas;
+	struct vdpa_dev_set_config vdev_cfg;
 };
 
 /**
@@ -103,16 +116,6 @@ struct vdpa_iova_range {
 	u64 last;
 };
 
-struct vdpa_dev_set_config {
-	u64 device_features;
-	struct {
-		u8 mac[ETH_ALEN];
-		u16 mtu;
-		u16 max_vq_pairs;
-	} net;
-	u64 mask;
-};
-
 /**
  * Corresponding file area for device memory mapping
  * @file: vma->vm_file for the mapping
-- 
1.8.3.1

