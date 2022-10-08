Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAB5F872D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJHTkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJHTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3F2034E;
        Sat,  8 Oct 2022 12:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D90D60A09;
        Sat,  8 Oct 2022 19:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B91C433D6;
        Sat,  8 Oct 2022 19:40:20 +0000 (UTC)
Date:   Sat, 8 Oct 2022 15:40:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
Message-ID: <20221008154016.0f7ecd8f@rorschach.local.home>
In-Reply-To: <Y0CFnWDpMNGajIRD@fuller.cnet>
References: <20221007154145.1877054-1-vschneid@redhat.com>
        <Y0CFnWDpMNGajIRD@fuller.cnet>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 17:01:33 -0300
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> > As for the targeted CPUs, the existing tracepoint does export them, albeit in
> > cpumask form, which is quite inconvenient from a tooling perspective. For
> > instance, as far as I'm aware, it's not possible to do event filtering on a
> > cpumask via trace-cmd.  
> 
> https://man7.org/linux/man-pages/man1/trace-cmd-set.1.html
> 
>        -f filter
>            Specify a filter for the previous event. This must come after
>            a -e. This will filter what events get recorded based on the
>            content of the event. Filtering is passed to the kernel
>            directly so what filtering is allowed may depend on what
>            version of the kernel you have. Basically, it will let you
>            use C notation to check if an event should be processed or
>            not.
> 
>                ==, >=, <=, >, <, &, |, && and ||
> 
>            The above are usually safe to use to compare fields.

We could always add an "isset(x)" filter ;-)

-- Steve
