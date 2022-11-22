Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124DE63439F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiKVS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiKVS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:29:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3DB5DBBD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F5F1B81D3F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9E9C433D6;
        Tue, 22 Nov 2022 18:29:06 +0000 (UTC)
Date:   Tue, 22 Nov 2022 13:29:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Mason <clm@meta.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-ID: <20221122132905.12a8d5ad@gandalf.local.home>
In-Reply-To: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
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

On Tue, 22 Nov 2022 12:42:33 -0500
Chris Mason <clm@meta.com> wrote:

> On 11/22/22 5:39 AM, Borislav Petkov wrote:
> > On Mon, Nov 21, 2022 at 03:36:08PM -0800, Alexei Starovoitov wrote:  
> >> The commit log is bogus and the lack of understanding what  
> > 
> > You mean that:
> > 
> > Documentation/fault-injection/fault-injection.rst
> > 
> > ?
> > 
> > I don't want any of that possible in production setups. And until you
> > give me a sane argument why it is good to have in production setups
> > generically, this is end of story.
> >   
> 
> I think there are a few different sides to this:
> 
> - it makes total sense that we all have wildly different ideas about
> which tools should be available in prod.  Making this decision more fine
> grained seems reasonable.
> 
> - fault injection for testing: we have a stage of qualification that
> does error injection against the prod kernel.  It helps to have this
> against the debug kernel too, but that misses some races etc.  I always
> just assumed distros and partners did some fault injection tests against
> the prod kernel builds?
> 
> - fault injection for debugging:  it doesn't happen often but at some
> point we run out of ideas and start making different functions fail in
> prod to figure out why we're not prodding.

As you have stated, we have different ideas for production. Your POV is
cloud based (as is with other parts of my company). But my POV is
Chromebooks where production means what's on a user's device. There's no
reason to ever have fault injection enabled in such cases. I would assume
that distributions are the same. But having kprobes for visibility can also
be useful for debugging purposes, even in the field.

> 
> - overriding return values for security fixes: also not a common thing,
> but it's a tool we've used.  There are usually better long term fixes,
> but it happens.
> 
> Stepping back to the big picture of debugging systems with bpf in use, I
> love hearing (and telling) stories of debugging difficult problems.  As
> far as I know, BPF telling lies hasn't really been a problem for us, so
> even though it's a huge tangent, if you have specific examples of
> problems you've seen, I'm really interested in hearing more.
> 
> When I talk about production, both overall stability and validating new
> kernels, if I compare the BPF subsystem with MM, filesystems, cgroups,
> the scheduler, networking, and all things Jens, the systems BPF
> developers put in place are working really well for me.
> 
> If I expand the discussion to the BPF programs themselves, there have
> been rare issues.   Still completely on par with the rest of the kernel
> subsystems and within the noise in comparison with hardware failures.
> 
> In other words, I really do care about the concerns you're expressing
> here, and I'm usually first in line to complain when random people make
> my job harder.  I'm just not seeing these issues with BPF, and I see
> them actively trying to increase safety over time.

I'm sure you are not seeing theses issues with BPF, as the main developers
and you have the same focus areas.

I have no problem with the concept of BPF. My concern is mostly the
development side of it. As you can basically attach functionality to
arbitrary points in the kernel via BPF programs, the perception is that
anything that is available is fair game. BPF tends to expand features
beyond their intended usage. Heck, look at the name itself. "extended
Berkeley Packet Filter", were eBPF has nothing to do with packet filtering
anymore. Perhaps it should be renamed to CUST (Compiled Use Space
Trampoline) ;-)

Alexei said it's "sad" about my expression of BPF and error injection. If
it has to do with security, then I would like to see more collaboration
with the security folks and perhaps have BPF integrate with their
infrastructure. But the usual response is "that's not fast enough for me"
and then something is done from scratch without working with that
subsystem to make it fast enough. Yes, it takes more time to collaborate
than just doing it on your own. But that's the nature of an open source
*community*.

-- Steve
