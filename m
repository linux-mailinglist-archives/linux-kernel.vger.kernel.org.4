Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982F5FD708
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJMJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:26:39 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571B39AC0D;
        Thu, 13 Oct 2022 02:26:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VS37q9T_1665653188;
Received: from 30.221.98.246(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VS37q9T_1665653188)
          by smtp.aliyun-inc.com;
          Thu, 13 Oct 2022 17:26:30 +0800
Message-ID: <f296f028-522a-7a1e-7082-c11377e0af12@linux.alibaba.com>
Date:   Thu, 13 Oct 2022 17:26:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
 <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com>
 <Y0aOcsf06a2+ExrU@wendy>
 <55606b89-13f2-5e3b-9176-bacbec8c36d1@linux.alibaba.com>
 <22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/13 下午1:24, Conor Dooley 写道:
>
> On 13 October 2022 03:28:09 IST, Xianting Tian <xianting.tian@linux.alibaba.com> wrote:
>> 在 2022/10/12 下午5:52, Conor Dooley 写道:
>>> On Wed, Oct 12, 2022 at 05:42:37PM +0800, Xianting Tian wrote:
>>>> 在 2022/8/12 上午12:17, Palmer Dabbelt 写道:
>>>>> On Thu, 11 Aug 2022 00:41:44 PDT (-0700),
>>>>> xianting.tian@linux.alibaba.com wrote:
>>>>>> I ever sent the patch 1 in the link:
>>>>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
>>>>>>
>>>>>> And patch 2,3 in the link:
>>>>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>>>>>>
>>>>>>
>>>>>> This patch set just put these patches together, and with three new
>>>>>> patch 4, 5, 6.
>>>>>> these six patches are the fixups for machine_kexec, kernel mode PC
>>>>>> for vmcore
>>>>>> and improvements for vmcoreinfo, memory layout dump and fixup
>>>>>> schedule out issue
>>>>>> in machine_crash_shutdown().
>>>>>>
>>>>>> The main changes in the six patchs as below,
>>>>>> Patch 1: Fixup use of smp_processor_id() in preemptible context, to
>>>>>> cleanup
>>>>>>            the console prints.
>>>>>> Patch 2: Fixup to get correct kernel mode PC for kernel mode regs
>>>>>> for vmcore.
>>>>>> Patch 3: Fixup schedule out issue in machine_crash_shutdown()
>>>>>> Patch 4: Add modules to virtual kernel memory layout dump.
>>>>>> Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can
>>>>>> simplify
>>>>>>            the development of crash tool as ARM64 already did
>>>>>>            (arch/arm64/kernel/crash_core.c).
>>>>>> Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.
>>>>>>
>>>>>> With these six patches(patch 2 is must), crash tool can work well to
>>>>>> analyze
>>>>>> a vmcore. The patches for crash tool for RISCV64 is in the link:
>>>>>> https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/
>>>>>>
>>>>>>
>>>>>> ------
>>>>>> Changes v1 -> v2:
>>>>>>     1, remove the patch "Add a fast call path of crash_kexec()" from
>>>>>> this series
>>>>>>        of patches, as it already applied to riscv git.
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>>>>>     2, add 'Reviewed-by' based on the comments of v1.
>>>>>> Changes v2 -> v3:
>>>>>>     use "riscv" instead of "riscv64" in patch 5 subject line.
>>>>>> Changes v3 -> v4:
>>>>>>     use "riscv" instead of "riscv64" in the summary of patch 5 subject
>>>>>> line.
>>>>>> Changes v4 -> v5:
>>>>>>     add a new patch "RISC-V: Fixup schedule out issue in
>>>>>> machine_crash_shutdown()"
>>>>>> Changes v5 -> v6:
>>>>>>     1, move "fixup" patches to the start of the patch set.
>>>>>>     2, change patch 1, 2, 6's subject to make it tell more what it's
>>>>>> about.
>>>>>>     3, add Fixes for patch 3.
>>>>>>     4, adjuest the changes format for patch 6.
>>>>>>
>>>>>>
>>>>>> Xianting Tian (6):
>>>>>>     RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
>>>>>>     RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>>>>>>     RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>>>>>>     RISC-V: Add modules to virtual kernel memory layout dump
>>>>>>     RISC-V: Add arch_crash_save_vmcoreinfo support
>>>>>>     Documentation: kdump: describe VMCOREINFO export for RISCV64
>>>>>>
>>>>>>    .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>>>>>>    arch/riscv/kernel/Makefile                    |  1 +
>>>>>>    arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>>>>>>    arch/riscv/kernel/crash_save_regs.S           |  2 +-
>>>>>>    arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
>>>>>>    arch/riscv/mm/init.c                          |  4 +++
>>>>>>    6 files changed, 89 insertions(+), 6 deletions(-)
>>>>>>    create mode 100644 arch/riscv/kernel/crash_core.c
>>>>> Thank.  I've taken the first 4 onto for-next, which is still targeted
>>>>> for 5.20, as they're fixes.  I'm not opposed to taking the documentation
>>>>> patch for this cycle as well, it just needs some going-over as the
>>>>> wording looks very odd (or at least it does to me right now, maybe I'm
>>>>> just still half asleep).  Patch 5 is a new feature, and given that it's
>>>>> being spun during the merge window it's too late.
>>>> Hi Palmer
>>>>
>>>> Do you plan to merge the two patch to Linux 6.1 to support crash tool work?
>>>> thanks
>>>>
>>>>     RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
>>> 357628e68f5c ("RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context"
>>>
>>>>     RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>>> 59c026c359c3 ("RISC-V: Fixup get incorrect user mode PC for kernel mode regs")
>>>
>>> Hey Xianting, those two commits already seem to have been applied, do
>>> you perhaps instead mean the documentation patch and the addition of
>>> support for arch_crash_save_vmcoreinfo? I recalled asking if you needed
>>> to respin at the time, but do not see a response:
>>> https://lore.kernel.org/linux-riscv/39fdc85e-b2d5-863c-4878-4b3380d76bc4@microchip.com/
>>> IIRC Bagas had some outstanding comments on the documentation change
>>> too. Was I incorrect?
>> Sorry, It is the two patches:
>>
>>    RISC-V: Add arch_crash_save_vmcoreinfo support
>>    Documentation: kdump: describe VMCOREINFO export for RISCV64
>>
>> I saw Palmer already merged the two patches to his riscv-crash branch, it means they are OK?
> Dunno, but no harm in resending given it's been a while cycle since then.
I checked the Documentation patch,  the only comment I missed from Bagas is:

Use "Document these RISCV64 exports above" instead of "This patch just 
add the description of VMCOREINFO export for RISCV64" in commit message.

Unfortunately, my patch sending env is broken, I can't send new patch now:(

>
>> https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-crash
>>
>> I saw Bagas's comments, I will send new version patch for the two patches, thanks for the reminder.
>>
>>> Thanks,
>>> Conor.
