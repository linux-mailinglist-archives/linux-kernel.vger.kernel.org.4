Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429360B96B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiJXUK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiJXUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8DA3FD4E;
        Mon, 24 Oct 2022 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ClFXQ2ZV+/bUAkDKi3L3kqgvjLxDWp28fevK+TjwY4=; b=YFSBuedRQn0SpGar9nbdXYgH5a
        CcVomkH518IsRXGet4aBAoBBuxqB74Str+VlfykjoqT2QGKvGJ3XaWHG64HvelnlEGBwCrndej52R
        5aUqQ4fq4HjyKb5aJcjXGFKS2/bNziO9e7DKtwCZjzJokKjXSfD2wqez70Kxz+zYkWSv3lYA5mAMo
        xQ+beImqYflDnVnLuiJdr/v1OhEiOE/1jSDuQnr+KUTlBwgdsEwsbWJ+jTU0rLK7T/PrPEnKeRpM5
        bkaAeT7a41jTCN7oW2EpWLO5CsfKQbbNWEfGyfrmB+LmpxHDfA3o35BSGzQrlr9GMS8T+0VD32dQc
        l59MKpcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on0vs-002Qz6-Te; Mon, 24 Oct 2022 17:08:12 +0000
Date:   Mon, 24 Oct 2022 10:08:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y1bGfG9p4Nauk/RA@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
 <Y1D2kFy+I8dgDkll@alley>
 <848276b0-f038-565a-cad1-30a0531cc851@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848276b0-f038-565a-cad1-30a0531cc851@redhat.com>
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

On Mon, Oct 24, 2022 at 09:22:35AM -0400, Prarit Bhargava wrote:
> On 10/20/22 03:19, Petr Mladek wrote:
> > On Tue 2022-10-18 15:53:03, Prarit Bhargava wrote:
> > > On 10/18/22 14:33, Luis Chamberlain wrote:
> > > > On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> > > > > The patch does address a regression observed after commit 6e6de3dee51a
> > > > > ("kernel/module.c: Only return -EEXIST for modules that have finished
> > > > > loading"). I guess it can have a Fixes tag added to the patch.
> > > > > 
> > > > > I think it is hard to split this patch into parts because the implemented
> > > > > "optimization" is the fix.
> > > > 
> > > > git describe --contains 6e6de3dee51a
> > > > v5.3-rc1~38^2~6
> > > > 
> > > > I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> > > > right thing to do, but without it, it still leaves the issue reported
> > > > by Prarit Bhargava. We need a way to resolve the issue on stable and
> > > > then your optimizations can be applied on top.
> > > > 
> > > > Prarit Bhargava, please review Petry's work and see if you can come up
> > > > with a sensible way to address this for stable.
> > > 
> > > I found the original thread surrounding these changes and I do not think
> > > this solution should have been committed to the kernel.  It is not a good
> > > solution to the problem being solved and adds complexity where none is
> > > needed IMO.
> > > 
> > > Quoting from the original thread,
> > > 
> > > > 
> > > > Motivation for this patch is to fix an issue observed on larger machines with
> > > > many CPUs where it can take a significant amount of time during boot to run
> > > > systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
> > > > active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
> > > > attempt to load these modules too. The operation will eventually fail in the
> > > > init function of a respective module where it gets recognized that another
> > > > cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
> > > > is triggered for each CPU and so multiple loads of these modules will be
> > > > present. The current code then processes all such loads individually and
> > > > serializes them with the barrier in add_unformed_module().
> > > > 
> > > 
> > > The way to solve this is not in the module loading code, but in the udev
> > > code by adding a new event or in the userspace which handles the loading
> > > events.
> > > 
> > > Option 1)
> > > 
> > > Write/modify a udev rule to to use a flock userspace file lock to prevent
> > > repeated loading.  The problem with this is that it is still racy and still
> > > consumes CPU time repeated load the ELF header and, depending on the system
> > > (ie a large number of cpus) would still cause a boot delay.  This would be
> > > better than what we have and is worth looking at as a simple solution.  I'd
> > > like to see boot times with this change, and I'll try to come up with a
> > > measurement on a large CPU system.
> > 
> > This sounds like a ping-pong between projects where to put the
> > complexity. Honestly, I think that it would be more reliable if
> > we serialized/squashed parallel loads on the kernel side.
> > 
> 
> Well, that's the world we live in.  Module loading ping pongs between udev
> and the kernel.

You are missing the point. Think of stable first. Upgrading udev is not
an option.

Yes ou can think of optimizations later that udev can do, and should
perhaps do, but that's beyond the scope of the fix needed here. kmod
(the library which modprobe now uses) can / probably already has a
lookup for modules prior to issuing a new request. But even then, we
cannot assume all users user kmod (think android). Anything can request
a new module and we should do what is sensible in-kernel.

I'd like to see us think about stable first here.

  Luis
