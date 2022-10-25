Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136C60D637
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiJYVeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiJYVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9010B796
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666733658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXHwc88zoXy5niySo4vHvgYx00FvBOSVxmx9o0lebKk=;
        b=YAR+Z5r2tqFvbNXEySzh5Hog6NaE7UZaYhq7sVZAA+s1Ex1t05g7kxDFfl5SrNA21R3p20
        E+42BM5aYLY4o8S940EClfy+8/NG5wziRaNNarLVZbkbmp0ICVaNowavzhTTR8Diw+4UQE
        bNXTkNOJCvXpanwjYi9xbqFd5/bRfq0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-PDhdg9EoOeir1UGFQrKUlw-1; Tue, 25 Oct 2022 17:34:16 -0400
X-MC-Unique: PDhdg9EoOeir1UGFQrKUlw-1
Received: by mail-wr1-f72.google.com with SMTP id l16-20020adfc790000000b00230c2505f96so5191758wrg.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXHwc88zoXy5niySo4vHvgYx00FvBOSVxmx9o0lebKk=;
        b=yuILHlgbr/SjakFqcnwPMHxHpAO8fdLcwnSwWLIipekjHgabeDX+8Wue/SXzv1rWBr
         3A5XDQng3C+mp0UYuzZ3y9Ycaj5P3ACjCvYYQ0lJJ1Vjn8ek0fu6t7ipsOJ6kJkrJlRd
         2Z5l2YMqp0oxERjlX/gXMOOzHQancyjEVxrRmCabUhzRTTup69LaVDZkmfz3DpwjEBJH
         KUzetAagxLrWUxWhFoTjG/ygvKZqJe+tcSPiG+YEMYlJubTHljlHazuLjwWMtnNVSTxv
         /WiNBJT4J/DPTAJklG9FlMRwLiyb8qDJ4LdZla0q0xRuaLR33SOFRdUXVprjbfyBIII0
         4SvQ==
X-Gm-Message-State: ACrzQf3hqzUb1Q891xvmDf/GGTjpcN4QfuRTLfk94rKsVYBueDmbRGfk
        utN/ppGEsPZW8ROfqFYswqkMlfaLg32CDGwmQ42A/BSNRg3IxS9YU3r4xURlOBaHErDQRC+mBL5
        NoYYCJN6qkJZDsKumf+IzmFci
X-Received: by 2002:a5d:64cd:0:b0:236:6d1c:c1a2 with SMTP id f13-20020a5d64cd000000b002366d1cc1a2mr10411527wri.360.1666733655636;
        Tue, 25 Oct 2022 14:34:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Hl+RX0kZAcgsB+yOz64CtotYs1n5NnSCZiP2ZgHwiy2s2f79AAZHBEylZPdYcfSzcxH9V3A==
X-Received: by 2002:a5d:64cd:0:b0:236:6d1c:c1a2 with SMTP id f13-20020a5d64cd000000b002366d1cc1a2mr10411518wri.360.1666733655418;
        Tue, 25 Oct 2022 14:34:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id p2-20020a5d6382000000b002368a6deaf8sm389470wru.57.2022.10.25.14.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 14:34:14 -0700 (PDT)
Message-ID: <02c910bb-3ea0-fa84-7a1c-92fb9e8b03de@redhat.com>
Date:   Tue, 25 Oct 2022 23:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/4] KVM: API to block and resume all running vcpus in a
 vm
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022154819.1823133-1-eesposit@redhat.com>
 <a2e16531-5522-a334-40a1-2b0e17663800@linux.ibm.com>
 <2701ce67-bfff-8c0c-4450-7c4a281419de@redhat.com>
 <384b2622-8d7f-ce02-1452-84a86e3a5697@linux.ibm.com>
 <Y1cVfECAAfmp5XqA@google.com>
 <5a26c107-9ab5-60ee-0e9c-a9955dfe313d@redhat.com>
 <Y1gG/W/q/VIydpMu@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y1gG/W/q/VIydpMu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 17:55, Sean Christopherson wrote:
> On Tue, Oct 25, 2022, Paolo Bonzini wrote:
>> That said, I believe the limited memslot API makes it more than just a QEMU
>> problem.  Because KVM_GET_DIRTY_LOG cannot be combined atomically with
>> KVM_SET_USER_MEMORY_REGION(MR_DELETE), any VMM that uses dirty-log regions
>> while the VM is running is liable to losing the dirty status of some pages.
> 
> ... and doesn't already do the sane thing and pause vCPUs _and anything else that
> can touch guest memory_ before modifying memslots. I honestly think QEMU is the > only VMM that would ever use this API. Providing a way to force vCPUs 
out of KVM_RUN> is at best half of the solution.

I agree this is not a full solution (and I do want to remove 
KVM_RESUME_ALL_KICKED_VCPUS).

>    - a refcounting scheme to track the number of "holds" put on the system
>    - serialization to ensure KVM_RESUME_ALL_KICKED_VCPUS completes before a new
>      KVM_KICK_ALL_RUNNING_VCPUS is initiated

Both of these can be just a mutex, the others are potentially more 
interesting but I'm not sure I understand them:

>    - to prevent _all_ ioctls() because it's not just KVM_RUN that consumes memslots

This is perhaps an occasion to solve another disagreement: I still think 
that accessing memory outside KVM_RUN (for example KVM_SET_NESTED_STATE 
loading the APICv pages from VMCS12) is a bug, on the other hand we 
disagreed on that and you wanted to kill KVM_REQ_GET_NESTED_STATE_PAGES.

>    - to stop anything else in the system that consumes KVM memslots, e.g. KVM GT

Is this true if you only look at the KVM_GET_DIRTY_LOG case and consider 
it a guest bug to access the memory (i.e. ignore the strange read-only 
changes which only happen at boot, and which I agree are QEMU-specific)?

>    - to signal vCPU tasks so that the system doesn't livelock if a vCPU is stuck
>      outside of KVM, e.g. in get_user_pages_unlocked() (Peter Xu's series)

This is the more important one but why would it livelock?

> And because of the nature of KVM, to support this API on all architectures, KVM
> needs to make change on all architectures, whereas userspace should be able to
> implement a generic solution.

Yes, I agree that this is essentially just a more efficient kill(). 
Emanuele, perhaps you can put together a patch to x86/vmexit.c in 
kvm-unit-tests, where CPU0 keeps changing memslots and the other CPUs 
are in a for(;;) busy wait, to measure the various ways to do it?

Paolo

