Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10364BF40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiLMWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379051F9F1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670969953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CHoK2HpHhEEysAUZtzY/hl1zhUH9ZxpSfovvfrKLKw=;
        b=elu8lDCvrJKFi8gXMBnZq8q+8wnq2iyiys6YHCxG3VsSR3SIGUid+NOK6jA6qUlIcpHV8T
        E+wBGSlRx99dk3FeB61gTw9nTs43nMqfEufapLH0yJoNSC6+uz3h5yZbCIs7GVZui8hKtC
        +EoAgu5PMjiEszjo73f+EeWPD8i9Q6Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-8oifaLg0OE2h1Fn95kM7dg-1; Tue, 13 Dec 2022 17:19:12 -0500
X-MC-Unique: 8oifaLg0OE2h1Fn95kM7dg-1
Received: by mail-qk1-f197.google.com with SMTP id br8-20020a05620a460800b006fbf8866293so1257315qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:subject:from:references:cc:to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CHoK2HpHhEEysAUZtzY/hl1zhUH9ZxpSfovvfrKLKw=;
        b=Fzvnral9zM+tSVnHkTQ77RRu46O4QfbhJkcdZSfxXlpwkmKc9LWkeZLzA1LDX/9rtj
         Q0jDtaICOFU3enDVXnWuea2V7P7aFVlGtrqHXcPAr2AFKNMSSGoVKfV6W5fPuSOUK9E1
         3jwxVD0Rg3ewOwcQz9Rx6ZMBNmrAewu7c2+Uconw6nRwR6s9ypQiRVE5YTtYWQXi82by
         OwY1hD8vCpQ+YCB6398QQ0g/Oz8rGef79AYTQoTbKSbTEnOdk6Mgeq2O05OstjZD0Qig
         hi9OAQT96VnFiKWiS7KYDXWlRMZ2su3SHp0ccheTT6yM0tL23mIVaU3ysqFe3ZL6idPo
         oF/g==
X-Gm-Message-State: ANoB5pnd4lPfr8bPq3XCepkSwW++8NtPz4pcUM24EXdVPhtpvdQxc1kU
        B+ky3rXJFVc7GWVUYaUpBki3hgsgEmexRkBUboFKYDj8V8fXFg/F9+J7+Rmt1D+ri4Q9HQ2bkYK
        CreiJ6RIUfXH3LuNprR6fygsg
X-Received: by 2002:ac8:775c:0:b0:3a8:1c25:57fa with SMTP id g28-20020ac8775c000000b003a81c2557famr5875066qtu.42.1670969951507;
        Tue, 13 Dec 2022 14:19:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OhAgFQn7DTQvxgad+rjUjO0fppY7ZjavOoJKidh13WEzvYiqGgupHyqI/NwTf4duGAn323A==
X-Received: by 2002:ac8:775c:0:b0:3a8:1c25:57fa with SMTP id g28-20020ac8775c000000b003a81c2557famr5875024qtu.42.1670969951098;
        Tue, 13 Dec 2022 14:19:11 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8124b000000b003a57eb7f212sm616807qtj.10.2022.12.13.14.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 14:19:10 -0800 (PST)
To:     Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>
References: <20220901171252.2148348-1-song@kernel.org>
 <Y3expGRt4cPoZgHL@alley>
 <CAPhsuW4qYpX7wzHn5J5Hn9cnOFSZwwQPCjTM_HPTt_zbBS03ww@mail.gmail.com>
 <Y5Me5dTGv+GznvtO@alley>
 <CAPhsuW4pt7vfHTj8KorTRCx5zJaoUiyYUOLy8uXZDbTbur4RRA@mail.gmail.com>
 <Y5dg25LV24mBRf4t@alley>
 <CAPhsuW7y1GzT8+quk4vJEqM6SagqDqc=HXA3jtdmfTfC=Gsv-Q@mail.gmail.com>
 <Y5h+PX6a1a9yjQPp@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: powerpc-part: was: Re: [PATCH v6] livepatch: Clear relocation
 targets on a module removal
Message-ID: <21984193-f9a5-1a7d-ecb7-0ae74b8cf202@redhat.com>
Date:   Tue, 13 Dec 2022 17:19:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y5h+PX6a1a9yjQPp@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 8:29 AM, Petr Mladek wrote:
> On Tue 2022-12-13 00:13:46, Song Liu wrote:
>> )() ()On Mon, Dec 12, 2022 at 9:12 AM Petr Mladek <pmladek@suse.com> wrote:
>>>
>>> On Fri 2022-12-09 11:59:35, Song Liu wrote:
>>>> On Fri, Dec 9, 2022 at 3:41 AM Petr Mladek <pmladek@suse.com> wrote:
>>>>> On Mon 2022-11-28 17:57:06, Song Liu wrote:
>>>>>> On Fri, Nov 18, 2022 at 8:24 AM Petr Mladek <pmladek@suse.com> wrote:
>>>>>>>
>>>>>>>> --- a/arch/powerpc/kernel/module_64.c
>>>>>>>> +++ b/arch/powerpc/kernel/module_64.c
>>>>>>>> +#ifdef CONFIG_LIVEPATCH
>>>>>>>> +void clear_relocate_add(Elf64_Shdr *sechdrs,
>>>>>>>> +                    const char *strtab,
>>>>>>>> +                    unsigned int symindex,
>>>>>>>> +                    unsigned int relsec,
>>>>>>>> +                    struct module *me)
>>>>>>>> +{
>>>
>>> [...]
>>>
>>>>>>>> +
>>>>>>>> +             instruction = (u32 *)location;
>>>>>>>> +             if (is_mprofile_ftrace_call(symname))
>>>>>>>> +                     continue;
>>>>>
>>>>> Why do we ignore these symbols?
>>>>>
>>>>> I can't find any counter-part in apply_relocate_add(). It looks super
>>>>> tricky. It would deserve a comment.
>>>>>
>>>>> And I have no idea how we could maintain these exceptions.
>>>>>
>>>>>>>> +             if (!instr_is_relative_link_branch(ppc_inst(*instruction)))
>>>>>>>> +                     continue;
>>>>>
>>>>> Same here. It looks super tricky and there is no explanation.
>>>>
>>>> The two checks are from restore_r2(). But I cannot really remember
>>>> why we needed them. It is probably an updated version from an earlier
>>>> version (3 year earlier..).
>>>
>>> This is a good sign that it has to be explained in a comment.
>>> Or even better, it should not by copy pasted.
>>>
>>>>>>>> +             instruction += 1;
>>>>>>>> +             patch_instruction(instruction, ppc_inst(PPC_RAW_NOP()));
>>>
>>> I believe that this is not enough. apply_relocate_add() does this:
>>>
>>> int apply_relocate_add(Elf64_Shdr *sechdrs,
>>> [...]
>>>                        struct module *me)
>>> {
>>> [...]
>>>                 case R_PPC_REL24:
>>>                         /* FIXME: Handle weak symbols here --RR */
>>>                         if (sym->st_shndx == SHN_UNDEF ||
>>>                             sym->st_shndx == SHN_LIVEPATCH) {
>>> [...]
>>>                         if (!restore_r2(strtab + sym->st_name,
>>>                                                         (u32 *)location + 1, me))
>>> [...]                                   return -ENOEXEC;
>>>
>>> --->                    if (patch_instruction((u32 *)location, ppc_inst(value)))
>>>                                 return -EFAULT;
>>>
>>> , where restore_r2() does:
>>>
>>> static int restore_r2(const char *name, u32 *instruction, struct module *me)
>>> {
>>> [...]
>>>         /* ld r2,R2_STACK_OFFSET(r1) */
>>> --->    if (patch_instruction(instruction, ppc_inst(PPC_INST_LD_TOC)))
>>>                 return 0;
>>> [...]
>>> }
>>>
>>> By other words, apply_relocate_add() modifies two instructions:
>>>
>>>    + patch_instruction() called in restore_r2() writes into "location + 1"
>>>    + patch_instruction() called in apply_relocate_add() writes into "location"
>>>
>>> IMHO, we have to clear both.
>>>
>>> IMHO, we need to implement a function that reverts the changes done
>>> in restore_r2(). Also we need to revert the changes done in
>>> apply_relocate_add().
>>
>> I finally got time to read all the details again and recalled what
>> happened with the code.
>>
>> The failure happens when we
>> 1) call apply_relocate_add() on klp load (or module first load,
>>    if klp was loaded first);
>> 2) do nothing when the module is unloaded;
>> 3) call apply_relocate_add() on module reload, which failed.
>>
>> The failure happens at this check in restore_r2():
>>
>>         if (*instruction != PPC_RAW_NOP()) {
>>                 pr_err("%s: Expected nop after call, got %08x at %pS\n",
>>                         me->name, *instruction, instruction);
>>                 return 0;
>>         }
>>
>> Therefore, apply_relocate_add only fails when "location + 1"
>> is not NOP. And to make it not fail, we only need to write NOP to
>> "location + 1" in clear_relocate_add().
> 
> Yes, this should be enough to pass the existing check.
> 
>> IIUC, you want clear_relocate_add() to undo everything we did
>> in apply_relocate_add(); while I was writing clear_relocate_add()
>> to make the next apply_relocate_add() not fail.
>>
>> I agree that, based on the name, clear_relocate_add() should
>> undo everything by apply_relocate_add(). But I am not sure how
>> to handle some cases. For example, how do we undo
>>
>>                 case R_PPC64_ADDR32:
>>                         /* Simply set it */
>>                         *(u32 *)location = value;
>>                        break;
>>
>> Shall we just write zeros? I don't think this matters.
> 
> I guess that it would be zeros as we do in x86_64.
> 
> 
>> I think this is the question we should answer first:
>> What shall clear_relocate_add() do?
>> 1) undo everything by apply_relocate_add();
>> 2) only do things needed to make the next
>>    apply_relocate_add succeed;
>> 3) something between 1) and 2).
> 
> Good question.
> 
> Hmm, the commit a443bf6e8a7674b86221f49 ("powerpc/modules: Add REL24
> relocation support of livepatch symbols") suggests that all symbols
> in the section SHN_LIVEPATCH have the type R_PPC_REL24. AFAIK, the
> kernel livepatches are the only user of the clear_relocate_add()
> feature.
> 
> If the above is correct then it might be enough to clear only
> R_PPC_REL24 type. And it might be enough to warn when clear_relocate_add()
> is called for another type so that we know when the relocations
> were not cleared properly.
> 
> Good question.  We might need some input from people familiar
> with the architecture and creating the livepatches.
> 

Adding Russell to the to CC list as he worked some of recent ppc64le
livepatch klp-relocation threads [1] [2].

Maybe it would simpler to first organize a cleanup of the code, then add
the capability to undo the relocations?  According to [2] and the last
comment on [3], it sounded like the Power folks had a "full"(er)
solution in mind depending on our requirements.

Finally, I'll try to finish my v6.1 rebase of the klp-convert patchset
this week.  That includes a bunch of kselftests that generate all manner
of klp-relocation types and sections.  (More than I've ever seen out of
kpatch-build.)

[1] https://lore.kernel.org/linuxppc-dev/YX9UUBeudSUuJs01@redhat.com/
[2] https://lore.kernel.org/linuxppc-dev/YxAc87dTmclHGCUy@redhat.com/
[3] https://github.com/linuxppc/issues/issues/375

-- 
Joe

