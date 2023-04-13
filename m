Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750116E0D29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDML6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDML6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35F6183
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681387048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eCLBo30JEhG/craFWy4JRpaeUSHeOPHom+9kBQBO60=;
        b=H1S4rwoBVdTNGyy36nLwRyihREqQGSra2NC6JugUbF1m6CH7c/fdJTA4GIZHc2m2l2gHgH
        viNTTY8ue81t240EYRdthFd9HbSQI3tCKhH4ksnUgjhwwV9UWqkfMPTegHP7eMufzvI4jQ
        A7uGgYYmYEJfs5ATgYBS+aNBcPWHd7s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--kxciNMtMuyoB42ncKERHw-1; Thu, 13 Apr 2023 07:57:26 -0400
X-MC-Unique: -kxciNMtMuyoB42ncKERHw-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020adf8b52000000b002f52c16d166so771533wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387045; x=1683979045;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eCLBo30JEhG/craFWy4JRpaeUSHeOPHom+9kBQBO60=;
        b=FpYCrxaueJ8f/7cOows4o9gS5opwOKxV4VwNutnUf5dgAfgufd3rB29JsN27T3ucqT
         3itNPhZkfyAMR30CH8LSNYql2b7Nqc9ONEueOOdby41EpuAVTo0ydF9aDjAnQ2ue+Ozm
         mYjsR5JlJmVx1BVxg4JZjIyWgr7+znqcFa81K+KrgtlqxArxOr2M+2UmU/H5ygro2VOQ
         +8kjszv44N5vujUdk1ALObSILjHmGNQdJELEIEXHLszsn98+RgCjTqkQLli6nBc8YGHS
         Mg8V5oEpKJcB2Kwxj+IXVh6qbofc3sKWUcaSUEOOzMWr4u74T6qNVBoMkt8k85vJf7TL
         M03g==
X-Gm-Message-State: AAQBX9cZtQUZeME3bqpCkmfjTKDHYB+BLqv/B0JN8u29e3IiBwPj4uDS
        7FO13HVJK5TCBcKQF4gEzsKGDqC9tcx9ecad5J7K6T+DDsH0AVFXuwsg2aQmSE/U6IhZ3bTg/ww
        ehWJSDxB57uDJvNm15yciMiCd
X-Received: by 2002:a5d:6a89:0:b0:2f5:ce19:8ec2 with SMTP id s9-20020a5d6a89000000b002f5ce198ec2mr1275464wru.11.1681387045352;
        Thu, 13 Apr 2023 04:57:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZpwSb/zonNIwuuMN1BAYppgjZ1EYfUFCmirswM12PndB9SkMrFo2O02MM3m2XE/i7/54vVaw==
X-Received: by 2002:a5d:6a89:0:b0:2f5:ce19:8ec2 with SMTP id s9-20020a5d6a89000000b002f5ce198ec2mr1275453wru.11.1681387045019;
        Thu, 13 Apr 2023 04:57:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d45d0000000b002ca864b807csm1185678wrs.0.2023.04.13.04.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:57:24 -0700 (PDT)
Message-ID: <22830f0d-720e-ad7d-1540-6d6681301d94@redhat.com>
Date:   Thu, 13 Apr 2023 13:57:23 +0200
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
References: <20230413011719.4355-1-wangdeming@inspur.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413011719.4355-1-wangdeming@inspur.com>
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

On 13.04.23 03:17, Deming Wang wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign()
> 
> As a pointer is passed into posix_memalign(), initialize *one_page
> to NULL to silence a warning about the function's return value being
> used as uninitialized (which is not valid anyway because the error
> is properly checked before one_page is returned).

^ I'm getting tired of pointing out the same thing.

Please collect similar patches and send them as a series; and stop
copy-pasting the same thing into all of the similar patches you send.

Last but not least, tag you patches accordingly: "selftests/mm: 
split_huge_page_test: ..."

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

