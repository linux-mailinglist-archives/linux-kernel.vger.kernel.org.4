Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22376B388A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCJI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:27:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE110976D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:27:30 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PXzcP10YQznWXp;
        Fri, 10 Mar 2023 16:24:37 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 16:27:27 +0800
Subject: Re: [PATCH v8 0/5] add debugfs to migration driver
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <beadef1f-c8cd-3c42-4802-04cf1665dc17@huawei.com>
Date:   Fri, 10 Mar 2023 16:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230217084831.35783-1-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/17 16:48, Longfang Liu wrote:
> Add a debugfs function to the migration driver in VFIO to provide
> a step-by-step test function for the migration driver.
> 
> When the execution of live migration fails, the user can view the
> status and data during the migration process separately from the
> source and the destination, which is convenient for users to analyze
> and locate problems.
> 
> Changes v7 -> v8
> 	Add support for platform devices.
> 
> Changes v6 -> v7
> 	Fix some code style issues.
> 
> Changes v5 -> v6
> 	Control the creation of debugfs through the CONFIG_DEBUG_FS.
> 
> Changes v4 -> v5
> 	Remove the newly added vfio_migration_ops and use seq_printf
> 	to optimize the implementation of debugfs.
> 
> Changes v3 -> v4
> 	Change the migration_debug_operate interface to debug_root file.
> 
> Changes v2 -> v3
> 	Extend the debugfs function from hisilicon device to vfio.
> 
> Changes v1 -> v2
> 	Change the registration method of root_debugfs to register
> 	with module initialization.
> 
> Longfang Liu (5):
>   vfio/migration: Add debugfs to live migration driver
>   hisi_acc_vfio_pci: extract public functions for container_of
>   hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
>   Documentation: add debugfs description for vfio
>   vfio: update live migration device status
> 
>  .../ABI/testing/debugfs-hisi-migration        |  28 ++
>  Documentation/ABI/testing/debugfs-vfio        |  17 +
>  drivers/vfio/Makefile                         |   2 +-
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 306 +++++++++++++++++-
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  drivers/vfio/pci/mlx5/main.c                  |   3 +
>  drivers/vfio/vfio.h                           |  14 +
>  drivers/vfio/vfio_debugfs.c                   |  82 +++++
>  drivers/vfio/vfio_main.c                      |   5 +
>  include/linux/vfio.h                          |   8 +
>  10 files changed, 465 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>  create mode 100644 drivers/vfio/vfio_debugfs.c
> 
Hi Alex:
please help to review this patchset.
thanks.

Longfang.
