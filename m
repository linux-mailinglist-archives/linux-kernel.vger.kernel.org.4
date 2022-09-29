Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3F5EF9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiI2QBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiI2QBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF686D12EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664467263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBH/YMCh8jX5plN90vVsJmDCGb+vheY1ZW2kHBpdn5E=;
        b=Xu+26igAWaaTQUt8Yui5QOhauHzYBE9RZS82dbJpAKEkeyrWLYGKhdP05+wwcyh2ciLQXv
        A0b384mJ8dl8CKUck3K0enNRfubMDwXthQfYtzbOEKic/Zu+K8DftVHCQ1vttdX3kcNhT3
        L8jHdDt8TqofsqPTWz4PxWiLzbIpCuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-2jgslHDaMOuPNA9QYWidXA-1; Thu, 29 Sep 2022 12:01:02 -0400
X-MC-Unique: 2jgslHDaMOuPNA9QYWidXA-1
Received: by mail-wm1-f69.google.com with SMTP id f25-20020a7bc8d9000000b003b4768dcd9cso589720wml.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=cBH/YMCh8jX5plN90vVsJmDCGb+vheY1ZW2kHBpdn5E=;
        b=cMjmEZp301+qe2TKmopoWc4hLX/4pe/j/7gwF6RqBROgmwJAv0k9N690Tg8H459Rm4
         QN6USasmOfuO+N/KxWuInB9X0TSBuN+Q0M0ETq6uawdo62QrJM0Me6LWyAZAZOqX2nqx
         CU1mTX9QLn5UbSC6w8BO+2npCzpr7guvS3gG5hxI63ywPV1muz7IMwYLWDxJK0Hz2dm7
         QNqu06+xtmHj1cJTrqCkAFMqNUDe9YWMYNHrSx8dI6iH6SeIWH1ozYGNETLEjNcruXQh
         U9N72BliMGZrs6+Q+gS1t3opghzc4GoWxksQs7GdhhATL6ic/eoEmmvy8o84bOn+LaUn
         Xrmg==
X-Gm-Message-State: ACrzQf3yWV7pu7R89m3mX6N4Kid6Ycvh2YeaM/G5TQQmj4DAyzaE66OI
        UQvo55xiGjtf1mJ+ywoX0EYQpx6tQ0tE/pS6pJa7EYOiwt+8sEtRunuMW8GzR+1gtzyjitKeosL
        oayAjNHzvV0xDlDPzMMEGLTpO
X-Received: by 2002:a05:6000:1565:b0:22c:8da7:3cf8 with SMTP id 5-20020a056000156500b0022c8da73cf8mr2821141wrz.688.1664467259518;
        Thu, 29 Sep 2022 09:00:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4dbNs/yaGi1fN0VvWkuDCL5173wC2ulxS1iDwO1YOCsCp6F8H6xxIA3tlmG2eFttiHIIrOkw==
X-Received: by 2002:a05:6000:1565:b0:22c:8da7:3cf8 with SMTP id 5-20020a056000156500b0022c8da73cf8mr2821099wrz.688.1664467259167;
        Thu, 29 Sep 2022 09:00:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a5f54e3bbbsm5461403wmq.38.2022.09.29.09.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:00:58 -0700 (PDT)
Message-ID: <75243b83-f85d-3d51-7df4-3e95abbb7ef4@redhat.com>
Date:   Thu, 29 Sep 2022 18:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <55d7f0bd-ace1-506b-ea5b-105a86290114@redhat.com>
 <f753391e-7bdc-bada-856a-87344e75bd74@redhat.com>
 <111a46c1-7082-62e3-4f3a-860a95cd560a@redhat.com>
 <14d5b8f2-7cb6-ce24-c7a7-32aa9117c953@redhat.com>
 <YzIZhn47brWBfQah@google.com>
 <3b04db9d-0177-7e6e-a54c-a28ada8b1d36@redhat.com>
 <YzMdjSkKaJ8HyWXh@google.com>
 <dd6db8c9-80b1-b6c5-29b8-5eced48f1303@redhat.com>
 <YzRvMZDoukMbeaxR@google.com>
 <8534dfe4-bc71-2c14-b268-e610a3111d14@redhat.com>
 <YzSxhHzgNKHL3Cvm@google.com>
 <d8d2bd39-cbb3-010d-266a-4e967765a382@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/9] kvm: implement atomic memslot updates
In-Reply-To: <d8d2bd39-cbb3-010d-266a-4e967765a382@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The main cases are:
> 
> - for the boot case, splitting and merging existing memslots.  QEMU
> likes to merge adjacent memory regions into a single memslot, so if
> something goes from read-write to read-only it has to be split and vice
> versa.  I guess a "don't merge this memory region" flag would be the
> less hideous way to solve it in userspace.
> 
> - however, there is also the case of resizing an existing memslot which
> is what David would like to have for virtio-mem.  This is not really
> fixable because part of the appeal of virtio-mem is to have a single
> huge memslot instead of many smaller ones, in order to reduce the
> granularity of add/remove (David, correct me if I'm wrong).

Yes, the most important case I am working on in that regard is reducing 
the memslot size/overhead when only exposing comparatively little memory 
towards a VM using virtio-mem (say, a virtio-mem device that could grow 
to 1 TiB, but we initially only expose 1 GiB to the VM).

One approach I prototyped in the past (where my RFC for atomic updates 
came into play because I ran into this issue) to achieve that was 
dynamically growing (and eventually shrinking) a single memslot on demand.

An alternative [1] uses multiple individual memslots, and exposes them 
on demand. There, I have to make sure that QEMU won't merge adjacent 
memslots into a bigger one -- because otherwise, we'd again need atomic 
memslot updates again, which KVM, vhost-user, ... don't support. But in 
the future, I think we want to have that: if there is no fragmentation, 
we should only have a single large memslot and all memslot consumers 
should be able to cope with atomic updates.


So in any case, I will have good use for atomic memslot updates. Just 
like other hypervisors that (will) implement virtio-mem or something 
comparable :)

[1] https://lore.kernel.org/all/20211013103330.26869-1-david@redhat.com/T/#u

-- 
Thanks,

David / dhildenb

