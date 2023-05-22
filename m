Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F670B85F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjEVJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjEVJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020AB198B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684746074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzEpQY/7nndsvAN6PZNeW+EyAvkjNx8VBecr+dfpZ2c=;
        b=FkaLyfzcpdqaRn8VE77vXhONJ2BpAK4f70y/vjRHmwgCzxkfCh2ETN4tdEkJ7E16rklec7
        xdX/ZMXH9CxwyMu174Vb5S921ZHMaf9eB/plR24YcjHvoqxMyDsWrDHelqN881gvkjWcWI
        hO4fe547wgbKQhQAMUj8/Y/M9NLWYLw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-y2vgwgTkMmSGDmlO6Hy0ww-1; Mon, 22 May 2023 05:01:13 -0400
X-MC-Unique: y2vgwgTkMmSGDmlO6Hy0ww-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30a5d4e5731so560480f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684746072; x=1687338072;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzEpQY/7nndsvAN6PZNeW+EyAvkjNx8VBecr+dfpZ2c=;
        b=JEUAImrKk55tPB/x1E1OCugwNJYVHD5XjZh+EOd7+hixPc4nElMi1rXZWzA6BV0R63
         wtGY3+baUcguYr3PVdVR0Vm1421ZyjVCj5LbYMbZtYkQhPVabm4jtxFq3r9fTHYQ2+a4
         7kTFws7myGldP8Nf/GgGm0/jzYJpVTVu7HYA8Dkm6DfIhKW1vTjOqrmBEspAPJ4PIzvY
         3g14HJJMUj0yeecrXhYKSk/uBpB2LkBUblZR4UJYzFwgOuJH8nPv9HSl3MWqwbF0BDdi
         98Jjiq/SHJrXDuuUM6C34hhXB8AimRNCOh6+g0CKYhuSwVz0PLrioTpb99lWnvN28Gvt
         hoeg==
X-Gm-Message-State: AC+VfDz4rCRXFjMWIAq0ezdOGYfEkwJgNrQ+eagEwzl5caaDvIXjdEb1
        VBbhkA/4UTWLqTBF9OOnryniE8lnLePA174a79h7M4UeqzCsULD1WipBb9YeoCXOqnh89gWLc6e
        36ESlXXeJKj48Q++IPj9Z0Rk6
X-Received: by 2002:a5d:525a:0:b0:306:2aa7:2ed2 with SMTP id k26-20020a5d525a000000b003062aa72ed2mr6782100wrc.61.1684746072317;
        Mon, 22 May 2023 02:01:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bb40zKS/iNYKwUkkkFlzbwe0kLkFMZbI9ubHHDnhTRHL+Ab/6a9w3M24/SPXPV45Zl978eA==
X-Received: by 2002:a5d:525a:0:b0:306:2aa7:2ed2 with SMTP id k26-20020a5d525a000000b003062aa72ed2mr6782077wrc.61.1684746071840;
        Mon, 22 May 2023 02:01:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id f18-20020adfdb52000000b00307d20546e6sm7090571wrj.27.2023.05.22.02.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:01:11 -0700 (PDT)
Message-ID: <7883b08b-6bdc-a214-96a3-3f5bc1d36da4@redhat.com>
Date:   Mon, 22 May 2023 11:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-5-revest@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230517150321.2890206-5-revest@chromium.org>
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

On 17.05.23 17:03, Florent Revest wrote:
> This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> that the process doesn't want MDWE protection to propagate to children.
> 
> To implement this no-inherit mode, the tag in current->mm->flags must be
> absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> without inherit" is different in the prctl than in the mm flags. This
> leads to a bit of bit-mangling in the prctl implementation.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>   include/linux/sched/coredump.h   | 10 ++++++++++
>   include/uapi/linux/prctl.h       |  1 +
>   kernel/fork.c                    |  2 +-
>   kernel/sys.c                     | 24 +++++++++++++++++++++---
>   tools/include/uapi/linux/prctl.h |  1 +
>   5 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 0ee96ea7a0e9..11f5e3dacb4e 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
>   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
>   
>   #define MMF_VM_MERGE_ANY	29
> +#define MMF_HAS_MDWE_NO_INHERIT	30
> +
> +#define MMF_INIT_FLAGS(flags)	({					\
> +	unsigned long new_flags = flags;				\
> +	if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))		\
> +		new_flags &= ~((1UL << MMF_HAS_MDWE) |			\
> +				(1UL << MMF_HAS_MDWE_NO_INHERIT));	\
> +	new_flags & MMF_INIT_MASK;					\
> +})

Why the desire for macros here? :)

We have a single user of MMF_INIT_FLAGS, why not inline or use a proper 
inline function?


-- 
Thanks,

David / dhildenb

