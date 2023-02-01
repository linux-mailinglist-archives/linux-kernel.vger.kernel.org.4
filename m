Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C468659D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjBALyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBALyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:54:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB0F71BCE;
        Wed,  1 Feb 2023 03:54:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B95A4B3;
        Wed,  1 Feb 2023 03:54:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB993F882;
        Wed,  1 Feb 2023 03:54:11 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:54:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user
 addresses
Message-ID: <Y9pS4MNnFWOEO2Fr@FVFF77S0Q05N>
References: <20230127162409.2505312-1-elver@google.com>
 <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
 <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
 <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
 <CACT4Y+Yriv_JYXm9N1YAMh+YuiT57irnF-vyCqxnTTux-2Ffwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yriv_JYXm9N1YAMh+YuiT57irnF-vyCqxnTTux-2Ffwg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

We raced to reply here, so there's more detail in my reply to Marco. I'm
providing minimal detail here, sorry for being terse! :)

On Wed, Feb 01, 2023 at 10:53:44AM +0100, Dmitry Vyukov wrote:
> On Wed, 1 Feb 2023 at 10:34, Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> > [...]
> > > > This again feels like a deficiency with access_ok(). Is there a better
> > > > primitive than access_ok(), or can we have something that gives us the
> > > > guarantee that whatever it says is "ok" is a userspace address?
> > >
> > > I don't think so, since this is contextual and temporal -- a helper can't give
> > > a single correct answert in all cases because it could change.
> >
> > That's fair, but unfortunate. Just curious: would
> > copy_from_user_nofault() reliably fail if it tries to access one of
> > those mappings but where access_ok() said "ok"?
> 
> I also wonder if these special mappings are ever accessible in a user
> task context?

No. The special mappings are actually distinct page tables from the user page
tables, so whenever userspace is executing and can issue a syscall, the user
page tables are installed.

The special mappings are only installed for transient periods within the
context of a user task. There *might* be some latent issues with work happening
in IPI context (e.g. perf user backtrace) on some architectures.

> If yes, can a racing process_vm_readv/writev mess with these special mappings?

No; those happen in task context, and cannot be invoked within the critical
section where the page tables with the special mappings are installed.

> We could use copy_from_user() to probe that the watchpoint address is
> legit. But I think the memory can be potentially PROT_NONE but still
> legit, so copy_from_user() won't work for these corner cases.

Please see my other reply; ahead-of-time checks cannot help here. An address
might be a legitimate user address and *also* transiently be a special mapping
(since the two aare in entirely separate page tables).

Thanks,
Mark.
