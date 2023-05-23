Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006A70D88E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjEWJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjEWJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F7109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684833161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnRPg7QY2jmRwV2BnlPo6Mcti7P+VISSM7w+qVsNvmc=;
        b=XiSlec67OSl+5B9kolvuBOOqdsm/ZSS+vETAWV3eTlyPL6nIzOJOmUWvJHwetX6UuuaSWK
        EP045Em6YB2iFYFSxJle0B0E17EZIRdN4liNlQemlBYwf37AI4dYfbu6+QtI7V+tk+L63a
        aqw68KQTLAVUQoLXTWvbyr7yjwpsvIg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-GQwu75XnM06-bsMLf2eYSA-1; Tue, 23 May 2023 05:12:40 -0400
X-MC-Unique: GQwu75XnM06-bsMLf2eYSA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30a8ba2debdso865921f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833159; x=1687425159;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnRPg7QY2jmRwV2BnlPo6Mcti7P+VISSM7w+qVsNvmc=;
        b=jHYWVKVrAuLFEb4BSVNxoiEoyBpRPN9QToDMCjQRRqtlLuLJ+7RtuTKcILTz04bY/3
         WFSvrUCBujGjx/CMvedA0Y79y5TuxaIFhLcAmBILojKr1Vj2ZTrnmvEid9WBvROdAwa1
         CWC82sY93gHu7U3wCPdD+th/nwo14IdmP9kiGh7ecVxKrWieMVVP+tIDRbQDLMG95iLp
         /Q8G+/naifLQY9wroK1C08MW2YLRPdmvsRZdUUYfprci9I4cehfutJ4sMdsjAGeD/s+/
         2nGxSvTteM5ERfgpEr3530mZ57J1QPTeq3dzAjrNQ5ot79ySuLtZC+40qEcMo3PWCLCM
         78Lg==
X-Gm-Message-State: AC+VfDyj4be9bQYl9r4a50aT8rFJAeLFB205OZX23ax+Wudg0S+HU1Vl
        xfT0q8d88WcmWY62rFZvcWDFmkC+EysF4lI685bSfmN8tb0gTnu7nDZh/gnJRc7h1q9Br+FRwD5
        nTnizr8jR1p2lsewxAYjIPgl/
X-Received: by 2002:a5d:4e8c:0:b0:309:4642:8773 with SMTP id e12-20020a5d4e8c000000b0030946428773mr10054988wru.55.1684833159525;
        Tue, 23 May 2023 02:12:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DElfwciEr1wIsTm3SdAMxxR1WaQ5j0YnhXCadJrC6nCvLteEd4TgO+w2gRb7AK1f623mTXg==
X-Received: by 2002:a5d:4e8c:0:b0:309:4642:8773 with SMTP id e12-20020a5d4e8c000000b0030946428773mr10054968wru.55.1684833159103;
        Tue, 23 May 2023 02:12:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd841000000b002f28de9f73bsm10365717wrl.55.2023.05.23.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:12:38 -0700 (PDT)
Message-ID: <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
Date:   Tue, 23 May 2023 11:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 20:58, Alexey Izbyshev wrote:
> On 2023-05-22 19:22, David Hildenbrand wrote:
>> On 22.05.23 12:35, Alexey Izbyshev wrote:
>>> On 2023-05-22 11:55, David Hildenbrand wrote:
>>>> On 17.05.23 17:03, Florent Revest wrote:
>>>>> Alexey pointed out that defining a prctl flag as an int is a footgun
>>>>> because, under some circumstances, when used as a flag to prctl, it
>>>>> can
>>>>> be casted to long with garbage upper bits which would result in
>>>>> unexpected behaviors.
>>>>>
>>>>> This patch changes the constant to a UL to eliminate these
>>>>> possibilities.
>>>>>
>>>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>>>> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
>>>>> ---
>>>>>     include/uapi/linux/prctl.h       | 2 +-
>>>>>     tools/include/uapi/linux/prctl.h | 2 +-
>>>>>     2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>>>> index f23d9a16507f..6e9af6cbc950 100644
>>>>> --- a/include/uapi/linux/prctl.h
>>>>> +++ b/include/uapi/linux/prctl.h
>>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>>       /* Memory deny write / execute */
>>>>>     #define PR_SET_MDWE			65
>>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>>       #define PR_GET_MDWE			66
>>>>>     diff --git a/tools/include/uapi/linux/prctl.h
>>>>> b/tools/include/uapi/linux/prctl.h
>>>>> index 759b3f53e53f..6e6563e97fef 100644
>>>>> --- a/tools/include/uapi/linux/prctl.h
>>>>> +++ b/tools/include/uapi/linux/prctl.h
>>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>>       /* Memory deny write / execute */
>>>>>     #define PR_SET_MDWE			65
>>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>>       #define PR_GET_MDWE			66
>>>>>
>>>>
>>>> Both are changing existing uapi, so you'll already have existing user
>>>> space using the old values, that your kernel code has to deal with
>>>> no?
>>>
>>> I'm the one who suggested this change, so I feel the need to clarify.
>>>
>>> For any existing 64-bit user space code using the kernel and the uapi
>>> headers before this patch and doing the wrong prctl(PR_SET_MDWE,
>>> PR_MDWE_REFUSE_EXEC_GAIN) call instead of the correct
>>> prctl(PR_SET_MDWE,
>>> (unsigned long)PR_MDWE_REFUSE_EXEC_GAIN), there are two possibilities
>>> when prctl() implementation extracts the second argument via
>>> va_arg(op,
>>> unsigned long):
>>>
>>> * It gets lucky, and the upper 32 bits of the argument are zero. The
>>> call does what is expected by the user.
>>>
>>> * The upper 32 bits are non-zero junk. The flags argument is rejected
>>> by
>>> the kernel, and the call fails with EINVAL (unexpectedly for the
>>> user).
>>>
>>> This change is intended to affect only the second case, and only after
>>> the program is recompiled with the new uapi headers. The currently
>>> wrong, but naturally-looking prctl(PR_SET_MDWE,
>>> PR_MDWE_REFUSE_EXEC_GAIN) call becomes correct.
>>>
>>> The kernel ABI is unaffected by this change, since it has been defined
>>> in terms of unsigned long from the start.
>>
>> The thing I'm concerned about is the following: old user space (that
>> would fail) on new kernel where we define some upper 32bit to actually
>> have a meaning (where it would succeed with wrong semantics).
>>
>> IOW, can we ever really "use" these upper 32bit, or should we instead
>> only consume the lower 32bit in the kernel and effectively ignore the
>> upper 32bit?
>>
> I see, thanks. But I think this question is mostly independent from this
> patch. The patch removes a footgun, but it doesn't change the flags
> check in the kernel, and nothing stops the user from doing
> 
> int flags = PR_MDWE_REFUSE_EXEC_GAIN;
> prctl(PR_SET_MDWE, flags);
> 
> So we have to decide whether to ignore the upper 32 bits or not even if
> this patch is not applied (actually *had to* when PR_SET_MDWE op was
> being added).

Well, an alternative to this patch would be to say "well, for this prctl 
we ignore any upper 32bit. Then, this change would not be needed. Yes, I 
also don't like that :)

Bu unrelated, I looked at some other random prctl.

#define SUID_DUMP_USER           1

And in kernel/sys.c:

	case PR_SET_DUMPABLE:
		if (arg2 != SUID_DUMP_DISABLE && arg2 != SUID_DUMP_USER)
	...

Wouldn't that also suffer from the same issue, or how is this different?

Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We need 
arg2 -> arg5 to be 0. But wouldn't the following also just pass a 0 "int" ?

prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)


I'm easily confused by such (va_args) things, so sorry for the dummy 
questions.

-- 
Thanks,

David / dhildenb

