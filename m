Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C8614F38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiKAQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiKAQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E251B1F7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDuALVSjY6duqc6mfdrdlk2vsq8fjIIz8Dsm5YsRvU8=;
        b=NK3ZvMmokqDaSprakg/26XDVS7YTXTcgYyibm5yuOVwRbpxmqyfK4PPSAmFfYTywiwAnN8
        cjAebcxAMC0gcrDgYondwffTSNlk7ciGEt2QodLl1oyhCMKQN5Bz8q2DIUYCln2eGuDwNs
        gIlm73RPi+pgdlgRcKgZ8C0/M4fqelk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-HuRKR7-CMi6SxV5KS0a8gg-1; Tue, 01 Nov 2022 12:29:03 -0400
X-MC-Unique: HuRKR7-CMi6SxV5KS0a8gg-1
Received: by mail-ej1-f72.google.com with SMTP id ho8-20020a1709070e8800b0078db5e53032so8121847ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDuALVSjY6duqc6mfdrdlk2vsq8fjIIz8Dsm5YsRvU8=;
        b=08zVEkGqDbTrCIh4Kw7kd4JxsM6bOIhilCuAtJ5FZMnBF5iE5pMheYMRC+oiXJ8rRN
         nv22BCAcTqmd9LnXszmOX8pEDCumSWGR3q3qdjOGaLF9q4leDFRI0OysE+mYHhq9qgwy
         wsRoze2GPL+6UkgfSrB9R+3XbKa3/6h/w4SsQLDZtmLs1aQvPzlHDrWbdBJEK0Jkq4A0
         tI0fBbIfmc7rF7wP6vzI9AaBWhy5MRtBNC50QwY0IsMdxcgwkPQh95zTCu6GG3HL8KnM
         edwsZSQOLi76vg1VtC7FWVPUeGD/0dN+Aej4tIacbw3Zl32XgaSJ/5HjYJjcS7FJZJwZ
         hd0g==
X-Gm-Message-State: ACrzQf1OLLx3i5y28MLO+FB0bux2uVrblLP/orSM6Uc8i/+pMg7u69yL
        /ZY+MoBr7SBtqCVM2GMYS886MzgNKLXZ4xFgXeLeYw1WS+kDQT405iKV2vnh4NdGknyo/epp6bA
        o2vIbfqpFmM8uzulO+6MSj1RArb0AgthRJIyQ4Y+sgxhfbXVn+AaYXnZpNS8UGaKFYr01WPNzaM
        uy
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr19492163ejw.203.1667320142739;
        Tue, 01 Nov 2022 09:29:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PPPjC11w84o98TwbRsI4d2SLwALdtwCixPHCa/pNLG7jKQOh3T/GXFYuBn3UT4EEHKKU4rA==
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr19492120ejw.203.1667320142403;
        Tue, 01 Nov 2022 09:29:02 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906305100b0073dbaeb50f6sm4326403ejd.169.2022.11.01.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:29:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/48] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y2E5chB/9pZcRWi6@google.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
 <Y2E5chB/9pZcRWi6@google.com>
Date:   Tue, 01 Nov 2022 17:29:00 +0100
Message-ID: <878rkuskoj.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Nov 01, 2022, Vitaly Kuznetsov wrote:
>> Changes since v12 (Sean):
>> - Reviewed-by: tags added.
>> - PATCH13: added a comment explaining why 'hc->ingpa' doesn't need to be
>>   translated when the hypercall is 'fast'.
>> - PATCH34: s,wraping,wrapping, in the blurb.
>> - PATCH36: added missing Signed-off-by: tag.
>> - "KVM: selftests: Stuff RAX/RCX with 'safe' values in vmmcall()/vmcall()"
>>   patch added (and used later in the series).
>> - "KVM: selftests: Introduce rdmsr_from_l2() and use it for MSR-Bitmap
>>   tests" patch added (and used later in the series).
>
> Note, this doesn't apply cleanly to kvm/queue for me, looks like there are superficial
> conflicts that make git unhappy with the vmx/evmcs.{ch} => vmx/hyperv.{ch}, though I
> might be missing a git am flag to help it deal with renames.

Sorry, forgot to rebase.

>
> Applies cleanly to e18d6152ff0f ("Merge tag 'kvm-riscv-6.1-1' of
> https://github.com/kvm-riscv/linux into HEAD") and then rebases to kvm/queue without
> needing human assistance.

The miracle of git :-)

-- 
Vitaly

