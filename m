Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E211E66E874
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjAQVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAQV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:29:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3650852;
        Tue, 17 Jan 2023 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NJtx9k7zK7osmEbmFZPuHNLZSNqdsxL4Z7HMD3kHJnA=; b=uZMimG9QEF0kVnMGdSX6KPtkbg
        uZiLjTYNTFaR/UnUO4QLzLIX2INtuaM6Pwu5l8wdfWmKNb+IVTN/hI+wWOawFjOckGTojwhso+hJi
        QPfDlyG/pRBwrGJkTRpH2tjua65eeCJnsJx1KBV655NdMcJzWWwbL4rC0rkak7uLGP8cc696zJ2VX
        XLUg2r6qZdL58QQflxpUbiReNnt/QvDhcSJr23y50FMa/0YkVTc7Dmi3pZ+FT21ehVhMOUhMF7oCS
        BtOYxQOtlnIXHZ/YROjZ6S9mR2rbL+tR+D1RLe5kAFFZ47KAJRG62PrQO43EetH10z6FmwLxdafW3
        orVmlt+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHrzh-00Fg7t-0H; Tue, 17 Jan 2023 19:51:41 +0000
Date:   Tue, 17 Jan 2023 11:51:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Allen Webb <allenwebb@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Mahoney <jeffm@suse.com>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Quentin Perret <qperret@google.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
Message-ID: <Y8b8TOJzd/RZXR8z@bombadil.infradead.org>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:31:44PM +0000, Nick Alcock wrote:
> The kallmodsyms patch series was originally posted in Nov 2019, and the thread
> (https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
> shows review comments, questions, and feedback from interested parties.
> Most recent posting: <https://lore.kernel.org/linux-modules/20221109134132.9052-1-nick.alcock@oracle.com/T/#t>.
> 
> All review comments have been satisfied, as far as I know:

No, not really. I have asked before to trim this cover letter down and
make each patch make sense atomically. You have not done so. I have also
asked you to get users of what you are suggesting to add to kernel to
vouch for this, and for you to make that clear and I feel that falls
short too. I have even suggested folks who likely could help review your
patches for other things they may need or are working on.

So no, this is patch review is slow moving but I'd like to clarify as to why.
It is not that I am ignoring this patch set, it is that each time I come
back to it I see only a slight step forward with the suggestions made.

> A kernel tree containing this series alone:
>    https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4-modules-next
> 
> 
> The whole point of symbols is that their names are unique: you can look up a
> symbol and get back a unique address, and vice versa.  Alas, because
> /proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
> really satisfy this requirement.

You make it sound that's would imply there's bug in kallsyms but its not. We
would have bug reports and I just don't see them associated to what you say.

kallsyms support was added first by Ingo Molnar on 2.5.38 kernel [0] and the
goal was to just to be able to print out symbolic crash information and symbolic
stack backtraces. Rusty Russel later extended support for modules [2] and Kai
Germaschewski finally decreased the speed to generate the file by writing a C
program for it [2]. To this day CONFIG_KALLSYMS is described to relfect that
this is just for oops traces and stack traces.

In that sense getting mapping of addresses to symbols for oops or stack
traces seems kallsyms is successful.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=218af2f340009e624603253ca8a35c884f31ab5a
[1] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=a5508ddcd000a435baa37f61ef1bdfb490fcf3c0
[2] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=6802d702761dfdd910e37da40ba95fa71fd06dd7

> Large numbers of symbols are duplicated
> many times (just search for __list_del_entry!), and while usually these are
> just out-of-lined things defined in header files and thus all have the same
> implementation, it does make it needlessly hard to figure out which one is
> which in stack dumps, when tracing, and such things.

Here is the problem you have in your cover letter: you first try to
state that kallsyms is falling short for your use case and then skim through
the actual use case where you need a unique mapping.

> Some configuration
> options make things much worse: my test make allyesconfig runs introduced
> thousands of text symbols named _sub_I_65535_1, one per compiler-generated
> object file, and it was fairly easy to make them appear in ftrace output.
> 
> Right now the kernel has no way at all to tell such symbols apart, and nor
> has the user: their address differs and that's all. 

You need to explain who would care and why this is an issue.

> Which module did they
> come from?  Which object file?  We don't know.  Figuring out which is which
> when tracing 

For the very *first* time in the cover letter do I see the first
description of a use case where someone might care.

> needs a combination of guesswork and luck, and if there are
> thousands of them that's not a pleasant prospect.  In discussions at LPC it
> became clear that this is not just annoying me but Steve Rostedt and others,
> so it's probably desirable to fix this.

You can just summarize this to say tracing folks care and you need to
explain why. Why this falls short. Why is this limitting tracing folks?

Other than tracing too, wouldn't folks who work on things like crash
care too (Jeff, Omar)? Wouldn't this help them or their teams which
rely on tooling around this?

> It turns out that the linker, and the kernel build system, can be made to
> give us everything we need to resolve this once and for all.  This series
> provides a new /proc/kallmodsyms which is like /proc/kallsyms except that it
> annotates every (textual) symbol which comes from a built-in kernel module
> with the module's name, in square brackets: if a symbol is used by multiple
> modules, it gets [multiple] [names]; if a symbol is still ambiguous it gets
> a cut-down {object file name}; the combination of symbol, [module] [names]
> and {object file name} is unique 

If this is about tracing and issues with a symbol name being mapped to
multiple objects why would this enhancement only involve what are
possibly modules? If the main motivation for the work you are
introducing is to help tracers get a better bearing when working with
a symbols, yes I can see the value in knowing if a symbol was part of
a module, but I'd likely would want to care about in-kernel symbols
too. Is the reason a new file is being introduced because you can
already get 1-1 mapping for symbols only used for built-in stuff?
Ie, is the semantic requirements for fidelity for pure built-in symbols
already satisfied by kallsyms? And do modules then introduce a new
semantic gap, which make it difficult to know what object file thinggs
map to?

Regardless, if tracing is the main use case and the goal here is to map
symbols to object files, I can't think of a reason why a symbol map
filename which also spits out built-in object files needs to be associated with
modules.

/proc/kallmodsyms seems to imply modules need to be involved somehow,
but it does not seem that's the reason for the file. Rather, you seem to
want to just be able to tell users if the symbol came from an object
file only assocaited to a module.

And if this new feature is being tucked away under a new kconfig symbol,
why not just extend the existing /proc/kallsyms when folks want the new
information?

> (with one minor exception: the arm64 nvhe
> module is pre-linked with ld -r, causing all symbols in it to appear to come
> from the same object file: if it was reworked to use thin archives this
> problem would go away).

OK so ARM64 nVHE folks might care, but perhaps other architectures might
be limitted with this feature. Could you express this via Kconfig so
that the feature cannot be selected by these architectures if they use
'ld -r'?

Please work with Guenter Roeck so to have a new branch for your work
tested on some of the oddball archs he has access to. That should help
proactively find odd arch issues we'd otherwise find out during testing
once merged.

> The object file names are cut down to save space: we store only the shortest
> suffix needed to distinguish symbols from each other.

If the information for tracers was so valuable, why trim this? And how
much space does that save you? Is the idea that CONFIG_KALLMODSYMS
would be enabled on production kernels?

> It's fairly rare even
> to see two/level names, let alone three/level/ones.

What does one level mean? What does two levels mean? What does three
levels mean here?

> We also save even more
> space by annotating every symbol in a given object file with the object file
> name if we annotate any of them.
> 
> We also add new fields that let you get at this new info in the kallsyms
> iterator.
> 
> In brief we do this by mapping from address ranges to object files (with
> assistance from the linker map file), then mapping from those object files
> to built-in kernel modules and object file names.  Because the number of
> object files is much smaller than the number of symbols, because we fuse
> address range and object file entries together if possible, and because we
> don't even store object file names unless we need to, this is a fairly
> efficient representation, even with a bit of extra complexity to allow
> object files to be in more than one module at once.
> 
> The size impact of all of this is minimal: in testing, vmlinux grew by 16632
> bytes, and the compressed vmlinux only grew by 12544 bytes (about .1% of a
> 10MiB kernel): though this is very configuration-dependent, it seems likely
> to scale roughly with the kernel as a whole.
> 
> This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
> set results in output in /proc/kallmodsyms that looks like this:
> 
> ffffffff97606e50 t not_visible
> ffffffff97606e70 T perf_msr_probe
> ffffffff97606f80 t test_msr     [rapl]
> ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
> ffffffffa6007440 t rapl_pmu_event_del   [rapl]
> ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
> ffffffffa6007500 t rapl_pmu_event_read  [rapl]
> ffffffffa6007520 t rapl_pmu_event_init  [rapl]
> ffffffffa6007630 t rapl_cpu_offline     [rapl]

My /proc/kallsyms already has something like:

ffffffffc04c7940 t show_shost_eh_deadline       [scsi_mod]
ffffffffc04c7990 t show_shost_active_mode       [scsi_mod]
ffffffffc04c79d0 t sdev_show_preferred_path     [scsi_mod]

So why is that falling short vs /proc/kallmodsyms ?

> Differences from v9, early November 2022:
> 
>  - Rework to use Luis Chamberlain's modules.builtin.objs rather than a
>    tristate-generated "modules_thick.builtin".  Keep the iterator over
>    modules_thick.builtin, but rename it to scripts/modules_builtin.c and
>    make it more robust against strange lines in modules.builtin.objs,
>    such as lines with no colon in.

Please extend the commit log to describe that subsequent patches would
use that information, as otherwise the commit log seems to just
introduce something for new user. My patch was simply a proof of concept
which denied what you claimed was not possible. You can describe also *why*
this information is useful, ie if your use cas is traces, then mention that
and why. The point to my patch also was to show you don't have to re-intrdouce
the tristate stuff, ie your effect revert of commit 8b41fc4454e36fbf ("kbuild:
create modules.builtin without Makefile.modbuiltin or tristate.conf")
and so I am extremely surprised you are still keeeping that patch and
using that suff in this v10 series! The point was to simplify your
patch series.

The semantics of the module license should suffice.

And please split out the driver conversions to remove module license per
subsystem, and a new thread. The justification should be simple, commit
8b41fc4454e36fbf ("kbuild: create modules.builtin without Makefile.modbuiltin or
tristate.conf") now relies on the module license tag to do simplify the
build system. And as part of follow up work to that patch we want to
correct false positives for modules.builtin where userspace may try to
load a module which is built-in but such module can never be built in.
You can add Suggested-by me to that set.

The same applies to your other Makefile patch (except to the
Suggested-by as I don't understand the goal there yet), I don't know what it is
trying to do, but it should be a separate effort. You can feel free to
Cc me on that too.

And lastly users. This cover letter should reflect clearly who are the
new users who are dying for this feature, Cc them and hope to have them be
actively engaged during review.

  Luis
