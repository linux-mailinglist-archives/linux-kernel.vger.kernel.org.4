Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B266621B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjAIJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjAIJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:37:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA47645F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:37:26 -0800 (PST)
Received: from kwepemm600001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nr82J5XXZz16Mgs;
        Mon,  9 Jan 2023 17:35:52 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 17:37:24 +0800
Message-ID: <54066d0e-ef50-183f-74fe-551bb99741eb@huawei.com>
Date:   Mon, 9 Jan 2023 17:37:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] kobject: Fix slab-out-of-bounds in fill_kobj_path()
From:   Wang Hai <wanghai38@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <anthony.l.nguyen@intel.com>, <rafael@kernel.org>,
        <jesse.brandeburg@intel.com>, <alice.chao@mediatek.com>
References: <20221220012143.52141-1-wanghai38@huawei.com>
In-Reply-To: <20221220012143.52141-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/20 9:21, Wang Hai 写道:
> In kobject_get_path(), if kobj->name is changed between calls
> get_kobj_path_length() and fill_kobj_path() and the length becomes
> longer, then fill_kobj_path() will have an out-of-bounds bug.
>
> The actual current problem occurs when the ixgbe probe.
>
> In ixgbe_mii_bus_init(), if the length of netdev->dev.kobj.name
> length becomes longer, out-of-bounds will occur.
>
> cpu0                                         cpu1
> ixgbe_probe
>   register_netdev(netdev)
>    netdev_register_kobject
>     device_add
>      kobject_uevent // Sending ADD events
>                                               systemd-udevd // rename netdev
>                                                dev_change_name
>                                                 device_rename
>                                                  kobject_rename
>   ixgbe_mii_bus_init                             |
>    mdiobus_register                              |
>     __mdiobus_register                           |
>      device_register                             |
>       device_add                                 |
>        kobject_uevent                            |
>         kobject_get_path                         |
>          len = get_kobj_path_length // old name  |
>          path = kzalloc(len, gfp_mask);          |
>                                                  kobj->name = name;
>                                                  /* name length becomes
>                                                   * longer
>                                                   */
>          fill_kobj_path /* kobj path length is
>                          * longer than path,
>                          * resulting in out of
>                          * bounds when filling path
>                          */
>
> This is the kasan report:
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in fill_kobj_path+0x50/0xc0
> Write of size 7 at addr ff1100090573d1fd by task kworker/28:1/673
>
>   Workqueue: events work_for_cpu_fn
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x34/0x48
>   print_address_description.constprop.0+0x86/0x1e7
>   print_report+0x36/0x4f
>   kasan_report+0xad/0x130
>   kasan_check_range+0x35/0x1c0
>   memcpy+0x39/0x60
>   fill_kobj_path+0x50/0xc0
>   kobject_get_path+0x5a/0xc0
>   kobject_uevent_env+0x140/0x460
>   device_add+0x5c7/0x910
>   __mdiobus_register+0x14e/0x490
>   ixgbe_probe.cold+0x441/0x574 [ixgbe]
>   local_pci_probe+0x78/0xc0
>   work_for_cpu_fn+0x26/0x40
>   process_one_work+0x3b6/0x6a0
>   worker_thread+0x368/0x520
>   kthread+0x165/0x1a0
>   ret_from_fork+0x1f/0x30
>
> This reproducer triggers that bug:
>
> while:
> do
>      rmmod ixgbe
>      sleep 0.5
>      modprobe ixgbe
>      sleep 0.5
>
> When calling fill_kobj_path() to fill path, if the name length of
> kobj becomes longer, return failure and retry. This fixes the problem.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
Hi, greg k-h.
Sorry to bother you. Can this patch be merged into the mainline?

-- 
Wang Hai

