Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1D70C338
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjEVQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEVQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D993FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684772576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5um2DUZCGOrnDKFk5C7dFmDvO0JwbcJTzc9WMdYWTFQ=;
        b=U6cmhQEaeX/ktiPz9tnNEECakn//OPU1F6gxncriJYhtsm/08ShvSroTBRxnzSYEbo8xP1
        HO3Ce2y9fge+vwlsx0RmX8nTPsT9oBpDM5C/bLPJaPnoXNv0dA6glLZ2YarX68p7fw97Qr
        /V7tARIFrA3I3Pn73PQUYIsBL1dZmgc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-nd9ZP6yuPcWc_zWglsEfAg-1; Mon, 22 May 2023 12:22:55 -0400
X-MC-Unique: nd9ZP6yuPcWc_zWglsEfAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-307814dd87eso2657325f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772574; x=1687364574;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5um2DUZCGOrnDKFk5C7dFmDvO0JwbcJTzc9WMdYWTFQ=;
        b=ex42OcuskIZJ5RaF5XOfTVIgbaQ+b/JjvYZ5bxAq7iPgRypFUPxdoYBW5z+q7n+BKF
         W/tsgxUD72psDIefVxjmQ+rVWt0DSK1hwwrOtcvv9g50iOzvmXvuvr8sVYPc1nRr/pl2
         ks6j+knDxoprJLsrx8cvP3TA4NBxPqXfiX/si9S0r32L3EKt8R8g1rip20IUnEKgSm/B
         J0bcggRNZxBdBeL5haWeS2C4dENJrTgDVRCprFRfIpLv8jmXy+FMEIab1oF998fE0EOq
         ydlvnwcbesZIvrhKL5Yp3EQlPHlJvq3+rsh9vhaN1qUyT4FLwJRP7hlT/XEJtBOWQTJl
         bsCQ==
X-Gm-Message-State: AC+VfDyB4aFR+5hoRDOuSlgSQH/35TmZryZsIRdwB4Km4ND/0OVAXPGG
        QTeZCvEVgZKgdIInFSfcdPG9pUgCeljn4mNhMEmXM1FKZ7gDqQc7IuQKgQ6LUg9+3UU2VhI+hh/
        FYRMnoFuPi/6uV5T/GiiR3QRr
X-Received: by 2002:a5d:6b4c:0:b0:2f5:83a8:a9a9 with SMTP id x12-20020a5d6b4c000000b002f583a8a9a9mr8879055wrw.16.1684772574042;
        Mon, 22 May 2023 09:22:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iC+0hWblwlzmu67PfNeSA6rcEpnFz0r3DcQrueBLHpgIycc51012PyvkJIr4xO+W7TQ/LMw==
X-Received: by 2002:a5d:6b4c:0:b0:2f5:83a8:a9a9 with SMTP id x12-20020a5d6b4c000000b002f583a8a9a9mr8879036wrw.16.1684772573694;
        Mon, 22 May 2023 09:22:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:4300:c403:519c:6f8f:19c9? (p200300cbc7484300c403519c6f8f19c9.dip0.t-ipconnect.de. [2003:cb:c748:4300:c403:519c:6f8f:19c9])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000100200b0030903d44dbcsm8189116wrx.33.2023.05.22.09.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 09:22:52 -0700 (PDT)
Message-ID: <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
Date:   Mon, 22 May 2023 18:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <884d131bbc28ebfa0b729176e6415269@ispras.ru>
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

On 22.05.23 12:35, Alexey Izbyshev wrote:
> On 2023-05-22 11:55, David Hildenbrand wrote:
>> On 17.05.23 17:03, Florent Revest wrote:
>>> Alexey pointed out that defining a prctl flag as an int is a footgun
>>> because, under some circumstances, when used as a flag to prctl, it
>>> can
>>> be casted to long with garbage upper bits which would result in
>>> unexpected behaviors.
>>>
>>> This patch changes the constant to a UL to eliminate these
>>> possibilities.
>>>
>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
>>> ---
>>>    include/uapi/linux/prctl.h       | 2 +-
>>>    tools/include/uapi/linux/prctl.h | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>> index f23d9a16507f..6e9af6cbc950 100644
>>> --- a/include/uapi/linux/prctl.h
>>> +++ b/include/uapi/linux/prctl.h
>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>      /* Memory deny write / execute */
>>>    #define PR_SET_MDWE			65
>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>      #define PR_GET_MDWE			66
>>>    diff --git a/tools/include/uapi/linux/prctl.h
>>> b/tools/include/uapi/linux/prctl.h
>>> index 759b3f53e53f..6e6563e97fef 100644
>>> --- a/tools/include/uapi/linux/prctl.h
>>> +++ b/tools/include/uapi/linux/prctl.h
>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>      /* Memory deny write / execute */
>>>    #define PR_SET_MDWE			65
>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>      #define PR_GET_MDWE			66
>>>
>>
>> Both are changing existing uapi, so you'll already have existing user
>> space using the old values, that your kernel code has to deal with no?
> 
> I'm the one who suggested this change, so I feel the need to clarify.
> 
> For any existing 64-bit user space code using the kernel and the uapi
> headers before this patch and doing the wrong prctl(PR_SET_MDWE,
> PR_MDWE_REFUSE_EXEC_GAIN) call instead of the correct prctl(PR_SET_MDWE,
> (unsigned long)PR_MDWE_REFUSE_EXEC_GAIN), there are two possibilities
> when prctl() implementation extracts the second argument via va_arg(op,
> unsigned long):
> 
> * It gets lucky, and the upper 32 bits of the argument are zero. The
> call does what is expected by the user.
> 
> * The upper 32 bits are non-zero junk. The flags argument is rejected by
> the kernel, and the call fails with EINVAL (unexpectedly for the user).
> 
> This change is intended to affect only the second case, and only after
> the program is recompiled with the new uapi headers. The currently
> wrong, but naturally-looking prctl(PR_SET_MDWE,
> PR_MDWE_REFUSE_EXEC_GAIN) call becomes correct.
> 
> The kernel ABI is unaffected by this change, since it has been defined
> in terms of unsigned long from the start.

The thing I'm concerned about is the following: old user space (that 
would fail) on new kernel where we define some upper 32bit to actually 
have a meaning (where it would succeed with wrong semantics).

IOW, can we ever really "use" these upper 32bit, or should we instead 
only consume the lower 32bit in the kernel and effectively ignore the 
upper 32bit?

I guess the feature is not that old, so having many existing user space 
applications is unlikely.

Which raises the question if we want to tag this here with a "Fixes" and 
eventually cc stable (hmm ...)?

-- 
Thanks,

David / dhildenb

