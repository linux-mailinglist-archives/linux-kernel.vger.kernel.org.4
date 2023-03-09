Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DA6B1863
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCIBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCIBCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:02:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CBBC7AF;
        Wed,  8 Mar 2023 17:01:51 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PX9qn2KsQzKmTS;
        Thu,  9 Mar 2023 09:01:41 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 09:01:48 +0800
Subject: Re: [bug report] scsi: libsas: Fix hung when disable phys
To:     yangxingui <yangxingui@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Kangfenglong <kangfenglong@huawei.com>,
        John Garry <john.g.garry@oracle.com>
References: <cf7ba927-c872-79c8-6e84-2196c350216e@huawei.com>
 <bd22a19a-dd51-aa34-0794-780368660683@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <cc52e18a-41d2-cff1-a86c-de114d8a140e@hisilicon.com>
Date:   Thu, 9 Mar 2023 09:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <bd22a19a-dd51-aa34-0794-780368660683@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


在 2023/2/27 21:17, yangxingui 写道:
>
> Hi, All
>
> If disabling remote PHY just after disabling all local PHYs in expander
> envirnment,as follows:
> echo 0 > /sys/class/sas_phy/phy-4\:0/enable
> echo 0 > /sys/class/sas_phy/phy-4\:1/enable
> echo 0 > /sys/class/sas_phy/phy-4\:2/enable
> echo 0 > /sys/class/sas_phy/phy-4\:3/enable
> echo 0 > /sys/class/sas_phy/phy-4\:4/enable
> echo 0 > /sys/class/sas_phy/phy-4\:5/enable
> echo 0 > /sys/class/sas_phy/phy-4\:6/enable
> echo 0 > /sys/class/sas_phy/phy-4\:7/enable
> echo 0 > /sys/class/sas_phy/phy-4:0:7/enable
>
> a hung as follows occurs.
>
> [  245.564088] INFO: task kworker/u256:1:883 blocked for more than 120 
> seconds.
> [  245.571115]       Tainted: G           O      5.16.0-rc4+ #1
> [  245.576759] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  245.584557] task:kworker/u256:1  state:D stack:    0 pid:  883 
> ppid:    2 flags:0x00000008
> [  245.592878] Workqueue: 0000:74:02.0_event_q sas_phy_event_worker 
> [libsas]
> [  245.599652] Call trace:
> [  245.602092]  __switch_to+0xd8/0x114
> [  245.605574]  __schedule+0x2f0/0x85c
> [  245.609054]  schedule+0x60/0x100
> [  245.612273]  __kernfs_remove.part.0+0x288/0x2e0
> [  245.616791]  kernfs_remove_by_name_ns+0x70/0xc0
> [  245.621307]  sysfs_remove_file_ns+0x24/0x30
> [  245.625477]  device_remove_file+0x24/0x34
> [  245.629475]  attribute_container_remove_attrs+0x50/0x8c
> [  245.634684]  attribute_container_class_device_del+0x24/0x3c
> [  245.640237]  transport_remove_classdev+0x64/0x80
> [  245.644839]  attribute_container_device_trigger+0x11c/0x124
> [  245.650393]  transport_remove_device+0x24/0x30
> [  245.654823]  sas_phy_delete+0x34/0x60
> [  245.658475]  do_sas_phy_delete+0x60/0x70
> [  245.662385]  device_for_each_child+0x68/0xb0
> [  245.666640]  sas_remove_children+0x44/0x54
> [  245.670723]  sas_destruct_devices+0x5c/0xa0 [libsas]
> [  245.675676]  sas_deform_port+0x178/0x1bc [libsas]
> [  245.680371]  sas_phye_loss_of_signal+0x28/0x34 [libsas]
> [  245.685583]  sas_phy_event_worker+0x3c/0x60 [libsas]
> [  245.690536]  process_one_work+0x1e0/0x46c
> [  245.694534]  worker_thread+0x15c/0x464
> [  245.698272]  kthread+0x188/0x194
> [  245.701491]  ret_from_fork+0x10/0x20
> [  245.705120] INFO: task bash:25579 blocked for more than 120 seconds.
> [  245.711450]       Tainted: G           O      5.16.0-rc4+ #1
> [  245.717087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  245.724883] task:bash            state:D stack:    0 pid:25579 
> ppid: 25113 flags:0x00000200
> [  245.733202] Call trace:
> [  245.735639]  __switch_to+0xd8/0x114
> [  245.739117]  __schedule+0x2f0/0x85c
> [  245.742595]  schedule+0x60/0x100
> [  245.745814]  schedule_timeout+0x180/0x1bc
> [  245.749811]  wait_for_completion+0x8c/0x100
> [  245.753984]  flush_workqueue+0x108/0x3d4
> [  245.757896]  drain_workqueue+0xc8/0x16c
> [  245.761722]  __sas_drain_work+0x54/0x90 [libsas]
> [  245.766328]  sas_drain_work+0x68/0x70 [libsas]
> [  245.770760]  queue_phy_enable+0x9c/0xec [libsas]
> [  245.775368]  store_sas_phy_enable+0xf0/0x10c
> [  245.779624]  dev_attr_store+0x24/0x40
> [  245.783275]  sysfs_kf_write+0x50/0x60
> [  245.786930]  kernfs_fop_write_iter+0x124/0x1b4
> [  245.791361]  new_sync_write+0xf0/0x190
> [  245.795098]  vfs_write+0x23c/0x2a0
> [  245.798490]  ksys_write+0x78/0x104
> [  245.801882]  __arm64_sys_write+0x28/0x3c
> [  245.805794]  invoke_syscall.constprop.0+0x58/0xf0
> [  245.810483]  do_el0_svc+0x19c/0x1b0
> [  245.813962]  el0_svc+0x28/0xec
> [  245.817009]  el0t_64_sync_handler+0x1a8/0x1ac
> [  245.821351]  el0t_64_sync+0x1a0/0x1a4
>
> We find that when all local PHYs are disabled, all the devices will be
> removed in work PHY_LOSS_OF_SIGNAL which will try to wait the kn->active
> of the device to be deactivated (in function kernfs_drain)，but
> kn->active may be still activated as we use sysfs interface to disable
> remote PHYs at the same time, meanwhile it will drain libsas work
> including work PHY_LOSS_OF_SIGNAL in the sysfs interface, so hung
> occurs.
>
> How to fix the problem in this scenario?

It seems be a common issue in libsas layer.
What about directly calling callback function of  phy_enable_work and 
phy_reset_work in function
queue_phy_enable/queue_phy_reset instead of (queue those works + 
sas_drain_work)?


>
> regards,
>
> Xingui
>
> .
>
> .
>

