Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7375C041A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiIUQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiIUQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4426FA00
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663776504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OimMW84wY0gR3/RBoF6C5PXZtsmsYoRilCEK1meGRSk=;
        b=a5bHNKFwmXm1r+CoTaO78RN9Donj66KEwriP7wF8ikzXysbUHl0/rAIDHh6j0u3DJ4Cj9M
        r3X/44dD7HjeGTUGPrimKoEmxwtsyjrhg/xR6/uMZXLWmxgy2l8VS0jVYynI24fvy0S5UD
        ocDGaTxb4aslC/5kfrHbhzGmBtNvMn4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-142-2Zqx1BJEP1iKXXA-K0Ke9g-1; Wed, 21 Sep 2022 12:08:23 -0400
X-MC-Unique: 2Zqx1BJEP1iKXXA-K0Ke9g-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0045249bc17a9so4749080edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OimMW84wY0gR3/RBoF6C5PXZtsmsYoRilCEK1meGRSk=;
        b=HwcSs9l+dABKK7pcZuy6UL46ag3/a88kmwsgEVN8P6w9pUaOavC2E667QNfa13JbAK
         f8iPbQQXR4UNANUa0Fu9unKLTVHAaawH7kC+ktqSW9w7kJOb1w0Shqej8hmb/z6ixRjd
         EJLOB8+OLoAv/Hr01Pq9nkAdKewte0dE57Sg5ZNG1l/anGZ0v8TgSQ0VlX4H5zvKvXxw
         C0MChrplWZVb9+MbSTdhYxXL2xVgiHj2zKVP8xUGctySMbu7dIkeYpNDjxktObMaUizm
         WV3qWcSUlB9Fy0RcpRSvUpqCw7tRnXy48lsP8WYlisA0BedxSyESnbCsGc+yReHZtEkD
         0lDA==
X-Gm-Message-State: ACrzQf3q4FcYIMf48etlLJ8s9Hu/j56hATgsdUz5SElmdh4ibsHFP69I
        ZSZ0N1DTmRbHkcXUaPruQ8zaM3PuMUc1E1hD0YeNK0XwOv8M/Clv5f85LRdeVD0YX3JO5QIxoo7
        8hHNZ1Eg8QCVyimSNzMqnrl5z
X-Received: by 2002:a17:907:3f12:b0:77b:8d8:f353 with SMTP id hq18-20020a1709073f1200b0077b08d8f353mr21182512ejc.349.1663776502187;
        Wed, 21 Sep 2022 09:08:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4DBqU/AVjJWIHOO6nCHwQXljJw/YpNMz5sjefCqFsHKjJncrVMfsnJyDfsFAx7AeUUbHoOlg==
X-Received: by 2002:a17:907:3f12:b0:77b:8d8:f353 with SMTP id hq18-20020a1709073f1200b0077b08d8f353mr21182494ejc.349.1663776502005;
        Wed, 21 Sep 2022 09:08:22 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e4-20020aa7d7c4000000b0044ec76521a1sm2075927eds.55.2022.09.21.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:08:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v4 1/9] KVM: x86/mmu: Bug the VM if KVM attempts to
 double count an NX huge page
In-Reply-To: <YyswlLykptcOciOS@google.com>
References: <20220830235537.4004585-1-seanjc@google.com>
 <20220830235537.4004585-2-seanjc@google.com> <87tu50oohn.fsf@redhat.com>
 <YysjGNtYJbbPuxSN@google.com> <YyswlLykptcOciOS@google.com>
Date:   Wed, 21 Sep 2022 18:08:18 +0200
Message-ID: <87leqcoglp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 21, 2022, Sean Christopherson wrote:
>> On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
>> > [  962.257992]  ept_fetch+0x504/0x5a0 [kvm]
>> > [  962.261959]  ept_page_fault+0x2d7/0x300 [kvm]
>> > [  962.287701]  kvm_mmu_page_fault+0x258/0x290 [kvm]
>> > [  962.292451]  vmx_handle_exit+0xe/0x40 [kvm_intel]
>> > [  962.297173]  vcpu_enter_guest+0x665/0xfc0 [kvm]
>> > [  962.307580]  vcpu_run+0x33/0x250 [kvm]
>> > [  962.311367]  kvm_arch_vcpu_ioctl_run+0xf7/0x460 [kvm]
>> > [  962.316456]  kvm_vcpu_ioctl+0x271/0x670 [kvm]
>> > [  962.320843]  __x64_sys_ioctl+0x87/0xc0
>> > [  962.324602]  do_syscall_64+0x38/0x90
>> > [  962.328192]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> Ugh, past me completely forgot the basics of shadow paging[*].  The shadow MMU
>> can reuse existing shadow pages, whereas the TDP MMU always links in new pages.
>> 
>> I got turned around by the "doesn't exist" check, which only means "is there
>> already a _SPTE_ here", not "is there an existing SP for the target gfn+role that
>> can be used".
>> 
>> I'll drop the series from the queue, send a new pull request, and spin a v5
>> targeting 6.2, which amusing will look a lot like v1...
>
> Huh.  I was expecting more churn, but dropping the offending patch and then
> "reworking" the series yields a very trivial overall diff.  
>
> Vitaly, can you easily re-test with the below, i.e. simply delete the
> KVM_BUG_ON()?

This seems to work! At least, I haven't noticed anything weird when
booting my beloved Win11 + WSL2 guest.

-- 
Vitaly

