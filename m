Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D869B336
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBQThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQTha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A3126F0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676662606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYExQvIsCt0o1ZEFa6ZanJqmfuLccRgbfCWm1JARXDs=;
        b=anRN/uhxJnYN7opbAX9C+PBOWD7UAlSWwpzhDg1188mXVyIo2WJkfYbEWpdhPQ6w9JUeL2
        eTdEPsrwTRcPSTAujbGGUX71VEig8N2G3vVFC7ujaFjRpzhRGMJ9I+AR9GxVPKOTDJbwBb
        i9AhQNAkCFjaHwfsRTttxn41LFOoPYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450--uacMiPnMzW4bzKD0yKt8A-1; Fri, 17 Feb 2023 14:36:44 -0500
X-MC-Unique: -uacMiPnMzW4bzKD0yKt8A-1
Received: by mail-wm1-f72.google.com with SMTP id m19-20020a05600c3b1300b003e21fa60ec1so63718wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYExQvIsCt0o1ZEFa6ZanJqmfuLccRgbfCWm1JARXDs=;
        b=A+tVvgQ+VNZERlR+JVqXzvoWWoSJLBNbyOaKk04a/Ekmew6lsC4t4NhLz5ItBQFrfA
         Qje/KvFil+i975ntxtVVddu1sEbtSbSJdQnb+ludrgww+SHO7zZ9iqQbHnQHA9Rc0ZqS
         LKxtmbwxAJHD1CulriocM8ezD5AHds+zbwFXYCAOX1pe+GPmCd5623oHhpQFwi1t6X6A
         oWCMeN80dB5aKa1yIhGKaAN50cpEJ3wiZuGwNdrEZ6XR/wVK9r9Cw40UdEqPgvdnMtyS
         Np2p2G65kZMFiZhfX+xdkcTOXi44voDcT782DYQZGAbsE4gn3cahb36EaPwg9xcVnSIh
         28cg==
X-Gm-Message-State: AO0yUKWvqsfbwFlFsGIQqVgWWDammrY3itIVjD+CkJRQr3twUz9zPOAC
        c1xPHeuzBLd29yU7o2KlZeuhd+dTNcZ6dueAY35KWhEHp4+PoERAOjSOSfZQXVFBLUYHUwg0rHX
        ag5nVSc0Hlc9wuCpV6aWlFyb5
X-Received: by 2002:a05:600c:3481:b0:3df:eda1:439c with SMTP id a1-20020a05600c348100b003dfeda1439cmr6053871wmq.11.1676662603428;
        Fri, 17 Feb 2023 11:36:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/V4gZYOcfO6sSKYUl4AVbZ5LonUXino43CN37EpI7D/k8Yl39Woa9L0raq23pt4GsJlNtF0g==
X-Received: by 2002:a05:600c:3481:b0:3df:eda1:439c with SMTP id a1-20020a05600c348100b003dfeda1439cmr6053861wmq.11.1676662603164;
        Fri, 17 Feb 2023 11:36:43 -0800 (PST)
Received: from [192.168.8.104] (tmo-110-21.customers.d1-online.com. [80.187.110.21])
        by smtp.gmail.com with ESMTPSA id az17-20020a05600c601100b003dd1bd0b915sm2825694wmb.22.2023.02.17.11.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 11:36:42 -0800 (PST)
Message-ID: <06d04f32-8403-4d7f-76a1-11a7fac3078e@redhat.com>
Date:   Fri, 17 Feb 2023 20:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Daniel P. Berrange" <berrange@redhat.com>
References: <20220926165112.603078-1-pbonzini@redhat.com>
 <YzMt24/14n1BVdnI@google.com>
 <ed74c9a9d6a0d2fd2ad8bd98214ad36e97c243a0.camel@redhat.com>
 <15291c3f-d55c-a206-9261-253a1a33dce1@redhat.com>
 <YzRycXDnWgMDgbD7@google.com>
 <ad97d0671774a873175c71c6435763a33569f669.camel@redhat.com>
 <YzSKhUEg3L1eMKOR@google.com>
 <08dab49f-9ca4-4978-4482-1815cf168e74@redhat.com>
 <b8fa9561295bb6af2b7fcaa8125c6a3b89b305c7.camel@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
In-Reply-To: <b8fa9561295bb6af2b7fcaa8125c6a3b89b305c7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 15.52, Maxim Levitsky wrote:
> On Thu, 2022-09-29 at 15:26 +0200, Paolo Bonzini wrote:
>> On 9/28/22 19:55, Sean Christopherson wrote:
>>>> As far as my opinion goes I do volunteer to test this code more often,
>>>> and I do not want to see the 32 bit KVM support be removed*yet*.
>>>
>>> Yeah, I 100% agree that it shouldn't be removed until we have equivalent test
>>> coverage.  But I do think it should an "off-by-default" sort of thing.  Maybe
>>> BROKEN is the wrong dependency though?  E.g. would EXPERT be a better option?
>>
>> Yeah, maybe EXPERT is better but I'm not sure of the equivalent test
>> coverage.  32-bit VMX/SVM kvm-unit-tests are surely a good idea, but
>> what's wrong with booting an older guest?
> 
>>From my point of view, using the same kernel source for host and the guest
> is easier because you know that both kernels behave the same.
> 
> About EXPERT, IMHO these days most distros already dropped 32 bit suport thus anyway
> one needs to compile a recent 32 bit kernel manually - thus IMHO whoever
> these days compiles a 32 bit kernel, knows what they are doing.
> 
> I personally would wait few more releases when there is a pressing reason to remove
> this support.

FWIW, from the QEMU perspective, it would be very helpful to remove 32-bit 
KVM support from the kernel. The QEMU project currently struggles badly with 
keeping everything tested in the CI in a reasonable amount of time. The 
32-bit KVM kernel support is the only reason to keep the qemu-system-i386 
binary around - everything else can be covered with the qemu-system-x86_64 
binary that is a superset of the -i386 variant (except for the KVM part as 
far as I know).
Sure, we could also drop qemu-system-i386 from the CI without dropping the 
32-bit KVM code in the kernel, but I guess things will rather bitrot there 
even faster in that case, so I'd appreciate if the kernel could drop the 
32-bit in the near future, too.

  Thomas

