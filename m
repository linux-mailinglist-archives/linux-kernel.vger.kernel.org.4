Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5485EE08F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiI1PeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiI1PeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0071526C0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664379238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hvc4Bth99XeaF63Xo1wSSTs7cb8JI+3eopPFDZGezg=;
        b=NDJ8PRVgfH9fncrBkB+7/e9gFBVDZqe7Un7hSKqXUxLr17N4tIG85bfgZ7eKVmXXpxSGN8
        p8e2I5mdL/f9flfwxseqdX/TdYlAhAz4lU7j+bnljJXZBUl2/a8oogtdyRXxMvV/DthPoD
        y0r5C51ki1qAZ2Uv2Wo9ARRkLnyY1i4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-3Kv6T0lrNO-JWOqdv-0Wmg-1; Wed, 28 Sep 2022 11:33:56 -0400
X-MC-Unique: 3Kv6T0lrNO-JWOqdv-0Wmg-1
Received: by mail-wm1-f70.google.com with SMTP id b5-20020a05600c4e0500b003b499f99aceso1420047wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7Hvc4Bth99XeaF63Xo1wSSTs7cb8JI+3eopPFDZGezg=;
        b=wU9lJ7ibHE+LV1jk2AJlNzlZoFjESXZjCDqXCgZwKN6KkztUIRLtwsh3TuD0oxbt06
         oWd8Tvc238jfbkNf1KSMyb9uo+2fFLl+36QiFaWQvMDKt2wS2JP97kOc/f9sMGqliZv9
         7Xjy4wyHrFlPyRKPifbP5mYZJ+l5bxWJQQ4LcPxPGYJHSsQbc170gf12+bBY+cCMwake
         tmGt5qm+2IZ7uzTrLE4zMhs/0lU+fxREaW/JQDOXvq4EBU0sSUwz11Z3Gp1Fq3Tc1Y7w
         2BjXlZbJQeuDHYZeOlmbDbdtVMjJn6QWkTaPiTwXE79IqfTPH+NU6BjOs7ZMTzQ6q0yp
         JVsg==
X-Gm-Message-State: ACrzQf3qA1x3alN8j0515xvvNQ0MsqGfIDavZl2a7DkHdfMTp98TIIS2
        lB6qN67su4lfOkIAWhNhyytXU9bTP8zhUAktfBsu6Ho3Sw013dqf5pB/4F8bgGKhD/8LtO+LWsh
        ohVqtsDTDDt2DvXqVYqAIzJ/e
X-Received: by 2002:a5d:4648:0:b0:22c:cc4b:5327 with SMTP id j8-20020a5d4648000000b0022ccc4b5327mr953821wrs.646.1664379235581;
        Wed, 28 Sep 2022 08:33:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6rJi3nmjOcBa12AnKu94RezVzFzaamRYHigEI5k17H/J7+VENgjW/3k5n/8wLIG3t4YovXTg==
X-Received: by 2002:a5d:4648:0:b0:22c:cc4b:5327 with SMTP id j8-20020a5d4648000000b0022ccc4b5327mr953794wrs.646.1664379235256;
        Wed, 28 Sep 2022 08:33:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:1100:add9:5f61:6b94:7540? (p200300cbc7041100add95f616b947540.dip0.t-ipconnect.de. [2003:cb:c704:1100:add9:5f61:6b94:7540])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b003b31c560a0csm2092591wmq.12.2022.09.28.08.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 08:33:54 -0700 (PDT)
Message-ID: <57621993-95e2-b628-3c03-adf96384f4bb@redhat.com>
Date:   Wed, 28 Sep 2022 17:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 0/9] kvm: implement atomic memslot updates
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
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
References: <YxtOEgJhe4EcAJsE@google.com>
 <5f0345d2-d4d1-f4fe-86ba-6e22561cb6bd@redhat.com>
 <37b3162e-7b3a-919f-80e2-f96eca7d4b4c@redhat.com>
 <dfcbdf1d-b078-ec6c-7706-6af578f79ec2@redhat.com>
 <55d7f0bd-ace1-506b-ea5b-105a86290114@redhat.com>
 <f753391e-7bdc-bada-856a-87344e75bd74@redhat.com>
 <111a46c1-7082-62e3-4f3a-860a95cd560a@redhat.com>
 <14d5b8f2-7cb6-ce24-c7a7-32aa9117c953@redhat.com>
 <YzIZhn47brWBfQah@google.com>
 <3b04db9d-0177-7e6e-a54c-a28ada8b1d36@redhat.com>
 <YzMdjSkKaJ8HyWXh@google.com>
 <dd6db8c9-80b1-b6c5-29b8-5eced48f1303@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <dd6db8c9-80b1-b6c5-29b8-5eced48f1303@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.22 17:07, Paolo Bonzini wrote:
> On 9/27/22 17:58, Sean Christopherson wrote:
>> On Tue, Sep 27, 2022, Emanuele Giuseppe Esposito wrote:
>>>
>>> Am 26/09/2022 um 23:28 schrieb Sean Christopherson:
>>>> On Mon, Sep 26, 2022, David Hildenbrand wrote:
>>>>> As Sean said "This is an awful lot of a complexity to take on for something
>>>>> that appears to be solvable in userspace."
>>>>
>>>> And if the userspace solution is unpalatable for whatever reason, I'd like to
>>>> understand exactly what KVM behavior is problematic for userspace.  E.g. the
>>>> above RHBZ bug should no longer be an issue as the buggy commit has since been
>>>> reverted.
>>>
>>> It still is because I can reproduce the bug, as also pointed out in
>>> multiple comments below.
>>
>> You can reproduce _a_ bug, but it's obviously not the original bug, because the
>> last comment says:
>>
>>     Second, indeed the patch was reverted and somehow accepted without generating
>>     too much noise:
>>
>>     ...
>>
>>     The underlying issue of course as we both know is still there.
>>
>>     You might have luck reproducing it with this bug
>>
>>     https://bugzilla.redhat.com/show_bug.cgi?id=1855298
>>
>>     But for me it looks like it is 'working' as well, so you might have
>>     to write a unit test to trigger the issue.
>>
>>>> If the issue is KVM doing something nonsensical on a code fetch to MMIO, then I'd
>>>> much rather fix _that_ bug and improve KVM's user exit ABI to let userspace handle
>>>> the race _if_ userspace chooses not to pause vCPUs.
>>>>
>>>
>>> Also on the BZ they all seem (Paolo included) to agree that the issue is
>>> non-atomic memslots update.
>>
>> Yes, non-atomic memslot likely results in the guest fetching from a GPA without a
>> memslot.  I'm asking for an explanation of exactly what happens when that occurs,
>> because it should be possible to adjust KVM and/or QEMU to play nice with the
>> fetch, e.g. to resume the guest until the new memslot is installed, in which case
>> an atomic update isn't needed.
>>
>> I assume the issue is that KVM exits with KVM_EXIT_INTERNAL_ERROR because the
>> guest is running at CPL=0, and QEMU kills the guest in response.  If that's correct,
>> then that problem can be solved by exiting to userspace with KVM_EXIT_MMIO instead
>> of KVM_EXIT_INTERNAL_ERROR so that userspace can do something sane in response to
>> the MMIO code fetch.
>>
>> I'm pretty sure this patch will Just Work for QEMU, because QEMU simply resumes
>> the vCPU if mmio.len==0.  It's a bit of a hack, but I don't think it violates KVM's
>> ABI in any way, and it can even become "official" behavior since KVM x86 doesn't
>> otherwise exit with mmio.len==0.
> 
> I think this patch is not a good idea for two reasons:
> 
> 1) we don't know how userspace behaves if mmio.len is zero.  It is of
> course reasonable to do nothing, but an assertion failure is also a
> valid behavior
> 
> 2) more important, there is no way to distinguish a failure due to the
> guest going in the weeds (and then KVM_EXIT_INTERNAL_ERROR is fine) from
> one due to the KVM_SET_USER_MEMORY_REGION race condition.  So this will
> cause a guest that correctly caused an internal error to loop forever.
> 
> While the former could be handled in a "wait and see" manner, the latter
> in particular is part of the KVM_RUN contract.  Of course it is possible
> for a guest to just loop forever, but in general all of KVM, QEMU and
> upper userspace layers want a crashed guest to be detected and stopped
> forever.
> 
> Yes, QEMU could loop only if memslot updates are in progress, but
> honestly all the alternatives I have seen to atomic memslot updates are
> really *awful*.  David's patches even invent a new kind of mutex for
> which I have absolutely no idea what kind of deadlocks one should worry
> about and why they should not exist; QEMU's locking is already pretty
> crappy, it's certainly not on my wishlist to make it worse!

Just to comment on that (I'm happy as long as this gets fixed), a simple 
mutex with trylock should get the thing done as well -- kicking the VCPU 
if the trylock fails. But I did not look further into locking alternatives.

-- 
Thanks,

David / dhildenb

