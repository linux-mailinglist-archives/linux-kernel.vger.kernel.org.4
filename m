Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F47623E29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKJJAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:59:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB27EB6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:59:57 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7G4K1RXkzRpF9;
        Thu, 10 Nov 2022 16:59:45 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:59:55 +0800
Message-ID: <8796ba38-8aa4-42d5-d8b2-ee0d539a191a@huawei.com>
Date:   Thu, 10 Nov 2022 16:59:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] vdpa_sim: fix possible memory leak in
 vdpasim_net_init() and vdpasim_blk_init()
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <gautam.dawar@xilinx.com>, <elic@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20221110050446.3932031-1-ruanjinjie@huawei.com>
 <20221110080147.bpfumiab2yt7nehf@sgarzare-redhat>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20221110080147.bpfumiab2yt7nehf@sgarzare-redhat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much!

On 2022/11/10 16:01, Stefano Garzarella wrote:
> Hi,
> 
> On Thu, Nov 10, 2022 at 01:04:46PM +0800, ruanjinjie wrote:
>> Inject fault while probing module, if device_register() fails in
>> vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
>> not decreased to 0, the name allocated in dev_set_name() is leaked.
>> Fix this by calling put_device(), so that name can be freed in
>> callback function kobject_cleanup().
>>
>> (vdpa_sim_net)
>> unreferenced object 0xffff88807eebc370 (size 16):
>>  comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
>>  hex dump (first 16 bytes):
>>    76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
>>  backtrace:
>>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>>    [<ffffffffa0270013>] 0xffffffffa0270013
>>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> (vdpa_sim_blk)
>> unreferenced object 0xffff8881070c1250 (size 16):
>>  comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
>>  hex dump (first 16 bytes):
>>    76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
>>  backtrace:
>>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>>    [<ffffffffa0220013>] 0xffffffffa0220013
>>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - add fault inject message
>> ---
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
>> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
>> 2 files changed, 6 insertions(+), 2 deletions(-)
> 
> Thanks for the v2 of this patch!
> It LGTM, just a couple of comments about the submit process.
> 
> Usually when you get A-b R-b's and the patch doesn't change, it's better
> to bring them in later versions.
> 
> Also, we had suggested reporting the Fixes tag, because usually when we
> fix a bug it's good to identify which patch introduced the problem, so
> it's easier to backport this fix into stable versions of the kernel.
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
> 
> In this case we should use the following tags:
> 
> Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported
> devices")
> 
> With them:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 
