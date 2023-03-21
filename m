Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADF6C36F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCUQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:31:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6738013;
        Tue, 21 Mar 2023 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=t/rjQKj0LE5FASB99J7K94aXzuyufuTX7nhjjJbOPx0=; b=xMD124U37+hdXe76lN/nnDHzvC
        ryK4I1DLu4Tw7Ww8JSVhGQ4R6MW71Rm/VdAf4AQdhKE/U4s/lhgg6sYzKb+eaT2JyhOAEj8OpVxcx
        y5ycYrURhqEgkP7WgLxgiORLSWdL23Wy8ueOaj5I9Q/+1BRGMgsxQXZI/k8+jN9q/BkK1rL1gdiO8
        pDZWdfGI6szRWjfBne6YyqHTVTx8oRUIEPbeBO67kqFi22io5QGAgqYy6EsqyvQyh6r6QQbxgbS6R
        uExLFGbRYwtrwKP0uIdXRyCOKD8XTlp/npRqqZcSl/Wc17gTHKMKxc8GPj9i6yDlXURmAY5PjrVN8
        /LXSVLFw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peetU-00D5F1-2C;
        Tue, 21 Mar 2023 16:31:28 +0000
Date:   Tue, 21 Mar 2023 09:31:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     jim.cromie@gmail.com, linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in
 /proc/dynamic_debug/control
Message-ID: <ZBnb4KVdx26tMDLO@bombadil.infradead.org>
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
 <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
 <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
 <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUBJ_AS_SEEN,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 06:03:01PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 21, 2023 at 6:04 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Mar 20, 2023 at 01:59:28PM -0600, jim.cromie@gmail.com wrote:
> > > On Mon, Mar 20, 2023 at 12:35 PM Jason Baron <jbaron@akamai.com> wrote:
> > > >
> > > >
> > > >
> > > > On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > > > > dynamic-debug METADATA uses KBUILD_MODNAME as:
> > > > >
> > > > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > > >          static struct _ddebug  __aligned(8)                     \
> > > > >          __section("__dyndbg") name = {                          \
> > > > >                  .modname = KBUILD_MODNAME,                      \
> > > > >
> > > > > This is going amiss for some builtins, ie those enabled here, by:
> > > > >
> > > > >      echo module main +pmf > /proc/dynamic_debug_control
> > > > >      grep =pmf /proc/dynamic_debug/control
> > > > >
> > > > > init/main.c:1187 [main]initcall_blacklist =pmf "blacklisting initcall %s\n"
> > > > > init/main.c:1226 [main]initcall_blacklisted =pmf "initcall %s blacklisted\n"
> > > > > init/main.c:1432 [main]run_init_process =pmf "  with arguments:\n"
> > > > > init/main.c:1434 [main]run_init_process =pmf "    %s\n"
> > > > > init/main.c:1435 [main]run_init_process =pmf "  with environment:\n"
> > > > > init/main.c:1437 [main]run_init_process =pmf "    %s\n"
> > > >
> > > >
> > > > Hi Jim,
> > > >
> > > > So if I'm following correctly, this is not a new issue, the 'module'
> > > > name for dynamic debug has always been this way for builtin.
> > >
> > > It is not a new issue - both PM and init-main have been in [main] for some time.
> > >
> > > I believe that with
> > > cfc1d277891e module: Move all into module/
> > >
> > > module's module-name joined them, changing from [module] to [main]
> >
> > If there was a regression due to this, we'd be very interested in
> > hearing about it. Aaron he did the work to move the code to its own directory.
> >
> > > We could do
> > > > something simple and just normalize it when we initially create the
> > > > table, but setting the 'module name' to 'core' or 'builtin' or something
> > > > for all these?
> > >
> > > core and builtin would both lump all those separate modules together,
> > > making it less meaningful.
> > >
> > > having stable names independent of M vs Y config choices is imperative, ISTM.
> > >
> > > Also, I dont think "only builtins are affected" captures the whole problem.
> > > I dont recall amdgpu or other modules changing when built with =y
> > >
> > > Theres some subtlety in how KBUILD_MODNAME is set,
> > > and probably many current users who like its current behavior.
> > > A new var ?
> > >
> > > 1st, I think that anything tristate gets a sensible value,
> > > but at least some of the builtin-only "modules" get basenames, by default.
> >
> > In general we could all benefit from an enhancement for a shortname for
> > things which could be modules being built-in. We're now seeing requests
> > for dynamic debug, but it could also be usefulf for Nick's future work
> > to help userspace tools / tracing map kallsysms to specific modules when
> > built-in.
> 
> 
> 
> I think I rejected it some years ago.

Good to know.

> He comes back again and again with almost the same approaches,
> until he finds a "sponsor" (it's you) who will get it in.

Actually I also rejected the same approach too.

> Recently, I rejected the Kbuild changes again.

Yes I saw.

> > To that end I had suggested the current state of affairs & current difficulty
> > in trying to get us a name for this here:
> >
> > https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/
> >
> > I ended up suggesting perhaps we need a -DPOSSIBLE_MODULE then if we
> > could *somehow* pull that off perhaps then we could instead use
> > -DPOSSIBLE_KBUILD_MODNAME which would ensure a consistent symbol when
> > a module is built-in as well.
> >
> > That still leaves the difficulty in trying to gather possible-obj-m as
> > a future challenge.
> 
> I do not understand your point.
> 
> Why is it important to achieve "precisely-exactly-possible-obj-m" instead of
> "perhaps-possible-obj-m"?
> 
> When "modprobe foo" succeeds, the user is sure that the kernel
> provides the feature "foo" (but he does not care if
> "foo" is built-in or modular).

You are thinking about the modprobe situation. That is in no way shape
or form the end goal. Nick suggests he has tooling enhancements which
allow userspace to disambiguate symbols from kallsyms which are built-in
to come things which are modules. His hacks bring back the tristate crap
which both you and I have rejected. The alternative is to live with what
we *do* have. What do *do* have is to rely on the module license tag to
see if something could possibly be a module.

The module license cleanup is motivated by the fact that relying on the
fact that a module license tag does not always mean something can be a
module. Having something which could never be a module still use
MODULE_LICENSE() and have modprobe succeed is not fatal. However, if
future tooling *is* going to be relied upon to display to tracer /
debuggers where symbols come from, it becomes more useful if that
information is a bit more deterministic.

We eventually want to actually see if we can just infer the
MODULE_LICENSE() from the SPDX tag, how we go about that remains
to be seen, but if we *at least* had MODULE_LICENSE only in places
that *were really* modules this reduces the scope.

While we don't *need* to "fix" code which is using MODULE_LICENSE()
which can *never* be modules, removing that cruft *can* still be useful
from a driver maintainer perspective.

> He spams with MODULE_LICENSE removal with no justification.

If we don't want Nick to rely on the old tristate crap then the only
tooling available he has today at his disposal to map symbols to
possible modules is the MODULE_LICENSE tag.

Part of the issue with Nick's patches all along has been proper
justification / documentation. Try to take a step back and think about
the possible *value-add* of userspace having more concrete information
for traces / debugging. Again, value of his patches are separate, but
*if* someone wanted to bring such tooling which *did* want to help map
symbols more closely to possible modules *relying* on module-license is
one of the cheap ways to do it today without incurring a build system
slowdown.

  Luis
