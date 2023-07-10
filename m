Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616EE74D501
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGJMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:12:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5BB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:12:50 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R02tl2Glgz1FDlj;
        Mon, 10 Jul 2023 20:12:15 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 20:12:46 +0800
Subject: Re: [PATCH v11 0/4] add debugfs to migration driver
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20230630092457.54902-1-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <9c3f7b5c-b0c0-2c74-e32f-68fd3e1deee9@huawei.com>
Date:   Mon, 10 Jul 2023 20:12:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230630092457.54902-1-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/30 17:24, liulongfang wrote:
> Add a debugfs function to the migration driver in VFIO to provide
> a step-by-step test function for the migration driver.
> 
> When the execution of live migration fails, the user can view the
> status and data during the migration process separately from the
> source and the destination, which is convenient for users to analyze
> and locate problems.
> 
> Changes v10 -> v11
> 	Delete the device restore function in debugfs.
> 
> Changes v9 -> v10
> 	Update the debugfs file of the live migration driver.
> 
> Changes v8 -> v9
> 	Update the debugfs directory structure of vfio.
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
> Longfang Liu (4):
>   vfio/migration: Add debugfs to live migration driver
>   hisi_acc_vfio_pci: extract public functions for container_of
>   hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
>   Documentation: add debugfs description for vfio
> 
>  .../ABI/testing/debugfs-hisi-migration        |  32 +++
>  Documentation/ABI/testing/debugfs-vfio        |  25 +++
>  MAINTAINERS                                   |   2 +
>  drivers/vfio/Makefile                         |   1 +
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 203 +++++++++++++++++-
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  drivers/vfio/vfio.h                           |  14 ++
>  drivers/vfio/vfio_debugfs.c                   |  78 +++++++
>  drivers/vfio/vfio_main.c                      |   9 +-
>  include/linux/vfio.h                          |   7 +
>  10 files changed, 371 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>  create mode 100644 drivers/vfio/vfio_debugfs.c
> 

Hi, Alex
Can you help me to review these patches ?

Thanks,
Longfang.
