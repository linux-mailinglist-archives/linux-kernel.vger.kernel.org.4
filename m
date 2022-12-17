Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8679464F7EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 07:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLQGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 01:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLQGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 01:34:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF0222BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:34:06 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NYx3t3L4CzRq7C;
        Sat, 17 Dec 2022 14:32:58 +0800 (CST)
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 17 Dec
 2022 14:34:03 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v5 0/5] add debugfs to migration driver
Date:   Sat, 17 Dec 2022 14:32:43 +0800
Message-ID: <20221217063248.6735-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs function to the migration driver in VFIO to provide
a step-by-step test function for the migration driver.

When the execution of live migration fails, the user can view the
status and data during the migration process separately from the
source and the destination, which is convenient for users to analyze
and locate problems.

Changes v4 -> v5
	Remove the newly added vfio_migration_ops and use seq_printf
	to optimize the implementation of debugfs.

Changes v3 -> v4
	Change the migration_debug_operate interface to debug_root file.

Changes v2 -> v3
	Extend the debugfs function from hisilicon device to vfio.

Changes v1 -> v2
	Change the registration method of root_debugfs to register
	with module initialization.

Longfang Liu (5):
  vfio/migration: Add debugfs to live migration driver
  hisi_acc_vfio_pci: extract public functions for container_of
  hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
  Documentation: add debugfs description for hisi_acc_vfio_pci
  vfio: update live migration device status

 .../ABI/testing/debugfs-hisi-migration        |  32 ++
 drivers/vfio/pci/Makefile                     |   4 +
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 300 +++++++++++++++++-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
 drivers/vfio/pci/mlx5/main.c                  |   3 +
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_debugfs.c           |  76 +++++
 drivers/vfio/pci/vfio_pci_debugfs.h           |  30 ++
 include/linux/vfio.h                          |   6 +
 9 files changed, 455 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h

-- 
2.24.0

