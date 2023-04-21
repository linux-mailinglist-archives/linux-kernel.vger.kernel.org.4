Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290DB6EB1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjDUSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDUSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:45:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ACCE6D;
        Fri, 21 Apr 2023 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F45bDSwjMQFBIyyPup/mzrLU83zDLKudjeMCgm+n9uU=; b=osGw+QeXAhyfhx4s/aSHya/bVu
        4MjNm8ps5IYkBaiFFjBjwFyRkjHsdsqH1ofkZhYknco9iUWB8pYz9fZtT1FPwofmLmMafJguE/eGm
        AKAc0eHxwCgQRgCy377BMO4Lv5EY3zGM5M61Wv3KiEqQtl+6X3Jizlaclq/O3X0LMTCmxsI5gjXtR
        T0JNl67yNMfvAmKM+h8MGGRjhSb9zhYOxSmLaz7wv60fNVFQpAKg3hncCtonVN/9HhR650Npsrwuc
        Z4das1bJxPpMFfZsyvr11CkamiHmCBLxaaa+KTvP9OJoXrgYYwe/uNwohNG0PxAMFI0697PKiFzw5
        lLVeDllQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppvl4-00BeWM-1x;
        Fri, 21 Apr 2023 18:45:22 +0000
Date:   Fri, 21 Apr 2023 11:45:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, j.granados@samsung.com
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <ZELZwms4wrc419gt@bombadil.infradead.org>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
 <ZEKn89wPH19r2bM4@kroah.com>
 <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
 <ZELKKVJ11LdFsBYo@bombadil.infradead.org>
 <wjgsfhr642ec2ly24tsdqb5a3hlhvsyxknyajqql4zziqemrwh@w5rdsmxuownn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjgsfhr642ec2ly24tsdqb5a3hlhvsyxknyajqql4zziqemrwh@w5rdsmxuownn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:31:03AM -0700, Lucas De Marchi wrote:
> On Fri, Apr 21, 2023 at 10:38:49AM -0700, Luis Chamberlain wrote:
> > Just as with the kludge-of-concept I posted for kread [0], userspace
> > also should have similar issues in mapping module name to arbitrary
> > file names given:
> > 
> >  o a module can be in different paths and libkmod could for
> >     example at one point load a module in one path, then userspace
> >     removes it, and the next path is used.
> 
> no, it can't. Unless you are doing out of tree modules and loading them
> manually by path. There can only be one module with the same name in kmod's
> database. If you have duplicate modules, depmod will use the dir
> priority configured by the distro (see depmod.d(5)).
> 
> Since we are talking about *udev* it's not a real possibility as
> 1) the udev requests are serialized
> 2) there is only 1 kmod ctx, so they use the same configuration, no
> funky kmod_new("/another-rootfs", ...) type of thing.
> 
> >  o module names may differ from the filename slightly (in the kernel
> >    we replace dash with "_", refer to KBUILD_MODNAME
> 
> this is taken care by depmod/libkmod too. All the aliases are mapped to
> module names and then normalized. See modname_normalize() in kmod.

Great! So this should be much simpler in userspace.

> > [1] https://lore.kernel.org/all/ZDmAvwi+KNvie+OI@bombadil.infradead.org/T/#md172510af8fdf7e0f76f6caafee9c99f7a8b6de7
> > 
> > > libkmod only skips the call if the module is already in
> > > the live state.
> > 
> > It can do better, it can converge requests to avoid a kernel_read*()
> > from using vmalloc space. Note that this was not well known before,
> > but now it is clear.
> 
> in userspace, if using the same context and using init_module() rather
> than finit_module(), I **guess** we would have a similar thing due to
> the memory pool for modules: we don't read the module again. That is not
> true for finit_module() though as we just open and pass the fd.

I think we could not not care about init_module() races for now.

> > I realize though that this could mean sharing a context between all
> > loads thoughs in udev, and such a change could take significant time
> > and review to complete.
> 
> But there is only one context. There aren't multiple paralell requests
> from multiple sources. Probably need to Cc someone still changing
> udev's builtin...  but from a quick look, from what I remember about
> that the last time I touched it and without data to prove me wrong,
> it seems we are not looking at the right problem space to come up with a
> solution.

Data seems to indicate that somehow this might not be true.

> > If we *wanted* to do this in kernel instead, I have already shown it's
> > not hard.
> > 
> > > It seems systemd-udev also duplicates the check
> > > in src/shared/module-util.c:module_load_and_warn()
> > 
> > Evidence is showing that does not suffice for the races which are
> > currently possible.
> 
> can you raise the udev verbosity and share?

How do I do that?

> All the kmod-builtin
> calls will already be logged there. See
> src/udev/udev-event.c:udev_event_execute_run() leading to
> 
> 	log_device_debug(event->dev, "Running built-in command \"%s\"", command);
> 	r = udev_builtin_run(event->dev, &event->rtnl, builtin_cmd, command, false);
> 
> if you are rather seeing "Running command", ohh... then your udev was
> built without libkmod and it will just fork/exec. Not what we want.

I'm using debian testing everything vanilla packages except the kernel,
using modules-next.

> so it seems the easiest thing to do is collect the udev log.
> 
> hopefully you don't have CONFIG_UEVENT_HELPER_PATH set or anything
> mucking /sys/kernel/uevent_helper. Right?

No.

  Luis
