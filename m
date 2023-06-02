Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5C71FE84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjFBKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFBKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866ED180
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hyZGB3MGa7vf2rLRzCGFNwMw9GG2IWMkUvaL/SujQg=;
        b=c2q8LjwNnRvS/SDTzF5myjeC9SPBkFI231d2+ubaSMIdYTcbUdzzxsVcuVlaftsV0ZEuqU
        guBy3HHni/Nf5g5i7mZb7kkG2g7VkfM/Yl0YfwaX+wlCQUPxdMNqD3vHfXQVeGYAHikUWW
        kVuBm45ccJ7rgWHb1CqHbyQP1Usew74=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-StvabDJ4My6MPxNirynWNQ-1; Fri, 02 Jun 2023 06:05:00 -0400
X-MC-Unique: StvabDJ4My6MPxNirynWNQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f59c4df0f9so1391847e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700299; x=1688292299;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hyZGB3MGa7vf2rLRzCGFNwMw9GG2IWMkUvaL/SujQg=;
        b=ASNCgFmh90AIvQsyWLDFUs4Uc73mjass/h4gJ3QaSN3NF2Yk54+ur9PWBgeIgugXFx
         LEhh8hn0mk1o/ubOfzNEFe4TBeQtsqdlxv6B21+ZL8AEDxRoeKt5iZ9G7BlqEHkqr0Zq
         ZF4CTNdOoq7CeAt/osMqNIHJtUpKZMh7XfIPgd3WNNwnSJqOL4QceHQnXfsNVjFEk7k1
         3y6TmcHxj6Rs4JGcRGlT8iPA2w8aHVmtDV1kZrTnJqBKRpd4SK5loNCEA+B6cQwQYrbx
         qvVpvW8HRAiGzgTB82bZ0PfzhNv3bQd6NPYV6BviM0KpK68jEn1zinY93Vu7bYTdw+o+
         wcbg==
X-Gm-Message-State: AC+VfDyPzJQX6cNYp/WBBme3MuyodE93JLkaiDEHOdl5+MNllkJjhO3G
        8KGxSlDOOX47UFyHtGr9gT/FzLSeqkHoP90kUAWDChfNFVOnWmPqNNi9snUX8MeuM/ED3jOX8BW
        t5MttSS+thpPt3MDAiwnucfCg
X-Received: by 2002:a19:c214:0:b0:4f4:b92c:eef5 with SMTP id l20-20020a19c214000000b004f4b92ceef5mr1538956lfc.68.1685700299105;
        Fri, 02 Jun 2023 03:04:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4euVi2YxX2kiLZiXSZix61kY1chJny4ldV+5M2F0upuUba6zeVerZNKoZi8PAcRklKRWjZ/g==
X-Received: by 2002:a19:c214:0:b0:4f4:b92c:eef5 with SMTP id l20-20020a19c214000000b004f4b92ceef5mr1538940lfc.68.1685700298705;
        Fri, 02 Jun 2023 03:04:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0030647d1f34bsm1244929wrp.1.2023.06.02.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:04:58 -0700 (PDT)
Message-ID: <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com>
Date:   Fri, 2 Jun 2023 12:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-5-jhubbard@nvidia.com>
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
> The stop variable is a char*, so use "\0" when assigning to it, rather
> than attempting to assign a character type. This was generating a
> warning when compiling with clang.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mlock2-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 11b2301f3aa3..8ee95077dc25 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>   			printf("cannot parse /proc/self/maps\n");
>   			goto out;
>   		}
> -		stop = '\0';
> +		stop = "\0";
>   
>   		sscanf(line, "%lx", &start);
>   		sscanf(end_addr, "%lx", &end);


I'm probably missing something, but what is the stop variable supposed 
to do here? It's completely unused, no?

if (!strchr(end_addr, ' ')) {
	printf("cannot parse /proc/self/maps\n");
	goto out;
}

-- 
Thanks,

David / dhildenb

