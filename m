Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA1640992
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiLBPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLBPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:52:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81E25C76
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:52:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so6995583edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+wIpXgNYv9KbhQdHpAh2J9WARPV+I1Lg7bCetJiKY0=;
        b=Sem6WUQ30bgBzC9KFJ+Y7YA3IwBwBhgebQnrF4GbXaGxiRIF0+XG6VhdHPWg789tw8
         n3VUugODxZ3c7bAE/w+/fHWFhNPuAg1AY5zmDs4S7n45dEXhujUe4w4px+tRfioghqpv
         ykkgXtRxBx8NQRVeR7HRO3H2pjUVGzuBedjTJoAKzvem26bbr6zcTHV8oAXV9JUGFZiJ
         J5FDzfI9md7/uGbwi0hKVIPXeimUhD84nr2OZZKkvltbpOStlokrcHjKJUCOGD4yfK9i
         41VwZywKaELPX41bzbhzoKQqc71EFdj9W0tVnHtHXLzJ2C16cwECrOCyDFSLX6hqUjU0
         Lsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+wIpXgNYv9KbhQdHpAh2J9WARPV+I1Lg7bCetJiKY0=;
        b=D5kwx3s8RE/qpdy+4KXQJuAl+d2dmh54BokfGlTWMFKJOyGnYXk14XzrICHxdTeWQS
         tsqeE4ttnJM1zL/kIwSyHWBs0KxU3n5KgCXl02vw29XqAcSRr5tVWxo1YK7Ki36RpvOp
         WCFs4XelZ8L17vInrctDY19LrufXp91Bm9NS5gOmNQ7SHPTTJwSioPCNHfvJ3ClbmHkt
         i/51vNDTkiJFqb+/wzaUWyPshpE7VnCa3YoWcVhGbdUFRkPqCUA/QoFRp3NbOl0cR9/d
         rCpXzXswRIJqzvWo4k6QsPD8JQtY3xTc+znWppLp/s8MQn8VUjKCMbHDtx9dKUfDj+4G
         bJiA==
X-Gm-Message-State: ANoB5pnr2cJxQ8ly8t4iVFEtOTXML3SAhIidBMFE3m0jS8PJfAPJ9FdD
        vpvKx2WqooshTuBpAiN2b74M2nVRPJkc/RSNF04GiyGv00MGzlpP
X-Google-Smtp-Source: AA0mqf662JPkw13WatQ05CxiA2C/440i7NkXKGBOn8guOTRji46r4/SvC7l7wEqRAH4HVFtzVEqc5y56+NihZR175bE=
X-Received: by 2002:a05:6402:22ab:b0:46a:abc8:8018 with SMTP id
 cx11-20020a05640222ab00b0046aabc88018mr33472999edb.369.1669996376259; Fri, 02
 Dec 2022 07:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20221130161946.3254953-1-spm@google.com> <e43ffb47-6526-6b2d-f7b3-0755f3c54a71@redhat.com>
In-Reply-To: <e43ffb47-6526-6b2d-f7b3-0755f3c54a71@redhat.com>
From:   Space Meyer <spm@google.com>
Date:   Fri, 2 Dec 2022 16:52:20 +0100
Message-ID: <CAOLenvaUpnk=w7TSArwK-WqUsQDQ=GY=vOHcW4apH1E5hWTCJg@mail.gmail.com>
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
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

On Wed, Nov 30, 2022 at 5:59 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/30/22 17:19, Space Meyer wrote:
> >   bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >   {
> > +     DEFINE_WAIT_FUNC(vcpu_block_wait, woken_wake_function);
> >       struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
> >       bool waited = false;
> >
> > @@ -3437,13 +3439,11 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >       preempt_enable();
> >
> >       for (;;) {
> > -             set_current_state(TASK_INTERRUPTIBLE);
> > -
> >               if (kvm_vcpu_check_block(vcpu) < 0)
> >                       break;
> >
> >               waited = true;
> > -             schedule();
> > +             wait_woken(&vcpu_block_wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> >       }
>
> Also, this does not work I think, because there is
> add_wait_queue()/remove_wait_queue() pair.  Adding it is not easy
> because KVM is using a struct rcuwait here instead of a wait_queue_t.

Ah, sorry. I really was a bit quick on this one. I agree nothing would ever call
woken_wake_function, hence my patch doesn't make sense. Looking at the rcuwait
code I don't see something similar to wait_woken.

Do you see some other way we could avoid the pattern susceptible to the nested
sleeping problem?
