Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850D5BEC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiITSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiITSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:02:34 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92925F215
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:02:32 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 4A08697B; Tue, 20 Sep 2022 13:02:31 -0500 (CDT)
Date:   Tue, 20 Sep 2022 13:02:31 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <20220920180231.GA31753@mail.hallyn.com>
References: <YvpRLJ79GRWYjLdf@tycho.pizza>
 <20220901140647.1125079-1-tycho@tycho.pizza>
 <YyiEzbTDZ+g9iAas@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyiEzbTDZ+g9iAas@tycho.pizza>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:03:41AM -0600, Tycho Andersen wrote:
> Hi Miklos,
> 
> On Thu, Sep 01, 2022 at 08:06:47AM -0600, Tycho Andersen wrote:
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > In my very light testing this resolves a hang where a thread of the
> > fuse server was accessing the fuse filesystem (the fuse server is
> > serving up), when the fuse server is killed.
> > 
> > The practical problem is that the fuse server file descriptor was
> > being closed after the file descriptor into the fuse filesystem so
> > that the fuse filesystem operations were being blocked for instead of
> > being aborted.  Simply skipping the unnecessary wait resolves this
> > issue.
> > 
> > This is just a proof of concept and someone should look to see if the
> > fuse max_background limit could cause a problem with this approach.

I tried to track this down last week, but it looks to me like since
the max_background is per-connection, this should work as expected
and not affect any other connections.

> > Additionally testing PF_EXITING is a very crude way to tell if someone
> > wants the return code from the vfs flush operation.  As such in the
> > long run it probably makes sense to get some direct vfs support for
> > knowing if flush needs to block until all of the flushing is complete
> > and a status/return code can be returned.
> > 
> > Unless I have missed something this is a generic optimization that can
> > apply to many network filesystems.
> > 
> > Al, vfs folks? (igrab/iput sorted so as not to be distractions).
> > 
> > Perhaps a .flush_async method without a return code and a
> > filp_close_async function without a return code to take advantage of
> > this in the general sense.
> > 
> > Waiting potentially indefinitely for user space in do_exit seems like a
> > bad idea.  Especially when all that the wait is for is to get a return
> > code that will never be examined.
> > 
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > [tycho: small fixups for releasing fuse file + nocred flag]
> > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> > Reported-by: Tycho Andersen <tycho@tycho.pizza>
> > Tested-by: "Serge E. Hallyn" <serge@hallyn.com>
> 
> Any chance you're willing to take this patch? We're still seeing this
> a lot and it would be great to get it fixed.
> 
> Thanks.
> 
> Tycho
