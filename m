Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311966365A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjAJAhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjAJAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:37:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167DF03C;
        Mon,  9 Jan 2023 16:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FF9614A7;
        Tue, 10 Jan 2023 00:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B3CC433EF;
        Tue, 10 Jan 2023 00:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673311017;
        bh=4plEmWhJeJfE5GdKckggdpdil5hs4qzmsldtX3BEnP0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oK2iL9OldgcwSnSMgtOZ1qhrwxaTN1u30xdy8ajerh+rd1GVo0orelMBm6YL8kzB5
         t6aKBfozkjBxmyjqXSiEwDIMKPtnbK6q4u61+UyDtZaBmSFsxl5Ww8Z3n5V5r7312N
         Y++v77hTt6ra4p1C9Sr8FiIJs8+58jx3RgDQDZJTtQ3mh1nFRqlKW7j9uqTEqmIMhg
         qZeJF9aT3r/J1qwBFCUrEVgsYX72Ofpi/HPhOaWdmqp6jA/U0C4tWpZ6yuOPQjNXVI
         AJ+q/c0h3cVmUpYlC7ZtIpXzjmmCgh43ixM2VhdFRGTcMwbGgqDbSoRMpPrLTzVyF3
         OupuYMvG6sAew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A4905C0623; Mon,  9 Jan 2023 16:36:57 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:36:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH rcu 22/27] init: Remove "select SRCU"
Message-ID: <20230110003657.GE4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-22-paulmck@kernel.org>
 <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:02:48PM -0800, Nick Desaulniers wrote:
> On Wed, Jan 4, 2023 at 4:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> 
> Looks like that's the case as of
> commit 0cd7e350abc4 ("rcu: Make SRCU mandatory")
> in v6.2-rc1.

I freely confess that I took the cowardly way out by making it
unconditional in the last merge window and getting rid of references in
the next merge window.  ;-)

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Aaron Tomlin <atomlin@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Patch LGTM
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thank you!  I will apply this on my next rebase.

> Note that there's quite a few more of these though. Perhaps best to
> remove them all together? Or perhaps you already have individual
> patches out already for all of these?

I have these:

e73b36cbeb8eb arch/x86: Remove "select SRCU"
8bde7256e3bdc kvm: Remove "select SRCU"
047bbf23dd4f2 drivers/base: Remove CONFIG_SRCU
1b63789c861c1 drivers/clk: Remove "select SRCU"
3fe724041d29d drivers/cpufreq: Remove "select SRCU"
e8dc9f0f97d6f drivers/dax: Remove "select SRCU"
0be2fa022bcde drivers/devfreq: Remove "select SRCU"
e4ac435cd24da drivers/hwtracing/stm: Remove "select SRCU"
159ce13a6c500 drivers/md: Remove "select SRCU"
dbe417fa57042 drivers/net: Remove "select SRCU"
7cc598f342ae4 drivers/pci/controller: Remove "select SRCU"
fba630f40b15d fs/btrfs: Remove "select SRCU"
a17c8daaee218 fs/dlm: Remove "select SRCU"
fd77fd4fe1852 fs/notify: Remove "select SRCU"
47a84e7a9c1c6 fs/quota: Remove "select SRCU"
e5bc2dc08a416 init: Remove "select SRCU"
b7f8ff0898c04 kernel/power: Remove "select SRCU"
db389dace41db mm: Remove "select SRCU"
e5316ffd44aa1 fs: Remove CONFIG_SRCU
2d07d1c58fad7 kernel/notifier: Remove CONFIG_SRCU
c761c79f1e72f rcu: Remove CONFIG_SRCU

Plus there are three more that people wanted to take via their own
trees.  And I am fine either way.

But as long as you generated the list...

> $ grep -rn 'select SRCU'
> mm/Kconfig:670: select SRCU
> kernel/power/Kconfig:121: select SRCU
> arch/mips/kvm/Kconfig:29: select SRCU
> arch/riscv/kvm/Kconfig:30: select SRCU
> arch/s390/kvm/Kconfig:34: select SRCU
> arch/powerpc/kvm/Kconfig:25: select SRCU
> arch/x86/kvm/Kconfig:49: select SRCU
> arch/x86/Kconfig:286: select SRCU
> arch/x86/Kconfig:1941: select SRCU
> arch/arm64/kvm/Kconfig:31: select SRCU
> init/Kconfig:1868: select SRCU
> security/tomoyo/Kconfig:9: select SRCU
> fs/btrfs/Kconfig:20: select SRCU
> fs/dlm/Kconfig:7: select SRCU
> fs/quota/Kconfig:9: select SRCU
> fs/notify/Kconfig:4: select SRCU
> drivers/md/Kconfig:9: select SRCU
> drivers/clk/Kconfig:26: select SRCU
> drivers/dax/Kconfig:4: select SRCU
> drivers/devfreq/Kconfig:4: select SRCU
> drivers/net/Kconfig:337: select SRCU
> drivers/hwtracing/stm/Kconfig:5: select SRCU
> drivers/cpufreq/Kconfig:6: select SRCU
> drivers/opp/Kconfig:4: select SRCU

And it does look like I missed security/tomoyo/Kconfig, so thank you
for checking!  I have queued the patch.

The other one missing from -next is drivers/opp/Kconfig, which Viresh
said that he was taking.

There is no trace of CONFIG_SRCU in -next, which is the more worrying
one.

							Thanx, Paul

> > ---
> >  init/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 7e5c3ddc341de..af511c726d695 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1865,7 +1865,6 @@ config PERF_EVENTS
> >         default y if PROFILING
> >         depends on HAVE_PERF_EVENTS
> >         select IRQ_WORK
> > -       select SRCU
> >         help
> >           Enable kernel support for various performance events provided
> >           by software and hardware.
> > --
> > 2.31.1.189.g2e36527f23
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
