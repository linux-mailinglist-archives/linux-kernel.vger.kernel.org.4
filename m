Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A33644500
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiLFNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7D2B608
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670334789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ECE0g7YbfMnTJuWIRmn1xP32SqigQ6zugR1ek2C/cw=;
        b=c89Gb1+CI+5sMv+0HGEy8NJDxQwbNdtxWcgzmEHedSECkW61wy1Ap28PyhuD3rck6eLPTZ
        XMZCFbdlljs9LLCecXD6pPHxh9mDhIZBgdjh+aLIwmxbfR/TdfTtwfmUzSNoRTwd341EQr
        qFMA1tJ5eLqx8c0oU7ZtpFeXbXE9aWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-7IVfiazxODSYWQeI1UbTCQ-1; Tue, 06 Dec 2022 08:53:07 -0500
X-MC-Unique: 7IVfiazxODSYWQeI1UbTCQ-1
Received: by mail-wm1-f70.google.com with SMTP id i203-20020a1c3bd4000000b003d0f49bc21bso4397404wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ECE0g7YbfMnTJuWIRmn1xP32SqigQ6zugR1ek2C/cw=;
        b=2+GwuXCo/Xq1fLqhMSXfhWv6UZork1yyBS4AureXC7sP1TzGerSQTRG2yNUFpRkb1c
         rowsf0vTGxI0T3OApatnwZVaxi0swIvOhaQpbaDtpWoW1GscAjYxV7UP+zc+h25Byxy0
         /TeGc81kdZcBiR9lkAusYHAh+nL1SN57riwLnZjkWoWqsEZBRbyVEcqJPdoyghKp3bXD
         sFQxb9UEpYxJYRg3JQmOklxuTtudR9lJTgmpwyKsURarPeK7lwDK+T/XRaitHyTHjyOR
         My14phhiXQ31LzZxfJCIfosCRUKkGxPSfYBk/lsPrl6cuBI1rR9uGB/Fg3V0bYFbHF6a
         uLVA==
X-Gm-Message-State: ANoB5pkEAoassQLsX5lJHU+cmgF4lKDyXvVIMZKhoPpeMnSOx9hnnNFc
        uBS+3qvjZU8rIVFmlVMDzel0M0RtEWLEA26mVWnD3F813PGDoySrzR4qPtri9ZC19aVc28lGMmG
        Xc+RvMYm/Z5ZUI3J4rnYUMqMgBaGI8pX3fEmsX0Z7h9vhRLMZkQa9OntsBMfnUg+P574NBZdxSf
        c3
X-Received: by 2002:a7b:c315:0:b0:3cf:ca62:7ab with SMTP id k21-20020a7bc315000000b003cfca6207abmr334264wmj.23.1670334786666;
        Tue, 06 Dec 2022 05:53:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Arxt6oofscVN8skgdjZ/sDcuxwWiozQstiNdWtSwlkiStCmejQeNBgbSlwRCno3PPgyy0+A==
X-Received: by 2002:a7b:c315:0:b0:3cf:ca62:7ab with SMTP id k21-20020a7bc315000000b003cfca6207abmr334256wmj.23.1670334786383;
        Tue, 06 Dec 2022 05:53:06 -0800 (PST)
Received: from ovpn-194-152.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c410400b003cfbbd54178sm2937311wmi.2.2022.12.06.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:53:05 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        coverity-bot <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: hyper-v: Fix 'using uninitialized value'
 Coverity warning
In-Reply-To: <Y4odRLlFRj17tUNE@google.com>
References: <20221202105856.434886-1-vkuznets@redhat.com>
 <Y4odRLlFRj17tUNE@google.com>
Date:   Tue, 06 Dec 2022 14:53:04 +0100
Message-ID: <87pmcwd4fz.fsf@ovpn-194-152.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Dec 02, 2022, Vitaly Kuznetsov wrote:
>> In kvm_hv_flush_tlb(), 'data_offset' and 'consumed_xmm_halves' variables
>> are used in a mutually exclusive way: in 'hc->fast' we count in 'XMM
>> halves' and increase 'data_offset' otherwise. Coverity discovered, that in
>> one case both variables are incremented unconditionally. This doesn't seem
>> to cause any issues as the only user of 'data_offset'/'consumed_xmm_halves'
>> data is kvm_hv_get_tlb_flush_entries() ->  kvm_hv_get_hc_data() which also
>> takes into account 'hc->fast' but is still worth fixing.
>
> If those calls aren't inlined, then 32-bit Hyper-V will be "consuming" uninitialized
> data when pushing parameters onto the stack.  It won't cause real problems, but
> checkers might complain.
>
> What about shoving this metadata into "struct kvm_hv_hcall" as a union?  That'd
> help convey that the two are mutually exclusive, would provide a place to document
> said exclusion, and would yield a nice cleanup too by eliminating multiple params
> from various functions.

"struct kvm_hv_hcall" used to hold raw data from the guest and
'consumed_xmm_halves'/ 'data_offset' are rather our implementation
details, how we consume these data. I don't see why we can't re-purpose
it a little bit to hold both, let me try that in v2.

-- 
Vitaly

