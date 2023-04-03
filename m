Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7F6D3E71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjDCHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjDCHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE6BBA8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuNvA2nKyssC8Mw42yhvtdZdNtWcsTv2ko3FlyfNo0g=;
        b=ZnJV+6nTPRfEIA3OPRHcgPGEafXwrs4YrLX5meDSOh3MdqQmBgnM7KKHtGYthR/52JkZ7C
        bDi1V7+K9nQJj4qgRJ5fFDXbTzJocGor+4cb+HqZa7Ac4LA5qhGhy2hNqWmU69sT1gP0Zj
        zWlta1Cc9SsPxtUl++ofsM+dLflHvgo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-TTX6hshsO9uSnAUX5niAeg-1; Mon, 03 Apr 2023 03:52:40 -0400
X-MC-Unique: TTX6hshsO9uSnAUX5niAeg-1
Received: by mail-wm1-f69.google.com with SMTP id n19-20020a05600c3b9300b003ef63ef4519so12772099wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508359;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuNvA2nKyssC8Mw42yhvtdZdNtWcsTv2ko3FlyfNo0g=;
        b=x8B7GCX6r2qSBQhbO0JNUgcQaZZzzIH/q8a7r5jHAGsigpILUw1DzcM1Ar2ilmdAyx
         kow/+5CJp/G/ilsE4bKKWOVRpggE+VarkxNWK1ytCzx0slCM3acyzqsbYr9aMkd8Z3bA
         l+9VH9VTgXzqBnVt6o6imBx2/rf2z9HlTQOvMyKkB/86QdVuEY8NvD9KNCLahOGlfW8H
         3U6PCoUn2e1kiWi1+MXk9rD026Q1zLyQwl95GqpQggLgKW3nqdwlukb8G79jxw1pbmnJ
         mrX5RsLv9SW3qnCnj5zib7gxZ2TOhe2+vBmYkIU3X/cp80hNxKebR4Rfp0vj6RMgUgqc
         3GKw==
X-Gm-Message-State: AO0yUKVHpVyqChQKKfKBE0nrl3Xy37sKg95uyrLHtaM0uGGVIfg2c8SJ
        AcigN1CpHZI1xmbY3c1BlH9E1O8hBqHUyITxONYEeUzZZSrPncCohQ7OQtdm41SZ/zK+bWNXuPK
        AsNFbmVUYmDm1UkGYhXxxv9UW
X-Received: by 2002:a7b:c44b:0:b0:3ed:301c:375c with SMTP id l11-20020a7bc44b000000b003ed301c375cmr26683040wmi.21.1680508359708;
        Mon, 03 Apr 2023 00:52:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set9sN66Fu0OR7DdsHfUH7uNbeGlefBq2JdK4W4DYZUe1DfGhnu8HRrpA2YIMjYskud5HvpHu1w==
X-Received: by 2002:a7b:c44b:0:b0:3ed:301c:375c with SMTP id l11-20020a7bc44b000000b003ed301c375cmr26683018wmi.21.1680508359394;
        Mon, 03 Apr 2023 00:52:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c231800b003ed2276cd0dsm11269065wmo.38.2023.04.03.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:52:38 -0700 (PDT)
Message-ID: <6979452b-0667-c97f-8306-6c1c1cc88b98@redhat.com>
Date:   Mon, 3 Apr 2023 09:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 06/29] selftests/mm: Link vm_util.c always
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160700.3106955-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160700.3106955-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:07, Peter Xu wrote:
> We do have plenty of files that want to link against vm_util.c.  Just make
> it simple by linking it always.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/Makefile | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 47516a78d447..b35f3eafde3c 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -105,17 +105,7 @@ TEST_FILES += va_128TBswitch.sh
>   
>   include ../lib.mk
>   
> -$(OUTPUT)/cow: vm_util.c
> -$(OUTPUT)/khugepaged: vm_util.c
> -$(OUTPUT)/ksm_functional_tests: vm_util.c
> -$(OUTPUT)/madv_populate: vm_util.c
> -$(OUTPUT)/soft-dirty: vm_util.c
> -$(OUTPUT)/split_huge_page_test: vm_util.c
> -$(OUTPUT)/userfaultfd: vm_util.c
> -$(OUTPUT)/gup_test: vm_util.c
> -$(OUTPUT)/mrelease_test: vm_util.c
> -$(OUTPUT)/transhuge-stress: vm_util.c
> -$(OUTPUT)/ksm_tests: vm_util.c
> +$(TEST_GEN_PROGS): vm_util.c
>   
>   ifeq ($(MACHINE),x86_64)
>   BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

