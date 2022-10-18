Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BA603356
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJRT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:29:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2E6D56A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=lcM7PDU+W78CbEKHN9YfRJV5gYHnLEK9SFOQzcXXDYA=; b=jgE+5SYp10uf2d7LZp4fW/9e1n
        H0y8oFzq2013vvIW8n9xOwKbx2P1fmnQP65mPNUGrL9rppmd+3Wp2NOS1erj1v20zjVY4ZL8YFDdr
        VkcknO+/MuQwKQssMGpERUh6HycM3mtWZ15fG/EMWrebY1/jqKe5KhlaKY2ZEVe8qXSe88wxjWWau
        /smUoWOlAsmSqBYMvDWAVrF06ISrFJbvnkKat6re3j3M72V03gG3/ICwNCnnM3aHtZdYBwsPK1BpZ
        VmHWZImzI1IU6fCJsNSmx8V3z0QKKtRRTVZxIhILwZcoZo96wq0EqqDawf/VlgPz70yVk6dTjhLud
        Gfr+e5eA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oksGd-00AExV-8e; Tue, 18 Oct 2022 19:28:50 +0000
Message-ID: <46b4bf12-f501-0447-8c3c-8dd0cb91ba92@infradead.org>
Date:   Tue, 18 Oct 2022 12:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Content-Language: en-US
To:     Jane Chu <jane.chu@oracle.com>, Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/18/22 11:56, Jane Chu wrote:
> On 10/18/2022 5:45 AM, Petr Mladek wrote:
>> On Mon 2022-10-17 19:31:53, Jane Chu wrote:
>>> On 10/17/2022 12:25 PM, Andy Shevchenko wrote:
>>>> On Mon, Oct 17, 2022 at 01:16:11PM -0600, Jane Chu wrote:
>>>>> While debugging a separate issue, it was found that an invalid string
>>>>> pointer could very well contain a non-canical address, such as
>>>>> 0x7665645f63616465. In that case, this line of defense isn't enough
>>>>> to protect the kernel from crashing due to general protection fault
>>>>>
>>>>> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>>>>>                   return "(efault)";
>>>>>
>>>>> So instead, use kern_addr_valid() to validate the string pointer.
>>>>
>>>> How did you check that value of the (invalid string) pointer?
>>>>
>>>
>>> In the bug scenario, the invalid string pointer was an out-of-bound
>>> string pointer. While the OOB referencing is fixed,
>>
>> Could you please provide more details about the fixed OOB?
>> What exact vsprintf()/printk() call was broken and eventually
>> how it was fixed, please?
> 
> For sensitive reason, I'd like to avoid mentioning the specific name of 
> the sysfs attribute in the bug, instead, just call it "devX_attrY[]",
> and describe the precise nature of the issue.
> 
> devX_attrY[] is a string array, declared and filled at compile time,
> like
>    const char const devX_attrY[] = {
> 	[ATTRY_A] = "Dev X AttributeY A",
> 	[ATTRY_B] = "Dev X AttributeY B",
> 	...
> 	[ATTRY_G] = "Dev X AttributeY G",
>    }
> such that, when user "cat /sys/devices/systems/.../attry_1",
> "Dev X AttributeY B" will show up in the terminal.
> That's it, no more reference to the pointer devX_attrY[ATTRY_B] after that.
> 
> The bug was that the index to the array was wrongfully produced,
> leading up to OOB, e.g. devX_attrY[11].  The fix was to fix the 
> calculation and that is not an upstream fix.
> 
>>
>>> the lingering issue
>>> is that the kernel ought to be able to protect itself, as the pointer
>>> contains a non-canonical address.
>>
>> Was the pointer used only by the vsprintf()?
>> Or was it accessed also by another code, please?
> 
> The OOB pointer was used only by vsprintf() for the "cat" sysfs case.
> No other code uses the OOB pointer, verified both by code examination 
> and test.
> 
> Here is a snippet of the crash backtrace from an instrumented kernel, 
> scratched one line for sensitive reason -
> 
> crash> bt
> PID: 3250   TASK: ffff9cb50fe23d80  CPU: 18  COMMAND: "cat"
>   #0 [ffffc0bacf377998] machine_kexec at ffffffff9b06c7c1
>   #1 [ffffc0bacf3779f8] __crash_kexec at ffffffff9b13bb52
>   #2 [ffffc0bacf377ac8] crash_kexec at ffffffff9b13cdac
>   #3 [ffffc0bacf377ae8] oops_end at ffffffff9b03357a
>   #4 [ffffc0bacf377b10] die at ffffffff9b033c32
>   #5 [ffffc0bacf377b40] do_general_protection at ffffffff9b030c52
>   #6 [ffffc0bacf377b70] general_protection at ffffffff9ba03db4
>      [exception RIP: string_nocheck+19]
>      RIP: ffffffff9b87cc73  RSP: ffffc0bacf377c20  RFLAGS: 00010286
>      RAX: 0000000000000000  RBX: ffff9da13fc17fff  RCX: ffff0a00ffffff04
>      RDX: 726f635f63616465  RSI: ffff9da13fc17fff  RDI: ffffffffffffffff
>      RBP: ffffc0bacf377c20   R8: ffff9da0bfd2f010   R9: ffff9da0bfc18000
>      R10: 0000000000001000  R11: 0000000000000000  R12: 726f635f63616465
>      R13: ffff0a00ffffff04  R14: ffffffff9c1a6a4f  R15: ffffffff9c1a6a4f
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #7 [ffffc0bacf377c28] string at ffffffff9b87ce98
>   #8 [ffffc0bacf377c58] vsnprintf at ffffffff9b87efe3
>   #9 [ffffc0bacf377cb8] sprintf at ffffffff9b87f506
> #10 [ffffc0bacf377d18] <------------------------------>
> #11 [ffffc0bacf377d28] dev_attr_show at ffffffff9b56d183
> #12 [ffffc0bacf377d48] sysfs_kf_seq_show at ffffffff9b3272dc
> #13 [ffffc0bacf377d68] kernfs_seq_show at ffffffff9b32576c
> #14 [ffffc0bacf377d78] seq_read at ffffffff9b2be407
> #15 [ffffc0bacf377de8] kernfs_fop_read at ffffffff9b325ffe
> #16 [ffffc0bacf377e28] __vfs_read at ffffffff9b2940ea
> #17 [ffffc0bacf377eb0] vfs_read at ffffffff9b2942ac
> #18 [ffffc0bacf377ee0] sys_read at ffffffff9b29485c
> #19 [ffffc0bacf377f28] do_syscall_64 at ffffffff9b003ca9
> #20 [ffffc0bacf377f50] entry_SYSCALL_64_after_hwframe at ffffffff9ba001b1
> 
> crash> dis ffffffff9b87cc73
> 0xffffffff9b87cc73 <string_nocheck+19>: movzbl (%rdx),%r8d
> 
> and RDX: 726f635f63616465 was a non-canonical address.
> 
> After applying this patch to the instrumented kernel, instead of panic, 
> the "cat" command produced  "(efault)"
> 
>>
>> I wonder if this patch would prevent the crash or if the broken
>> kernel would crash later anyway.
> 
> A broken kernel has a different issue to be fixed, the upstream kernel 
> isn't broken, it could just offer better protect in case a bug was 
> introduced in future.
> 
>>
>>> That said, I realized that not all
>>> architecture implement meaningful kern_addr_valid(), so this line
>>>      if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>>> is still need.  I'll send v2.
>>
>> Please, add linux-mm@kvack.org into CC. 
> 
> Will do.
> 
>> I wonder if kern_addr_valid()
>> is safe to use anywhere, especially during early boot. I wonder if
>> it would make sense to implement it on all architectures.
> 
> On x86 architecture, kern_addr_valid() looks safe to me though, on 
> several other architectures, it's defined (1).

You might want to compare this patch, which seems to have some support:

https://lore.kernel.org/lkml/20221018074014.185687-1-wangkefeng.wang@huawei.com/

-- 
~Randy
