Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E2704A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjEPKW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjEPKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5ED2738
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684232516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdwZekQhQhJYfD71ineBvZDWMF1v7qroVT5L1UXxv4Y=;
        b=BJLmKJH/+DqLPoaghhFc3uDuMNe1iWdl6Z5VnoOsIyjD7ypWzdGOFt/lYPDua3+5sc3G2Y
        uGl4QbTUvj0zM3bIhaVLwwLKip7EZvNQdI3CA49SOjkDWsZF1EViw1qIqNcpUpEh2je6KS
        aRAH03hFn/6QNuCRQ/Y+PmQmHn9s2es=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-YnCaYPAoPP2jcxw6BwBWIg-1; Tue, 16 May 2023 06:21:55 -0400
X-MC-Unique: YnCaYPAoPP2jcxw6BwBWIg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3078b9943d6so4099306f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232514; x=1686824514;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdwZekQhQhJYfD71ineBvZDWMF1v7qroVT5L1UXxv4Y=;
        b=NMkt/Rzvos/NnHsNKTZzBs5CjXTdXwgKhBxPNdVMMBl6FRPtjh5rwbxsWtrx91+efL
         PxTKgxLxXo++FGrO8UDht6LIibn3ZMIvD3dO2tinOPzMFJtu2zB0EaAfPvsBY5mkuyXM
         DPOOamE0qVAWZT4b9IL5KcIs9VW0DvoYWzPmgO2gc7wF+eO5hN+0S4TEEEubxFMwoRAc
         l9QJwXIeHESdAVjalRMdh3uTS0jiwOuZnhCfz2JCzxaH915FB3DvC6ps0SXjml20TDS+
         tCf2t+UBmQex4A4NZOJm5D5bbhrMyZuo4HtzH2uYJSeQPPrSSILjhnzlB4fa+q5lfAy4
         wmFw==
X-Gm-Message-State: AC+VfDzbEiUt/mvUpWmgRBRDKCgK0PkxEX3WobHHKHIyGWnBBJcyjfMb
        hTTCVGZVrWJ6qp3lMldPcAfQtex3Y9KuEA81sUwjvFrzenABRxHo423J1OYvbXuENnaDH9qcBMi
        HE+1762yNapKj+pJsxnDl7kxN
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr28037432wrw.15.1684232513857;
        Tue, 16 May 2023 03:21:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bdJSovfEtFVKVvmRsoufWG6M0qCFHLXRoPnSmKuTb+/8PzxuUbfsqia5+hKdAyzixUpyepw==
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr28037403wrw.15.1684232513432;
        Tue, 16 May 2023 03:21:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d5341000000b002ff2c39d072sm2092106wrv.104.2023.05.16.03.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:21:52 -0700 (PDT)
Message-ID: <b97e8c2a-b629-f597-d011-395071011f1b@redhat.com>
Date:   Tue, 16 May 2023 12:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Christian Konig <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <b61d5999a4fc6d50b7e073cc3c3efa8fe79bbd94.1684097002.git.lstoakes@gmail.com>
 <ZGKC9fHoE+kDs0ar@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/6] mm/gup: remove unused vmas parameter from
 get_user_pages()
In-Reply-To: <ZGKC9fHoE+kDs0ar@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 21:07, Sean Christopherson wrote:
> On Sun, May 14, 2023, Lorenzo Stoakes wrote:
>> No invocation of get_user_pages() use the vmas parameter, so remove it.
>>
>> The GUP API is confusing and caveated. Recent changes have done much to
>> improve that, however there is more we can do. Exporting vmas is a prime
>> target as the caller has to be extremely careful to preclude their use
>> after the mmap_lock has expired or otherwise be left with dangling
>> pointers.
>>
>> Removing the vmas parameter focuses the GUP functions upon their primary
>> purpose - pinning (and outputting) pages as well as performing the actions
>> implied by the input flags.
>>
>> This is part of a patch series aiming to remove the vmas parameter
>> altogether.
>>
>> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Acked-by: Christian Kï¿½nig <christian.koenig@amd.com> (for radeon parts)
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/ioctl.c     | 2 +-
>>   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
>>   drivers/misc/sgi-gru/grufault.c     | 2 +-
>>   include/linux/mm.h                  | 3 +--
>>   mm/gup.c                            | 9 +++------
>>   mm/gup_test.c                       | 5 ++---
>>   virt/kvm/kvm_main.c                 | 2 +-
>>   7 files changed, 10 insertions(+), 15 deletions(-)
> 
> Acked-by: Sean Christopherson <seanjc@google.com> (KVM)
> 
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index cb5c13eee193..eaa5bb8dbadc 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2477,7 +2477,7 @@ static inline int check_user_page_hwpoison(unsigned long addr)
>>   {
>>   	int rc, flags = FOLL_HWPOISON | FOLL_WRITE;
>>   
>> -	rc = get_user_pages(addr, 1, flags, NULL, NULL);
>> +	rc = get_user_pages(addr, 1, flags, NULL);
>>   	return rc == -EHWPOISON;
> 
> Unrelated to this patch, I think there's a pre-existing bug here.  If gup() returns
> a valid page, KVM will leak the refcount and unintentionally pin the page.  That's

When passing NULL as "pages" to get_user_pages(), 
__get_user_pages_locked() won't set FOLL_GET. As FOLL_PIN is also not 
set, we won't be messing with the mapcount of the page.

So even if get_user_pages() returns "1", we should be fine.


Or am I misunderstanding your concern? At least hva_to_pfn_slow() most 
certainly didn't return "1" if we end up calling 
check_user_page_hwpoison(), so nothing would have been pinned there as well.

-- 
Thanks,

David / dhildenb

