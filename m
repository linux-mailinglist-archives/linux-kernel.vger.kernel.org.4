Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866968CA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFXMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:12:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09603AA9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:12:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDs7K003917;
        Mon, 6 Feb 2023 23:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=rqLjb7Eq7PhCO+c3t5Ma4CPmiNDolUZo9sZGERYgDXk=;
 b=a+JTZ2nNEPkF9aBL8ncX5UiDJJNm9xk1KnCfUyrEKWabJAIFKXIeahTQO4yJH/5nvJXW
 XwKm6ej+XcBW8vUnzaHIy9StaGpVT4vj8PHT2Q+5MutGug0Y6Uow1pyiFrJUWqPi87J8
 WgSP7fBqsy776WI/2Rn4xAdL59p33oaFEUDHYXppSm0sSi346kIZtQAFyCRBmAHONNRw
 Y+ZzrS2pjxUAYggIgUteNFsuY5ei/jcXAH5V2Uz0MtxebdUC/Wz4bwZAzYoLjmWX0N1p
 Eum78uJLPtEkYQahyTj9Pe5HdMYmJAiKOH4GrmiFjT2F0V8CEQQsUcGotjC+NpW7P4Eq FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytv8bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:12:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316LpWgp021033;
        Mon, 6 Feb 2023 23:12:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt4sj6f-1;
        Mon, 06 Feb 2023 23:12:24 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESENT v4 0/6] features provisioning fixes and mlx5_vdpa support
Date:   Mon,  6 Feb 2023 15:11:58 -0800
Message-Id: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060202
X-Proofpoint-GUID: sMkSKpJqvpXunl3q339Xx1j39Rc-awbv
X-Proofpoint-ORIG-GUID: sMkSKpJqvpXunl3q339Xx1j39Rc-awbv
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
v3 -> v4:
  - rewrite while loop to a for loop per mst's call
  - fix wording in the subject of patch
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
  vdpa/mlx5: make MTU/STATUS presence conditional on feature bits
  vdpa/mlx5: support device features provisioning

 drivers/vdpa/mlx5/net/mlx5_vnet.c |  71 ++++++++++++++++++++------
 drivers/vdpa/vdpa.c               | 103 ++++++++++++++++++++++++++++++++------
 2 files changed, 144 insertions(+), 30 deletions(-)

-- 
1.8.3.1

