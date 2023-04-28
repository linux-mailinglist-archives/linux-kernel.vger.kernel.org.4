Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680346F1144
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjD1FMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD1FMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AE270A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8ED863DA7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C26C433D2;
        Fri, 28 Apr 2023 05:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682658752;
        bh=DhCCN/+Mv7LdBSrGrD3rhW6i08LYvc7UAwLhwOx63ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJkrCiTgjLYfbI1lnlSeAsfy5CiLQPyTrWuMqwxyvk7P4+mvzQ8stVKOCJDFkgMG2
         d/gDLR9eO/nkhUXd6HlmpIr0Qzebz4aVpfyjfbGbhC244exeF3g9VJJRKV1yodqzxS
         GeeyjSItTMVaDGFqL47t/CkNFzBVYSPJYN8dLOUA=
Date:   Fri, 28 Apr 2023 07:12:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core updates for 6.4-rc1
Message-ID: <ZEtVvK6LTQHw6Onu@kroah.com>
References: <ZEqEx7C2iuApvrvt@kroah.com>
 <CAHk-=wjcvp-JxG2PW7TF6HV2h1xx2_2SMh_HGNZuEpK0CtNTww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjcvp-JxG2PW7TF6HV2h1xx2_2SMh_HGNZuEpK0CtNTww@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:31:39PM -0700, Linus Torvalds wrote:
> On Thu, Apr 27, 2023 at 7:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Once again, a busy development cycle, with lots of changes happening in
> > the driver core in the quest to be able to move "struct bus" and "struct
> > class" into read-only memory, a task now complete with these changes.
> 
> Well, this also caused a build failure, and I didn't catch it during
> the merge, because it only happened on arm64.
> 
> The reason it only happens on arm64 is that it is in the CDX bus
> driver, and that one has
> 
>         depends on OF && ARM64
> 
> despite apparently building fine on x86-64 too if you were to just add
> a "|| COMPILE_TEST" to it.
> 
> And I did notice this build failure eventually, since I do arm64
> builds on my M2 Macbook Air. But while it's a perfectly cromulent
> laptop, it's not like it's a speed daemon. It takes something like ~75
> minutes for afull allmodconfig build, so certainly not between each
> pull request.
> 
> End result: my merge test builds are all done on x86-64, and the arm64
> test builds happen much less regularly (ie: typically a couple of
> times a day).
> 
> I did the obvious fixup, but I can only assume (and hope) that this
> was caught by somebody else during the merge window, and that
> 
> > All of these have been in linux-next for a while with no reported
> > problems.
> 
> was just a lie.

Sorry about that, on it's own, it was fine, but merged with the
char-misc tree, there was a build issue, I had forgotten all about that.
I know we had already resolved one issue with merging this tree with the
DRM tree by reworking the DRM tree in advance, and that had pushed this
instance out of my memory.

In the future, how do you want stuff like "when this is merged with that
tree, something needs to be done" type of things to be pointed out?
linux-next keeps resolution patches around, do you want just a pointer
to that to make things easier?

And thanks for the fixup, it looks correct.

greg k-h
