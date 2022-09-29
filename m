Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521AA5EF052
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiI2IYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiI2IYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF41C1A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664439875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGv1JHAhPXZqqb7g7YUmRe7Q2fJqPz0gthMW+myxPZs=;
        b=FPJ/X9iizTp2LMc2aHjpzKNEYg/1k7G6ANMvISkL/ykdzFXCv4vho3LRGhVMfYuHf9nf5V
        x9DDpHhYkaROoWPFbePPc/SeXJoqJHHunxQJuZRZ5RwQsR26f2a2Q0ufjaCeNcuzAi2Z6/
        Yr5WtkQCmeTcO9eknI8j+yuVl3IbDTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-bTCqq8OwNDSuTtLrKvJd4A-1; Thu, 29 Sep 2022 04:24:30 -0400
X-MC-Unique: bTCqq8OwNDSuTtLrKvJd4A-1
Received: by mail-wr1-f69.google.com with SMTP id o7-20020adfba07000000b00228663f217fso226962wrg.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=eGv1JHAhPXZqqb7g7YUmRe7Q2fJqPz0gthMW+myxPZs=;
        b=mxLRMX3FOdNp9Kw22FkfRseKeUvUDsT1bcHIaqksSkVaVsHMKacFQsMU891/ZWZO8m
         2etiTrnZT5itQKzqdHo4Y44ajIdfsqeGYJgS4/0ysASq7KXY5+mOuIyWVv7JwIaYwkrW
         i9nqR4NZlP/aHsaiut3xgtyvFvm4EKsi+Ax7IAe3arAOPqIJ3VsZUx8jTDjlec7gU23f
         jc6k1hehyWFmYs4xpAXxsOgu/OuRUYrwQuZ7xfHwiLYQQ2D0IbecEwAvD1JeC7+DSq7N
         3Jsx+HCpakcEBrx81IWtpgbIi253F0oxJVVEbbbVL0boJ1kp8W81Gc+tAgEmHexQalQn
         xyaQ==
X-Gm-Message-State: ACrzQf0VLFd9xcYkR1ginUpv5K4dN0EZbIFlQ05friitjFMS7z+D71Tb
        lWb5YiyISJkT9+fGu/z28ywBKYwa6p+OeZW+KmsuahmDmJk3uY0FcltAnrczywp5/WUDxwtq+o5
        lY9ihWEVfNPr3Wgz7adbDQt6b
X-Received: by 2002:a05:6000:2ad:b0:22a:399b:5611 with SMTP id l13-20020a05600002ad00b0022a399b5611mr1317896wry.434.1664439869188;
        Thu, 29 Sep 2022 01:24:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6W+5+fHtlLgKVEAZNvyyln2tT2qaJfB7tfgYmeHu1zI5+dohDHUYiHHiVFkePQdXvbOQbfFw==
X-Received: by 2002:a05:6000:2ad:b0:22a:399b:5611 with SMTP id l13-20020a05600002ad00b0022a399b5611mr1317879wry.434.1664439868951;
        Thu, 29 Sep 2022 01:24:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id x17-20020adff651000000b00228fa832b7asm6112405wrp.52.2022.09.29.01.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:24:28 -0700 (PDT)
Message-ID: <9b809d54-e7f5-5b6a-9586-2248336dbd9b@redhat.com>
Date:   Thu, 29 Sep 2022 10:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 0/9] kvm: implement atomic memslot updates
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
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
 <637e7ef3-e204-52fc-a4ff-1f0df5227a3e@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <637e7ef3-e204-52fc-a4ff-1f0df5227a3e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 10:05, Emanuele Giuseppe Esposito wrote:
> 
> 
> Am 28/09/2022 um 22:41 schrieb Sean Christopherson:
>> On Wed, Sep 28, 2022, Paolo Bonzini wrote:
>>> On 9/28/22 17:58, Sean Christopherson wrote:
>>>> I don't disagree that the memslots API is lacking, but IMO that is somewhat
>>>> orthogonal to fixing KVM x86's "code fetch to MMIO" mess.  Such a massive new API
>>>> should be viewed and prioritized as a new feature, not as a bug fix, e.g. I'd
>>>> like to have the luxury of being able to explore ideas beyond "let userspace
>>>> batch memslot updates", and I really don't want to feel pressured to get this
>>>> code reviewed and merge.
>>>
>>> I absolutely agree that this is not a bugfix.  Most new features for KVM can
>>> be seen as bug fixes if you squint hard enough, but they're still features.
>>
>> I guess I'm complaining that there isn't sufficient justification for this new
>> feature.  The cover letter provides a bug that would be fixed by having batched
>> updates, but as above, that's really due to deficiencies in a different KVM ABI.
>>
>> Beyond that, there's no explanation of why this exact API is necessary, i.e. there
>> are no requirements given.
>>
>>    - Why can't this be solved in userspace?
> 
> Because this would provide the "feature" only to QEMU, leaving each
> other hypervisor to implement its own.
> 
> In addition (maybe you already answered this question but I couldn't
> find an answer in the email thread), does it make sense to stop all
> vcpus for a couple of memslot update? What if we have 100 cpus?
> 
>>
>>    - Is performance a concern?  I.e. are updates that need to be batched going to
>>      be high frequency operations?
> 
> Currently they are limited to run only at boot. In an unmodified
> KVM/QEMU build, however, I count 86 memslot updates done at boot with
> 
> ./qemu-system-x86_64 --overcommit cpu-pm=on --smp $v --accel kvm
> --display none

I *think* there are only ~3 problematic ones (split/resize), where we 
temporarily delete something we will re-add. At least that's what I 
remember from working on my prototype.

-- 
Thanks,

David / dhildenb

