Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFD611F79
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJ2Cze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJ2Czc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:55:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0A659C9;
        Fri, 28 Oct 2022 19:54:56 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzkSs4fPRzpVZw;
        Sat, 29 Oct 2022 10:51:25 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 10:54:53 +0800
Message-ID: <46fbef33-13a3-3909-0345-628e98a5b460@huawei.com>
Date:   Sat, 29 Oct 2022 10:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4] cifs: fix use-after-free caused by invalid pointer
 `hostname`
Content-Language: en-US
To:     Shyam Prasad N <nspmangalore@gmail.com>
CC:     <sfrench@samba.org>, <tom@talpey.com>, <sprasad@microsoft.com>,
        <pc@cjr.nz>, <lsahlber@redhat.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
References: <20221027124528.2487025-1-zengheng4@huawei.com>
 <CANT5p=q50Kt+eyVaxyh891sizFSzC=eUp5P46ON-odHFRjMsEQ@mail.gmail.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <CANT5p=q50Kt+eyVaxyh891sizFSzC=eUp5P46ON-odHFRjMsEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure `cifsd` terminated to avoid race condition, it has to call 
function like kthread_stop.

Then the whole `server` struct would be released by `cifsd` and another 
UAF appears.


On 2022/10/28 13:41, Shyam Prasad N wrote:
> On Thu, Oct 27, 2022 at 6:19 PM Zeng Heng <zengheng4@huawei.com> wrote:
>> `hostname` needs to be set as null-pointer after free in
>> `cifs_put_tcp_session` function, or when `cifsd` thread attempts
>> to resolve hostname and reconnect the host, the thread would deref
>> the invalid pointer.
>>
>> Here is one of practical backtrace examples as reference:
>>
>> Task 477
>> ---------------------------
>>   do_mount
>>    path_mount
>>     do_new_mount
>>      vfs_get_tree
>>       smb3_get_tree
>>        smb3_get_tree_common
>>         cifs_smb3_do_mount
>>          cifs_mount
>>           mount_put_conns
>>            cifs_put_tcp_session
>>            --> kfree(server->hostname)
>>
>> cifsd
>> ---------------------------
>>   kthread
>>    cifs_demultiplex_thread
>>     cifs_reconnect
>>      reconn_set_ipaddr_from_hostname
>>      --> if (!server->hostname)
>>      --> if (server->hostname[0] == '\0')  // !! UAF fault here
>>
>> CIFS: VFS: cifs_mount failed w/return code = -112
>> mount error(112): Host is down
>> BUG: KASAN: use-after-free in reconn_set_ipaddr_from_hostname+0x2ba/0x310
>> Read of size 1 at addr ffff888108f35380 by task cifsd/480
>> CPU: 2 PID: 480 Comm: cifsd Not tainted 6.1.0-rc2-00106-gf705792f89dd-dirty #25
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x68/0x85
>>   print_report+0x16c/0x4a3
>>   kasan_report+0x95/0x190
>>   reconn_set_ipaddr_from_hostname+0x2ba/0x310
>>   __cifs_reconnect.part.0+0x241/0x800
>>   cifs_reconnect+0x65f/0xb60
>>   cifs_demultiplex_thread+0x1570/0x2570
>>   kthread+0x2c5/0x380
>>   ret_from_fork+0x22/0x30
>>   </TASK>
>> Allocated by task 477:
>>   kasan_save_stack+0x1e/0x40
>>   kasan_set_track+0x21/0x30
>>   __kasan_kmalloc+0x7e/0x90
>>   __kmalloc_node_track_caller+0x52/0x1b0
>>   kstrdup+0x3b/0x70
>>   cifs_get_tcp_session+0xbc/0x19b0
>>   mount_get_conns+0xa9/0x10c0
>>   cifs_mount+0xdf/0x1970
>>   cifs_smb3_do_mount+0x295/0x1660
>>   smb3_get_tree+0x352/0x5e0
>>   vfs_get_tree+0x8e/0x2e0
>>   path_mount+0xf8c/0x1990
>>   do_mount+0xee/0x110
>>   __x64_sys_mount+0x14b/0x1f0
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> Freed by task 477:
>>   kasan_save_stack+0x1e/0x40
>>   kasan_set_track+0x21/0x30
>>   kasan_save_free_info+0x2a/0x50
>>   __kasan_slab_free+0x10a/0x190
>>   __kmem_cache_free+0xca/0x3f0
>>   cifs_put_tcp_session+0x30c/0x450
>>   cifs_mount+0xf95/0x1970
>>   cifs_smb3_do_mount+0x295/0x1660
>>   smb3_get_tree+0x352/0x5e0
>>   vfs_get_tree+0x8e/0x2e0
>>   path_mount+0xf8c/0x1990
>>   do_mount+0xee/0x110
>>   __x64_sys_mount+0x14b/0x1f0
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> The buggy address belongs to the object at ffff888108f35380
>>   which belongs to the cache kmalloc-16 of size 16
>> The buggy address is located 0 bytes inside of
>>   16-byte region [ffff888108f35380, ffff888108f35390)
>> The buggy address belongs to the physical page:
>> page:00000000333f8e58 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888108f350e0 pfn:0x108f35
>> flags: 0x200000000000200(slab|node=0|zone=2)
>> raw: 0200000000000200 0000000000000000 dead000000000122 ffff8881000423c0
>> raw: ffff888108f350e0 000000008080007a 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> Memory state around the buggy address:
>>   ffff888108f35280: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>>   ffff888108f35300: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>>> ffff888108f35380: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>>                     ^
>>   ffff888108f35400: fa fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888108f35480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>
>> Fixes: 7be3248f3139 ("cifs: To match file servers, make sure the server hostname matches")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>> ---
>> changes in v4:
>>   - correct fix tag
>>   - add reviewed-by
>> ---
>>   fs/cifs/connect.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
>> index ffb291579bb9..1cc47dd3b4d6 100644
>> --- a/fs/cifs/connect.c
>> +++ b/fs/cifs/connect.c
>> @@ -1584,6 +1584,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
>>          server->session_key.response = NULL;
>>          server->session_key.len = 0;
>>          kfree(server->hostname);
>> +       server->hostname = NULL;
>>
>>          task = xchg(&server->tsk, NULL);
>>          if (task)
>> --
>> 2.25.1
>>
> Good catch. But I think there can be a better fix.
> How about moving the lines that follow i.e. cifsd thread kill to
> before setting tcpStatus? That way, we don't leave scope for things to
> race.
>
