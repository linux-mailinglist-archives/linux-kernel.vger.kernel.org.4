Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E75F2CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiJCJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJCJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A582CE2F;
        Mon,  3 Oct 2022 01:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58DBB60FAF;
        Mon,  3 Oct 2022 08:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9D4C433D6;
        Mon,  3 Oct 2022 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664787341;
        bh=taK4aXEwLH+Sy6xcAfVK7IAuQnHdGd80trTzKvGYIzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLrXTfyDqwMNI4s/jHRcRBIt1MK05xlnE2fiw3552IKcarSb/tqgD502dtfzqWXLG
         +qPTq0SC+ipDehsfnrvRjc4drCzpLE+lhx+gEo+hYxUf4F9m04hzJ/qGIBYBLEiSh9
         klvIVJV+PXQ/hs9cvBvm4vurP/zcEQSWz284shNkzo0xuR5x5zxdwo1vTI6vbRqiYJ
         dyoID6HOCD/0DeZgC/o8+KfDSL6gnF9gmeDrd9/2Jr+AfMPXTXhEAa4VmMo2v19TvI
         bQTYVHblziqUiyeyjIEpJ6Ln+mIJLzgjxM4zK3ZfIsnsYjvZQfZAh6sZ8bVcz91LKO
         CvA68Ct1Dut0w==
Date:   Mon, 3 Oct 2022 11:55:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzqjfU66alRlGk5y@kernel.org>
References: <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:41:08AM +0000, Artem S. Tashkinov wrote:
> 
> 
> On 10/2/22 23:04, Al Viro wrote:
> > On Sun, Oct 02, 2022 at 10:20:40PM +0000, Artem S. Tashkinov wrote:
> > 
> > > Bugzilla hasn't been updated in a very long time so it's missing both
> > > mailing lists and individual kernel developers.
> > > 
> > > AFAIK, some pieces of kernel have no appropriate mailing lists at all.
> > > What about that? I've no clue.
> > 
> > There's that file, right in the root of the source tree.  Called "MAINTAINERS",
> > in all-caps...  Could have something to do with locating maintainers, could it not?
> > 
> > > Opt-in will work, except I've no idea how to make it work. Mass email
> > > all the kernel developers and politely invite them to sign up? Most will
> > > simply ignore it.
> > 
> > Sigh...   You really don't seem to appreciate just how deep a septic
> > tank you've jumped into with your combination of "it should be opt-out"
> > and "but unsubscribing takes just a minute, what are you unhappy about?!?"
> > 
> > Maybe you are not using email a lot, but for just about everyone who does...
> > We have heard that.  Many, many times.  From many sources - spammers,
> > "legitimate" companies' marketing departments, etc.
> > 
> > And you keep moving along the same track - the usual reaction of some
> > company after having pulled back a bloody stump and enjoyed the pile of
> > explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
> > is along the lines of "OK, we'll just spam everyone in our database once
> > and ask them to opt-in - that must be OK, right?"
> 
> Being on bugzilla does _not_ mean you'll receive a single email unless
> someone _specifically_ CC's you.

If I'm not mistaken, bugzilla lets CC people explicitly. How the database
of emails in bugzilla would help choosing the right people to CC better
than MAINTAINERS?

You repeated multiple times that bug reports sent to the mailing lists are
ignored, but what will make emails from bugzilla different from those bug
reports? Why do you think they will get more attention? 
 
> Anyways, Bugzilla is bad but it surely works. Let's have 100+ more
> interchanges inventing something most users (for whom Bugzilla exists -
> which people here keep forgetting all the time) will a have hard time
> working with.

You keep repeating that bugzilla is better then email, but the major point
here is not the tools, but the lack of resources to deal with initial
triage of the bugs and holding users' hand to get a meaningful report.
Until that changes, there is no point in trying to add more people CC'ed on
bugzilla reports. They won't be handled unless somebody would want to take
care of them and forcing people to receive these reports won't make anybody
more willing to help.
 
> Regards,
> Artem
> 

-- 
Sincerely yours,
Mike.
