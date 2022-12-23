Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430465533F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiLWRbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLWRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12075BF74
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671816625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deNXT8hNeTJkuV52qcNJ9spcFBZRdWwkDFHQUIuDxdI=;
        b=J9IIbJsqGb8IMWNiArrcAIre0fYVhFvdhk/rlpsQWWj2cwF4GtYPSYWzOa7KJtc7DxYX8i
        3VNUu7eAQ3ptHoB6TFqC3f2ET4sGA+HRi8U+pSAmFdrHfs4NHbnIA+MwzpCFOI5WDPvQ/z
        i1YjkqrodG959qA4cTU8ArYFxqxBr48=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-jnDw-f54NuiA8fsyCT79Hg-1; Fri, 23 Dec 2022 12:30:23 -0500
X-MC-Unique: jnDw-f54NuiA8fsyCT79Hg-1
Received: by mail-ed1-f70.google.com with SMTP id t17-20020a056402525100b00478b85eecedso4064711edd.18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deNXT8hNeTJkuV52qcNJ9spcFBZRdWwkDFHQUIuDxdI=;
        b=T78CXrdDFFMzClCaZa+S8kbKjFQAwj8X/ovQyGqeYUpWMOlOLSH/nN28/W+CTHYbTk
         dEKgXqkYyEtxnVDph2DR6WCcoiQugWaLsyg5aRK3yf62aotrxQlToS1qDKheVqbntkAw
         a1ffDo1F2cKmjfvRKyLGpr+AiKgNcoP21PJzdcKRCvzHaKZw4J7cl7o5/PE9mjcIIhzP
         rPoq1V8J2KIgfyf9ZFnEMYueNmoMXE0nhTww8bktGl2M5C8yN49dEq0MsNy62rLmbC35
         P7KYKkx2whB/bN0Xy0XfAXK6glQP22cMAMniJv6W4UqmVV+Q5C4OMPmmLJO/zyOQFeDl
         9qbg==
X-Gm-Message-State: AFqh2krdp5qE2Y9H5FqhG27B1HbZ4lijyKx85YMfbfyWz4R5d+HDiDxh
        5YrBR4iHgX6AswNWn36hphITWQ8p2YWf5UgG4WDzZRZZXbjbTgHqu52Kx90Fc3Lm2tBAxiePrnQ
        EGLKhlNMGRpQNZr505o2eY1we
X-Received: by 2002:a05:6402:1a4a:b0:472:2d7e:8c6d with SMTP id bf10-20020a0564021a4a00b004722d7e8c6dmr8624285edb.28.1671816622480;
        Fri, 23 Dec 2022 09:30:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvBky2Bt9aX6KGCMIxzE8iMEIeQBlbZmQ7EvyOXS6mwqJQY5NixNV1YBTWb9By9zIbdMbDjRA==
X-Received: by 2002:a05:6402:1a4a:b0:472:2d7e:8c6d with SMTP id bf10-20020a0564021a4a00b004722d7e8c6dmr8624275edb.28.1671816622261;
        Fri, 23 Dec 2022 09:30:22 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id l26-20020a056402125a00b0046b471596e6sm1710656edw.57.2022.12.23.09.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 09:30:21 -0800 (PST)
Message-ID: <70872206-7a75-0a19-3df5-a97207e710fa@redhat.com>
Date:   Fri, 23 Dec 2022 18:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/4] KVM: nVMX: Don't muck with allowed sec exec
 controls on CPUID changes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
References: <20221213062306.667649-1-seanjc@google.com>
 <20221213062306.667649-4-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221213062306.667649-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 07:23, Sean Christopherson wrote:
> Don't modify the set of allowed secondary execution controls, i.e. the
> virtual MSR_IA32_VMX_PROCBASED_CTLS2, in response to guest CPUID changes.
> To avoid breaking old userspace that never sets the VMX MSRs, i.e. relies
> on KVM to provide a consistent vCPU model, keep the existing behavior if
> userspace has never written MSR_IA32_VMX_PROCBASED_CTLS2.
> 
> KVM should not modify the VMX capabilities presented to L1 based on CPUID
> as doing so may discard explicit settings provided by userspace.  E.g. if
> userspace does KVM_SET_MSRS => KVM_SET_CPUID and disables a feature in
> the VMX MSRs but not CPUID (to prevent exposing the feature to L2), then
> stuffing the VMX MSRs during KVM_SET_CPUID will expose the feature to L2
> against userspace's wishes.

The commit message doesn't explain *why* KVM_SET_CPUID would be done 
before KVM_SET_MSRS.  The presence of certain MSRs or bits within is 
signaled by CPUID bits, and even though KVM is more lenient on 
host-initiated MSR writes it still verifies in general that the bits are 
valid.

For now I applied patch 1 and (with a reworded comment) patch 2.  I'm 
not opposed to the rest, but I would like to better understand the 
reason for them.  (If it has been reported to the mailing list, please 
add a "Link" trailer too).

Paolo

