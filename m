Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13F9662C37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjAIRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjAIRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:06:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E4A17593;
        Mon,  9 Jan 2023 09:06:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E36E91042;
        Mon,  9 Jan 2023 09:06:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A321C3F587;
        Mon,  9 Jan 2023 09:06:06 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:06:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment
 workarounds
Message-ID: <Y7xJeHDcanUJoHt+@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-2-mark.rutland@arm.com>
 <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:43:16PM +0100, Miguel Ojeda wrote:
> On Mon, Jan 9, 2023 at 2:58 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > As far as I can tell, GCC doesn't respect '-falign-functions=N':
> >
> > * When the __weak__ attribute is used
> >
> >   GCC seems to forget the alignment specified by '-falign-functions=N',
> >   but will respect the '__aligned__(N)' function attribute. Thus, we can
> >   work around this by explciitly setting the alignment for weak

Whoops: s/explciitly/explicitly/ here too; I'll go re-proofread the series.

> >   functions.
> >
> > * When the __cold__ attribute is used
> >
> >   GCC seems to forget the alignment specified by '-falign-functions=N',
> >   and also doesn't seem to respect the '__aligned__(N)' function
> >   attribute. The only way to work around this is to not use the __cold__
> >   attibute.

Whoops: s/attibute/attribute/

> If you happen to have a reduced case, then it would be nice to link it
> in the commit. A bug report to GCC would also be nice.
> 
> I gave it a very quick try in Compiler Explorer, but I couldn't
> reproduce it, so I guess it depends on flags, non-trivial functions or
> something else.

Sorry, that is something I had intendeed to do but I hadn't extracted a
reproducer yet. I'll try to come up with something that can be included in the
commit message and reported to GCC folk (and double-check at the same time that
there's not another hidden cause)

With this series applied and this patch reverted, it's possible to see when
building defconfig + CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y, where scanning
/proc/kallsyms with:

  $ grep ' [Tt] ' /proc/kallsyms | grep -iv '[048c]0 [Tt] '

... will show a bunch of cold functions (and their callees/callers), largely
init/exit functions (so I'll double-check whether section handling as an
effect), e.g.

  ffffdf08be173b8c t snd_soc_exit
  ffffdf08be173bc4 t apple_mca_driver_exit
  ffffdf08be173be8 t failover_exit
  ffffdf08be173c10 t inet_diag_exit
  ffffdf08be173c60 t tcp_diag_exit
  ffffdf08be173c84 t cubictcp_unregister
  ffffdf08be173cac t af_unix_exit
  ffffdf08be173cf4 t packet_exit
  ffffdf08be173d3c t cleanup_sunrpc
  ffffdf08be173d8c t exit_rpcsec_gss
  ffffdf08be173dc4 t exit_p9
  ffffdf08be173dec T p9_client_exit
  ffffdf08be173e10 t p9_trans_fd_exit
  ffffdf08be173e58 t p9_virtio_cleanup
  ffffdf08be173e90 t exit_dns_resolver

> > + * '-falign-functions=N', and require alignment to be specificed via a function
> 
> Nit: specificed -> specified

Thanks, fixed

> > +#if CONFIG_FUNCTION_ALIGNMENT > 0
> > +#define __function_aligned             __aligned(CONFIG_FUNCTION_ALIGNMENT)
> > +#else
> > +#define __function_aligned
> > +#endif
> 
> Currently, the file is intended for attributes that do not depend on
> `CONFIG_*` options.
> 
> What I usually mention is that we could change that policy, but
> otherwise these would go into e.g. `compiler_types.h`.

I'm happy to move these, I just wasn't sure what the policy would be w.r.t. the
existing __weak and __cold defitions since those end up depending upon
__function_aligned.

I assume I should move them all? i.e. move __weak as well?

> > +#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
> >  #define __cold                          __attribute__((__cold__))
> > +#else
> > +#define __cold
> > +#endif
> 
> Similarly, in this case this could go into `compiler-gcc.h` /
> `compiler-clang.h` etc., since the definition will be different for
> each.

Sure, can do.

Thanks,
Mark.
