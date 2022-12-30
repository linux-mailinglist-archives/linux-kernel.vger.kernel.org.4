Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48865957B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiL3GjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3GjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:39:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF231186A0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2006161A2D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 06:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371DAC433EF;
        Fri, 30 Dec 2022 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672382357;
        bh=q8wxwX0wZcFLGiE0Owq5Y55vjOPnnvuF0IJnjlUHQQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1QqX7mvBwvtYiYgzlRKkx5+AdvXwNKskV3hb9gbn7BlLtvHHgNkDaGINPa0KOFTp
         Kz6m0liioTY55DRPiX80Ya8/CZqDPG++A9ZtT85jub05Eo90wr0krBVKPsGgCnFCqB
         p4zmHmuBtRHIUAEwecBLrnlOtbU53Y+XKWpkBPwzkUGwZW+BZoP0fh11FtIJuRQZhT
         ECO5b15lPjeo7pMZVkHwuCVuNDp5XD0qn8Dj7XVcGsUKBxDGXtCRGdKHTfWH34aJTU
         tmgTufFBfcLc3p8nCHk2RYwoeub31f0ynX4EjSQQC8IyWDvoLZ2IYKWrjpxUs31mJ6
         jmaQLdRjXK5Yw==
Date:   Thu, 29 Dec 2022 22:39:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        F2FS Development <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Fwd: f2fs write error Linux v6.2
Message-ID: <Y66Hk6waTeXQDz1/@sol.localdomain>
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me>
 <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
 <CAAJw_Zv0iBg4rkzxQ2UOOLS9JQZ4cCmM7gSoDXec_gm-GggB6A@mail.gmail.com>
 <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 06:56:36AM +0100, Thorsten Leemhuis wrote:
> On 30.12.22 05:04, Jeff Chua wrote:
> > On 12/24/22 19:43, Bagas Sanjaya wrote:
> >> On Sat, Dec 24, 2022 at 01:48:55PM +0800, Jeff Chua wrote:
> >>> Got the following error in latest linux-6.2-git with just vim (:w
> >>> file1). No problem with linux-6.1.1
> > 
> > What happened to the f2fs developers? No response from anyone yet.
> 
> Well, that indeed is unfortunate and ideally shouldn't happen, but the
> simple reality is: that can happen this time of the year due to this
> thing called "festive season".
> 
> > Am
> > I the only one facing this? Linux-6.2 is unusable until this is fixed.
> > What can I do to help?
> 
> The usual: bisect the issue, as then (a) we know exactly which developer
> caused it, (b) which subsystem/maintainer is responsible (issues in a fs
> might be caused by the VFS, block layer, mm, ...), and (c) might be able
> to quickly revert that culprit, even if the people normally responsible
> are MIA for some reason.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
> 

FWIW, I've tested f2fs on mainline in the last few days, and I haven't seen
this.  The following works fine, for example:

    mkfs.f2fs -f /dev/vdb
    mount /dev/vdb /mnt
    vim
    # write something, then ':w /mnt/file'

If you could provide the mkfs and mount options you are using, and any other
relevant details, that would be helpful.  Bisection would also be very helpful,
as Thorsten mentioned.

- Eric
