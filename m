Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBCF616EDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKBUj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKBUjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:39:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924FBD5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:39:25 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h21so87090qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXnvSC1TaspuA9x5JTm6vgC+Sjs7jb9jSpqNRLf7Mjg=;
        b=C2n9FPrtSJEa5vf2rRbzphnBxVAA39duYTrJDMU0+f39HLuOyyZax125VxViH5d91o
         kW8gI6sKaqT1v4TEnRBpKy5vaqjaCsIhDc2si/nJqGGGLaA6XZYXWmfO5hWqSFjUQT/B
         F1YxTjF9AsOdcYrYxfIEsExhBE/pJ4z+hqBP5uZjtDzvSfXshZqu/7C6T+6InMmquyOi
         HuV5jYLoV+EBrN3B0RpbMEMo/Q66mLOgfY0j6EtN3pH3flopeCOBcJ7Wi46MAlNHMhhB
         0zikHU1t4jfS+YWl2ujxpBOEOrRu7D3es7kkQZ699WjHMjQkzkGqczYWwlrCZDA3vdgN
         qw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXnvSC1TaspuA9x5JTm6vgC+Sjs7jb9jSpqNRLf7Mjg=;
        b=I4Ydwr0mM49t2XDooWxV1JVJw1JGJ9yY+k4MskI87t0HwNogppCtwgPtU4dS1q9Ty7
         anR044aeRWcKHOenQI5FLilpiM5h7Sqf0cJAxFjGjUxNrLF0+NNn824wEPCt1evmSvrt
         O4CaS0oAPFOKQA5SjHRvV/3SaYh0+SLqNeVqCzJm7SDuceXGPgLvHjGJbw2HaXVSQ1D6
         Yv6r+UMJ5WjZozno8BR3/WEasTxAN3xzyKYzN8qrlb72p685tg4w6BmhtGIkff6yjavQ
         XhO3ELTG9Ae9peQqgSlpaC2EiM3M9OT5QdaPElWMFZQ9mlsIr5xfTFusAgOrFaoQdBr9
         iBgw==
X-Gm-Message-State: ACrzQf0dowjv+AsRLaDtvhlqO8KTsMKXfdsWJzRAW1tPAva+Xgl0NfDC
        MpBsNu6xdyWBBxf82l5/T14SrMwFnQnqxsvEplPvOA==
X-Google-Smtp-Source: AMsMyM72euYlWWo3F5kT1U8Hzqu/wTTPX+za/Deafi+rOqeKcOEWDgt22/T4ZZfIIAEi+yP5s6gTeN5EhJaWeVS14sE=
X-Received: by 2002:ac8:7ef3:0:b0:3a5:108b:4cc0 with SMTP id
 r19-20020ac87ef3000000b003a5108b4cc0mr20753701qtc.436.1667421564237; Wed, 02
 Nov 2022 13:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221102193020.1091939-1-bgardon@google.com> <Y2LJSE5nuHZJV7fF@google.com>
In-Reply-To: <Y2LJSE5nuHZJV7fF@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 2 Nov 2022 13:39:13 -0700
Message-ID: <CANgfPd_WRRSP0uokotCMXWxb+vWmSoFRopbM8i9nyfb_ys0VXw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use SRCU to protect zap in __kvm_set_or_clear_apicv_inhibit
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 12:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Nov 02, 2022, Ben Gardon wrote:
> > kvm_zap_gfn_range must be called in an SRCU read-critical section, but
>
> Please add parantheses when referencing functions, i.e. kvm_zap_gfn_range().
>
> > there is no SRCU annotation in __kvm_set_or_clear_apicv_inhibit.
>
> __kvm_set_or_clear_apicv_inhibit()
>
> > Add the needed SRCU annotation.
>
> It's not an annotation, acquiring SRCU is very much functional code.

Right, totally true. Will correct.

>
> > Tested: ran tools/testing/selftests/kvm/x86_64/debug_regs on a DBG
> >       build. This patch causes the suspicious RCU warning to disappear.
> >       Note that the warning is hit in __kvm_zap_rmaps, so
> >       kvm_memslots_have_rmaps must return true in order for this to
> >       repro (i.e. the TDP MMU must be off or nesting in use.)
>
> Please provide the stack trace or at least a verbal description of what paths
> can reach __kvm_set_or_clear_apicv_inhibit() without holding SRCU, i.e. explain
> why this bug isn't being hit left and right.
>
> E.g.
>
>   Unconditionally take KVM's SRCU lock in __kvm_set_or_clear_apicv_inhibit()
>   when zapping virtual APIC SPTEs.  SRCU must be held when zapping SPTEs in
>   shadow MMUs to protect the gfn=>memslot translation (the TDP MMU walks all
>   roots and so doesn't dereference memslots).
>
>   In most cases, the inhibits are updated during KVM_RUN and so SRCU is
>   already held, but other ioctls() can also modify inhibits and don't
>   acquire SRCU, e.g. KVM_SET_GUEST_DEBUG and KVM_SET_LAPIC.  Acquire SRCU
>   unconditionally to avoid playing whack-a-mole, as nesting SRCU locks is
>   safe and this is not a hot path.
>
> > Fixes: 36222b117e36 ("KVM: x86: don't disable APICv memslot when inhibited")
>
> Reported-by?  IIRC this originated in a syzkaller report?

This was found on an non-upstream Google kernel by Greg Thelen, but a
great point. I'll credit him in v2.
