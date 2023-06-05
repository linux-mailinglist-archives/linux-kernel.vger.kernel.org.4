Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F597224B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjFELgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjFELgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7699
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYARy8HibsJRuVCsxN/w1opXBP1A7Z939kJomrPeo3k=;
        b=gx4+vO5yukSO1rHywesm9BglIwuDitnv5aHOAz/JdDAZEmHmFi062i9Ag/BEpoDFiCHf2e
        GyYbEXPU3NkinCbbVHle0LBnEx1H8PdKDCtxHz8a7ghK17EQG0Q/5bDmL2iFH697T1hJxO
        KyUzoZPnyWDTJslsoyH67IpvM/7MZvo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-u6tKp_a8NAyyiNa5KeGhjA-1; Mon, 05 Jun 2023 07:36:00 -0400
X-MC-Unique: u6tKp_a8NAyyiNa5KeGhjA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5ec8aac77so27909505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964959; x=1688556959;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYARy8HibsJRuVCsxN/w1opXBP1A7Z939kJomrPeo3k=;
        b=iN4V96FBXrFV81OQElIvNcr0lDnEXzsMUF9mGPMgOZLpvgUnyaxntj+BpdWCqx68/y
         XD7riF1G4yjWx2tRv3z7ty3xxrDD5G+uoO6FjfsvbEMaEWz7T6PnG/o7uEtJCi8QzWzL
         W/Exua0P1nO66fLqbIc9WqBP53I9dvPh1UgvURHE6sIQIoO9u0KTtjwziSoqirqESNm1
         1gXUPWav6BVuLC+wGnU1XRbMP+5DKCjcXv53cqzPB0t31y0eG2e3rioxU0INq3ajl98J
         YZyHRTAQpb7zd05dmsdN4Inq0Iwjc9yQoymPhTRxr0WPefBSkaV88BY2pu5TEnNAdfR8
         re8A==
X-Gm-Message-State: AC+VfDzLXTAwO4Tlnvp0Pen0KUAUuJLLF3IAbN161KJKWHaWXZHnjruz
        KjA1usCrT/URwAoQRmqgIErAn1zlRtmOp1WumtU0uoc7Im2cJf9aDYJu+4fkQqS/KEVp4o8BS04
        0JaD9pmiHCOhWaNJqhJGJk4ZR
X-Received: by 2002:a1c:7208:0:b0:3f7:4961:52ad with SMTP id n8-20020a1c7208000000b003f7496152admr2513978wmc.3.1685964959155;
        Mon, 05 Jun 2023 04:35:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kqLKmA6Uaca3flnGm41wNf/22uPch19FG6pqRuK+wk+si/v/bT8+LCR0C/BaP0urg5ol3tQ==
X-Received: by 2002:a1c:7208:0:b0:3f7:4961:52ad with SMTP id n8-20020a1c7208000000b003f7496152admr2513963wmc.3.1685964958842;
        Mon, 05 Jun 2023 04:35:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b00306415ac69asm9435530wrt.15.2023.06.05.04.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:35:58 -0700 (PDT)
Message-ID: <0764cf72-26fe-627b-f56c-b0d2629bc9e3@redhat.com>
Date:   Mon, 5 Jun 2023 13:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in
 hugetlb-madvise.c, migration.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-3-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> Dummy variables are required in order to make these two (similar)
> routines work, so in both cases, declare the variables as volatile in
> order to avoid the clang compiler warning.
> 
> Furthermore, in order to ensure that each test actually does what is
> intended, add an asm volatile invocation (thanks to David Hildenbrand
> for the suggestion), with a clarifying comment so that it survives
> future maintenance.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
>   tools/testing/selftests/mm/migration.c       | 5 ++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 28426e30d9bc..d55322df4b73 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>   
>   void read_fault_pages(void *addr, unsigned long nr_pages)
>   {
> -	unsigned long dummy = 0;
> +	volatile unsigned long dummy = 0;
>   	unsigned long i;
>   
> -	for (i = 0; i < nr_pages; i++)
> +	for (i = 0; i < nr_pages; i++) {
>   		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
> +
> +		/* Prevent the compiler from optimizing out the entire loop: */
> +		asm volatile("" : "+r" (dummy));
> +	}
>   }
>   
>   int main(int argc, char **argv)
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 1cec8425e3ca..379581567f27 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
>   
>   void *access_mem(void *ptr)
>   {
> -	uint64_t y = 0;
> +	volatile uint64_t y = 0;
>   	volatile uint64_t *x = ptr;
>   
>   	while (1) {
>   		pthread_testcancel();
>   		y += *x;
> +
> +		/* Prevent the compiler from optimizing out the writes to y: */
> +		asm volatile("" : "+r" (y));
>   	}
>   
>   	return NULL;

With the asm, I think the "volatile" might be completely unnecessary. 
But it doesn't hurt.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

