Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48A1677BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjAWMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjAWMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26928C64B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674478431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBYV07fuEsbmrQz4pa4SyZyORm3t80BZlJSUiqj12qg=;
        b=GLHXRexo7We8YSSijQ3phmW5yAGzq67/c6XzXIzj6lw2tqVLKeHKncQr9T1PEcabYmmV/j
        Tyl0ff2eGUAxFxj7OktoDiFT233Dri5qMRLwiorJqIh6WPxr9Nx32u4VjvkxZ3buZUDCC7
        cv7GlgcxyDeWFjoACKihfbV57MXs83M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-IqTckuKCPDGHGb3RZrN7ag-1; Mon, 23 Jan 2023 07:53:50 -0500
X-MC-Unique: IqTckuKCPDGHGb3RZrN7ag-1
Received: by mail-wm1-f69.google.com with SMTP id p1-20020a05600c1d8100b003daff82f5edso7448303wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBYV07fuEsbmrQz4pa4SyZyORm3t80BZlJSUiqj12qg=;
        b=NsjaHsUsw27itUEpb8vqXaiSs2aaDPsCS9TcmB5pxNnUdFOej6SZGqP/X3bYDSt4nX
         Z8j0EN1wjeaeCmr+EadA94Lk82YyO6s2hW1M68VymgR2ZIHmWrcjsKc/e6xjLKPdchLk
         CcOqFlH777O40PkP8TvK7p25FTs0xTzHq0+z5SuFIfBTNZ6Ln6NKMI9H10s2twl0NXJg
         4T3PMe2A+4l3WcR+sIssf+N10hMsKhSilFQvh9w4NbD4dDZ/oxNL0AweijZvRkJmgDdy
         IMpRlo8kgW+bCtgZQVfUsy1sIjG/6OeOHIcmr53AavERLf2Fkj9RnrHc5zZ0bkmRZN4F
         I2Qg==
X-Gm-Message-State: AFqh2kp8a0bfPqTPAxdz2yU9Nx49wy5OpmnSrKJ3+fDg/RqobMnbNeY0
        u21Y0idHDLvt2V/yxdKfIHFDhnp5norqEFvJC5XXL+3uHryw0SsnSSS+AvKEdyWPei6741PpMaw
        rIJzt1p8mxhd3wqZJQK3XIx3j
X-Received: by 2002:adf:b604:0:b0:242:1809:7e17 with SMTP id f4-20020adfb604000000b0024218097e17mr20678770wre.6.1674478428843;
        Mon, 23 Jan 2023 04:53:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSg31BoPLMpZ6IuIfrhN9+GOXK1ForpDTK64UwrPOLXwlLdkWdfdykNreoZBg9BBBig0d9Vg==
X-Received: by 2002:adf:b604:0:b0:242:1809:7e17 with SMTP id f4-20020adfb604000000b0024218097e17mr20678755wre.6.1674478428504;
        Mon, 23 Jan 2023 04:53:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d4701000000b002423edd7e50sm4320205wrq.32.2023.01.23.04.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:53:47 -0800 (PST)
Message-ID: <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com>
Date:   Mon, 23 Jan 2023 13:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
In-Reply-To: <Y857Uoq7fjO0lZ12@arm.com>
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

On 23.01.23 13:19, Catalin Marinas wrote:
> On Mon, Jan 23, 2023 at 12:45:50PM +0100, David Hildenbrand wrote:
>> On 19.01.23 17:03, Joey Gouly wrote:
>>> The aim of such policy is to prevent a user task from creating an
>>> executable mapping that is also writeable.
>>>
>>> An example of mmap() returning -EACCESS if the policy is enabled:
>>>
>>> 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
>>>
>>> Similarly, mprotect() would return -EACCESS below:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
>>>
>>> The BPF filter that systemd MDWE uses is stateless, and disallows
>>> mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
>>> be enabled if it was already PROT_EXEC, which allows the following case:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
>>>
>>> where PROT_BTI enables branch tracking identification on arm64.
>>>
>>> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
>>> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>    include/linux/mman.h           | 34 ++++++++++++++++++++++++++++++++++
>>>    include/linux/sched/coredump.h |  6 +++++-
>>>    include/uapi/linux/prctl.h     |  6 ++++++
>>>    kernel/sys.c                   | 33 +++++++++++++++++++++++++++++++++
>>>    mm/mmap.c                      | 10 ++++++++++
>>>    mm/mprotect.c                  |  5 +++++
>>>    6 files changed, 93 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>> index 58b3abd457a3..cee1e4b566d8 100644
>>> --- a/include/linux/mman.h
>>> +++ b/include/linux/mman.h
>>> @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
>>>    }
>>>    unsigned long vm_commit_limit(void);
>>> +
>>> +/*
>>> + * Denies creating a writable executable mapping or gaining executable permissions.
>>> + *
>>> + * This denies the following:
>>> + *
>>> + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
>>> + *
>>> + *	b)	mmap(PROT_WRITE)
>>> + *		mprotect(PROT_EXEC)
>>> + *
>>> + *	c)	mmap(PROT_WRITE)
>>> + *		mprotect(PROT_READ)
>>> + *		mprotect(PROT_EXEC)
>>> + *
>>> + * But allows the following:
>>> + *
>>> + *	d)	mmap(PROT_READ | PROT_EXEC)
>>> + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
>>> + */
>>
>> Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set VM_EXEC
>> anymore? In an ideal world, there would be no further mprotect changes
>> required.
> 
> I don't think it works for this scenario. We don't want to disable
> PROT_EXEC entirely, only disallow it if the mapping is not already
> executable. The below should be allowed:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> 
> but IIUC what you meant, it fails if we cleared VM_MAYEXEC at mmap()
> time.

Yeah, if you allow write access at mmap time, clear VM_MAYEXEC (and 
disallow VM_EXEC of course). But I guess we'd have to go one step 
further: if we allow exec access at mmap time, clear VM_MAYWRITE (and 
disallow VM_WRITE of course).

That at least would be then similar to how we handle mmaped files: if 
the file is not executable, we clear VM_MAYEXEC. If the file is not 
writable, we clear VM_MAYWRITE.


Clearing VM_MAYWRITE would imply that also writes via /proc/self/mem to 
such memory would be forbidden, which might also be what we are trying 
to achieve, or is that expected to still work? But clearing VM_MAYWRITE 
would mean that is_cow_mapping() would no longer fire for some VMAs, and 
we'd have to check if that's fine in all cases.


Having that said, this patch handles the case when the prctl is applied 
to a process after already having created some writable or executable 
mappings, to at least forbid if afterwards on these mappings. What is 
expected to happen if the process already has writable mappings that are 
executable at the time we enable the prctl?

Clarifying what the expected semantics with /proc/self/mem are would be 
nice.

> 
> We could clear VM_MAYEXEC if the mapping was made VM_WRITE (either by
> mmap() or mprotect()) but IIRC we concluded that this should be an
> additional prctl() flag.

Yes, I agree with enabling this restriction on a per-process level. My 
remarks only apply to processes with this toggle enabled.

-- 
Thanks,

David / dhildenb

