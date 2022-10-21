Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044160823A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJUXtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJUXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:49:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CC32051
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:49:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDZas029908;
        Fri, 21 Oct 2022 23:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=xWjxZS84AK3m+Nv1TeUgp0dkNSgQgpfhujBF90NCAuI=;
 b=eyCN+sxyBDMbgoYp73XvaMlOIQgPMVwJx7WNoU2qBO5Rsds/dYEgPOHh7g7YfqXDlC/V
 FAsZqwIlksu3t5eLnc/9O5/WNx0sDCsjylU0LYXfh9lHb1WZhqAl/Sq9Uk6HWNIrp+Ah
 M2P/3dPhOH28ED5R2jQ6gfc78wgvRPWxymeozhF2ZBf1HF4qgulsVsQHG/CRJ1I/QFpi
 X6My4upxGCY2oJEi/cdXNawiJlCEVe58Ng0LDc3RS5RrBt3NIxl0PUdHgp8Btccldm+O
 +gypmHOozu7kWs4heCK3CCbQ1qKsSGFzEyOKiv8r/63zfC6ChAERL76ZrseeIcEJqvGA ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3tea0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 23:49:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LMgIQR007144;
        Fri, 21 Oct 2022 23:49:38 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hre9a3b-1;
        Fri, 21 Oct 2022 23:49:38 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
Date:   Fri, 21 Oct 2022 15:43:53 -0700
Message-Id: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210139
X-Proofpoint-ORIG-GUID: 6x2boUmJJDAYbf8289-RDc91KbkPPpew
X-Proofpoint-GUID: 6x2boUmJJDAYbf8289-RDc91KbkPPpew
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
same way as how source node created the device in the first place. 

In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query. This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

In this series, the initial device config for vdpa creation will be
exported via the "vdpa dev show" command. This is unlike the "vdpa
dev config show" command that usually goes with the live value in
the device config space, and is not reliable subject to the dynamics
of feature negotiation or possible change by driver to the config
space.

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
  initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
            "initial_config": {
                "mac": "e4:11:c6:d3:45:f0",
                "max_vq_pairs": 4
            }
        }
    }
}

---
v2 -> v3:
  - Rename vdev_cfg to init_cfg and also related function (Jason)
  - Change "virtio_config" to "initial_config" in command example
    output (Parav)

v1 -> v2:
  - Revised example output to export all config attributes under a
    json object (Jason)

---

Si-Wei Liu (4):
  vdpa: save vdpa_dev_set_config in struct vdpa_device
  vdpa: pass initial config to _vdpa_register_device()
  vdpa: show dev config as-is in "vdpa dev show" output
  vdpa: fix improper error message when adding vdpa dev

 drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
 drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
 include/linux/vdpa.h                 | 26 ++++++++-------
 8 files changed, 80 insertions(+), 22 deletions(-)

-- 
1.8.3.1

