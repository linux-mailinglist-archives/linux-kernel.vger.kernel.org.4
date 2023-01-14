Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C066AA68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjANJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjANJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:26:50 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B93AA7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:26:49 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NvCVg0xhFzJqKM;
        Sat, 14 Jan 2023 17:22:35 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 14 Jan
 2023 17:26:45 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v6 0/5] add debugfs to migration driver
Date:   Sat, 14 Jan 2023 17:26:10 +0800
Message-ID: <20230114092615.51841-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
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

Changes v5 -> v6
	Control the creation of debugfs through the CONFIG_DEBUG_FS.

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
 drivers/vfio/pci/Makefile                     |   1 +
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 306 +++++++++++++++++-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
 drivers/vfio/pci/mlx5/main.c                  |   3 +
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_debugfs.c           |  82 +++++
 drivers/vfio/pci/vfio_pci_debugfs.h           |  30 ++
 include/linux/vfio.h                          |   6 +
 9 files changed, 464 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h

-- 
2.24.0

