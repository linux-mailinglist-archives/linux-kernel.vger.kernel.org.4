Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E348640D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLBSYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLBSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE83C511C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670005398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P84c+bfPSykX3YQiadeIHsZVz2UzMEmnzobF5uJ1pLI=;
        b=D3ypzoDsXCSBYu/j5S9DOLT2bK1sWvMFbBntqIXcgq0znHFrJ0SYBXWC6X40LkSfUhXIC1
        FbCFlBn4u+voximswUQnO5Oqvcm6nRG8zRQaqBswOoCf6IIdotx3ZwTxaC/3fdn+ncgB7P
        k0aKycGbkD79iEiH1YV1O3Wpkydqu2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-b8Ewqkn4Mw6b1JmeLj6ShQ-1; Fri, 02 Dec 2022 13:23:17 -0500
X-MC-Unique: b8Ewqkn4Mw6b1JmeLj6ShQ-1
Received: by mail-wm1-f71.google.com with SMTP id u9-20020a05600c00c900b003cfb12839d6so2233141wmm.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P84c+bfPSykX3YQiadeIHsZVz2UzMEmnzobF5uJ1pLI=;
        b=pZ3UpO9oIXGRMYN/Y2o4iHIQ9VSRspUfG7FKQg/flDKREq9n9BErtR8RCTGPe+CGlC
         UelMhcx2H69Yj9CDigfb0md6R6bLDBtd3nLAEYDz6aOQmZL5KJUJsdCvjp+1tz+u+SSV
         Y+oJX79slErK1670OtUdOFVZnl67G0sEsUKOtbjS0IZ9Wf3c7m7T1ebmxhPdrV81tYBX
         gGInxEFqrKbjIAHUcIscVkznYOyXrhO2WgcpXj9KbIVlvOphg7XsJRQf8JbIchGmGezu
         HExI5RAOS3lDwBcfizoYsiDlldyeyVHJDd/WtJIIEiErJpIT31ygARFZUPwA9SpInFQP
         Homw==
X-Gm-Message-State: ANoB5pm9qwLSMVZFZGecSUQzaIJWzuNULJY9rlsKPQ1StEUMC/cxHmsc
        OvOg5Aetc9q7NHjrDpedN8CdRP9Udu2XQ0d1Tbye+FJwG9J5Odrez+fBJRgsaCVMtHdMA1Dh3Qw
        6vFH5vJZqvjcVl5QisHENeJQu
X-Received: by 2002:a05:600c:414d:b0:3d0:878e:6fed with SMTP id h13-20020a05600c414d00b003d0878e6fedmr2684204wmm.150.1670005396553;
        Fri, 02 Dec 2022 10:23:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ce8iPe1eG0lC8Hd032B6FnUH8YAiPhO90ACJEtpgSAmnJV++j8/y61/KMnH5cyF16TO0mfw==
X-Received: by 2002:a05:600c:414d:b0:3d0:878e:6fed with SMTP id h13-20020a05600c414d00b003d0878e6fedmr2684196wmm.150.1670005396315;
        Fri, 02 Dec 2022 10:23:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c0a0a00b003c70191f267sm15411305wmp.39.2022.12.02.10.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:23:15 -0800 (PST)
Message-ID: <7c6ac714-7ed8-0106-2e45-d1ca3055f39b@redhat.com>
Date:   Fri, 2 Dec 2022 19:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/9] tools: Make {clear,set}_bit() atomic for reals
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20221119013450.2643007-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221119013450.2643007-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/22 02:34, Sean Christopherson wrote:
> For obvious reasons I'd like to route the this through Paolo's tree.
> In theory, taking just patch 5 through tip would work, but creating a
> topic branch seems like the way to go, though maybe I'm being overly
> paranoid.  The current tip/perf/core doesn't have any conflicts, nor does
> it have new set_bit() or clear_bit() users.
> 
>   
> Code sitting in kvm/queue for 6.2 adds functionality that relies on
> clear_bit() being an atomic operation.  Unfortunately, despite being
> implemented in atomic.h (among other strong hits that they should be
> atomic), clear_bit() and set_bit() aren't actually atomic (and of course
> I realized this _just_ after everything got queued up).
> 
> Move current tools/ users of clear_bit() and set_bit() to the
> double-underscore versions (which tools/ already provides and documents
> as being non-atomic), and then implement clear_bit() and set_bit() as
> actual atomics to fix the KVM selftests bug.
> 
> Perf and KVM are the only affected users.  NVDIMM also has test code
> in tools/, but that builds against the kernel proper.  The KVM code is
> well tested and fully audited.  The perf code is lightly tested; if I
> understand the build system, it's probably not even fully compile tested.
> 
> Patches 1 and 2 are completely unrelated and are fixes for patches
> sitting in kvm/queue.  Paolo, they can be squashed if you want to rewrite
> history.
> 
> Patch 3 fixes a hilarious collision in a KVM ARM selftest that will arise
> when clear_bit() is converted to an atomic.
> 
> Patch 4 changes clear_bit() and set_bit() to take an "unsigned long"
> instead of an "int" so that patches 5-6 aren't accompanied by functional
> changes.  I.e. if something in perf is somehow relying on "bit" being a
> signed int, failures will bisect to patch 4 and not to the
> supposed-to-be-a-nop conversion to __clear_bit() and __set_bit().
> 
> Patch 5-9 switch perf+KVM and complete the conversion.
> 
> Applies on:
>    
>    git://git.kernel.org/pub/scm/virt/kvm/kvm.git queue

Queued, thanks Namhyung for the ACK!

Paolo

> 
> Sean Christopherson (9):
>    KVM: selftests: Add rdmsr_from_l2() implementation in Hyper-V eVMCS
>      test
>    KVM: selftests: Remove unused "vcpu" param to fix build error
>    KVM: arm64: selftests: Enable single-step without a "full" ucall()
>    tools: Take @bit as an "unsigned long" in {clear,set}_bit() helpers
>    perf tools: Use dedicated non-atomic clear/set bit helpers
>    KVM: selftests: Use non-atomic clear/set bit helpers in KVM tests
>    tools: Drop conflicting non-atomic test_and_{clear,set}_bit() helpers
>    tools: Drop "atomic_" prefix from atomic test_and_set_bit()
>    tools: KVM: selftests: Convert clear/set_bit() to actual atomics
> 
>   tools/arch/x86/include/asm/atomic.h           |  6 +++-
>   tools/include/asm-generic/atomic-gcc.h        | 13 ++++++-
>   tools/include/asm-generic/bitops/atomic.h     | 15 ++++----
>   tools/include/linux/bitmap.h                  | 34 -------------------
>   tools/perf/bench/find-bit-bench.c             |  2 +-
>   tools/perf/builtin-c2c.c                      |  6 ++--
>   tools/perf/builtin-kwork.c                    |  6 ++--
>   tools/perf/builtin-record.c                   |  6 ++--
>   tools/perf/builtin-sched.c                    |  2 +-
>   tools/perf/tests/bitmap.c                     |  2 +-
>   tools/perf/tests/mem2node.c                   |  2 +-
>   tools/perf/util/affinity.c                    |  4 +--
>   tools/perf/util/header.c                      |  8 ++---
>   tools/perf/util/mmap.c                        |  6 ++--
>   tools/perf/util/pmu.c                         |  2 +-
>   .../util/scripting-engines/trace-event-perl.c |  2 +-
>   .../scripting-engines/trace-event-python.c    |  2 +-
>   tools/perf/util/session.c                     |  2 +-
>   tools/perf/util/svghelper.c                   |  2 +-
>   .../selftests/kvm/aarch64/arch_timer.c        |  2 +-
>   .../selftests/kvm/aarch64/debug-exceptions.c  | 21 ++++++------
>   tools/testing/selftests/kvm/dirty_log_test.c  | 34 +++++++++----------
>   .../selftests/kvm/include/ucall_common.h      |  8 +++++
>   .../testing/selftests/kvm/lib/ucall_common.c  |  2 +-
>   .../selftests/kvm/x86_64/hyperv_evmcs.c       | 13 +++++--
>   .../selftests/kvm/x86_64/hyperv_svm_test.c    |  4 +--
>   .../selftests/kvm/x86_64/hyperv_tlb_flush.c   |  2 +-
>   27 files changed, 102 insertions(+), 106 deletions(-)
> 
> 
> base-commit: 3321eef4acb51c303f0598d8a8493ca58528a054

