Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A77402B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjF0R4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0R4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:56:45 -0400
Received: from port70.net (port70.net [81.7.13.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82124296B;
        Tue, 27 Jun 2023 10:56:41 -0700 (PDT)
Received: by port70.net (Postfix, from userid 1002)
        id D1130ABEC0C7; Tue, 27 Jun 2023 19:56:38 +0200 (CEST)
Date:   Tue, 27 Jun 2023 19:56:38 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org, Rich Felker <dalias@libc.org>
Subject: Re: [PATCH 3/4] openrisc: Support floating point user api
Message-ID: <20230627175638.GD3630668@port70.net>
References: <20230418165813.1900991-1-shorne@gmail.com>
 <20230418165813.1900991-4-shorne@gmail.com>
 <20230626213840.GA1236108@port70.net>
 <ZJsRHzDbuTlXKNCG@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsRHzDbuTlXKNCG@antec>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stafford Horne <shorne@gmail.com> [2023-06-27 17:41:03 +0100]:
> On Mon, Jun 26, 2023 at 11:38:40PM +0200, Szabolcs Nagy wrote:
> > * Stafford Horne <shorne@gmail.com> [2023-04-18 17:58:12 +0100]:
> > > Add support for handling floating point exceptions and forwarding the
> > > SIGFPE signal to processes.  Also, add fpu state to sigcontext.
> > > 
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > ...
> > > --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> > > +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> > > @@ -28,6 +28,7 @@
> > >  
> > >  struct sigcontext {
> > >  	struct user_regs_struct regs;  /* needs to be first */
> > > +	struct __or1k_fpu_state fpu;
> > >  	unsigned long oldmask;
> > >  };
> > 
> > this seems to break userspace abi.
> > glibc and musl have or1k abi without this field.
> > 
> > either this is a new abi where binaries opt-in with some marking
> > and then the base sigcontext should be unmodified,
> > 
> > or the fp state needs to be added to the signal frame in a way that
> > does not break existing abi (e.g. end of the struct ?) and also
> > advertise the new thing via a hwcap, otherwise userspace cannot
> > make use of it.
> > 
> > unless i'm missing something.
> 
> I think you are right, I meant to look into this but it must have slipped
> though.  Is this something causing you issues or did you just notice it?

i noticed it while trying to update musl headers to linux 6.4 uapi.

> I didn't run into issues when running the glibc test suite, but I may have
> missed it.

i would only expect issues when accessing ucontext entries
after uc_mcontext.regs in a signal handler registered with
SA_SIGINFO.

in particular uc_sigmask is after uc_mcontext on or1k and e.g.
musl thread cancellation uses this entry to affect the mask on
signal return which will not work on a 6.4 kernel (not tested).

i don't think glibc has tests for the ucontext signal abi.

> Just moving this to the end of the sigcontext may be all that is needed.

that won't help since uc_sigmask comes after sigcontext in ucontext.
it has to go to the end of ucontext or outside of ucontext then.

one way to have fpu in sigcontext is

struct sigcontext {
	struct user_regs_struct regs;
	unsigned long oldmask;
	char padding[sizeof(__userspace_sigset_t)];
	struct __or1k_fpu_state fpu;
};

but the kernel still has to interpret the padding in a bwcompat
way. (and if libc wants to expose fpu in its ucontext then it
needs a flag day abi break as the ucontext size is abi.)

(part of the userspace uc_sigmask is unused because sigset_t is
larger than necessary so may be that can be reused but this is
a hack as that's libc owned.)

not sure how important this fpu field is, arm does not seem to
have fpu state in ucontext and armhf works.

there may be other ways, i'm adding Rich (musl maintainer) on cc
in case he has an opinion.
