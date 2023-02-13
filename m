Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2615694EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBMSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB71F5D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676311875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btENug+HNZMgsHueHpBS/EHiJOI8qsodxlQ5SGXxzpc=;
        b=WFGfMLy7GOxtL8j8yCOihQpGIVn0QTwP6ETfnTZQvOSW9IBpkLMi9vCUBmtWnZq1fA1RBY
        1Erz12w5gbtfEIGGo/YnSYYwgC3uNtwqZMHsWy327aVB6fx5WlKBNkoN5QzOoirK8EGgLL
        WkwR5q1KVEytHULaOkb4GF34Tf8tTxI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-M7xXVt6lN5aAQfk5lrqsWA-1; Mon, 13 Feb 2023 13:11:12 -0500
X-MC-Unique: M7xXVt6lN5aAQfk5lrqsWA-1
Received: by mail-ed1-f71.google.com with SMTP id s20-20020a05640217d400b004ab46449f12so6109146edy.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btENug+HNZMgsHueHpBS/EHiJOI8qsodxlQ5SGXxzpc=;
        b=gTC75AOkgFI7V56M0AeAxSiRBc07ssYyJC0ej19Ez43czDAS9jGOeKCkgg+Bplsso7
         pAIVW58uUJHJlvh4xDVqwVcWmgroSdjGnhUN48T4e5h4DnzVm+ElhmGPVexhxpb2cqyI
         t4GvyBl2Tfdys69Ym3h/oAXtPVfZlgMNYnLLMCT63tZV6GwT0jJnPVbhK1jEjNJ8oAXb
         o42qWXXcVQGLZ3AYT9Ba3fy8WGOJH2rWZRNJODbFSqXjXDdDDi/PhP0Xdwa1PAwKL+/l
         553SrzF9TijxNBjeaWSQ9gC3lp/aY4UnCfMI1YmpywaVyGqBHXPcoy83WqriKS4S8wl7
         Cuag==
X-Gm-Message-State: AO0yUKW8KHZ1kWWB3gCVO0DgUjDJ3pqrpOQN4hqqkMNvWLTvDsJLeOIR
        F5ukejwKN70l8w9g+hRGoepzK4R/akwXoEXosTZjTee5hyMN7CrLFz6llbmUoN44483FUXm8niO
        9MpO1gmXPyIhyvOPoALB6KWbB
X-Received: by 2002:a50:c007:0:b0:4ac:d2b3:b724 with SMTP id r7-20020a50c007000000b004acd2b3b724mr1951821edb.27.1676311871479;
        Mon, 13 Feb 2023 10:11:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/2IiZueKNbZNJhFBMmU9KPuO2w+xCZ6ywEnPIDIDhVsdPwjrHBnwQ6oyt753mIL9L3C/68yg==
X-Received: by 2002:a50:c007:0:b0:4ac:d2b3:b724 with SMTP id r7-20020a50c007000000b004acd2b3b724mr1951812edb.27.1676311871311;
        Mon, 13 Feb 2023 10:11:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u12-20020a50950c000000b004aac44175e7sm6942278eda.12.2023.02.13.10.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:11:10 -0800 (PST)
Message-ID: <35ff8f48-2677-78ea-b5f3-329c75ce65c9@redhat.com>
Date:   Mon, 13 Feb 2023 19:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu Lan <ltykernel@gmail.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <43980946-7bbf-dcef-7e40-af904c456250@linux.microsoft.com>
 <Y+p1j7tYT+16MX6B@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: "KVM: x86/mmu: Overhaul TDP MMU zapping and flushing" breaks SVM
 on Hyper-V
In-Reply-To: <Y+p1j7tYT+16MX6B@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 18:38, Sean Christopherson wrote:
> On Fri, Feb 10, 2023, Jeremi Piotrowski wrote:
>> Hi Paolo/Sean,
>>
>> We've noticed that changes introduced in "KVM: x86/mmu: Overhaul TDP MMU
>> zapping and flushing" conflict with a nested Hyper-V enlightenment that is
>> always enabled on AMD CPUs (HV_X64_NESTED_ENLIGHTENED_TLB). The scenario that
>> is affected is L0 Hyper-V + L1 KVM on AMD,
> 
> Do you see issues with Intel and HV_X64_NESTED_GUEST_MAPPING_FLUSH?  IIUC, on the
> KVM side, that setup is equivalent to HV_X64_NESTED_ENLIGHTENED_TLB.

My reading of the spec[1] is that HV_X64_NESTED_ENLIGHTENED_TLB will 
cause svm_flush_tlb_current to behave (in Intel parlance) as an INVVPID 
rather than an INVEPT.  So svm_flush_tlb_current has to be changed to 
also add a call to HvCallFlushGuestPhysicalAddressSpace.  I'm not sure 
if that's a good idea though.

First, that's a TLB shootdown rather than just a local thing; 
flush_tlb_current is supposed to be relatively cheap, and there would be 
a lot of them because of the unconditional calls to 
nested_svm_transition_tlb_flush on vmentry/vmexit.

Second, while the nCR3 matches across virtual processors for SVM, the 
(nCR3, ASID) pair does not, so it doesn't even make much sense to do a 
TLB shootdown.

Depending on the performance results of adding the hypercall to 
svm_flush_tlb_current, the fix could indeed be to just disable usage of 
HV_X64_NESTED_ENLIGHTENED_TLB.

Paolo

[1] 
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/nested-virtualization

