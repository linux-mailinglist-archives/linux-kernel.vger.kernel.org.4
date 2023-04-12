Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E46DED94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDLI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDLI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDD6A5F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681288035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0xd8DfJiLhqVCFxGUegEqGNdKacgPcFKvCcRUHx0Qo=;
        b=Q3oezVetK6J5LJAutBnu7+8czZKyy1O5o6l8/YvLk9Aw9Y9qcpuww/3QsH4p2Sm6999R9h
        3hlVJ6IViKgr47Ll7YGWnfoCDO5VzQokgMu3RDUj4NOJ3DJiW6Y0fiW5acOOO1E6S/QH2/
        ESrnSq4oHpELXvVDflUIPR9MXQuDRqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-gXTKKqyJPYqVxAcGpAZJsQ-1; Wed, 12 Apr 2023 04:27:13 -0400
X-MC-Unique: gXTKKqyJPYqVxAcGpAZJsQ-1
Received: by mail-wr1-f71.google.com with SMTP id l4-20020adfc784000000b002f44a791472so294674wrg.17
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681288032; x=1683880032;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0xd8DfJiLhqVCFxGUegEqGNdKacgPcFKvCcRUHx0Qo=;
        b=HM5NkgxluNuVGu8ss6I2fiVTd5/T6zlDnA7Ex2JIOiuHazMbFCjDiAiK0xn8Co/mr0
         vlVT858XoLCbAh2TElkFdkviXOBQ/0aMS+yyHLBY4IqB7tLvZ5yG8yUEdn+i9mvOTC7Q
         nyZe1Xq64FQsVgMw6ZvyxzpWdTCxg6ynG2K6tPtbxZMxkdB7XFm0jlSDAgixABXZKQ6T
         I1HngO8keIirqodU1MC4Vrs/xekDLyUuujBfGlL1j8bm2K8RtvAONigsW1Yx6XPhLHvL
         08fPwHQNdE3h92VBv2P/B6vdQ218RXKbEwpGeDdQmU6hXLQ+CQCoI9E3G/ZJW3XmOIWl
         fA8Q==
X-Gm-Message-State: AAQBX9enG3VWmvcatAV+FO4GkQov9csb3Cm3zHky4Au0CVzPUY1KD2tH
        uONLlUMR3bKwFCj3aETaWplouv3FJmmRmHM1KWcdboEzicTNg85CBI8QM6isK3XRm9iWDcDxsmN
        xlUA/CgckCNw5RyyCwNuZOO/3
X-Received: by 2002:a7b:ca57:0:b0:3ed:95a5:3257 with SMTP id m23-20020a7bca57000000b003ed95a53257mr12072276wml.2.1681288031871;
        Wed, 12 Apr 2023 01:27:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350bnpzhPshYNabRXKjBC5x502FVLmSLcHcUiRU+rXCOSS75n+ezWNWKlk8WaBcXclHp8adUCFQ==
X-Received: by 2002:a7b:ca57:0:b0:3ed:95a5:3257 with SMTP id m23-20020a7bca57000000b003ed95a53257mr12072257wml.2.1681288031497;
        Wed, 12 Apr 2023 01:27:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b003f09fe8312csm533342wml.20.2023.04.12.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:27:11 -0700 (PDT)
Message-ID: <5f5ef0ce-ba7f-d5cb-57ee-f6b7debac3da@redhat.com>
Date:   Wed, 12 Apr 2023 10:27:10 +0200
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
References: <20230412074915.2303-1-wangdeming@inspur.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230412074915.2303-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 09:49, Deming Wang wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().

Comment does not apply.

> 
> As a pointer is passed into posix_memalign(), initialize *p to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).

Comment does not apply.

> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index cbb5e6893cbf..8f48f07bc821 100644
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
> +	ret = posix_memalign((void **)(&one_page), pmd_pagesize, len);

ret = posix_memalign((void **)&one_page, pmd_pagesize, len);

Should do.

> +	if (ret < 0) {
>   		printf("Fail to allocate memory\n");
>   		exit(EXIT_FAILURE);
>   	}

-- 
Thanks,

David / dhildenb

