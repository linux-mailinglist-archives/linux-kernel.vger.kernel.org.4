Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D691B61EF34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKGJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A73C10
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667813859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RA5h23L4uCyLHhh8VO30UEa386MUEsaDniZmx0LN9mo=;
        b=NmAsIghB9OmoFeYrB0WOanNVyeigAaVhFbJm6WG69CN+xKOrBjmqx6x2VYv8af8qxW9AhP
        /EUr9bmV8g4QDahEInysW2A6/kyBDE1LC/8en3TDLFcx/72GhrYiTdtqyQcJN6ozH4455K
        JPU28hX5qtRnNMYryAGM9L+FEBPSkCM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-ogBbAQK4MeuZCHdYF5tFXA-1; Mon, 07 Nov 2022 04:37:37 -0500
X-MC-Unique: ogBbAQK4MeuZCHdYF5tFXA-1
Received: by mail-vk1-f198.google.com with SMTP id u186-20020a1fabc3000000b003b80089c9e6so3153049vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RA5h23L4uCyLHhh8VO30UEa386MUEsaDniZmx0LN9mo=;
        b=6UbY6IFR/l39AJg7j8ctRSox7WeOJ9xKmh+agcnA+zuQBJ4VIBXZtZwvlwRCX6uhqe
         jB7vPGIJeT112/Vnvk/z94L8Wis4tkWqU0aZX5Bm2UBmtgqpweJ+Xa9czBroCLQ28oKz
         aycRq6L/9oK/gyn0Gmsh0+olOIp6ZyYwan++FuDqo0q4KSVTt6mEtEf9kUs2O1yOWwU0
         xlNAo9rkvbGCsDD25a0zCu+c0P8yq52hqxKJdfX+8wOKal2mKzXEY8l6kFtvqmGRAn0l
         7QQpo1/B3HujRFYAydexV+ow19gMfzuqTS1R9ZwcNhgWivx/14o6QaYRLlJNxBHQC7OU
         f1aw==
X-Gm-Message-State: ACrzQf1UQ6AaQpwbjR3mNBVHKt9l3VDdrsl/l9TLsZ8jnQ83/YocggKd
        KPeJj2coM2uW/v+M/o81bLjyzgUcQHIjv8DjMzFcegks40DZeGPBwtMCNoiIuyKc9AiK4VJPSGG
        YMfWXdUnYn4fMMdZxxd30ZJMJkjKFF9Uz68ODAFzD
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id y23-20020a67c997000000b003aa1d0c6bc7mr26593164vsk.16.1667813857378;
        Mon, 07 Nov 2022 01:37:37 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4iooYOJKgVrQAXHtKWqN/IHYiqmUVm64ZXPIaHfP7hfWHBzsSjnEhIQGt/4NX3Mkvyi+CxSL8AlhQFAmOXHds=
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id
 y23-20020a67c997000000b003aa1d0c6bc7mr26593145vsk.16.1667813857115; Mon, 07
 Nov 2022 01:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20220915111039.092790446@infradead.org> <20220915111147.890071690@infradead.org>
 <Y1HVZKW4o0KRsMtq@dev-arch.thelio-3990X> <Y1JsBQAhDFB2C0OE@hirez.programming.kicks-ass.net>
 <Y1K5D2u6pzXRQz6a@dev-arch.thelio-3990X> <08bbd7ab-049e-3cc3-f814-636669b856be@citrix.com>
 <Y2UJPrgYTtKHblnh@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2UJPrgYTtKHblnh@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon, 7 Nov 2022 10:37:26 +0100
Message-ID: <CABgObfb1yhuKMo6_qCrJxAoA6=-3ZkmQYdFLMJWDmgJbPWbGmA@mail.gmail.com>
Subject: Re: KVM vs AMD: Re: [PATCH v3 48/59] x86/retbleed: Add SKL return thunk
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 1:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 03, 2022 at 10:53:54PM +0000, Andrew Cooper wrote:
> > On 21/10/2022 16:21, Nathan Chancellor wrote:
> > > On Fri, Oct 21, 2022 at 11:53:09AM +0200, Peter Zijlstra wrote:
> > >> On Thu, Oct 20, 2022 at 04:10:28PM -0700, Nathan Chancellor wrote:
> > >>> This commit is now in -next as commit 5d8213864ade ("x86/retbleed: Add
> > >>> SKL return thunk"). I just bisected an immediate reboot on my AMD test
> > >>> system when starting a virtual machine with QEMU + KVM to it (see the
> > >>> bisect log below). My Intel test systems do not show this.
> > >>> Unfortunately, I do not have much more information, as there are no logs
> > >>> in journalctl, which makes sense as the reboot occurs immediately after
> > >>> I hit the enter key for the QEMU command.
> > >>>
> > >>> If there is any further information I can provide or patches I can test
> > >>> for further debugging, I am more than happy to do so.
> > >> Moo :-(
> > >>
> > >> you happen to have a .config for me?
> > > Sure thing, sorry I did not provide it in the first place! Attached. It
> > > has been run through localmodconfig for the particular machine but I
> > > assume the core pieces should still be present.
> >
> > Following up from some debugging on IRC.
> >
> > The problem is that FILL_RETURN_BUFFER now has a per-cpu variable
> > access, and AMD SVM has a fun optimisation where the VMRUN instruction
> > doesn't swap, amongst other things, %gs.
> >
> > per-cpu variables only become safe following
> > vmload(__sme_page_pa(sd->save_area)); in svm_vcpu_enter_exit().
> >
> > Given that retbleed=force ought to work on non-skylake hardware, the
> > appropriate fix is to move the VMLOAD/VMSAVE's down into asm and put
> > them adjacent to VMRUN.
> >
> > This also addresses an undocumented dependency where its only the memory
> > clobber in vmload() which stops the compiler moving
> > svm_vcpu_enter_exit()'s calculation of sd into an unsafe position.
>
> So, aside from wasting the entire morning on resuscitating my AMD
> Interlagos, I ended up with the below patch which seems to work.
>
> Not being a virt person, I'm sure I've messed up something, please
> advise.

Oh, that was fast. I was doing similar stuff to move MSR_IA32_SPEC_CTRL
save/restore to assembly, because we're not sure it's safe to do the restore
in C code, and there is overlap with this change. I'll get it out today.

The main issue in the patch below is that _ASM_ARG4 does not exist
on 32-bits, and also _ASM_ARG3 is kinda offlimits because I need it
for the aforementioned MSR_IA32_SPEC_CTRL change.

Otherwise it's similar to my change.

Paolo

