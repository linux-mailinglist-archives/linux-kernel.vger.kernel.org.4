Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AB71FE6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjFBJ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjFBJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50717136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685699913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjcMa1EzAvCm+h6bWeTWaHaKzxs/0IMxe2zdQtxTz/E=;
        b=A6OIPlFD1ULuD4XBT9Hco0YSPWzQO9jIFnIbF4oUzOO3Haavpg8w1eT1+eH4nAzNaBWery
        M17KCfVYhMTl/unRVGxe4LMuRLl+BmdumSShG8MPxZwuscg4mV7kjquzDFYZDU1kBVbqO2
        7hp9jxfeRJoWT2h5bz/lUzf+TwNbafQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-pu2LUgk0MtOSv_Bi3KjOsg-1; Fri, 02 Jun 2023 05:58:31 -0400
X-MC-Unique: pu2LUgk0MtOSv_Bi3KjOsg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30ae7bd987dso891413f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699910; x=1688291910;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjcMa1EzAvCm+h6bWeTWaHaKzxs/0IMxe2zdQtxTz/E=;
        b=i7H+EthYlXO/UvDSyKJnX7KwrPtn4Vl3gUAf3ujR5JFNQqirUkWw5c5al7u+9vpBXj
         GAn/9oqE6iWg397dQp62E4DE3JEI9Zpgjk8ByIEoU632WmcbOHRCORRa9cnAT+BDhWDw
         NmjOJ6nCDNrRh5VZPinACmkiztn3+XGQScoVR8SVyIm5QA6HKot5ySbS8Fjh5fS3VCX9
         0Ux/+Afo2ykgN5T0J0pB2Bb9B3MBKq8NskVAiEuQG7ED3eTG8thvCxa6xhDFMS53R3Ph
         1AqWIWt64agjdYbM1cxczdYX/3JnH+iUsCH5OdG6VQHlqLtM/FQiajcmNYpzG6KFN/oF
         bXCQ==
X-Gm-Message-State: AC+VfDxNZZ+I1gOle31tgE7smrzZ3UddpKkpQOuujAVJ/mey9xbPGYC6
        oF4QKDIII4Udr1kVoGHHLlohl/NjNuqofT4wjPNLgH/Hz/IfdDARetuTYSZ6Lg0Z7fA2zV2BsRD
        L5/KG9WDAIbHMSVSshnc8PXXfELlWcEhZ
X-Received: by 2002:a5d:53cd:0:b0:306:372d:7891 with SMTP id a13-20020a5d53cd000000b00306372d7891mr4169885wrw.59.1685699910684;
        Fri, 02 Jun 2023 02:58:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ631YkvzdiQwtylZVnj17BIofH3TVIc2MrP/4WsIUKRfMiZxci47Q/7IW3XCY0js5fVl6qpCQ==
X-Received: by 2002:a5d:53cd:0:b0:306:372d:7891 with SMTP id a13-20020a5d53cd000000b00306372d7891mr4169878wrw.59.1685699910350;
        Fri, 02 Jun 2023 02:58:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id y8-20020a056000108800b002ff2c39d072sm1154826wrw.104.2023.06.02.02.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:58:29 -0700 (PDT)
Message-ID: <b7420aeb-21d6-ac06-60ce-44d625d351d3@redhat.com>
Date:   Fri, 2 Jun 2023 11:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/12] selftests/mm: fix uffd-stress unused function
 warning
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-2-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-2-jhubbard@nvidia.com>
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
> uffd_minor_feature() was unused. Remove it in order to fix the
> associated clang build warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/uffd-stress.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index f1ad9eef1c3a..995ff13e74c7 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -88,16 +88,6 @@ static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
>   	}
>   }
>   
> -static inline uint64_t uffd_minor_feature(void)
> -{
> -	if (test_type == TEST_HUGETLB && map_shared)
> -		return UFFD_FEATURE_MINOR_HUGETLBFS;
> -	else if (test_type == TEST_SHMEM)
> -		return UFFD_FEATURE_MINOR_SHMEM;
> -	else
> -		return 0;
> -}
> -
>   static void *locking_thread(void *arg)
>   {
>   	unsigned long cpu = (unsigned long) arg;


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

