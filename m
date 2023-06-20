Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D39736AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFTLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFTLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2066DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687259681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mu3ZQzCMoDG/BdFJ4c8DVA27suqD5RiJoI5p+Cmymt4=;
        b=OWlVsml/39/YkE0agg5rZuZ8ZVgLCCqGV4k9xQBvrarcU61ErE0qfhhiaLQ8gf2SAuEvKi
        0oZpntp5XqXhUC5zQ+xWjse4OyXGvJ2YUm6uv58JyXNt8D7BzbIgndTlgAv27mBjuAvtG7
        U9LAU726B7o0aRYphEltmhBokKfuxi4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Fck9umUFNu2kfS7xz5oT_w-1; Tue, 20 Jun 2023 07:14:39 -0400
X-MC-Unique: Fck9umUFNu2kfS7xz5oT_w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f9b8e0896aso2339925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259678; x=1689851678;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu3ZQzCMoDG/BdFJ4c8DVA27suqD5RiJoI5p+Cmymt4=;
        b=J29AqVgJ0lmkl8kNFfeK2jXiue0swEmv+qjjBkxKMO8MvDVN/s7ys/kCqwvBd+ZZ/l
         ButZmHHrKRZ1jrYGKlmXDR4M0rzDhI2eu4FwGTwg3L1l28S1CJnFit2OPXJtxTxWFnua
         pDrVGrMlAlM6cJvDB9j8Dk0F0utYUZnAVV7qJUdWS9WbPu5+gYUmvxUUPYvUdDqtoXK9
         lOVsnNhfW/flDAkJw9kG7u+98kPBvZ8JGnbm0bnz1KaQF8cFCX6CuH1WrRBK7siq7g6s
         D0ivEH6n3FUJLbaVmjOWekDslPGBy7vsMNauIEohzYZ5+qoNCgb/eVnOF4+2M6xTE0og
         HJQQ==
X-Gm-Message-State: AC+VfDzzMyfz+/JYTau6TgRpGWXNu2nP8/ViXsQM9r51Ngm3fR4AnkmE
        TwGbKE6qOV9VcwnOZrcuxShvFCrOaJyw1zQwQZW6h0T8w1D+N9EOxXWJijjuCTAr4A8eCaTVDyH
        8sbOeO2ylRytTRxVIZoOqiTSB
X-Received: by 2002:a05:600c:ad7:b0:3f9:991:61da with SMTP id c23-20020a05600c0ad700b003f9099161damr6086204wmr.39.1687259678528;
        Tue, 20 Jun 2023 04:14:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6u6jldeAOsB6wg1qa0UPiJcOns6sSKWJbgG0tPJvfJ3eO3oLpf80/A1fUaVkJjziN4kC9ERA==
X-Received: by 2002:a05:600c:ad7:b0:3f9:991:61da with SMTP id c23-20020a05600c0ad700b003f9099161damr6086174wmr.39.1687259678152;
        Tue, 20 Jun 2023 04:14:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b003f7f475c3bcsm22876375wmo.1.2023.06.20.04.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 04:14:37 -0700 (PDT)
Message-ID: <193d0e6d-27b6-b50e-8a3e-35c1816b20fc@redhat.com>
Date:   Tue, 20 Jun 2023 13:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v11 06/20] x86/virt/tdx: Handle SEAMCALL running out of
 entropy error
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shahar, Sagi" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
References: <cover.1685887183.git.kai.huang@intel.com>
 <9b3582c9f3a81ae68b32d9997fcd20baecb63b9b.1685887183.git.kai.huang@intel.com>
 <dfb59553-2777-15ed-d523-6a7cc5b68e53@redhat.com>
 <1cc1879691fcd077fed1a485de799594d751a8ec.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1cc1879691fcd077fed1a485de799594d751a8ec.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 12:39, Huang, Kai wrote:
> 
>>> @@ -33,12 +34,24 @@ static int __always_unused seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>>    				    struct tdx_module_output *out)
>>>    {
>>>    	int cpu, ret = 0;
>>> +	int retry;
>>>    	u64 sret;
>>>    
>>>    	/* Need a stable CPU id for printing error message */
>>>    	cpu = get_cpu();
>>>    
>>> -	sret = __seamcall(fn, rcx, rdx, r8, r9, out);
>>> +	/*
>>> +	 * Certain SEAMCALL leaf functions may return error due to
>>> +	 * running out of entropy, in which case the SEAMCALL should
>>> +	 * be retried.  Handle this in SEAMCALL common function.
>>> +	 *
>>> +	 * Mimic the existing rdrand_long() to retry
>>> +	 * RDRAND_RETRY_LOOPS times.
>>> +	 */
>>> +	retry = RDRAND_RETRY_LOOPS;
>>
>> Nit: I'd just do a "int retry = RDRAND_RETRY_LOOPS" and simplify this
>> comment to "Mimic rdrand_long() retry behavior."
> 
> OK will do.
> 
> But I think you are talking about replacing the second paragraph but not the
> entire comment?
>

Yes.

-- 
Cheers,

David / dhildenb

