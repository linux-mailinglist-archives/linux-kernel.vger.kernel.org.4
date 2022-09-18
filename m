Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3D5BBEED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIRQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIRQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 12:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379955F4C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663517911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBfOixkOjHpC0SlW/myuMM+eEQ6CMURRJUP0DN9jWbI=;
        b=E+3cPXCmaPjO4IPF6/idlty0tCZvmSS9rV6xu+mzO8tXBO9y6ZZmUO4XSnjU5Eu3xWLHa5
        hoByYL9sYmWrg1LyItPVrfvVMnVo9KV1wKOTrXLAh+1QeZNqMIO34RwNeQ9iPiyiCcFlw8
        yenmxIt6y4n3fo8r2Wy/htbNDQHZzoE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-A9s1tydjMq2lknQa6EiDrQ-1; Sun, 18 Sep 2022 12:18:28 -0400
X-MC-Unique: A9s1tydjMq2lknQa6EiDrQ-1
Received: by mail-qt1-f199.google.com with SMTP id cb22-20020a05622a1f9600b0035bb51792d2so14842779qtb.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LBfOixkOjHpC0SlW/myuMM+eEQ6CMURRJUP0DN9jWbI=;
        b=OPOr6J68Gu/eQavJNciCkOgTYwG5dkiofK/EOW0eqHNjDZmFugYUspPAjMFOb+84dA
         SYeRCO+CM5z+J74Lf1tAhl7hwIAl2ynpPKqrYQUEWfUofRzzeHPLcgz9QWmsU6hLE/ui
         +bOWNFux/jPNr952nYT/m6xpMRCkAMnCVP5lCschXZX3VSyXcg6wz1TP1L1wGerumhY3
         DhHd2TEKt5yiCjgTyLqws+xQ5qcPcc/XAtv8JOztavlCcaMXRwdJHeRzgNkKUkU+0sN2
         /BlEihcwWXsPQ9sdHD2zj7j4TuHm6CuQNihNnjaRdbSeomFFWc5YLDCsPcYz0JAXB6xm
         DWXA==
X-Gm-Message-State: ACrzQf1l0VXo7+QhMrN5ufPmvcgxGZ8TrM1fXsdMeJ0gU/Iwde8fvwGP
        N/Nl0o3N+x0K4zJCX+bx2f1bEFidTuAKuy0XzZx0PWqrFF9JAfY3kFXeXuWKXdweDzy0mZMD1f0
        JNESPiV8bfVuVIVUJ76u1KYbx
X-Received: by 2002:a05:620a:2a0c:b0:6ce:7f98:d7a5 with SMTP id o12-20020a05620a2a0c00b006ce7f98d7a5mr10228425qkp.713.1663517907677;
        Sun, 18 Sep 2022 09:18:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4fgpD0KMAoAXpDXKH9gaDlFMR/QMWzXGxAYozX3WJQ8dzcwHKXfL1Yi6D9FrOIzRNTGWmuXw==
X-Received: by 2002:a05:620a:2a0c:b0:6ce:7f98:d7a5 with SMTP id o12-20020a05620a2a0c00b006ce7f98d7a5mr10228399qkp.713.1663517907447;
        Sun, 18 Sep 2022 09:18:27 -0700 (PDT)
Received: from ?IPV6:2a04:ee41:4:31cb:e591:1e1e:abde:a8f1? ([2a04:ee41:4:31cb:e591:1e1e:abde:a8f1])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a441000b006ceafb1aa92sm8124430qkp.96.2022.09.18.09.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 09:18:26 -0700 (PDT)
Message-ID: <d7e508d2-0f55-c417-107a-44c3315be030@redhat.com>
Date:   Sun, 18 Sep 2022 18:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 9/9] kvm_main.c: handle atomic memslot update
Content-Language: en-US
To:     "Yang, Weijiang" <weijiang.yang@intel.com>, kvm@vger.kernel.org
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
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-10-eesposit@redhat.com>
 <7e64d472-fbce-6640-033a-51b8906b7924@intel.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <7e64d472-fbce-6640-033a-51b8906b7924@intel.com>
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



Am 13/09/2022 um 04:30 schrieb Yang, Weijiang:
> 
> On 9/9/2022 6:45 PM, Emanuele Giuseppe Esposito wrote:
>> When kvm_vm_ioctl_set_memory_region_list() is invoked, we need
>> to make sure that all memslots are updated in the inactive list
>> and then swap (preferreably only once) the lists, so that all
>> changes are visible immediately.
> [...]
>> +static int kvm_vm_ioctl_set_memory_region_list(struct kvm *kvm,
>> +               struct kvm_userspace_memory_region_list *list,
>> +               struct kvm_userspace_memory_region_entry __user *mem_arg)
>> +{
>> +    struct kvm_userspace_memory_region_entry *mem, *m_iter;
>> +    struct kvm_userspace_memory_region *mem_region;
>> +    struct kvm_internal_memory_region_list *batch, *b_iter;
>> +    int i, r = 0;
>> +    bool *as_to_swap;
>> +
>> +    /* TODO: limit the number of mem to a max? */
>> +
>> +    if (!list->nent)
>> +        return r;
>> +
>> +    mem = vmemdup_user(mem_arg, array_size(sizeof(*mem), list->nent));
>> +    if (IS_ERR(mem)) {
>> +        r = PTR_ERR(mem);
>> +        goto out;
>> +    }
> 
> IMO, it's more natural to dup the user memory at the first place, i.e.,
> kvm_vm_ioctl,
> 
> it also makes the outlets shorter.
> 

I followed the same pattern as kvm_vcpu_ioctl_set_cpuid2, which performs
the user memory dup inside the call :)

I see your point but I guess it's better to keep all ioctl
implementations similar.

Thank you,
Emanuele

