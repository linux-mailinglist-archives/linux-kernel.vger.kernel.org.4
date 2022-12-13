Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA16A64B1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiLMJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiLMJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:04:36 -0500
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com [115.236.127.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A215A35;
        Tue, 13 Dec 2022 01:03:08 -0800 (PST)
Received: from [0.0.0.0] (unknown [172.96.223.238])
        by mail-m12746.qiye.163.com (Hmail) with ESMTPA id AF687BC03F5;
        Tue, 13 Dec 2022 17:02:58 +0800 (CST)
Message-ID: <e61b69d9-390c-d38d-8df1-5804e5f1ba9d@sangfor.com.cn>
Date:   Tue, 13 Dec 2022 17:03:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] scsi: iscsi_tcp: Fix UAF when access shost attr during
 session logout
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Wenchao Hao <haowenchao22@gmail.com>
Cc:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209082247.6330-1-dinghui@sangfor.com.cn>
 <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
 <CAOptpSO-TMhqR35RW4Sssm29NA=8rJ6-9TgjTVpGKpYOeS_8sA@mail.gmail.com>
 <a60661e9-0ea5-1087-4fbe-27a11cf7edf0@oracle.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <a60661e9-0ea5-1087-4fbe-27a11cf7edf0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH01JVkhDQkxMHxhDTEsaHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpMSVVCTVVJSUhVSUhDWVdZFhoPEhUdFFlBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6TQw*AT0oAk1JCS0YKwk1
        QhFPCyJVSlVKTUxLQklJSkNIQ0lKVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKTElVQk1VSUlIVUlIQ1lXWQgBWUFDTUNLNwY+
X-HM-Tid: 0a850ab92039b219kuuuaf687bc03f5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 1:00, Mike Christie wrote:
> On 12/11/22 8:32 AM, Wenchao Hao wrote:
>> On Sun, Dec 11, 2022 at 6:07 AM Mike Christie
>> <michael.christie@oracle.com> wrote:
>>>
>>> On 12/9/22 2:22 AM, Ding Hui wrote:
>>>> During iscsi session logout, if another task accessing shost ipaddress
>>>> attr at this time, we can get a KASAN UAF report like this:
>>>>
>>>> [  276.941685] ==================================================================
>>>> [  276.942144] BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x78/0xe0
>>>> [  276.942535] Write of size 4 at addr ffff8881053b45b8 by task cat/4088
>>>> [  276.943511] CPU: 2 PID: 4088 Comm: cat Tainted: G            E      6.1.0-rc8+ #3
>>>> [  276.943997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>> [  276.944470] Call Trace:
>>>> [  276.944943]  <TASK>
>>>> [  276.945397]  dump_stack_lvl+0x34/0x48
>>>> [  276.945887]  print_address_description.constprop.0+0x86/0x1e7
>>>> [  276.946421]  print_report+0x36/0x4f
>>>> [  276.947358]  kasan_report+0xad/0x130
>>>> [  276.948234]  kasan_check_range+0x35/0x1c0
>>>> [  276.948674]  _raw_spin_lock_bh+0x78/0xe0
>>>> [  276.949989]  iscsi_sw_tcp_host_get_param+0xad/0x2e0 [iscsi_tcp]
>>>> [  276.951765]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0xe9/0x130 [scsi_transport_iscsi]
>>>> [  276.952185]  dev_attr_show+0x3f/0x80
>>>> [  276.953005]  sysfs_kf_seq_show+0x1fb/0x3e0
>>>> [  276.953401]  seq_read_iter+0x402/0x1020
>>>> [  276.954260]  vfs_read+0x532/0x7b0
>>>> [  276.955113]  ksys_read+0xed/0x1c0
>>>> [  276.955952]  do_syscall_64+0x38/0x90
>>>> [  276.956347]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>> [  276.956769] RIP: 0033:0x7f5d3a679222
>>>> [  276.957161] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 32 c0 0b 00 e8 a5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
>>>> [  276.958009] RSP: 002b:00007ffc864d16a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>>> [  276.958431] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5d3a679222
>>>> [  276.958857] RDX: 0000000000020000 RSI: 00007f5d3a4fe000 RDI: 0000000000000003
>>>> [  276.959281] RBP: 00007f5d3a4fe000 R08: 00000000ffffffff R09: 0000000000000000
>>>> [  276.959682] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
>>>> [  276.960126] R13: 0000000000000003 R14: 0000000000000000 R15: 0000557a26dada58
>>>> [  276.960536]  </TASK>
>>>> [  276.961357] Allocated by task 2209:
>>>> [  276.961756]  kasan_save_stack+0x1e/0x40
>>>> [  276.962170]  kasan_set_track+0x21/0x30
>>>> [  276.962557]  __kasan_kmalloc+0x7e/0x90
>>>> [  276.962923]  __kmalloc+0x5b/0x140
>>>> [  276.963308]  iscsi_alloc_session+0x28/0x840 [scsi_transport_iscsi]
>>>> [  276.963712]  iscsi_session_setup+0xda/0xba0 [libiscsi]
>>>> [  276.964078]  iscsi_sw_tcp_session_create+0x1fd/0x330 [iscsi_tcp]
>>>> [  276.964431]  iscsi_if_create_session.isra.0+0x50/0x260 [scsi_transport_iscsi]
>>>> [  276.964793]  iscsi_if_recv_msg+0xc5a/0x2660 [scsi_transport_iscsi]
>>>> [  276.965153]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
>>>> [  276.965546]  netlink_unicast+0x4d5/0x7b0
>>>> [  276.965905]  netlink_sendmsg+0x78d/0xc30
>>>> [  276.966236]  sock_sendmsg+0xe5/0x120
>>>> [  276.966576]  ____sys_sendmsg+0x5fe/0x860
>>>> [  276.966923]  ___sys_sendmsg+0xe0/0x170
>>>> [  276.967300]  __sys_sendmsg+0xc8/0x170
>>>> [  276.967666]  do_syscall_64+0x38/0x90
>>>> [  276.968028]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>> [  276.968773] Freed by task 2209:
>>>> [  276.969111]  kasan_save_stack+0x1e/0x40
>>>> [  276.969449]  kasan_set_track+0x21/0x30
>>>> [  276.969789]  kasan_save_free_info+0x2a/0x50
>>>> [  276.970146]  __kasan_slab_free+0x106/0x190
>>>> [  276.970470]  __kmem_cache_free+0x133/0x270
>>>> [  276.970816]  device_release+0x98/0x210
>>>> [  276.971145]  kobject_cleanup+0x101/0x360
>>>> [  276.971462]  iscsi_session_teardown+0x3fb/0x530 [libiscsi]
>>>> [  276.971775]  iscsi_sw_tcp_session_destroy+0xd8/0x130 [iscsi_tcp]
>>>> [  276.972143]  iscsi_if_recv_msg+0x1bf1/0x2660 [scsi_transport_iscsi]
>>>> [  276.972485]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
>>>> [  276.972808]  netlink_unicast+0x4d5/0x7b0
>>>> [  276.973201]  netlink_sendmsg+0x78d/0xc30
>>>> [  276.973544]  sock_sendmsg+0xe5/0x120
>>>> [  276.973864]  ____sys_sendmsg+0x5fe/0x860
>>>> [  276.974248]  ___sys_sendmsg+0xe0/0x170
>>>> [  276.974583]  __sys_sendmsg+0xc8/0x170
>>>> [  276.974891]  do_syscall_64+0x38/0x90
>>>> [  276.975216]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>
>>>> We can easily reproduce by two tasks:
>>>> 1. while :; do iscsiadm -m node --login; iscsiadm -m node --logout; done
>>>> 2. while :; do cat /sys/devices/platform/host*/iscsi_host/host*/ipaddress; done
>>>>
>>>>              iscsid                |        cat
>>>> ----------------------------------+-------------------------------------------------
>>>> |- iscsi_sw_tcp_session_destroy   |
>>>>    |- iscsi_session_teardown       |
>>>>      |- device_release             |
>>>>        |- iscsi_session_release    |  |- dev_attr_show
>>>>          |- kfree                  |    |- show_host_param_ISCSI_HOST_PARAM_IPADDRESS
>>>>                                    |      |- iscsi_sw_tcp_host_get_param
>>>>                                    |        |- r/w tcp_sw_host->session (UAF)
>>>>    |- iscsi_host_remove            |
>>>>    |- iscsi_host_free              |
>>>>
>>>> Since shost hold a pointer to session which is belong to cls_session by its
>>>> priv tcp_sw_host, so we should get a ref of cls_session, and after
>>>> iscsi_host_remove() the sysfs is cleared, then we can drop the ref.
>>>>
>>>
>>> Nice bug report and thanks for the patch. I think though we should just
>>> split the removal from the freeing. The removal will wait on users
>>> accessing sysfs files for us, so once they return we know we can just
>>> free things.
>>>
>>> Something like this:
>>>
>>>
>>
>> Hi, dinghui and Mike, I submitted patches to fix this issue one year
>> ago. But I missed Mike's
>> reply because I was new to the community, so the patches did not keep on.
>>
>> https://lore.kernel.org/linux-scsi/20210407012450.97754-1-haowenchao@huawei.com/
>>
>> Because of my negligence, this bug has been discovered so far, and I
>> apologize for this.
> 
> Ah yeah, I remember that now. Don't worry about it. It was also my fault
> for not pinging you.
> 
> I'll fix up my patches into a proper patchset and submit.
> 

Hi Wenchao and Mike,

Thanks for your work, I am looking forward to it.

-- 
Thanks,
- Ding Hui

