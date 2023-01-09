Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B5662FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAITDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjAITDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493A38AF9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673290937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
        b=iYLzfX/+x0gg809zW0TTeakmRwaUF0lw64Q6nF8en1Uul5QIM1GCu8sbmRnTHfpB3HFrp6
        oxhdcO7uTCXXXxk7EsQgQVC/pVAGqjSG9jgNDQdmVvz9akY9LbE16OWkdEv69rUibGbcws
        LgFQhXQxiRIFhsuNJsoft1bsRTeAWt8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-207-6smQJm95OT-arvqHN5Q1fw-1; Mon, 09 Jan 2023 14:02:16 -0500
X-MC-Unique: 6smQJm95OT-arvqHN5Q1fw-1
Received: by mail-yb1-f198.google.com with SMTP id k18-20020a25e812000000b0077cc9ab9dd9so9902356ybd.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
        b=ieL0SCwOxrvDng39qdHkAjV3Ylm/pujm/NHTobE4oYOpfBY0JIKsPia4TtP6ZSBY+K
         i1/ySxX9zS5YunpLhOHsO9/IvI489Fh4AYClSt+i/LsWY1MIZr1ZugSYIW+KhupFQqtK
         iU7b4GaUFdijc5HPGRKS2d+dMhFq02VIc/JpvmFUrjzCWdt8YP7J4wic9MdkEDNsCOB5
         Ym6KRR08RvBU099/y53S8Zn7e+I1OYwCyEnwRWaZwUiq/y4PMZvEnpb/o+ZYhzoAuWyS
         yRqJvjDDqmButj2GKDwXZjVvuOXVynstNL2A6V9wpBZ+OrcEZ3ELlk77miSaAx3DNv3z
         sofw==
X-Gm-Message-State: AFqh2kqc4/UeMLZnVlKwqiY5HGqfTnZGBS7fsHOgOogCSxz/sozxx6FJ
        4SsNI2V4lW0IQMDJ4kDMVVp6NHvxOg/gzOm50vnrH03CvMj8F54q4FgpEihW3yxMlhwkm4qHe4E
        nKwa0LJ1c2QpN1S6g/g4kK9Nh
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id fh22-20020a0575005c9600b000f00f14b4f6mr1334335gab.55.1673290935395;
        Mon, 09 Jan 2023 11:02:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpgx9uVCbTytxfSzpNGAx1CCCprwK9dYT+w5TdWAjmS9/Yvcm6uASOc9C3qqyAspkLlpcI4w==
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id fh22-20020a0575005c9600b000f00f14b4f6mr1334309gab.55.1673290934985;
        Mon, 09 Jan 2023 11:02:14 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006fbbdc6c68fsm5795671qkb.68.2023.01.09.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:02:14 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
In-Reply-To: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
 <Y7lRz7oCaAmAhoqS@gmail.com>
Date:   Mon, 09 Jan 2023 19:02:08 +0000
Message-ID: <xhsmh4jszedlb.mognet@vschneid.remote.csb>
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

On 07/01/23 12:04, Ingo Molnar wrote:
> * Valentin Schneider <vschneid@redhat.com> wrote:
>
>> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
>> of smp_call_function*() via either generic_exec_single() or
>> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
>> 
>> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
>> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> Patch series logistics:
>
>  - No objections from the scheduler side, this feature looks pretty useful.
>

Thanks!

>  - Certain patches are incomplete, others are noted as being merged 
>    separately, so I presume you'll send an updated/completed series 
>    eventually?
>

The first patch from Steve is now in, so can drop it.

The other patches are complete, though I need to rebase them and regenerate
the treewide patch to catch any changes that came with 6.2. I'll do that
this week.

The "incompleteness" pointed out in the cover letter is about the types of
IPIs that can be traced. This series covers the ones that end up invoking
some core code (coincidentally those are the most common ones), others such
as e.g. tick_broadcast() for arm, arm64, riscv and hexagon remain
unaffected.

I'm not that much interested in these (other than maybe the tick broadcast
one they are all fairly unfrequent), but I'm happy to have a shot at them
for the sake of completeness - either in that series or in a followup, up
to you.  

>  - We can merge this via the scheduler tree I suspect, as most callbacks 
>    affected relate to tip:sched/core and tmp:smp/core - but if you have 
>    some other preferred tree that's fine too.
>

Either sound good to me.

> Thanks,
>
> 	Ingo

