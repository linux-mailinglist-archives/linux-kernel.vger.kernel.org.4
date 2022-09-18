Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4835BBEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIRQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 12:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIRQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 12:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBACE07
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663518140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODbIQU9597VA/Wq31XH7ZTVJyvSErs3yWMdjJTILVD0=;
        b=X2+Dkm7GLX2ZUFpGarFpOUXONHwaEsOf8GCzR5OgJniz8Fueik2H2UJ8ScssgmUNtt7uPq
        GtaMPzYwxy0HBzm2Wq/vI3F5PbctOmoRASuUpYwOQbMgfeNGQH3k1C7jQ0gu7lSsPh9oCw
        zvDx5TS5LZQWoLkRg7TlrQQCz4qFOWo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-ahqmzYSUPneThVo4_PSPXQ-1; Sun, 18 Sep 2022 12:22:18 -0400
X-MC-Unique: ahqmzYSUPneThVo4_PSPXQ-1
Received: by mail-qk1-f200.google.com with SMTP id u20-20020a05620a455400b006ce5151968dso16182398qkp.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ODbIQU9597VA/Wq31XH7ZTVJyvSErs3yWMdjJTILVD0=;
        b=EodEpqM20xcKcQKzQilHOxDnPrOqXO+doJFkZenFrJS6wJlvaUfHKQGWokDNPuvuUx
         HDD8OwtiOp1H3oWEefW7bfTz8U32jaJvtOCDsz7MAPKwLs9F/gy+G6oxmp4DNJjLWQpx
         rfmJj2VveKsSI/1knK0DzcTR+y20bx7haprOwKczpJhPQxwxA5Ow1z8trcVo5NQO5c+w
         0GLQdu5euszdYp71RIX33zOvbLmoxAkiasifaQeSP5K4L5kUOKtoSZMGFEBrIAPXaC+m
         8SVXPLfHUvapSuX5OfquJeSRaDh0bXVs93SAL/OJeIAlgrAPJaca7p6cOVXAsMWlfLVB
         uusg==
X-Gm-Message-State: ACrzQf3VSnDTodGas1L9ERiRy0+xHpcfp/G4Fb7+toeyY38JTakJ/+vB
        P+AHnC05gfdAsqZFxIh+rmB2IzodtRvCpwloJH0u1b4yIkRGZii1NFvQCHW4ppnxMYCrkPbxPSq
        CZruh5sxJK7Zq+3npS/gpWL55
X-Received: by 2002:ad4:5aaf:0:b0:4a8:a817:e00d with SMTP id u15-20020ad45aaf000000b004a8a817e00dmr11896907qvg.18.1663518138143;
        Sun, 18 Sep 2022 09:22:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6HM0smyk7S3EfsY4LP5UqF8eIAlKyJpB1/tjXjxtadc7CBpN5zw+uMHWgETW55DSOrFhypeQ==
X-Received: by 2002:ad4:5aaf:0:b0:4a8:a817:e00d with SMTP id u15-20020ad45aaf000000b004a8a817e00dmr11896890qvg.18.1663518137931;
        Sun, 18 Sep 2022 09:22:17 -0700 (PDT)
Received: from ?IPV6:2a04:ee41:4:31cb:e591:1e1e:abde:a8f1? ([2a04:ee41:4:31cb:e591:1e1e:abde:a8f1])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006b9c9b7db8bsm11592922qko.82.2022.09.18.09.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 09:22:17 -0700 (PDT)
Message-ID: <b9e8febd-b87e-422c-fc67-59272d225e1d@redhat.com>
Date:   Sun, 18 Sep 2022 18:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 5/9] kvm_main.c: split __kvm_set_memory_region logic
 in kvm_check_mem and kvm_prepare_batch
Content-Language: en-US
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-6-eesposit@redhat.com>
 <9fcd1d25-ec4d-eebe-623f-cfeb48b6656f@intel.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <9fcd1d25-ec4d-eebe-623f-cfeb48b6656f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13/09/2022 um 04:56 schrieb Yang, Weijiang:
> 
> On 9/9/2022 6:45 PM, Emanuele Giuseppe Esposito wrote:
>> Just a function split. No functional change intended,
>> except for the fact that kvm_prepare_batch() does not
>> immediately call kvm_set_memslot() if batch->change is
>> KVM_MR_DELETE, but delegates the caller (__kvm_set_memory_region).
>>
>>
>> +static int kvm_check_memory_region(struct kvm *kvm,
>> +                const struct kvm_userspace_memory_region *mem,
>> +                struct kvm_internal_memory_region_list *batch)
>> +{
>> +    int r;
>> +
>> +    r = check_memory_region_flags(mem);
>> +    if (r)
>> +        return r;
>>   -    r = kvm_set_memslot(kvm, batch);
>> +    r = kvm_check_mem(mem);
>>       if (r)
>> -        kfree(new);
>> +        return r;
>> +
>> +    r = kvm_prepare_batch(kvm, mem, batch);
>> +    if (r && batch->new)
>> +        kfree(batch->new);
> From the patch, r !=0 and batch->new !=NULL are exclusive, so free()
> here is not reachable.

Good point, I'll get rid of this.

Thank you,
Emanuele
>> +
>>       return r;
>>   }
> [...]
>>   
> 

