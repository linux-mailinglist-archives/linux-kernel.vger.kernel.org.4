Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB46C0D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCTJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCTJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:26:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC752448D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:26:17 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pg8RL4mKCznYgh;
        Mon, 20 Mar 2023 17:23:10 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 17:26:14 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v9 4/5] Documentation: add debugfs description for vfio
Date:   Mon, 20 Mar 2023 17:23:37 +0800
Message-ID: <20230320092338.2889-5-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230320092338.2889-1-liulongfang@huawei.com>
References: <20230320092338.2889-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two debugfs document description file to help users understand
how to use the accelerator live migration driver's debugfs.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../ABI/testing/debugfs-hisi-migration        | 28 +++++++++++++++++++
 Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 Documentation/ABI/testing/debugfs-vfio

diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
new file mode 100644
index 000000000000..ffcf4b5ecd51
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-migration
@@ -0,0 +1,28 @@
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration data of the vfio device.
+		The output format of the data is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration attributes of the vfio device.
+		The output format of the attributes is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/debug
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debug file supports "echo" command	write operations.
+		The command is actually represented by an integer number, and the
+		specific meaning is defined by the corresponding device driver.
+		For example, three commands are defined in the HiSilicon accelerator
+		live migration driver:
+		0: State save
+		1: State resume
+		2: IO test
diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
new file mode 100644
index 000000000000..81a66cf60553
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -0,0 +1,25 @@
+What:		/sys/kernel/debug/vfio
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices.
+		Each device can create a device subdirectory under this
+		directory by referencing the public registration interface.
+
+What:		/sys/kernel/debug/vfio/<device>/migration
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices that support live migration.
+		The debugfs of each vfio device that supports live migration
+		could be created under this directory.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/state
+Date:		Mar 2023
+KernelVersion:  6.2
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration status of the vfio device.
+		The status of these live migrations includes:
+		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
-- 
2.24.0

