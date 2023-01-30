Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93901681CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjA3Vh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3VhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:37:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCD35B0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:37:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UL3rF1010564;
        Mon, 30 Jan 2023 21:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=0s4y1MDssHKhpvnOleVZPgAoMVzvrH7+LhP7fjbqZEo=;
 b=ZopwcV24m1pgerC5QsSEzz9rW2SOOsfVG7xb1+hyeisgZVzBPUqmj570OegT0luA8yyu
 IaSNGU+n3UfI75RTuIcGn7yK7MSxvgQazoiZcYNnqggNa06EAs+7jrVHGxLzC2O7T8Sd
 Jr18c/u6q3XDP5RiAoB/7/vjaoapuZEG6QlS6NJ7OYUVin80anVrYpkxc+fVgTI8c3gP
 YWLn5YMPQBIW2HBRJLeMhfJ/JT930bo/J8tniEzU2FsIdo5PJ+UcPsXxgdJgm1EofT2W
 6Asq+m0Ij2ziYsy72f8dCRAzO0JNtjjrbs+eKqIUCu5aww/w9ZMXTQ6LJRKwIgN86f8B AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjv1vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 21:37:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UK8hpv031798;
        Mon, 30 Jan 2023 21:37:19 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct54qa7f-1;
        Mon, 30 Jan 2023 21:37:18 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] features provisioning fixes and mlx5_vdpa support
Date:   Mon, 30 Jan 2023 12:30:37 -0800
Message-Id: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300200
X-Proofpoint-GUID: LpeTCHa7klMpYoBGyUBxgmOJTK6HsRdn
X-Proofpoint-ORIG-GUID: LpeTCHa7klMpYoBGyUBxgmOJTK6HsRdn
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

Si-Wei Liu (6):
  vdpa: fix improper error message when adding vdpa dev
  vdpa: conditionally read STATUS in config space
  vdpa: validate provisioned device features against specified attribute
  virtio: VIRTIO_DEVICE_F_MASK for all per-device features
  vdpa: validate device feature provisioning against supported class
  vdpa/mlx5: support device features provisioning

 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 72 ++++++++++++++++++++++------
 drivers/vdpa/vdpa.c                | 98 ++++++++++++++++++++++++++++++++------
 include/uapi/linux/virtio_config.h |  8 ++++
 3 files changed, 149 insertions(+), 29 deletions(-)

-- 
1.8.3.1

