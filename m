Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F266A6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjAMXHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjAMXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:07:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB02AE6;
        Fri, 13 Jan 2023 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iwz7mFj6BnnAFkpB1WWVGVKEvGEgqsYMT8OTDqMBOOc=; b=S5supkgbtZvpM5usiJROXh2SMd
        Y1hgUhSckjLRWnEj5HAZ28xKY2/jO40aad8NX8SKFWSCGAGe9KDs1BwfBsuo5kkXW+s94bGtLGHLI
        tCwn3nTKTH6Y54z00u1h2FEamqJJ9FozrXUhLCT+bbmOAPmvO4MpU3yC4BZZPuqCJuQpnxv4XE4ri
        i/ADfdDAjavLauay0iZr1J1GtFopf3WPbsKebPod2u5+ZdkCp2KfKD1UgttFwmQjf6xHk24kVgjeO
        ydAAQcarw67L37NRtPQlurvEl5LBfoxJmbuhhgEvzjMnppCsrL1pAdipAe6/gxO2dsi8h/TCCtzjr
        jxA615hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGT8N-004mqa-Md; Fri, 13 Jan 2023 23:06:51 +0000
Date:   Fri, 13 Jan 2023 15:06:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, Petr Mladek <pmladek@suse.com>,
        prarit@redhat.com, david@redhat.com, mwilck@suse.com,
        linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3] kmod: harden user namespaces with new
 kernel.ns_modules_allowed sysctl
Message-ID: <Y8HkC1re3Fo46Ne3@bombadil.infradead.org>
References: <20230112131911.7684-1-vegard.nossum@oracle.com>
 <Y8BVNihCrKOeY/FO@bombadil.infradead.org>
 <e88d9189-317c-6431-7fe0-08b82f13a81c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88d9189-317c-6431-7fe0-08b82f13a81c@oracle.com>
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

On Thu, Jan 12, 2023 at 10:53:07PM +0100, Vegard Nossum wrote:
> On 1/12/23 19:45, Luis Chamberlain wrote:
> > On Thu, Jan 12, 2023 at 02:19:11PM +0100, Vegard Nossum wrote:
> > > +ns_modules_allowed
> > > +==================
> > > +
> > > +Control whether processes may trigger module loading inside a user namespace.
> > 
> > This is false documentation. The place it is trying to protect simply
> > prevents trying to call modprobe for auto-loading within the kernel.
> 
> I don't think this is false -- but yes, this only protects module
> auto-loading in user namespaces; all auto-loading calls within the
> kernel should be going through this __request_module() -> modprobe path.
> 
> init_module()/finit_module(), the mechanism used by modprobe, are
> themselves already restricted inside user namespaces, see below.

The documentation should be clear about the exact nature of what
mechanism is prevented to load.

> > > +	/*
> > > +	 * Disallow module loading if we're in a user namespace.
> > > +	 */
> > > +	if (current_user_ns() != &init_user_ns &&
> > > +	    !sysctl_ns_modules_allowed) {
> > > +		pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
> > > +			task_pid_nr(current), current->comm, module_name);
> > > +		return -EPERM;
> > > +	}
> > > +
> > >   	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
> > >   		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
> > >   				    atomic_read(&kmod_concurrent_max),
> > 
> > Have you seen what call_modprobe() does?
> 
> Yes.
> 
> > This is just a limitting the auto-loading through calling modprobe.
> > If the concern is to load modules wouldn't you be better off just
> > putting a stop gap at finit_module() which actually receives the
> > load attempt from modprobe? Ie, an evil namespace, if it has access
> > to /sbin/modprobe could simply just try calling /sbin/modprobe on its
> > own.
> 
> No.
> 
> Root inside a user namespace can't call finit_module() as it won't have
> the necessary capabilities in the init namespace, see may_init_module().

I think the documentation to this knob you are adding should explain
this as well to give a bette context as to why it is useful.

And if may_init_module() suffices, why not just add a may_init_module()
instead of your check? Why would we allow a successful call to modprobe
with your sysctl but end up having it ignored in the end by
finit_module()? If what is being allowed here is to overcome may_init_module()
CAP_SYS_MODULE check by using call_modprobe() on the user namespace
the commit log should just mention this, and mention that by design
user namespaces have never been intended to allow loading modules, even if
they somehow end up triggering auto-loading of modules via request_module().

If this is true then currently we are enabling auto-loading as a
mistake, and the sysctl is only valuable to prevent regressions with
existing behaviour which should have been disabled from the start.

Is there an example successful exploit which takes avantage of having
a user namespace auto-load a kernel module and that triggers a security
flaw? What's an example of one?

> > What this *could* do is race to force a failure on some other *real*
> > modprobe request we do wish to honor when the above kmod kmod_concurrent_max
> > is triggered.
> 
> How? My new check is done before the kmod_concurrent_max check/critical
> section... the check doesn't cause any more modprobe requests to happen
> in the first place, the only thing it can do is make them exit early.
> There is no way my patch can make this worse.

You are missing my point. My point is that abuse in general over having
a user namespace calling modprobe could cause harm that it can possibly
Denial-of-Service valid requests.

If user namespaces should never have been allowed to even auto-load the
commit log should mention that.

> > So in terms of justification, this commit log needs a bit more work as I
> > just can't see how this alone is fixing any CVE.
> 
> [...]
> 
> > So let's take a step back and think this through. What exaclty and why
> > would this commit fix *any* security issue? Itemizing CVEs won't cut it.
> 
> I can include my explanations above in the changelog if you think that
> will help.

Answering the above questions would help.

  Luis
