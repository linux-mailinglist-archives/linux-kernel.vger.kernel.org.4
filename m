Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16B6780FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjAWQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAWQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD91041A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674490213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaz2eFwwKZQeqzaBnyjvTh9KlIDFMudiVk4t+F3NjSY=;
        b=KRXIFTog9TqXhCCBDnRinSvB5Re4iSrjoPqF9mKLlxGISmx3HdmK/YIl/AHyarFBsovxTA
        5dujvCDK5/4dTjyg0FBT4SsNHCCOAaoGmgdrhq4/1QKFmUUkfKs7zKCpMGZF4KgrUy0Dvd
        z0JwICKFDuVfkCOX+8bLuA5l/VYukH8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-_eYZcNE0MLC2Xd_ihJZhbA-1; Mon, 23 Jan 2023 11:10:11 -0500
X-MC-Unique: _eYZcNE0MLC2Xd_ihJZhbA-1
Received: by mail-wm1-f70.google.com with SMTP id p1-20020a05600c1d8100b003daff82f5edso7735937wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaz2eFwwKZQeqzaBnyjvTh9KlIDFMudiVk4t+F3NjSY=;
        b=yia8TddF/HnHMRndcVpg3tnwzwx2FNjSsS1UXehyHJhX3ZU2FKLZP8UCIDXeg8XKP6
         NG/yjUUaYpNmt1VI5A2mpEtSDVNfmhuMePMjYOt4wmmTgHKn7Q/HwIxpxYZsTUwXW43G
         fJOVGN2tNu0OnVylYBGT6vI3tfHkCt0nl9W1IMFDE/k8e/eMsjXSt+0IPnJCLeoHlmBZ
         vzcgUE/8rXF577EIMHe3+AQfAqRGPPcGHvLcPpvt5q+GuJL14GqGb1PYLHOBrxhguJ/V
         J29zCjpG272+kGFy7qr7TPzr+44TackxvJNCsSP1k06cCQ3g6b1mXDvWKRB6piBP+gpy
         O7rw==
X-Gm-Message-State: AFqh2kpIF1wpGB5AipR6Hkxel4nkOT1tjMeT1+xsnA80rScn1G1dXFEg
        io4gTQESy6/5tV+wPXgG9G2+rDtZrQtVauoSmqEvBX8XpI8E0DYcrpOlzvhat6KaZueemsW/xfr
        QLzRb/o8shxf78on2Xt8AfBa0
X-Received: by 2002:a5d:4703:0:b0:2be:5408:5d6c with SMTP id y3-20020a5d4703000000b002be54085d6cmr11570103wrq.25.1674490210339;
        Mon, 23 Jan 2023 08:10:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXshtGaRKAVI126HK3VLdPO+gptPTBr2easvP2Gqa9Z3J0by8Blo1tezQKxtshHAuSHVh0wtaw==
X-Received: by 2002:a5d:4703:0:b0:2be:5408:5d6c with SMTP id y3-20020a5d4703000000b002be54085d6cmr11570084wrq.25.1674490210013;
        Mon, 23 Jan 2023 08:10:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d670d000000b002bdc19f8e8asm30883764wru.79.2023.01.23.08.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:10:09 -0800 (PST)
Message-ID: <e07d958a-1400-3630-8a24-154850f41fb7@redhat.com>
Date:   Mon, 23 Jan 2023 17:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
 <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com> <Y857Uoq7fjO0lZ12@arm.com>
 <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com> <Y86wA0s/HRVtqLru@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y86wA0s/HRVtqLru@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.23 17:04, Catalin Marinas wrote:
> On Mon, Jan 23, 2023 at 01:53:46PM +0100, David Hildenbrand wrote:
>> On 23.01.23 13:19, Catalin Marinas wrote:
>>> On Mon, Jan 23, 2023 at 12:45:50PM +0100, David Hildenbrand wrote:
>>>> On 19.01.23 17:03, Joey Gouly wrote:
>>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>>> index 58b3abd457a3..cee1e4b566d8 100644
>>>>> --- a/include/linux/mman.h
>>>>> +++ b/include/linux/mman.h
>>>>> @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
>>>>>     }
>>>>>     unsigned long vm_commit_limit(void);
>>>>> +
>>>>> +/*
>>>>> + * Denies creating a writable executable mapping or gaining executable permissions.
>>>>> + *
>>>>> + * This denies the following:
>>>>> + *
>>>>> + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
>>>>> + *
>>>>> + *	b)	mmap(PROT_WRITE)
>>>>> + *		mprotect(PROT_EXEC)
>>>>> + *
>>>>> + *	c)	mmap(PROT_WRITE)
>>>>> + *		mprotect(PROT_READ)
>>>>> + *		mprotect(PROT_EXEC)
>>>>> + *
>>>>> + * But allows the following:
>>>>> + *
>>>>> + *	d)	mmap(PROT_READ | PROT_EXEC)
>>>>> + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
>>>>> + */
>>>>
>>>> Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set VM_EXEC
>>>> anymore? In an ideal world, there would be no further mprotect changes
>>>> required.
>>>
>>> I don't think it works for this scenario. We don't want to disable
>>> PROT_EXEC entirely, only disallow it if the mapping is not already
>>> executable. The below should be allowed:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
>>>
>>> but IIUC what you meant, it fails if we cleared VM_MAYEXEC at mmap()
>>> time.
>>
>> Yeah, if you allow write access at mmap time, clear VM_MAYEXEC (and disallow
>> VM_EXEC of course).
> 
> This should work but it doesn't fully mimic systemd's MDWE behaviour
> (e.g. disallow mprotect(PROT_EXEC) even if the mmap was PROT_READ only).

Interesting.

> Topi wanted to stay close to that at least in the first incarnation of
> this control (can be extended later).
> 
>> But I guess we'd have to go one step further: if we allow exec access
>> at mmap time, clear VM_MAYWRITE (and disallow VM_WRITE of course).
> 
> Yes, both this and the VM_MAYEXEC clearing if VM_WRITE would be useful
> but as additional controls a process can enable.
> 
>> That at least would be then similar to how we handle mmaped files: if the
>> file is not executable, we clear VM_MAYEXEC. If the file is not writable, we
>> clear VM_MAYWRITE.
> 
> We still allow VM_MAYWRITE for private mappings, though we do clear
> VM_MAYEXEC if not executable.
> 
> It would be nice to use VM_MAY* flags for this logic but we can only
> emulate MDWE if we change the semantics of 'MAY': only check the 'MAY'
> flags for permissions being changed (e.g. allow PROT_EXEC if the vma is
> already VM_EXEC even if !VM_MAYEXEC). Another issue is that we end up
> with some weird combinations like having VM_EXEC without VM_MAYEXEC
> (maybe that's fine).

No, we wouldn't want VM_EXEC if VM_MAYEXEC is not set. I don't 
immediately see how that would happen.

> 
>> Clearing VM_MAYWRITE would imply that also writes via /proc/self/mem to such
>> memory would be forbidden, which might also be what we are trying to
>> achieve, or is that expected to still work?
> 
> I think currently with systemd's MDWE it still works (I haven't tried
> though), unless there's something else forcing that file read-only.

Okay, just curious if this is an easy way to bypass the MDWE restriction.

> 
>> But clearing VM_MAYWRITE would mean that is_cow_mapping() would no
>> longer fire for some VMAs, and we'd have to check if that's fine in
>> all cases.
> 
> This will break __access_remote_vm() AFAICT since it can't do a CoW on
> read-only private mapping.

Yeah, might require some thought.

> 
>> Having that said, this patch handles the case when the prctl is applied to a
>> process after already having created some writable or executable mappings,
>> to at least forbid if afterwards on these mappings. What is expected to
>> happen if the process already has writable mappings that are executable at
>> the time we enable the prctl?
> 
> They are expected to continue to work. The prctl() is meant to be
> invoked by something like systemd so that any subsequent exec() will
> inherit the property.

Okay, thanks. So it's mostly about new processes inheriting that 
restriction.

> 
>> Clarifying what the expected semantics with /proc/self/mem are would be
>> nice.
> 
> Yeah, this series doesn't handle this. Topi, do you know if systemd does
> anything about /proc/self/mem? To me this option is more about catching
> inadvertent write|exec mappings rather than blocking programs that
> insist on doing this (they can always map a memfd file twice with
> separate write and exec attributes for example).

I remember some work regarding forbidding ececutable memfds.

-- 
Thanks,

David / dhildenb

