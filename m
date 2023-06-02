Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62671FF39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjFBK0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjFBKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7AE71
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685701414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxTIvBa280tFX1Ziuv3vXhP9JFFIHvNa5gTAJi66bKg=;
        b=aSG/EahSbf7bx7tXiabdgMEOgqfKUQl+sXK0v/r2KaHQ0J0Wd7k0Hw+9SluQV7qCXeyCJe
        zLwCwQpa5cue5zPqHH5k5Vs+dsN3Ez1T90QhNvueRsxGPshp+bUuQSuVHu4IG+IDnTGktM
        AUb31vfp1ECnsuWaujHShGhjtnhQIjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-gwSIe4lRPWObChsARoH6ag-1; Fri, 02 Jun 2023 06:23:31 -0400
X-MC-Unique: gwSIe4lRPWObChsARoH6ag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f6fa88a86bso10562275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701410; x=1688293410;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxTIvBa280tFX1Ziuv3vXhP9JFFIHvNa5gTAJi66bKg=;
        b=eXUFP1C8waMUusuGNxEAUgyBJnJulmNTn2upndVkuhcdB8nx5z1rY+z5VtIPLmgLBK
         ls5TwGxRVXRQbtQV8ceBtS436L3sothW4CYApGepcfqE/FqUVAfzM+ANEappzkSvYKFg
         nnmgCyLkFyczcWQJqpd3BUB5uUo7OtNSR7hOu1JWUw94XY5/NCE7znKUEO5+EUMk2OwG
         PuFLjnhDLd+yNfrz/f3ny9hKR7V2kLg7jNauV3M2TOgfXUFHKAxtLpEYNncT87Rvgmlx
         Qy8bB3LCVO61ocyWj6pHbFheAltZ6KoLjah6YTIA87BnOupWguiP7OIAqa6cd79Yugk0
         nfXA==
X-Gm-Message-State: AC+VfDycLwWQg2HpJSMWlNZtpxOvLiWrPm+hJsV1dr2e01dscAzu9puJ
        3ckNNOTynpPcmfXzn1qYezNBuCFsuizZcWjcLLJa+PfnoPtRLa1ksrdXs9jxJgMNLRADLbraWQn
        kUaOdFaP5Fv+eAIuQQXqmCx8s
X-Received: by 2002:adf:e905:0:b0:30a:e499:e5ff with SMTP id f5-20020adfe905000000b0030ae499e5ffmr4186474wrm.30.1685701410384;
        Fri, 02 Jun 2023 03:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VxWw+nvusOgvfBrsCuX+swQ9iMsm5wh4JYGmC+BxQY+ezR55VhpYbTbnv+HzMc9NMkzKcbQ==
X-Received: by 2002:adf:e905:0:b0:30a:e499:e5ff with SMTP id f5-20020adfe905000000b0030ae499e5ffmr4186466wrm.30.1685701410071;
        Fri, 02 Jun 2023 03:23:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b0030adc30e9f1sm1249661wrt.68.2023.06.02.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:23:29 -0700 (PDT)
Message-ID: <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
Date:   Fri, 2 Jun 2023 12:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> UFFDIO_CONTINUE_MODE_WP, UFFD_FEATURE_WP_UNPOPULATED, USERFAULTFD_IOC,
> and USERFAULTFD_IOC_NEW are needed lately, but they are not in my host
> (Arch Linux) distro's userfaultfd.h yet. So put them in here.
> 
> A better approach would be to include the uapi version of userfaultfd.h
> from the kernel tree, but that currently fails with rather difficult
> linker problems (__packed is defined multiple times, ugg), so defer that
> to another day and just fix the build for now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/uffd-common.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index a1cdb78c0762..98847e41ecf9 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -36,6 +36,23 @@
>   
>   #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
>   
> +#ifndef UFFDIO_CONTINUE_MODE_WP
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
> +#endif
> +
> +#ifndef UFFD_FEATURE_WP_UNPOPULATED
> +#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
> +#endif
> +
> +/* ioctls for /dev/userfaultfd */
> +#ifndef USERFAULTFD_IOC
> +#define USERFAULTFD_IOC 0xAA
> +#endif
> +
> +#ifndef USERFAULTFD_IOC_NEW
> +#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
> +#endif
> +
>   #define _err(fmt, ...)						\
>   	do {							\
>   		int ret = errno;				\

Unfortunately, that seems to be the ugly way to handle this because
including the in-tree headers seems to not work and I yet haven't
figured out why (there were some changes back and forth so I lost track).

CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

