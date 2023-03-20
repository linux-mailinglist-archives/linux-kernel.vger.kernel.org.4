Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7466F6C235A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCTVE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCTVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301C14EAE;
        Mon, 20 Mar 2023 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=D3BVyr7z3/LsIQimIZFRzV1o+ANkI7efYBNPjgbxhxE=; b=Qwks+KfSLjSC93jiDkvXvM5s1g
        FELkk7XGy7ASSd8+E5MZ1ZcvQL32BvP9NDspwFchEPteUGLldNsF6p0NIRX+cM/eJovlJCy3WAYs3
        3eHk0fkuOeUin3W6P++64JJlztACRqDj7BmuXFhbV5B26VbDU6/w6SBfeV2SEM6KVZOHvsXW9fFSJ
        7rjqA79+baoD96P3QkF0G05R52ljjuv/VuS7GY+8JzdyknmO9zwspY/U3vaYb8tbI9dBIMF1d1Pmt
        /EZmS5oUwDwEQ+RN5j/INenbGTCR/xd2TK3VCuY2GitAiGkMTzyvPrRhS1GCsQjKpiozgMO5MwWTH
        4Gt4QMTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peMgR-00AUlB-2r;
        Mon, 20 Mar 2023 21:04:47 +0000
Date:   Mon, 20 Mar 2023 14:04:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com, linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in
 /proc/dynamic_debug/control
Message-ID: <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
 <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:59:28PM -0600, jim.cromie@gmail.com wrote:
> On Mon, Mar 20, 2023 at 12:35 PM Jason Baron <jbaron@akamai.com> wrote:
> >
> >
> >
> > On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > > dynamic-debug METADATA uses KBUILD_MODNAME as:
> > >
> > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > >          static struct _ddebug  __aligned(8)                     \
> > >          __section("__dyndbg") name = {                          \
> > >                  .modname = KBUILD_MODNAME,                      \
> > >
> > > This is going amiss for some builtins, ie those enabled here, by:
> > >
> > >      echo module main +pmf > /proc/dynamic_debug_control
> > >      grep =pmf /proc/dynamic_debug/control
> > >
> > > init/main.c:1187 [main]initcall_blacklist =pmf "blacklisting initcall %s\n"
> > > init/main.c:1226 [main]initcall_blacklisted =pmf "initcall %s blacklisted\n"
> > > init/main.c:1432 [main]run_init_process =pmf "  with arguments:\n"
> > > init/main.c:1434 [main]run_init_process =pmf "    %s\n"
> > > init/main.c:1435 [main]run_init_process =pmf "  with environment:\n"
> > > init/main.c:1437 [main]run_init_process =pmf "    %s\n"
> >
> >
> > Hi Jim,
> >
> > So if I'm following correctly, this is not a new issue, the 'module'
> > name for dynamic debug has always been this way for builtin.
> 
> It is not a new issue - both PM and init-main have been in [main] for some time.
> 
> I believe that with
> cfc1d277891e module: Move all into module/
> 
> module's module-name joined them, changing from [module] to [main]

If there was a regression due to this, we'd be very interested in
hearing about it. Aaron he did the work to move the code to its own directory. 

> We could do
> > something simple and just normalize it when we initially create the
> > table, but setting the 'module name' to 'core' or 'builtin' or something
> > for all these?
> 
> core and builtin would both lump all those separate modules together,
> making it less meaningful.
> 
> having stable names independent of M vs Y config choices is imperative, ISTM.
> 
> Also, I dont think "only builtins are affected" captures the whole problem.
> I dont recall amdgpu or other modules changing when built with =y
> 
> Theres some subtlety in how KBUILD_MODNAME is set,
> and probably many current users who like its current behavior.
> A new var ?
> 
> 1st, I think that anything tristate gets a sensible value,
> but at least some of the builtin-only "modules" get basenames, by default.

In general we could all benefit from an enhancement for a shortname for
things which could be modules being built-in. We're now seeing requests
for dynamic debug, but it could also be usefulf for Nick's future work
to help userspace tools / tracing map kallsysms to specific modules when
built-in.

To that end I had suggested the current state of affairs & current difficulty
in trying to get us a name for this here:

https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/

I ended up suggesting perhaps we need a -DPOSSIBLE_MODULE then if we
could *somehow* pull that off perhaps then we could instead use
-DPOSSIBLE_KBUILD_MODNAME which would ensure a consistent symbol when
a module is built-in as well.

That still leaves the difficulty in trying to gather possible-obj-m as
a future challenge.

  Luis
