Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672D655999
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 10:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiLXJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 04:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 04:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C026548
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671873421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WJ5IG512JK4HdlC/w+MEPT5hs4wW6eIO1tcvJBoFHE=;
        b=Tc7Xku+IyC+S1yNG6F9lUgTbJAW9zwMUFY5tiu4muqOWCHMn9wR0kyD4xg9R10/IYe4i3c
        1qDtcsfEA1WMUQ8qFRCQw8aqkvLZIjBSa0s6IocG9WGUOEBfwgQtcvT/wSbr8+1uG8iofw
        kSCnc/6WnZVZy5zT5iFhn6bYlpDHSuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-qRVfgIYEPzuFhK5xGnvSGw-1; Sat, 24 Dec 2022 04:16:59 -0500
X-MC-Unique: qRVfgIYEPzuFhK5xGnvSGw-1
Received: by mail-ed1-f69.google.com with SMTP id z20-20020a05640240d400b0047028edd264so4993834edb.20
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WJ5IG512JK4HdlC/w+MEPT5hs4wW6eIO1tcvJBoFHE=;
        b=ZaNpIwC97VBbF82oYdEZt4pmUm6Gg2TZcnrpB3x1J619SnWkk1HXF45HRSbL/Xf44D
         G1UUVwBExNeKsWdwBkEZz+aALN6w0lLe79tnu+qF3HVh1GeCsK11n9veSPvbRSTHAiq9
         Mj22EkL4C23UvexInqp6hCk4tAsMjF1x+I2sf7+sMmOpRe4V0j95e/XlEgdhE9Xso8bv
         JidrZRfI77n+cz+mY55+vyNs5mk6RUJfShe2Jb6Um5e3lT9qcVzMu1VYDG4Q8oLWiaee
         bT9oTwK/jduy5RRp58oR2WgQdeZXFptrQ4ENEoofOsZikzO0KPKg77Sd0PZua+gqY4og
         Q8qQ==
X-Gm-Message-State: AFqh2kqsgfnr86QrvkRih1rPh+b3hGse+a0GgaKKi2P7Eq2zEVn7cJHt
        o/oKzGZBb24zP+ILxd8xlbvwjXWmqru8TT6F9QFmIOCwbtab/Oz7xttcEv0J+j5WVjYuWqRaOHi
        SwpRvsVEFS8DPBH/VMpWuoXTz
X-Received: by 2002:a17:906:2813:b0:7c0:f9ef:23a2 with SMTP id r19-20020a170906281300b007c0f9ef23a2mr12170054ejc.30.1671873418346;
        Sat, 24 Dec 2022 01:16:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxPdiaG4E8UewTBDKGwk+RrHY5iIcLLbOD+rhwdwS97aEIalcuCrM4uQvmfbCxpmo46L3Qww==
X-Received: by 2002:a17:906:2813:b0:7c0:f9ef:23a2 with SMTP id r19-20020a170906281300b007c0f9ef23a2mr12170039ejc.30.1671873418109;
        Sat, 24 Dec 2022 01:16:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id gf3-20020a170906e20300b007bff9fb211fsm2323104ejb.57.2022.12.24.01.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 01:16:57 -0800 (PST)
Message-ID: <f53ed5b9-156c-e809-08e2-050217a970a5@redhat.com>
Date:   Sat, 24 Dec 2022 10:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 09/14] KVM: selftests: Explicitly disable builtins for
 mem*() overrides
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
References: <20221213001653.3852042-1-seanjc@google.com>
 <20221213001653.3852042-10-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221213001653.3852042-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 01:16, Sean Christopherson wrote:
> Explicitly disable the compiler's builtin memcmp(), memcpy(), and
> memset().  Because only lib/string_override.c is built with -ffreestanding,
> the compiler reserves the right to do what it wants and can try to link the
> non-freestanding code to its own crud.
> 
>    /usr/bin/x86_64-linux-gnu-ld: /lib/x86_64-linux-gnu/libc.a(memcmp.o): in function `memcmp_ifunc':
>    (.text+0x0): multiple definition of `memcmp'; tools/testing/selftests/kvm/lib/string_override.o:
>    tools/testing/selftests/kvm/lib/string_override.c:15: first defined here
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)

Hmm, that's weird though.  I think it's an effect of ifunc and maybe 
even a linker bug.  The patch makes sense anyway.

Paolo

