Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD2D688EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBCFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:02:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF474C03
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:02:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130O1Nv029043;
        Fri, 3 Feb 2023 05:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=AHbxwsOm4AwW1oY98fJpc+CKBCmA/NaPVHInFQ6pv24=;
 b=tEJWieRu/cBXJesshEiZNDOQY6XNqWzM6Xh5rO0XIq9AA6yTMEb5zqOnF+G6BWBZhML/
 /gibWar93OneTOVpSG3Qi/mO/kj/KgrZ6iEgp8WyoUQS0YknJp21AouLY42raeZPc+N1
 1F4X8ez9KoPQ8hsdxjc/vlYtEI/sAJzd2lXT9dC66bKHedk6SweBIvQ/FBmPS8ktOOAa
 hCOPWN/L3wLzseJvAFnrnpwsPaXOUJKa3eM1lFs4UcCDtCMv2d8jTu/qvjsz2pNxiMjn
 z3VPJ/smttnLt2Uq1/mihnGBjnRokyyndPovFfxa1LEWNlwu1OcLcdr4b4yWbPGkZ9T9 gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfn9ymrqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 05:02:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31340RuL006053;
        Fri, 3 Feb 2023 05:02:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5a2tm8-1;
        Fri, 03 Feb 2023 05:02:21 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] features provisioning fixes and mlx5_vdpa support
Date:   Thu,  2 Feb 2023 21:01:57 -0800
Message-Id: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030044
X-Proofpoint-ORIG-GUID: QMdcnPqMObnkhsLYNoUsFm0OdzDtxOeI
X-Proofpoint-GUID: QMdcnPqMObnkhsLYNoUsFm0OdzDtxOeI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is pre-requisite to export and provision device
config attributes and features for vdpa live migration, in a way
backward and forward compatibility can be retained. The follow up
work [1] will need to be built around the new feature provisioning
uAPI, with which it's easier to formalize migration compatibility
support at the driver level.

Thanks,
-Siwei

[1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/

---
v2 -> v3:
  - fix incorrect reference of local variable in future patch
  - prohibit per-device bitmask macro from exposure in uapi header
  - add fixes tag
v1 -> v2:
  - include specific attribute info to error message 
  - move conditional feature presence in mlx5_vdpa config space
    to a separate patch
  - remove redundant check
---

Si-Wei Liu (6):
  vdpa: fix improper error message when adding vdpa dev
  vdpa: conditionally read STATUS in config space
  vdpa: validate provisioned device features against specified attribute
  vdpa: validate device feature provisioning against supported class
  vdpa/mlx5: conditionally show MTU and STATUS in config space
  vdpa/mlx5: support device features provisioning

 drivers/vdpa/mlx5/net/mlx5_vnet.c |  71 +++++++++++++++++++++-----
 drivers/vdpa/vdpa.c               | 105 ++++++++++++++++++++++++++++++++------
 2 files changed, 146 insertions(+), 30 deletions(-)

-- 
1.8.3.1

