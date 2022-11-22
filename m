Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB763311F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiKVAJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKVAJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:09:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2292B49
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:09:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350C0B818BB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639B3C433C1;
        Tue, 22 Nov 2022 00:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669075768;
        bh=G9mypmJ53//+0ldpPbJnECVMW+Tkis8i8dMcM/sNngQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ijer0lC1IqpROTX9VX3nYDYySvThDYlGVdBKT1jrJaIZRK0t9dL4jadISMaRtk5Ic
         U3j63Wk7cgDvMDeQ3/8PwtCXdrD/5BZ0Ba2U/Y+vMTbPryo9GUG0RwpUXEW3RRA7rt
         EsxnA05ZpvDdMl3Ihr1Ln6M2abg9L9qCwc9nA7fwG3+t2bPjis0TRPrMr9VjA3vhGU
         3kiP0r59d+nIXTUqHUu0KoPAK1lAB18T0/vLWbTwxIjkkPxmxGLNg0FA3ubYpLxpML
         v+8oGvw0UAcje/FNFEfsB/AiJu+B2I4rCWcuZ3w6uXymjxb6mU0Tru9KGpWFSbVUlY
         bdrbXKWzc3H5Q==
Date:   Tue, 22 Nov 2022 09:09:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-Id: <20221122090923.9d7de73221be99c8ede30379@kernel.org>
In-Reply-To: <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 15:36:08 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Nov 21, 2022 at 11:32 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Nov 21, 2022 at 10:44:03AM -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > >
> > > The config to be able to inject error codes into any function annotated
> > > with ALLOW_ERROR_INJECTION() is enabled when CONFIG_FUNCTION_ERROR_INJECTION
> > > is enabled. But unfortunately, this is always enabled on x86 when KPROBES
> > > is enabled, and there's no way to turn it off.
> > >
> > > As kprobes is useful for observability of the kernel, it is useful to have
> > > it enabled in production environments. But error injection should be
> > > avoided. Add a prompt to the config to allow it to be disabled even when
> > > kprobes is enabled, and get rid of the "def_bool y".
> > >
> > > This is a kernel debug feature (it's in Kconfig.debug), and should have
> > > never been something enabled by default.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 540adea3809f6 ("error-injection: Separate error-injection from kprobe")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > >  lib/Kconfig.debug | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > As stated on another thread, debugging production kernels where folks
> > have been injecting errors into functions is not something anyone would
> > like to and have to do. Especially if from looking at system dumps, it
> > is not even clear what has been injected and why, rendering the system
> > unstable and the issue probably unreproducible.
> >
> > Acked-by: Borislav Petkov <bp@suse.de>
> 
> The commit log is bogus and the lack of understanding what
> bpf and error injection hooks are used for expressed
> in this thread is quite sad.
> Disabling error injection makes the system _less_ secure.

Why? I thought this was only used for testing. Or, are you
using this for changing the kernel behavior in production
environment?

For example, the commit 540adea3809f6 ("error-injection: Separate
error-injection from kprobe") specifies that some btrfs functions
to whitelist, which is I thought only for the testing btrfs.

Now it seems more functions related to syscalls registered to
the whitelist. (I didn't notice that...) If it is intended to
filter syscalls, I recommend you to use secomp instead of this.

> But giving people an option to reduce security is a decision
> that every distro and data center has to make on their own.

This function-level override should be used carefully just for
testing linux kernel code. For forcibly filtering some functionality,
it should use LSM or have another facility based on jump label.
(yeah, if it is for security, why can you use LSM?)


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
