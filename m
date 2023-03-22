Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBE6C53AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCVSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCVSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB002279AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679509385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQmTyEbfymjzRNtIW6wpo43MqQOqbzqrZwvZwgWkUpU=;
        b=B76yuHLr3WzM3ffro1QHk7O4uhnaJxfQ4EBlrkDCu39our0KCylGDwlMjuSBZk4J3LglFo
        IpbSO1ZO+MVXQR26U7FC/rRqVM/6zHeKzmXcrZZZMEP5HPeG1XqU0jVQ6rF9SgQDkz4jQo
        l8DQ7kExLM4ITERMlhO5Q/vqRqimUsE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-mIS0lzLRP12G3KNEKBJLGA-1; Wed, 22 Mar 2023 14:22:45 -0400
X-MC-Unique: mIS0lzLRP12G3KNEKBJLGA-1
Received: by mail-qk1-f197.google.com with SMTP id 66-20020a370345000000b00746886b1593so4727342qkd.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509357;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQmTyEbfymjzRNtIW6wpo43MqQOqbzqrZwvZwgWkUpU=;
        b=RKXU2boUAjR/W/iClHabctes3SwD18MtG8paldvQR8zkt0ja3i+59hA+Cddagywaau
         eyZROciS0LIGqI5766FLUqjovl8rKVtC3+sjtub43XenwIBvuoL9gVzxtaoRrI3Cjdzl
         P82HSydory1t2FfRhxs2KJD4Zf1x/JCpmasF0/GGuq+jkmMEG0qdUX/Q2OaSeG4RFl/I
         jaGKd64dYLpzh2OGhS6T9daGkMMykf626U57ABJ6jjt2RRkKodJDhhWGcFM96Z9x3q15
         XlkPV1fAqARRAFOz2wV9RjPpA51U5vGHfROLitn3g2vUzVaaPI2UAm2pj18leaSYF/rX
         UD5Q==
X-Gm-Message-State: AO0yUKXnnSLBPPXVb+jDg4/AAheQBz/4cYxsubUjImAfRRrWBLy8L1uc
        Xogov+iLI9oJHj9XQsRAfodloYbRvzHpMjrHyV5wWD71veFH4uDcyXMA8unhGkSOqDVNIfzeLTU
        1EvjtNXGXf1/6u36iT9VpwnFS
X-Received: by 2002:ac8:594a:0:b0:3e3:7e53:9a8f with SMTP id 10-20020ac8594a000000b003e37e539a8fmr7511724qtz.50.1679509356906;
        Wed, 22 Mar 2023 11:22:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+t7wmz3/x7URy1IAcP9apu1JV9+38nhf9A/nHJ2ae3E1Cp8z62mk26+NWh6ExaxyxmUk07Nw==
X-Received: by 2002:ac8:594a:0:b0:3e3:7e53:9a8f with SMTP id 10-20020ac8594a000000b003e37e539a8fmr7511693qtz.50.1679509356631;
        Wed, 22 Mar 2023 11:22:36 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id j23-20020ac86657000000b003e0c29112b6sm6351465qtp.7.2023.03.22.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:22:36 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
In-Reply-To: <20230322172242.GH2357380@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
 <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
 <xhsmhjzz8d8km.mognet@vschneid.remote.csb>
 <20230322172242.GH2357380@hirez.programming.kicks-ass.net>
Date:   Wed, 22 Mar 2023 18:22:28 +0000
Message-ID: <xhsmhh6ucd4t7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/23 18:22, Peter Zijlstra wrote:
> On Wed, Mar 22, 2023 at 05:01:13PM +0000, Valentin Schneider wrote:
>
>> > So I was thinking something like this:
>
>> Hm, this does get rid of the func being passed down the helpers, but this
>> means the trace events are now stateful, i.e. I need the first and last
>> events in a CSD stack to figure out which one actually caused the IPI.
>
> Isn't much of tracing stateful? I mean, why am I always writing awk
> programs to parse trace output?
>
> The one that is directly followed by
> generic_smp_call_function_single_interrupt() (horrible name that), is
> the one that tripped the IPI.
>

Right.

>> It also requires whoever is looking at the trace to be aware of which IPIs
>> are attached to a CSD, and which ones aren't. ATM that's only the resched
>> IPI, but per the cover letter there's more to come (e.g. tick_broadcast()
>> for arm64/riscv and a few others). For instance:
>> 
>>        hackbench-157   [001]    10.894320: ipi_send_cpu:         cpu=3 callsite=check_preempt_curr+0x37 callback=0x0
>
> Arguably we should be setting callback to scheduler_ipi(), except
> ofcourse, that's not an actual function...
>
> Maybe we can do "extern inline" for the actual users and provide a dummy
> function for the symbol when tracing.
>

Huh, I wasn't aware that was an option, I'll look into that. I did scribble
down a comment next to smp_send_reschedule(), but having a decodable
function name would be better!

>>        hackbench-157   [001]    10.895068: ipi_send_cpu:         cpu=3 callsite=try_to_wake_up+0x29e callback=sched_ttwu_pending+0x0
>>        hackbench-157   [001]    10.895068: ipi_send_cpu:         cpu=3 callsite=try_to_wake_up+0x29e callback=generic_smp_call_function_single_interrupt+0x0
>> 
>> That first one sent a RESCHEDULE IPI, the second one a CALL_FUNCTION one,
>> but you really have to know what you're looking at...
>
> But you have to know that anyway, you can't do tracing and not know wtf
> you're doing. Or rather, if you do, I don't give a crap and you can keep
> the pieces :-)
>
> Grepping the callback should be pretty quick resolution at to what trips
> it, no?
>
> (also, if you *realllllly* can't manage, we can always add yet another
> argument that gives a type thingy)
>

Ah, I was a bit unclear here - I don't care too much about the IPI type
being used, but rather being able to figure out on IRQ entry where that IPI
came from - thinking some more about now, I don't think logging *all* CSDs
causes an issue there, as you'd look at the earliest-not-seen-yet event
targeting this CPU anyway.

That'll be made easy once I get to having cpumask filters for ftrace, so
I can just issue something like:

  trace-cmd record -e 'ipi_send_cpu' -f "cpu == 3" -e 'ipi_send_cpumask' -f "cpus \in {3}" -T hackbench 

(it's somewhere on the todolist...)

TL;DR: I *think* I've convinced myself logging all of them isn't an issue -
I'm going to play with this on something "smarter" than just hackbench
under QEMU just to drill it in.

