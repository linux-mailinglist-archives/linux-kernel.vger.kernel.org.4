Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C426C376B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCUQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:52:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B12748A;
        Tue, 21 Mar 2023 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MKu5xGf+iyVxyePgE1Qwoc1lgqQyupd6nJfU1vNsuUk=; b=T1EQvoV8a2/05HZvpYXICqz/4A
        R+sCkx+CFLviyxi/N0xnBqHDK3wgftEaQWiF38noy0lJeuYI20PCOVxtk4OjUDjAUgOEEjWxKOhx0
        IVNjApwhYkSWV0Es1XAqVMGS+/y7NfYrihU+TSrfmCaIxn7+MA3C3SaSzjuJN7yO1/EDKvE5F/X3G
        7wHO/oivXz2zsbDEdYucTwyV4GvyZLk4c0XUF7CUyuPf9mb1MutOEMC9t3J98vjQJPGCXYlzql4S2
        OB+MqnTngV93Escl4VzzcBsq7oAIQzGHMamwlIGQvQL4dw1KAXgutvcbzKbDibcY/uElRrLm8kUrF
        HM9WWB9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pefDu-00D8We-0Y;
        Tue, 21 Mar 2023 16:52:34 +0000
Date:   Tue, 21 Mar 2023 09:52:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBng0qnm/ADtSTBQ@bombadil.infradead.org>
References: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <eaa75ce0-7064-7919-0e72-6bb4ccc5d0d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa75ce0-7064-7919-0e72-6bb4ccc5d0d6@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:11:27PM +0100, David Hildenbrand wrote:
> On 20.03.23 22:23, Luis Chamberlain wrote:
> > On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
> > > On 20.03.23 22:09, Luis Chamberlain wrote:
> > > > On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
> > > > > On 20.03.23 10:38, David Hildenbrand wrote:
> > > > > > On 18.03.23 01:11, Luis Chamberlain wrote:
> > > > > > > On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
> > > > > > > > On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
> > > > > > > > > On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
> > > > > > > > > > I expect to have a machine (with a crazy number of CPUs/devices) available
> > > > > > > > > > in a couple of days (1-2), so no need to rush.
> > > > > > > > > > 
> > > > > > > > > > The original machine I was able to reproduce with is blocked for a little
> > > > > > > > > > bit longer; so I hope the alternative I looked up will similarly trigger the
> > > > > > > > > > issue easily.
> > > > > > > > > 
> > > > > > > > > OK give this a spin:
> > > > > > > > > 
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
> > > > > > > 
> > > > > > > Today I am up to here:
> > > > > > > 
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
> > > > > > > 
> > > > > > > The last patch really would have no justification yet at all unless it
> > > > > > > does help your case.
> > > > > > 
> > > > > > Still waiting on the system (the replacement system I was able to grab
> > > > > > broke ...).
> > > > > > 
> > > > > > I'll let you know once I succeeded in reproducing + testing your fixes.
> > > > > 
> > > > > Okay, I have a system where I can reproduce.
> > > > > 
> > > > > Should I give
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
> > > > > 
> > > > > from yesterday a churn?
> > > > 
> > > > Yes please give that a run.
> > > 
> > > Reproduced with v6.3.0-rc1 (on 1st try)
> > 
> > By reproduced, you mean it fails to boot?
> 
> It boots but we get vmap allocation warnings, because the ~440 CPUs manage
> to completely exhaust the module vmap area due to KASAN.

Thanks, can you post a trace?

> > > Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
> > 
> > Oh wow, so to clarify, it boots OK?
> 
> It boots and I don't get the vmap allocation warnings.

Wonderful!

Now to zero if all commits are required, and measure small value-add 
for each of them. That is the hard part and thanks for any time you
can help dedicate towards that.

There's really only 3 functional changes we need to measure:

In the 20230319-module-alloc-opts-adjust branch they are left towards
the end, in history, the top being the most recent commit:

600f1f769d06 module: add a sanity check prior to allowing kernel module auto-loading
680f2c1fff2d module: use list_add_tail_rcu() when adding module
6023a6c7d98c module: avoid allocation if module is already present and ready

My guess is the majority of the fix comes from the last commit, so
commit 6023a6c7d98c ("module: avoid allocation if module is already
present and ready").

The rcu one probably doesn't help much but I think it makes sense while
we're at it.

The last one is the one I'm less convinced makes sense. But *if* it does
help, it means such finit_module() situations / stresses are much larger
than we ever anticipated.

> > > > Please collect systemd-analyze given lack of any other tool to evaluate
> > > > any deltas. Can't think of anything else to gather other than seeing if
> > > > it booted.
> > > 
> > > Issue is that some services (kdump, tuned) seem to take sometimes ages on
> > > that system to start for some reason,
> > 
> > How about disabling that?
> 
> It seems to be random services. On my debug kernel with KASAN everything is
> just super slow. I'll try to measure on a !debug kernel.

Got it thanks!

  Luis
