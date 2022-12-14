Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96864C443
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiLNHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiLNHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:09:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D6C34;
        Tue, 13 Dec 2022 23:09:13 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NX5zv2WLyzRq37;
        Wed, 14 Dec 2022 15:08:11 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 15:09:11 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 0/2] scsi:donot skip lun if inquiry returns PQ=1 for all hosts
Date:   Wed, 14 Dec 2022 15:08:44 +0800
Message-ID: <20221214070846.1808300-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 948e922fc4461 ("scsi: core: map PQ=1, PDT=other values to
SCSI_SCAN_TARGET_PRESENT") returns SCSI_SCAN_TARGET_PRESENT if inquiry
returns PQ=1.

According to the SPC, PQ=1 means the addressed logical unit having the
indicated device type is not accessible, it does not mean the addressed
logical unit is invalid. We still can map this lun to an sg device.

In some conditions, we do not want to skip these devices, for example
with iSCSI:

When iSCSI initiator logged in target, the target attached none valid
lun but lun0. lun0 is not an valid disk, while it would response
inquiry command with PQ=1 and other general scsi commands like probe lun.
The others luns of target is added/removed dynamicly.

We want the lun0 to be mapped to an sg device in initiator, so we can
probe luns of target based on lun0.

In first patch, I add an interface to control if to skip luns return
PQ=1 for inquiry.

In second patch, make iscsi_tcp do not skip luns return PQ=1 as default,
since I do not have iscsi_tcp environment, so here just modified the
iscsi_tcp.

Wenchao Hao (2):
  scsi:core:Add sysfs interface to control if skip lun with PQ=1
  scsi:iscsi_tcp:Do not skip lun inquiry returns PQ=1

 drivers/scsi/iscsi_tcp.c  |  1 +
 drivers/scsi/scsi_scan.c  |  9 ++++++---
 drivers/scsi/scsi_sysfs.c | 29 +++++++++++++++++++++++++++++
 include/scsi/scsi_host.h  |  3 +++
 4 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.32.0

