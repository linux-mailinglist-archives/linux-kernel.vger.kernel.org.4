Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A970B81C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjEVIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEVIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C4A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684745605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sjz73XelY9z0l4QYLhIw3O47wzYWVLPX1qVdIi43Aus=;
        b=foQ8EBfP5HM5t+7AI2gSoUsgcnStLs9+V0i0N3Szqz8oVbJM2LHl2T4XRJrb2FA5xYZXNp
        XPM4Kv60/t0eAhFcMfs9SL5SaM+hnxDzsLyI6c0rGeGT9SxHl72rKU0XW0S2YY6WzWdo9W
        jxcmAQ4AyGP7H626KfL/11DWz/ax2DU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-6mulDtD_NZOb2M8ghtNY7g-1; Mon, 22 May 2023 04:53:24 -0400
X-MC-Unique: 6mulDtD_NZOb2M8ghtNY7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30a8ba2debdso347619f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745603; x=1687337603;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sjz73XelY9z0l4QYLhIw3O47wzYWVLPX1qVdIi43Aus=;
        b=lVI6lzAP6rRaCrV93QXCyOG8GXtaa+owBA3+NrP92BkLQwLsLjEDMo/17f5RJU+7kd
         GH6sE1TvdunJ/HBCJRS68J3A6UUn5VROgtYcGhgoLLIQSBaszIaCXLBN6uza1y8RddAb
         Ax77hlazgamUmHT/sjIGlkmseWMrSg1gpyhwSh2j2ILU2D+KivvGvRFYrXSeIGhaRpYJ
         jt9qIAyVgFCFNEedX5UXqg5SGyY25sQzqQ4Fr/aG3H/Jds6NqPzRanFaVeBzw6gqRln9
         lOM5xz5cs+Ds16UQ7ZNLoyav3XcQIrWtljDUkYi/seAPzoAZIxmQjBB9B556+frZAruu
         urJg==
X-Gm-Message-State: AC+VfDy16DSd+aBJ5+tlqQcZDF8FpaEhNRx9QSs+MRdHIdWVxY7ttP53
        rN8fE18G1jkwSNUz6stfjYssAXMJNxj3UhddFpfOul8lYXYJemMlAMIxCbHzTSG4ag+GaNQZ9H8
        Per6+WV0sMkO95qLJS5FSCBJz
X-Received: by 2002:a5d:40c4:0:b0:309:43a2:8e9f with SMTP id b4-20020a5d40c4000000b0030943a28e9fmr6809486wrq.27.1684745602911;
        Mon, 22 May 2023 01:53:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KKCcdrWmgRwNWw4qSMirvKEhU5alle4r59vpIahQSImqVLM3az/jLZvgFtpdvVt36nC7Inw==
X-Received: by 2002:a5d:40c4:0:b0:309:43a2:8e9f with SMTP id b4-20020a5d40c4000000b0030943a28e9fmr6809469wrq.27.1684745602626;
        Mon, 22 May 2023 01:53:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b00306344eaebfsm7043661wrt.28.2023.05.22.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:53:22 -0700 (PDT)
Message-ID: <bdd25950-8e28-01f2-5f87-ef35bda6b2f6@redhat.com>
Date:   Mon, 22 May 2023 10:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-3-revest@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230517150321.2890206-3-revest@chromium.org>
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
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
> 
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
> 
> This patch keeps the test case to make it clear that this situation is
> expected to work.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
> ---
>   tools/testing/selftests/mm/mdwe_test.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index d0954c657feb..91aa9c3099e7 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
>   	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
>   	ASSERT_NE(self->p, MAP_FAILED);
>   
> -	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
> +	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
> +	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
>   		 self->flags | MAP_FIXED, 0, 0);
> -	if (variant->enabled) {
> -		EXPECT_EQ(p, MAP_FAILED);
> -	} else {
> -		EXPECT_EQ(p, self->p);
> -	}
> +	EXPECT_EQ(p, self->p);
>   }
>   
>   TEST_F(mdwe, arm64_BTI)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

