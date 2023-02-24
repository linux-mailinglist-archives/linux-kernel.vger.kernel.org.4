Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F26A169D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBXG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7932305CB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677220115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8NmeWYfEBo54q57BynLRuq+X9RVl5AphfQ84IuXhB4=;
        b=cBOViVYBTSJz5CIvn5aflc6WnYypVbTFMPiADuM7CTP/jeT4Gp9aNVrwe/elotkOFDuD0J
        dKszVP/4qT07cO4WI0Bs4RQdw++PVbnTm6sJsir1KN5R9VAbWTnyK8nyU4qhjTcz6jEDTX
        8/88eMIPFHl7YJd052h2+cekOyyVPKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54--rrHZ6cLMReJl6kyLaVGVw-1; Fri, 24 Feb 2023 01:28:34 -0500
X-MC-Unique: -rrHZ6cLMReJl6kyLaVGVw-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b003e10d3e1c23so802793wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8NmeWYfEBo54q57BynLRuq+X9RVl5AphfQ84IuXhB4=;
        b=fnUjIr39k7n1bUgk4ljy/xefycRC3Qrbt6W7/RH3Dh40wCZrwJ+xJ3XGv9lELyDBTk
         A0J1J4uv45vCHHBwkRB1qrLaglNWU+O7LIwCpXxAMieTQiSM5cC56SL9dRQF8NsH0gu1
         glsj275SKSXk0DP7z+mjcf2KHbw3yUv8GH2ooQDLh3biAnDRb778nAdc3yt4TZWesT71
         mHEoqIAKaeiIO1AWRC+3OMeuGZmoN7jRyCXio1NpUJ11SUy55B8+7Iq+hrn8hcsydxve
         sNekiO4a6FyNbQyq/02n3mdmbMFa7hwDd42uuIrb3yFMki6D1ANVln/KZ76T7ZONR080
         QHRQ==
X-Gm-Message-State: AO0yUKXPZtezf1Rg/frWvQDLwQTarcoX+JoA9iKS2XVhTzVZe8MTbaGA
        gnUI38zPS1BJa8wSOLvlcZfDJZXfewKFXDQQwzYaeaGdFvRrFb/pz5+Wzp4NLoLPr+ZG77sc/4W
        DwECswCC94Q7ney1NoZ8tdziY
X-Received: by 2002:a05:6000:18cc:b0:2c3:f00c:ebaa with SMTP id w12-20020a05600018cc00b002c3f00cebaamr12779612wrq.4.1677220113285;
        Thu, 23 Feb 2023 22:28:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8tIaeA/259vouSZG8Ssz+MwsY2MlwshXVTqw/09KyTDp1P44dXBc8TB2n2sZCTwGon2WoJ3A==
X-Received: by 2002:a05:6000:18cc:b0:2c3:f00c:ebaa with SMTP id w12-20020a05600018cc00b002c3f00cebaamr12779601wrq.4.1677220112971;
        Thu, 23 Feb 2023 22:28:32 -0800 (PST)
Received: from [192.168.8.100] (tmo-115-119.customers.d1-online.com. [80.187.115.119])
        by smtp.gmail.com with ESMTPSA id e7-20020adffc47000000b002c70f5627d5sm4215917wrs.63.2023.02.23.22.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 22:28:32 -0800 (PST)
Message-ID: <1fc187c0-e1b1-bb8c-bee2-0820598a8cd9@redhat.com>
Date:   Fri, 24 Feb 2023 07:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, "Daniel P. Berrange" <berrange@redhat.com>
References: <15291c3f-d55c-a206-9261-253a1a33dce1@redhat.com>
 <YzRycXDnWgMDgbD7@google.com>
 <ad97d0671774a873175c71c6435763a33569f669.camel@redhat.com>
 <YzSKhUEg3L1eMKOR@google.com>
 <08dab49f-9ca4-4978-4482-1815cf168e74@redhat.com>
 <b8fa9561295bb6af2b7fcaa8125c6a3b89b305c7.camel@redhat.com>
 <06d04f32-8403-4d7f-76a1-11a7fac3078e@redhat.com>
 <Y/aWx4EiDzKW6RHe@google.com>
 <05144c6d-922c-e70d-e625-c60952b60f3c@redhat.com>
 <092591cbcc40fbbcc42abd3f603b6d782f411770.camel@redhat.com>
 <Y/fkTs5ajFy0hP1U@google.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <Y/fkTs5ajFy0hP1U@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 23.10, Sean Christopherson wrote:
> On Thu, Feb 23, 2023, Maxim Levitsky wrote:
>> On Thu, 2023-02-23 at 08:01 +0100, Thomas Huth wrote:
>>> On 22/02/2023 23.27, Sean Christopherson wrote:
>>>> On Fri, Feb 17, 2023, Thomas Huth wrote:
>>>>> On 29/09/2022 15.52, Maxim Levitsky wrote:
>>>>>> On Thu, 2022-09-29 at 15:26 +0200, Paolo Bonzini wrote:
>>>>>>> On 9/28/22 19:55, Sean Christopherson wrote:
>>>>>>>>> As far as my opinion goes I do volunteer to test this code more often,
>>>>>>>>> and I do not want to see the 32 bit KVM support be removed*yet*.
>>>>>>>>
>>>>>>>> Yeah, I 100% agree that it shouldn't be removed until we have equivalent test
>>>>>>>> coverage.  But I do think it should an "off-by-default" sort of thing.  Maybe
>>>>>>>> BROKEN is the wrong dependency though?  E.g. would EXPERT be a better option?
>>>>>>>
>>>>>>> Yeah, maybe EXPERT is better but I'm not sure of the equivalent test
>>>>>>> coverage.  32-bit VMX/SVM kvm-unit-tests are surely a good idea, but
>>>>>>> what's wrong with booting an older guest?
>>>>>>>   From my point of view, using the same kernel source for host and the guest
>>>>>> is easier because you know that both kernels behave the same.
>>>>>>
>>>>>> About EXPERT, IMHO these days most distros already dropped 32 bit suport thus anyway
>>>>>> one needs to compile a recent 32 bit kernel manually - thus IMHO whoever
>>>>>> these days compiles a 32 bit kernel, knows what they are doing.
>>>>>>
>>>>>> I personally would wait few more releases when there is a pressing reason to remove
>>>>>> this support.
>>>>>
>>>>> FWIW, from the QEMU perspective, it would be very helpful to remove 32-bit
>>>>> KVM support from the kernel. The QEMU project currently struggles badly with
>>>>> keeping everything tested in the CI in a reasonable amount of time. The
>>>>> 32-bit KVM kernel support is the only reason to keep the qemu-system-i386
>>>>> binary around - everything else can be covered with the qemu-system-x86_64
>>>>> binary that is a superset of the -i386 variant (except for the KVM part as
>>>>> far as I know).
>>>>> Sure, we could also drop qemu-system-i386 from the CI without dropping the
>>>>> 32-bit KVM code in the kernel, but I guess things will rather bitrot there
>>>>> even faster in that case, so I'd appreciate if the kernel could drop the
>>>>> 32-bit in the near future, too.
>>>>
>>>> Ya, I would happily drop support for 32-bit kernels today, the only sticking point
>>>> is the lack of 32-bit shadow paging test coverage, which unfortunately is a rather
>>>> large point.  :-(
>>>
>>>   From your point of view, would it be OK if QEMU dropped qemu-system-i386?
>>> I.e. would it be fine to use older versions of QEMU only for that test
>>> coverage (or do you even use a different userspace for testing that)?
> 
> For me personally, I have no objection to dropping qemu-system-i386 support in
> future QEMU releases.  I update my 32-bit images very, very infrequently, so I
> probably wouldn't even notice for like 5 years :-)
> 
>>  From my point of view qemu-system-x86_64 does run 32 bit guests just fine.
> 
> Right, but unless I seriously misunderstand what qemu-system-x86_64 ecompasses,
> it can't be used to run guests of 32-bit _hosts_, which is what we need to test
> shadowing of 32-bit NPT.

That's what I've been told in the past, too, and that's why I asked. Thanks 
for the clarification!

To summarize: My takeaway is that nobody really needs qemu-system-i386 
anymore for recent development - the remaining 32-bit KVM use cases can be 
done with older versions of QEMU instead, thus it should be fine for the 
QEMU project to drop qemu-system-i386 nowadays.

  Thanks,
   Thomas

