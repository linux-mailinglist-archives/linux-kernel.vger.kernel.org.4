Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CD6DF54A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDLMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75C119
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681302663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blrnCpTcS5ZianZmqVUuhTTwLp6B2ozOa080drqpcNk=;
        b=Cw//rO04eo5eAjBLrZJQS9PbqTWLI47o+Ou0K27uEtYX3lcYqe89m1jiGfF+CKKv5Zfq31
        K0dP1pAB1oVOKun7Z2OOezJukDx7Wxyf0Z60SOEX978cP6cwavXrwfr7jHIaxIezvTIEN4
        WLyHwmm0wjRsuWQFC6JTZp+G8uepqfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-dQVSWA5FPnywJevIVqrG8A-1; Wed, 12 Apr 2023 08:31:02 -0400
X-MC-Unique: dQVSWA5FPnywJevIVqrG8A-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a05600c19ce00b003f0331154b1so15324350wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302660; x=1683894660;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blrnCpTcS5ZianZmqVUuhTTwLp6B2ozOa080drqpcNk=;
        b=Av57tHzNRzKxKf/rohyNffyk41rPCJbNoqKmW+ZbtgJdrRtBWtycDGTlgcYznHvn3L
         S25RLXFyaXubzYS60gdBnYb5mqtpVRcniGN2y8T3Bk95d7wGQmIfXBjnR2eOwHK5C7NQ
         NgfdlsSaF9TQVxP8rI+0XIInAhPxJlwhnhpF6aUqaKHvNQwYvpivc7AcbYymtvZ2k9gK
         X5rYKf5c5ebzoXnAzYwBAOLeofRsIlE9hAcFX6EBP3yOhrPSHQrhh0VhszOK7iBxeWYO
         bF9Xf7YRtpCjs4SQkKLVLYUHGLR2TVfouO7fn+PvW/nC9AldJzGp2iCCUqJEEUfolDvi
         jmwA==
X-Gm-Message-State: AAQBX9efeLfp4p93EbVUH89qphnCtJqU00oti0s/ewYZUc3/nalysV/d
        RUDGFI1aTd62LwUayk+LKhg/6aJJ+IcvxrRmuMjXh32uOD+Av5BnfR9aNaEhkErXAp2jro/acyK
        1tAz0dw7JXgPFKB65r5P3sGLX
X-Received: by 2002:a7b:c389:0:b0:3ed:3268:5f35 with SMTP id s9-20020a7bc389000000b003ed32685f35mr1999660wmj.18.1681302660620;
        Wed, 12 Apr 2023 05:31:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4K/3OVCcip+JnxiMy5/dD33dZGeMKTqg1Z1LDfrRMSsp30yfO/Pr8lzVdPaorZJ0aIgTe/w==
X-Received: by 2002:a7b:c389:0:b0:3ed:3268:5f35 with SMTP id s9-20020a7bc389000000b003ed32685f35mr1999645wmj.18.1681302660313;
        Wed, 12 Apr 2023 05:31:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b003ed51cdb94csm2313468wmq.26.2023.04.12.05.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:30:59 -0700 (PDT)
Message-ID: <b5df5cac-5258-7f5c-d386-6b17391b080e@redhat.com>
Date:   Wed, 12 Apr 2023 14:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: huge_memory: Replace obsolete memalign() with
 posix_memalign()
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412104502.1836-1-wangdeming@inspur.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230412104502.1836-1-wangdeming@inspur.com>
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

On 12.04.23 12:45, Deming Wang wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign()
> 
> As a pointer is passed into posix_memalign(), initialize *one_page
> to NULL to silence a warning about the function's return value being

Where is the initialization to NULL done below?

> used as uninitialized (which is not valid anyway because the error
> is properly checked before p is returned).

"p" ?

> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index cbb5e6893cbf..94c7dffc4d7d 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -96,10 +96,10 @@ void split_pmd_thp(void)
>   	char *one_page;
>   	size_t len = 4 * pmd_pagesize;
>   	size_t i;
> +	int ret;
>   
> -	one_page = memalign(pmd_pagesize, len);
> -
> -	if (!one_page) {
> +	ret = posix_memalign((void **)&one_page, pmd_pagesize, len);
> +	if (ret < 0) {
>   		printf("Fail to allocate memory\n");
>   		exit(EXIT_FAILURE);
>   	}

-- 
Thanks,

David / dhildenb

