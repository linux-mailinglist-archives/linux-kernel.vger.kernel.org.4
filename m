Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E16D3E88
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDCIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDCIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342A10E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXxZmEIu5fHKpEMjWe4VFwGD5foe1yAV7hjfRn3UlQw=;
        b=er5tMVjZLm4VQ17ATM2B8q3thos4ZBNx409/Np+SXAw4eDuKCotZiN05vP/YQm98e8zB6T
        kOEelEtRF+HZWJ8Wjo5m/mFtmgTzfIRYVL/1FGlo97eIixpt96tsFZbaIqPKJY4p9f2S/c
        8JvE26ItLPIG4dzDIX9Iqw1rv5BLoJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-DePMMOpWM1Gvtcc7GQyBuQ-1; Mon, 03 Apr 2023 03:59:53 -0400
X-MC-Unique: DePMMOpWM1Gvtcc7GQyBuQ-1
Received: by mail-wm1-f72.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso14134133wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508792;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXxZmEIu5fHKpEMjWe4VFwGD5foe1yAV7hjfRn3UlQw=;
        b=peoGK54rumHI1Ihc1S/jqTfZue560x4LVwJgROVpv/XWIaM1KA2GY5vlAQRIcwN4j1
         s2c6naCJFhcU4XibhWyWvribrREIwak0jGQoZUJEocfeLKQEt6Mih1AFrXQaKvFCHJ3e
         hrjgdJlo1Ea7ozLDoJWNU/d6+9zXnL+By+pMOl7lam0WeUyzAzcOfT/TG3RwWqRw1zC4
         gremEb0Jh6NvQabwq93jL9s7XLZro6qk1Si2opha2GgQ2s2cSNpV3vafHuYdYOWtq19t
         o9NA3TLT9BPh9bmsNeKLhAoTZLpuaV9JLHd8jaKAlJZA7khjeLSQvQbIPQh+CCPyH7Kg
         1WCA==
X-Gm-Message-State: AO0yUKXuMEO3h5PlDZ/iItZWg/JwV3VDzSP7ZzWqS2GjsZoXbXPlFECb
        aHT4aZBoxHC0UDS9u0LmCVhZIv6TKbaYW9N/EsQV+ry+4qXBOiSSjPqrb13L5hz4hbol2TMv8am
        REkhO8dnE8XUahoaWIBdzC7fg
X-Received: by 2002:a1c:7207:0:b0:3ed:2606:d236 with SMTP id n7-20020a1c7207000000b003ed2606d236mr25401782wmc.38.1680508792347;
        Mon, 03 Apr 2023 00:59:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/X8u79MwLl/J+jYDyOlSnA4U8KdIDWLyX6dzDnoptzNHhMETa2Fns7sTP9CEwwl0Dk04D5Hg==
X-Received: by 2002:a1c:7207:0:b0:3ed:2606:d236 with SMTP id n7-20020a1c7207000000b003ed2606d236mr25401770wmc.38.1680508791986;
        Mon, 03 Apr 2023 00:59:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003f046ad52efsm9861898wmq.31.2023.04.03.00.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:59:51 -0700 (PDT)
Message-ID: <fcf40deb-e731-c257-fb77-7fcfddf623b1@redhat.com>
Date:   Mon, 3 Apr 2023 09:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160752.3107283-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160752.3107283-1-peterx@redhat.com>
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
> Add one simple test for UFFDIO_API.  With that, I also added a bunch of
> small but handy helpers along the way.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/uffd-unit-tests.c | 111 ++++++++++++++++++-
>   tools/testing/selftests/mm/vm_util.c         |  10 ++
>   2 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 6857388783be..dfb44ffad5f5 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -9,9 +9,118 @@
>   
>   #ifdef __NR_userfaultfd
>   
> +struct {
> +	unsigned int pass, skip, fail, total;
> +} uffd_test_acct;
> +
> +static void uffd_test_report(void)
> +{
> +	printf("Userfaults unit tests: pass=%u, skip=%u, fail=%u (total=%u)\n",
> +	       uffd_test_acct.pass,
> +	       uffd_test_acct.skip,
> +	       uffd_test_acct.fail,
> +	       uffd_test_acct.total);
> +}
> +
> +static void uffd_test_pass(void)
> +{
> +	printf("done\n");
> +	uffd_test_acct.pass++;
> +}
> +
> +#define  uffd_test_start(...)  do {		\
> +		printf(__VA_ARGS__);		\
> +		printf("... ");			\
> +		uffd_test_acct.total++;		\
> +	} while (0)
> +
> +#define  uffd_test_fail(...)  do {		\
> +		printf("failed [reason: ");	\
> +		printf(__VA_ARGS__);		\
> +		printf("]\n");			\
> +		uffd_test_acct.fail++;		\
> +	} while (0)
> +
> +#define  uffd_test_skip(...)  do {		\
> +		printf("skipped [reason: ");	\
> +		printf(__VA_ARGS__);		\
> +		printf("]\n");			\
> +		uffd_test_acct.skip++;		\
> +	} while (0)
> +


There is ksft_print_msg, ksft_test_result, ksft_test_result_fail, ... do 
we maybe want to convert properly to ksft while already at it?

-- 
Thanks,

David / dhildenb

