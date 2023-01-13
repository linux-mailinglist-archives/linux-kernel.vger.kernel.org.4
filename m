Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B566A1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAMSRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjAMSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C440C38
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673633166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQvFnya6NFdzrd0uXGd+lLCU8K6l8CjIC+mc6Joc75c=;
        b=IJl+RtvOTIyV9LyVTAnGcFYYCSh7k7AivRDbZaAvvCJsLNCjjd/qykEurNTuALvETLZ/76
        xg9s2IPZb4ONmd8IfdZ799N6c5zjDT/LCofr5XPyat3bANIm3wceBNZAMLSU6imtzuqduN
        zHLhA6EYQods4robzf4AlwtoQg3L2ZA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-iY59gdtnPgyOT0GXLm4GfQ-1; Fri, 13 Jan 2023 13:06:04 -0500
X-MC-Unique: iY59gdtnPgyOT0GXLm4GfQ-1
Received: by mail-ej1-f71.google.com with SMTP id sd1-20020a1709076e0100b00810be49e7afso15951608ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQvFnya6NFdzrd0uXGd+lLCU8K6l8CjIC+mc6Joc75c=;
        b=hHmN/TWlok6ce/jAZLYvy9hS3uaOwjFEyVDloloXMLQ/pbwNvl5VUgLRHfWleLKCpw
         dstIrVe++YHSjOKzAnPXxtkSTelfpG7YdgWTx3KnLQ7uqpe1tRVXm+K8F4eSIxOR47NB
         E45Rizsts5yPykRIBZT2VXJ63sHFMN0Eg2hWi9YNZqCPv8JsUqJtIHHDAWH5HxJ8ydax
         6aNc9P0Ttv4SKH4e/HmPWrqI5eIOSLCT9bMCLT2pUtYPyeFVdcUKw+2Hfy4WuikcuLZh
         8WRiOkdmPf/sy1GAkd6iB3Qyfb4+ZunUSEJM40N+a/pT/nggtX3wbmaOQ4jJ3TARig08
         mvTA==
X-Gm-Message-State: AFqh2ko1KPgRV9f46dtEssD0q6kZGBLH6QZ7Xzqpl2mY7HhplmDygc42
        Cmpyv/TGFJIJjNj1EunBEXgyWrdkx+IVTlNvK4rW6cTKyzYeCBgNb5B5Iv4WHiwna8T3puCp2XT
        LKAXG0X5fY399XelEELeVLXUR
X-Received: by 2002:a17:906:7c58:b0:84d:4e9d:864a with SMTP id g24-20020a1709067c5800b0084d4e9d864amr15761301ejp.74.1673633163193;
        Fri, 13 Jan 2023 10:06:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt4OmwyB6O2jyNzsN9OMjhhAn2F5iRTGB3A9G+/HJ+y66pFH9MGlJvZurdSDSOqdub4DT7B+Q==
X-Received: by 2002:a17:906:7c58:b0:84d:4e9d:864a with SMTP id g24-20020a1709067c5800b0084d4e9d864amr15761291ejp.74.1673633163017;
        Fri, 13 Jan 2023 10:06:03 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id la19-20020a170907781300b007aee7ca1199sm8819421ejc.10.2023.01.13.10.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 10:06:02 -0800 (PST)
Message-ID: <674ac894-12a2-c15f-72c5-878558a8005d@redhat.com>
Date:   Fri, 13 Jan 2023 19:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/6] KVM: x86: x2APIC reserved bits/regs fixes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
References: <20230107011025.565472-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230107011025.565472-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/23 02:10, Sean Christopherson wrote:
> Fixes for edge cases where KVM mishandles reserved bits/regs checks when
> the vCPU is in x2APIC mode.
> 
> The first two patches were previously posted[*], but both patches were
> broken (as posted against upstream), hence I took full credit for doing
> the work and changed Marc to a reporter.
> 
> The VMX APICv fixes are for bugs found when writing tests.  *sigh*
> I didn't Cc those to stable as the odds of breaking something when touching
> the MSR bitmaps seemed higher than someone caring about a 10 year old bug.
> 
> AMD x2AVIC support may or may not suffer similar interception bugs, but I
> don't have hardware to test and this already snowballed further than
> expected...
> 
> [*] https://lore.kernel.org/kvm/20220525173933.1611076-1-venkateshs@chromium.org

Looks good; please feel free to start gathering this in your tree for 6.3.

Next week I'll go through Ben's series as well as Aaron's "Clean up the 
supported xfeatures" and others.

Let me know if you would like me to queue anything of these instead, and 
please remember to set up the tree in linux-next. :)

Thanks,

Paolo

> Sean Christopherson (6):
>    KVM: x86: Inject #GP if WRMSR sets reserved bits in APIC Self-IPI
>    KVM: x86: Inject #GP on x2APIC WRMSR that sets reserved bits 63:32
>    KVM: x86: Mark x2APIC DFR reg as non-existent for x2APIC
>    KVM: x86: Split out logic to generate "readable" APIC regs mask to
>      helper
>    KVM: VMX: Always intercept accesses to unsupported "extended" x2APIC
>      regs
>    KVM: VMX: Intercept reads to invalid and write-only x2APIC registers
> 
>   arch/x86/kvm/lapic.c   | 55 ++++++++++++++++++++++++++----------------
>   arch/x86/kvm/lapic.h   |  2 ++
>   arch/x86/kvm/vmx/vmx.c | 40 +++++++++++++++---------------
>   3 files changed, 57 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 91dc252b0dbb6879e4067f614df1e397fec532a1

