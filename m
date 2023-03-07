Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACA6ADBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCGKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCGKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A5265A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678184542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/IPZqHOoz7jiojxziiZXAo+iRRmEKFV9o6Kto64+sI=;
        b=JhxT2o6KMG1ramiX4xI8zSuhYbWU75bhc97b5xk7T2JBhzsn+WmeoD5WdRvjBDi+sCVTFK
        UoPNOmVsS2YdtPjwetrv/h/c8gSbv2xkRPTOrbMALlvwR8ezXodOidhEtrTIdYzpszqh/n
        05ikZq8HG4YC7XlQzv2/633ustqL2/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-rt_pAKHaMjWugdbTKIrbCA-1; Tue, 07 Mar 2023 05:22:19 -0500
X-MC-Unique: rt_pAKHaMjWugdbTKIrbCA-1
Received: by mail-wr1-f72.google.com with SMTP id d14-20020adfa34e000000b002bfc062eaa8so2095964wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184538;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/IPZqHOoz7jiojxziiZXAo+iRRmEKFV9o6Kto64+sI=;
        b=ngIaghqxj3fUbWTiHIDXwsmeo+TjONuSF5vLcmNraeWZ765uaFYGK3TlCa8GmcWyOB
         Dgv00biMS5Vq5cGu9jbe1mhuVaBxankvnAUO3X3CplxTLkf+DypTMOVZ3ufF234aCS2i
         V0vecTwVfkYZldQGpgexh0Dkj4LCfhjQ5jI5jg4U0/IwIleQ2Zwzbv53XPsJIqjbV/Hc
         xe+kyk/dUrwhrTJoYny1brxAaD7ijCYnI7EQBXc/TkerdUAbWmcFMV1vbjoOxZOO1uU+
         QHpUOlJQDm7dk9o5legFJLc4FZpJACtk0aD68+U3gtx3sNJmEL4zKrrjFXWFmvENUsFZ
         UdIw==
X-Gm-Message-State: AO0yUKXwV+KBJzrjUhw5q24KZoFpppNzSh4XNsqO5g4kmL4pAaXyeGG/
        T65LvWZrYaD4Q8SF0/VdUKrL2OgKA0WlI+KHQHYvDcQyj6Ru6obXiWgTjOX92rDGTw7yBE+wGFL
        AdgsrV8oMig8XSkLR4gMTtHS8
X-Received: by 2002:a5d:5452:0:b0:2ce:50a9:6d8e with SMTP id w18-20020a5d5452000000b002ce50a96d8emr6603682wrv.20.1678184537904;
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
X-Google-Smtp-Source: AK7set/i5Nv1U3NOAuCbE4btJ9ZAiOioRnHyw6o9C90eWaBZTs9BfvSsigkdVvJPs3CCoLRzMZNrMw==
X-Received: by 2002:a5d:5452:0:b0:2ce:50a9:6d8e with SMTP id w18-20020a5d5452000000b002ce50a96d8emr6603670wrv.20.1678184537566;
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b002c553e061fdsm12270849wrx.112.2023.03.07.02.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
Message-ID: <9ce5434e-4c19-cb34-d3fa-99738c265b03@redhat.com>
Date:   Tue, 7 Mar 2023 11:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests/mm: fix split huge page tests
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Zach O'Keefe <zokeefe@google.com>
References: <20230306160907.16804-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306160907.16804-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.23 17:09, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Fixed two inputs to check_anon_huge() and one if condition, so the tests
> work as expected.
> 
> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 76e1c36dd9e5..b8558c7f1a39 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -106,7 +106,7 @@ void split_pmd_thp(void)
>   	for (i = 0; i < len; i++)
>   		one_page[i] = (char)i;
>   
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>   		printf("No THP is allocated\n");
>   		exit(EXIT_FAILURE);
>   	}
> @@ -122,7 +122,7 @@ void split_pmd_thp(void)
>   		}
>   
>   
> -	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
>   		printf("Still AnonHugePages not split\n");
>   		exit(EXIT_FAILURE);
>   	}
> @@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
>   	for (i = 0; i < len; i++)
>   		one_page[i] = (char)i;
>   
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>   		printf("No THP is allocated\n");
>   		exit(EXIT_FAILURE);
>   	}

Hard to read. It should probably be "get_huge_anon()" to then check for 
the value in the caller manually. Negative value could be used as an 
indicator for an error obtaining the value.

Anyhow, was briefly confused about the 4 ("magic value" also apprearing 
in "size_t len = 4 * pmd_pagesize;") but it seems to be the right thing 
to do.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

