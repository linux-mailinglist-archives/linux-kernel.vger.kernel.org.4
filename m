Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0A728A42
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjFHV3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjFHV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:29:33 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10142D4A;
        Thu,  8 Jun 2023 14:29:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QccXS0Rsrz9y10X;
        Fri,  9 Jun 2023 05:19:04 +0800 (CST)
Received: from [10.81.214.99] (unknown [10.81.214.99])
        by APP1 (Coremail) with SMTP id LxC2BwC3PwsoSIJkXE0hAw--.4266S2;
        Thu, 08 Jun 2023 22:29:18 +0100 (CET)
Message-ID: <688c274d-a4d2-9dc2-3bc0-ffd147f0bafd@huaweicloud.com>
Date:   Thu, 8 Jun 2023 23:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] memfd: Check for non-NULL file_seals in memfd_create()
 syscall
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230607132427.2867435-1-roberto.sassu@huaweicloud.com>
 <20230607102131.11964c87b1078374c9d4b341@linux-foundation.org>
 <6663c7b0-26f5-bdd9-1209-b1c4d8ad31cc@huaweicloud.com>
In-Reply-To: <6663c7b0-26f5-bdd9-1209-b1c4d8ad31cc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3PwsoSIJkXE0hAw--.4266S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF15XF4rAry8ZF1xur48WFg_yoW7XF47pr
        y8XayDGrW8tr18Xr17Ar1j9ryUJa12y3W8Xrn2yFWrAFnFvF1qvw4DXF4j9ryDCr48Zw17
        Ja1kJFn2vF18A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj4p0PwABs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2023 11:05 PM, Roberto Sassu wrote:
> On 6/7/2023 7:21 PM, Andrew Morton wrote:
>> On Wed,  7 Jun 2023 15:24:27 +0200 Roberto Sassu 
>> <roberto.sassu@huaweicloud.com> wrote:
>>
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Ensure that file_seals is non-NULL before using it in the memfd_create()
>>> syscall. One situation in which memfd_file_seals_ptr() could return a 
>>> NULL
>>> pointer is when CONFIG_SHMEM=n.
>>
>> Thanks.  Has thie crash actually been demonstrated?
> 
> Welcome. Yes, I noticed it when booting Fedora 38:
> 
> Jun 07 11:45:17 localhost kernel: BUG: kernel NULL pointer dereference, 
> address: 0000000000000000
> Jun 07 11:45:17 localhost kernel: #PF: supervisor write access in kernel 
> mode
> Jun 07 11:45:17 localhost kernel: #PF: error_code(0x0002) - not-present 
> page
> Jun 07 11:45:17 localhost kernel: PGD 0 P4D 0
> Jun 07 11:45:17 localhost kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
> Jun 07 11:45:17 localhost kernel: CPU: 0 PID: 752 Comm: dbus-broker-lau 
> Not tainted 6.4.0-rc1+ #596
> Jun 07 11:45:17 localhost kernel: Hardware name: QEMU Standard PC (Q35 + 
> ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Jun 07 11:45:17 localhost kernel: RIP: 
> 0010:__do_sys_memfd_create+0x2a4/0x320
> Jun 07 11:45:17 localhost kernel: Code: ff 83 e3 02 0f 84 6a ff ff ff 49 
> 81 7d 28 00 cd 24 82 74 0c 4c 89 ef e8 5a 6c 27 00 84 c0 74 29 49 8b 45 
> 20 48 05 88 04 00 0>
> Jun 07 11:45:17 localhost kernel: RSP: 0018:ffffc900007d3ef8 EFLAGS: 
> 00010246
> Jun 07 11:45:17 localhost kernel: RAX: 0000000000000000 RBX: 
> 0000000000000002 RCX: 0000000000000000
> Jun 07 11:45:17 localhost kernel: RDX: 0000000000000003 RSI: 
> 0000000000000004 RDI: ffff888012ab1600
> Jun 07 11:45:17 localhost kernel: RBP: ffff888025eb4d60 R08: 
> 0000000000000000 R09: 0000000000000000
> Jun 07 11:45:17 localhost kernel: R10: ffffffff83524c90 R11: 
> 0000000000000000 R12: 000000000000000c
> Jun 07 11:45:17 localhost kernel: R13: ffff888012ab1600 R14: 
> ffff888025eb4d66 R15: 0000000000000000
> Jun 07 11:45:17 localhost kernel: FS:  00007f4ef466de80(0000) 
> GS:ffff88807dc00000(0000) knlGS:0000000000000000
> Jun 07 11:45:17 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> Jun 07 11:45:17 localhost kernel: CR2: 0000000000000000 CR3: 
> 000000000e7fe000 CR4: 0000000000350ef0
> Jun 07 11:45:17 localhost kernel: Call Trace:
> Jun 07 11:45:17 localhost kernel:  <TASK>
> Jun 07 11:45:17 localhost kernel:  do_syscall_64+0x3b/0x90
> Jun 07 11:45:17 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> Jun 07 11:45:17 localhost kernel: RIP: 0033:0x7f4ef4a0dd2d
> Jun 07 11:45:17 localhost kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 
> 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 
> 4c 8b 4c 24 08 0f 0>
> Jun 07 11:45:17 localhost kernel: RSP: 002b:00007fff308c5b58 EFLAGS: 
> 00000246 ORIG_RAX: 000000000000013f
> Jun 07 11:45:17 localhost kernel: RAX: ffffffffffffffda RBX: 
> 00005597c14742d8 RCX: 00007f4ef4a0dd2d
> Jun 07 11:45:17 localhost kernel: RDX: 00007f4ef49dfa5b RSI: 
> 0000000000000003 RDI: 00005597c0b8f778
> Jun 07 11:45:17 localhost kernel: RBP: 00007fff308c5b80 R08: 
> 0000000000000000 R09: 00007fff308c5fa0
> Jun 07 11:45:17 localhost kernel: R10: 0000000000000000 R11: 
> 0000000000000246 R12: 0000000000000000
> Jun 07 11:45:17 localhost kernel: R13: 00007fff308c5e60 R14: 
> 00007fff308c5c20 R15: 00007fff308c5c00
> Jun 07 11:45:17 localhost kernel:  </TASK>
> Jun 07 11:45:17 localhost kernel: Modules linked in: sunrpc 
> intel_rapl_msr intel_rapl_common kvm_amd snd_hda_codec_generic ccp 
> snd_hda_intel snd_intel_dspcfg iTCO_w>
> Jun 07 11:45:17 localhost kernel: CR2: 0000000000000000
> Jun 07 11:45:17 localhost kernel: ---[ end trace 0000000000000000 ]---
> 
> Thanks for picking the patches. If it is still possible, it seems
> that the Fixes tag is incorrect. The fixed commit should be:
> 
> c3b1b1cbf002 ("ramfs: add support for "mode=" mount option")

Ops, sorry. The comment above was for the patch: shmem: Use 
ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs.

Thanks

Roberto

> Roberto
> 
>>> --- a/mm/memfd.c
>>> +++ b/mm/memfd.c
>>> @@ -371,12 +371,15 @@ SYSCALL_DEFINE2(memfd_create,
>>>           inode->i_mode &= ~0111;
>>>           file_seals = memfd_file_seals_ptr(file);
>>> -        *file_seals &= ~F_SEAL_SEAL;
>>> -        *file_seals |= F_SEAL_EXEC;
>>> +        if (file_seals) {
>>> +            *file_seals &= ~F_SEAL_SEAL;
>>> +            *file_seals |= F_SEAL_EXEC;
>>> +        }
>>>       } else if (flags & MFD_ALLOW_SEALING) {
>>>           /* MFD_EXEC and MFD_ALLOW_SEALING are set */
>>>           file_seals = memfd_file_seals_ptr(file);
>>> -        *file_seals &= ~F_SEAL_SEAL;
>>> +        if (file_seals)
>>> +            *file_seals &= ~F_SEAL_SEAL;
>>>       }
>>>       fd_install(fd, file);

