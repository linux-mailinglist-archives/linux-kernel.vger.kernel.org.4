Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E56AD07F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCFVdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC186161
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678138317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Sckc0VCeUKvUNJ3UV5csdV1/cFwo//qSZeMV4qvKsE=;
        b=Bzx8+j5GNRN+RJOflS6L/nXqHSLoHHT2Bk3kbFYNOQXEiHyvUC0OKoucpnItTrtG6+80jW
        iJNMwX1ilkio2BVBIohT+4XwWcni5q77S2zg2HuZh0pUa92X2RJBR6TTp36VfTU3Rfd1hU
        2Y4SY2HoayoNeKLMvI0PNBkl2UHGUL0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-DStOtT6rNEGP6_l_3HBVbA-1; Mon, 06 Mar 2023 16:31:56 -0500
X-MC-Unique: DStOtT6rNEGP6_l_3HBVbA-1
Received: by mail-ed1-f71.google.com with SMTP id d35-20020a056402402300b004e37aed9832so6337493eda.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678138315;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Sckc0VCeUKvUNJ3UV5csdV1/cFwo//qSZeMV4qvKsE=;
        b=c0Pe6ayU6JxNM7lFgbbygdtpvWMrb/HgMCrPrKFWsxj+0YmaL/WNlh0q6U77O/E0CO
         LqXyCWo8kx/o7y7F1sX/Cs5nHVXOc3vEwvAnGAAXoiGsBM5sSIupiXfey8MoPQbD9wlB
         C8Fp8dOUt4RYVKubhCroKcnrt6PWEPDHp2GNydgnNj5tCrJMB40G+OIf0bFFu2QlT61l
         dXO9DQjSxNUKXzn1/Cf9nuYAA1LaUabfAWGQIrBlsivcprGzZcfvHy77DU/oNXsCpDDT
         dmRtgjoztV2Zt0sVhICxp8GMm9LodZ4lGSUwu5auKEhW4oTdZkYArI8Z9Eq/ioqZryWe
         y2BA==
X-Gm-Message-State: AO0yUKWIiJ8sXwLrUe0YD1WWnmUDxmx8RRDxrbvjzNv4c4PpguAozxL2
        gaxA7we5ln/Y1O0T+99+hu5AfzChQ3O8zsmRHbgBqCMm6EdSW+cL+FiomWBGeET4wcMhNIquYYl
        oE6gTBvP8Qh8Gkcxm0S4SMGtm
X-Received: by 2002:a17:906:7948:b0:8b2:37b5:cc4 with SMTP id l8-20020a170906794800b008b237b50cc4mr18354701ejo.7.1678138315174;
        Mon, 06 Mar 2023 13:31:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9WW7UR33/gSwJ6Mh0PHQ88LrKUkeVLMxtBm6Ukg/R01iw8U7OSbNcuWsxfe6qJTHmMdHQWUg==
X-Received: by 2002:a17:906:7948:b0:8b2:37b5:cc4 with SMTP id l8-20020a170906794800b008b237b50cc4mr18354684ejo.7.1678138314857;
        Mon, 06 Mar 2023 13:31:54 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id hb15-20020a170906b88f00b008d09b900614sm5023508ejb.80.2023.03.06.13.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:31:54 -0800 (PST)
Message-ID: <bf06bda1-7a55-4a19-2f8c-38324a7fd219@redhat.com>
Date:   Mon, 6 Mar 2023 22:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Takahiro Itazuri <itazur@amazon.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takahiro Itazuri <zulinx86@gmail.com>
References: <20230227210526.83182-1-itazur@amazon.com>
 <Y/0jRXzbcbxTjqSS@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] KVM: x86: Propagate AMD-specific IBRS bits to guests
In-Reply-To: <Y/0jRXzbcbxTjqSS@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 22:40, Borislav Petkov wrote:
> On Mon, Feb 27, 2023 at 09:05:24PM +0000, Takahiro Itazuri wrote:
>> VMMs retrieve supported CPUID features via KVM_GET_SUPPORTED_CPUID to
>> construct CPUID information to be passed to KVM_SET_CPUID2. Most CPUID
>> feature bits related to speculative attacks are propagated from host
>> CPUID. But AMD processors have AMD-specific IBRS related bits in CPUID
>> Fn8000_0008_EBX (ref: AMD64 Architecture Programmer's Manual Volume 3:
>> General-Purpose and System Instructions) and some bits are not
>> propagated to guests.
>>
>> Enable propagation of these bits to guests, so that VMMs don't have to
>> enable them explicitly based on host CPUID.
>
> How hard is it for the VMMs to enable them?

Let me rephrase the second paragraph of Takahiro's commit message:

"Tell the VMMs that they can pass the bits to the guests, instead of 
having to second-guess that the hypervisor does not have to do anything 
to support these bits".

In general, userspace should not second guess the hypervisor.  There are 
some rare cases in which QEMU (and probably the proprietary hypervisors 
at Google and Amazon) does that, but in general you want it to trust 
information coming from the kernel.  New CPUID bits are quite frequent, 
and sometimes also stupidly difficult to get right, so if filtering 
CPUID can be done in the kernel you won't have to do the same change N 
times in _all_ userspaces that use KVM.

Paolo

