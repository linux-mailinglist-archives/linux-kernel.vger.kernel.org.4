Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BF5B997E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIOLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:23:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746917D783
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1EvKTI+8vdc4mrKuvrpi7vpxhe4JIVCAewhTA3ti8qc=; b=FuqDqvKs3kCvpr8IrOUsK3sFZz
        ZbTh3ayxic3EmFpQf240Nloa1N5nMIHSQ+AoME07L7MlloOYqzCityEaf555ngb1Xa8tQJhXL+jVe
        Za3802G+htij/YdzFxfkPD6mMhhr01ZUbUHUV05AWbCGsEU9ap6aDIXqaS2yNwV+RB9fVCvbWPAl3
        XIfQU+YQ9NdNdrmV41w2nNibxOMnJEYp/ypYPwHg0o9csIRwfppHFTlCpUsRq3ud7gwn0DJNm5UqC
        4LWXV49rteCtQdxkL5zkVdZVhP+L2D6y4kOnK/pu3XIwLx6MmH5vI8hPniVq7IBXkOHvPgYhofZqO
        sRuqEqDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYmwl-00CaNR-IB; Thu, 15 Sep 2022 11:22:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF47A30029C;
        Thu, 15 Sep 2022 13:22:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AACED2B1A4535; Thu, 15 Sep 2022 13:22:17 +0200 (CEST)
Date:   Thu, 15 Sep 2022 13:22:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 22/59] x86: Put hot per CPU variables into a struct
Message-ID: <YyMK6US2CmsugZbe@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130948.643735860@infradead.org>
 <CAG48ez07c2ThydovaHtBZ+u137eaXdEut4J-zycvPn7io4MySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez07c2ThydovaHtBZ+u137eaXdEut4J-zycvPn7io4MySw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:02:46PM +0200, Jann Horn wrote:
> On Fri, Sep 2, 2022 at 3:54 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > The layout of per-cpu variables is at the mercy of the compiler. This
> > can lead to random performance fluctuations from build to build.
> >
> > Create a structure to hold some of the hottest per-cpu variables,
> > starting with current_task.
> [...]
> > -DECLARE_PER_CPU(struct task_struct *, current_task);
> > +struct pcpu_hot {
> > +       union {
> > +               struct {
> > +                       struct task_struct      *current_task;
> > +               };
> > +               u8      pad[64];
> > +       };
> > +};
> 
> fixed_percpu_data::stack_canary is probably also a fairly hot per-cpu
> variable on distro kernels with CONFIG_STACKPROTECTOR_STRONG (which
> e.g. Debian enables), so perhaps it'd make sense to reuse
> fixed_percpu_data as the struct for hot percpu variables? But I don't
> have any numbers to actually back up that idea.

Not a bad idea; but the immediate problem I see with this is that
fixed_percpu_data is x86_64 only.

Also; I'm thinking the current stack-protector thing is somewhat of a
hack due to GCC limitations (per the comment there) and once that gets
cleaned up it can come live in the pcpu_hot thing.
