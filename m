Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70F6867DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjBAOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjBAOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:02:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D9658F;
        Wed,  1 Feb 2023 06:02:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA694B8217D;
        Wed,  1 Feb 2023 14:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D015C433D2;
        Wed,  1 Feb 2023 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675260138;
        bh=uDz882o8QGjil4P0o9GmH382T/0MD+lojG9404za37U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYPGNJjCvqyJleauxmq4REQ7+lHP5ZiSHxLgN2sSJsFOOYn22/JZPFPt+M2uQ+LiL
         7KT0gbRQZA7kifilH8EazAtYk1yNceiWD6nNmZPHXuiRUb77x4iYiK09jb8AX7WL4u
         yhC4mO9GIKMk2rEdAxTznLl5J/e76ks7Lgz/WU60=
Date:   Wed, 1 Feb 2023 15:02:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <Y9pw59V/CBTxmaoR@kroah.com>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <Y9peNbWUR9JmTJbo@kroah.com>
 <Y9pep+GBBaTiN/sN@kroah.com>
 <3d568611-8119-37c7-7d84-61cb97532446@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d568611-8119-37c7-7d84-61cb97532446@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:22:07PM +0100, Thorsten Leemhuis wrote:
> On 01.02.23 13:44, Greg KH wrote:
> > On Wed, Feb 01, 2023 at 01:42:29PM +0100, Greg KH wrote:
> >> On Wed, Feb 01, 2023 at 12:52:30PM +0100, Thorsten Leemhuis wrote:
> >>> Add a text explaining how to quickly build a kernel, as that's something
> >>> users will often have to do when they want to report an issue or test
> >>> proposed fixes. This is a huge and frightening task for quite a few
> >>> users these days, as many rely on pre-compiled kernels and have never
> >>> built their own. They find help on quite a few websites explaining the
> >>> process in various ways, but those howtos often omit important details
> >>> or make things too hard for the 'quickly build just for testing' case
> >>> that 'localmodconfig' is really useful for. Hence give users something
> >>> at hand to guide them, as that makes it easier for them to help with
> >>> testing, debugging, and fixing the kernel.
> >>
> >> First off, this is great, thanks for doing this.
> 
> Thx, feels good to hear.
> 
> Bisection is next on my todo list once this matured...
> 
> >> One minor comment, to prevent people from "overloading" the
> >> git.kernel.org systems:
> >>
> >>> +.. _sources_sbs:
> >>> +
> >>> + * Retrieve the sources of the Linux version you intend to build; then change
> >>> +   into the directory holding them, as all further commands in this guide are
> >>> +   meant to be executed from there.
> >>> +
> >>> +   If you plan to only build one particular kernel version, download its source
> >>> +   archive from https://kernel.org; afterwards extract its content to '~/linux/'
> >>> +   and change into the directory created during extraction.
> >>> +
> >>> +   In most other situations your best choice is to fetch the sources using git::
> >>> +
> >>> +          git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
> >>> +            ~/linux/sources
> >>> +          cd ~/linux/sources/
> >>
> >> Ideally you should never do a "full clone from scratch" like this, as it
> >> takes up loads of server resources.  The "best" way to do this is to
> >> download the kernel git bundle, and then pull and resolve the remaining
> >> bits.  It's explained, with a script to do the work for you, here:
> >>
> >> 	https://kernel.org/best-way-to-do-linux-clones-for-your-ci.html
> > 
> > Oops, here's the full steps involved:
> > 	https://www.kernel.org/cloning-linux-from-a-bundle.html
> > the first link above has a script that does it all for you, but you
> > probably just want to copy the steps at this last link instead.
> 
> Great idea, thx for bringing this up -- now that you mention it, I
> remember those pages and the script again... :-/
> 
> Sadly my "after cloning Linus tree, add the stable tree as remote and
> fetch everything" approach would will still create a lot of load.

Not really, nothing like doing a "full" clone of the original repo.
It's a much smaller working set that needs to be handled that way on the
server side.

I do this (as do many others) for CI systems, and the primary workload
is on the client resolving the bundle, that can take a bit of time, but
that's all client side, not server.

> I
> could use the script with the stable git repo, as that includes
> mainline; but I noticed it sometimes is not fully up2date. At least I
> once noticed it was quite a few hours (or maybe even a day?) behind. Is
> that normal? I assume you should know.

I think it's generated daily, so yes, it will be a bit out of date, but
that's fine.

> Anyway: maybe "a little bit behind" isn't something that's much of a
> problem for this document.

Adding the remote and doing a pull is good and recommended, so it's fine
if it's a day or so out of date.

thanks,

greg k-h
