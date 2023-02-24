Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E06A1FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBXQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBXQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B46A7A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677255980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Xi+aBdwuOD89B7gSm7Y+j5ZUoTLDl5rdG7wU4TCYXY=;
        b=XnXiz6cUn8/rIHZsuRPqBvExFqYQMQq4zSA1UGGa074yy8WpJtTy7FI698GryuwhDz/SpE
        el7aGiktpGgl1Gi6yt1QafkUFzEC+4GNZRDtutb5i2LwmHg68mzYlkORNv9bATZYKSjSax
        USXVbplKy1TnYajErAdvGOtxcms4skI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-u2jDRmVzNCGh2Y_roULm4Q-1; Fri, 24 Feb 2023 11:26:19 -0500
X-MC-Unique: u2jDRmVzNCGh2Y_roULm4Q-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so19760110edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xi+aBdwuOD89B7gSm7Y+j5ZUoTLDl5rdG7wU4TCYXY=;
        b=5yOrruVcm6fNpoF3m31D8jJE4dM+LtqCqQb2SGvekpvaHAx9xh6AYmebki1S651a5G
         uY1QjBx8RSlKtPK7GqWW5EJgfKOf1A7eZSdpg4hvL3JqXcqRkF/NIwDCmIWHauHzHJsj
         Bqu1mkqjJjKSzmiw0hTOpT9OKs9W59ZUlWxM+24bz7LWpuZTBfma8NAQo5KA62WCh7Nc
         C416OEydXK8rq1F5UqyVVtgAWX5dxSLGXihaCPTiPWyYHjn3RUX/lzfzhS+mMC9jLJ2M
         +q0GVxZEtY/B/3vU2dC1hHIQZ3N6eN7mthlv9wH1FtZ8MsyYlryj7VBJuxib5yxlyxO4
         tNOg==
X-Gm-Message-State: AO0yUKUm68oun3+wKkH9kf4PryUk+a83IQdNCevFloo6Ta44aHAhiVmJ
        ioBiZbL2NtAk5F9aNUlpTdDDocVCt9WnjDELTJ2lS949jEjleisukmkiuZMmECQyLL2itJjnW2R
        nFLQrF/k13f3i19AvV/uYqstO
X-Received: by 2002:a17:907:1623:b0:8b1:76dd:f5f6 with SMTP id hb35-20020a170907162300b008b176ddf5f6mr39580878ejc.50.1677255978262;
        Fri, 24 Feb 2023 08:26:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/V/bOhMcj1aqPLHaQnPGHD77HIE2wUV3FFmfrYJuWrVt3KIo+yNVog/5vKtvkTZ1ILPilVtQ==
X-Received: by 2002:a17:907:1623:b0:8b1:76dd:f5f6 with SMTP id hb35-20020a170907162300b008b176ddf5f6mr39580854ejc.50.1677255977916;
        Fri, 24 Feb 2023 08:26:17 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id k22-20020a170906579600b008edc39530fbsm2094504ejq.219.2023.02.24.08.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 08:26:17 -0800 (PST)
Message-ID: <6016ec96-fe6d-399f-2b9d-cd484ca28a3b@redhat.com>
Date:   Fri, 24 Feb 2023 17:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: "KVM: x86/mmu: Overhaul TDP MMU zapping and flushing" breaks SVM
 on Hyper-V
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu Lan <ltykernel@gmail.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <43980946-7bbf-dcef-7e40-af904c456250@linux.microsoft.com>
 <Y+p1j7tYT+16MX6B@google.com>
 <35ff8f48-2677-78ea-b5f3-329c75ce65c9@redhat.com>
 <Y+qLe42h9ZPRINrG@google.com>
 <CABgObfaZQOvt6v0yGz3MR7FBU7DcrTTGmS6M8RWCX0uy6WML1Q@mail.gmail.com>
 <20d189fc-8d20-8083-b448-460cc0420151@linux.microsoft.com>
 <Y+1ZpxAkome9s1Ve@google.com>
 <7e1d3590-2205-401c-c6f5-e4da534d85a7@linux.microsoft.com>
 <113888e0-ba94-deca-57a1-d3549d55a315@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <113888e0-ba94-deca-57a1-d3549d55a315@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/23 17:17, Jeremi Piotrowski wrote:
>>>>>>> Depending on the performance results of adding the hypercall to
>>>>>>> svm_flush_tlb_current, the fix could indeed be to just disable usage of
>>>>>>> HV_X64_NESTED_ENLIGHTENED_TLB.
>>>>>> Minus making nested SVM (L3) mutually exclusive, I believe this will do the trick:
>>>>>>
>>>>>> +       /* blah blah blah */
>>>>>> +       hv_flush_tlb_current(vcpu);
>>>>>> +
>>>>> Yes, it's either this or disabling the feature.
>>>>>
>>>>> Paolo
>>>> Combining the two sub-threads: both of the suggestions:
>>>>
>>>> a) adding a hyperv_flush_guest_mapping(__pa(root->spt) after kvm_tdp_mmu_get_vcpu_root_hpa's call to tdp_mmu_alloc_sp()
>>>> b) adding a hyperv_flush_guest_mapping(vcpu->arch.mmu->root.hpa) to svm_flush_tlb_current()
>>>>
>>>> appear to work in my test case (L2 vm startup until panic due to missing rootfs).
>>>>
>>>> But in both these cases (and also when I completely disable HV_X64_NESTED_ENLIGHTENED_TLB)
>>>> the runtime of an iteration of the test is noticeably longer compared to tdp_mmu=0.
>>> Hmm, what is test doing?
>> Booting through OVMF and kernel with no rootfs provided, and panic=-1 specified on the
>> kernel command line. It's a pure startup time test.
>>
> Hi Sean,
> 
> Have you been able to reproduce this by any chance?
> 
> I would be glad to see either of the two fixes getting merged (b) or a) if it doesn't require
> special L3 nested handling) in order to get this regression resolved.

For now the easiest course of action is to just disable the TDP MMU if 
HV_X64_NESTED_ENLIGHTENED_TLB is available.

Paolo

