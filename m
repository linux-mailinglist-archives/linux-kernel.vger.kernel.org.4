Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013196B7F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCMROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCMRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:13:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F01A496
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727596; x=1710263596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QLskafEFvLVlwwrnVjnRDt+QzueMXvMG+yjfza7ozsQ=;
  b=nZaA/tqFEcpkNSI9N+J9zgcFvJVCPK3EjMKKD3OhjbSv6NDuf4C4dczy
   FWoDiLFNuRQ3tvJbaj3hF81Wtvesi2gHmVff3GpoY9TJce/ldpDdrclD/
   2nhYOlcXBBZviZ6Ny4nVlgBb+ultu2ckv/EKcjZ4JIBaFeBZ11Kng0g3g
   FhkP5E1EVCCjIsrgb8Eb7iF7DmE23DngIjUc3sbVI0nIkVQfi7Zmi87cz
   IQgh0hml6TNG27j3zOZATS5SNdjifogBO4yzvZTNVf+q1E4rmuZ39gvTW
   me4atduu8VJR4zaHyVUpO1sGhVaLM9cPFyzy5EaGWu7+zJw0Sqbw+HkGU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317593651"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317593651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802530321"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802530321"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.61.64])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:12:05 -0700
Date:   Mon, 13 Mar 2023 10:12:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA9ZY91K8iQtn0ev@aschofie-mobl2>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
 <9938109.ZD9C4EEAuf@suse>
 <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:48:43PM +0500, Khadija Kamran wrote:
> On Mon, Mar 13, 2023 at 03:13:01PM +0100, Fabio M. De Francesco wrote:
> > On domenica 12 marzo 2023 18:33:19 CET Khadija Kamran wrote:
> > > Module parameter, read_timeout, can only be set at loading time. As it
> > > can only be modified once, initialize read_timeout once in the probe
> > > function.
> > > As a result, only use read_timeout as the last argument in
> > > wait_event_interruptible_timeout() call.
> > > 
> > > Same goes for write_timeout.
> > > 
> > 
> > Nice idea... But it's not yours :-)
> > 
> > Therefore, you should give credit to Greg with the following tag:
> > 
> > Suggested-by: Greg Kroah-Hartman <...> 
> > 
> > Place the above-mentioned tag a line before the "Signed-off-by:" (which is 
> > always the last line, whatever other tags you might need to add).
> >
> 
> Hey Fabio!
> Thank you for letting me know. I was confused as to where should I
> mention that this change was recommended by Greg.
> 
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > 
> > If this patch was a v4 you should have put a log right here, after the three 
> > dashes, explaining what changed from one release to another, release after 
> > release. Please read some other well formatted and accepted patches for real 
> > world examples of how to write version logs.
> > 
> 
> Okay, got it! I shouldn't have missed it.
> 
> > However, this patch is _not_ a v4 (so no version log is needed after the three 
> > dashes). This is your _first_ patch that addresses Greg's suggested 
> > refactoring. Therefore, just put [PATCH] in the subject line.
> > 
> > That inappropriate "v4" seems to explain the second error showed by the patch-
> > bot. Thus, read carefully its message and ask for further explanations if 
> > something is still unclear.
> > 
> 
> Thank you! It is clear. I will send this again as first_patch. 
> 
> > Thanks,
> > 
> > Fabio
> > 
> > P.S.: The code looks good but I could not apply it in mainline tree. I don't 
> > know whether this patch is somehow broken or the driver's files differ between 
> > the most recent staging tree and mainline.
> > 
> > However, does it work for you on the most recent staging tree? Did you run 
> > checkpatch on your own patch? (I'm also asking this question because of the 
> > first error showed by the patch-bot). Can you git-reset to a previous state 
> > and reapply your own patches to your local work branch?
> > 
> 
> Yes,  I did run checkpatch on my patch as suggested by Dan before. It
> showed errors regarding trailing white spaces. Sorry, I ignored them
> thinking that they were present before in the code. I will correct them
> in the next patch submission.

It sounds like the git commit hook for checkpatch, suggested in
the tutorial, would have saved you here. Please look that up.

Also see the section "Following the Driver commit style"
And, there are sections on revising patchsets too.

Much of the info in the tutorial doesn't make sense until you
need it. So, keep reviewing it to catch more useful info.

More on running checkpatch:
- Add that git commmit hook.
- The final checkpatch run can be on the formatted patches.
  After you've done git format-patch and have a .patch file you
  are thinking of sending, run it again. 

Something like this:
scripts/checkpatch.pl --no-tree --strict --codespellfile=/usr/bin/codespell ~/my_patches/*.patch

> 
> Also, I had one question. Is it okay to write a long subject as I have
> used in this patch? 
This is in the tutorial. section "Following the Driver commit style"

> 
> Regards,
> Khadija
> 
> > >  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > 
> > 
> 
