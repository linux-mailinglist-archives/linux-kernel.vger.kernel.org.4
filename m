Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAFD680A62
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjA3KGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjA3KGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F217CCA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8E85B80E99
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6441C433D2;
        Mon, 30 Jan 2023 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675073168;
        bh=rigHgfOVSJIsFEtBHXdBGAhHpFC2r19tx65r3TtKhQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzhUr8a5YBoFuAqyVrhgxG4rtuvhnhVdEI9OlOiA6wj/mHuYzsKFaVBjRAjhfSmFo
         ASAU6dw6Si0NIAbks9o59QRKUM63WmIpZcN8skxeqMvntQhaGmf3sEw4u+YTmjytXe
         emKNRGZ69zVs4tsBCnXSVHjc51eJNlpov6UutpFbDFPJZJm8kUuUBMZRL3kGwrJCS/
         5S4Ey/3qembMoJngjZhrr5jU3gAKgAa0Nfg/upvXjD0zwxl7Zn1A3EwmoKpVtFlPwE
         HNJ+cr15WBynVqyjAH1nVC6c7Aqy/0T7+ZzLRerJHnQKk7RfwgrrPFzJwr7gH4HKwu
         /cTR9o5FeNJ1Q==
Date:   Mon, 30 Jan 2023 11:06:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Larsson <alexl@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <20230130100602.elyvs6oorfzukjwh@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku>
 <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
 <20230129165812.sqypj6nzam7o33lf@wittgenstein>
 <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
 <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:53:31AM +0100, Christian Brauner wrote:
> On Sun, Jan 29, 2023 at 01:12:45PM -0500, Colin Walters wrote:
> > 
> > 
> > On Sun, Jan 29, 2023, at 11:58 AM, Christian Brauner wrote:
> > > On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
> > >> 
> > >> 
> > >> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
> > >> > 
> > >> > After reading some comments on the LWN.net article, I wonder if
> > >> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
> > >> > namespace or if in this case root should keep the privilege to inspect
> > >> > the binary of a process.  If a container runs with that many privileges
> > >> > then it has already other ways to damage the host anyway.
> > >> 
> > >> Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.
> > >
> > > If this can be circumvented via CAP_SYS_ADMIN 
> > 
> > To be clear, I'm proposing CAP_SYS_ADMIN in the current user namespace at the time of the prctl().  (Or if keeping around a reference just for this is too problematic, perhaps hardcoding to the init ns)
> 
> Oh no, I fully understand. The point was that the userspace fix protects
> even against attackers with CAP_SYS_ADMIN in init_user_ns. And that was
> important back then and is still relevant today for some workloads.
> 
> For unprivileged containers where host and container are separate by a
> meaningful user namespace boundary this whole mitigation is irrelevant
> as the binary can't be overwritten.
> 
> > 
> > A process with CAP_SYS_ADMIN in a child namespace would still not be able to read the binary.
> > 
> > > then this mitigation
> > > becomes immediately way less interesting because the userspace
> > > mitigation we came up with protects against CAP_SYS_ADMIN as well
> > > without any regression risk. 
> > 
> > The userspace mitigation here being "clone self to memfd"?  But that's a sufficiently ugly workaround that it's created new problems; see https://lwn.net/Articles/918106/
> 
> But this is a problem with the memfd api not with the fix. Following the
> thread the ability to create executable memfds will stay around. As it
> should be given how long this has been supported. And they have backward
> compatibility in mind which is great.

Following up from yesterday's promise to check with the criu org I'm
part of: this is going to break criu unforunately as it dumps (and
restores) /proc/self/exe. Even with an escape hatch we'd still risk
breaking it. Whereas again, the memfd solution doesn't cause those
issues.

Don't get me wrong it's pretty obvious that I was pretty supportive of
this fix especially because it looked rather simple but this is turning
out to be less simple than we tought. I don't think that this is worth
it given the functioning fixes we already have.

The good thing is that - even if it will take a longer - that Aleksa's
patchset will provide a more general solution by making it possible for
runc/crun/lxc to open the target binary with a restricted upgrade mask
making it impossible to open the binary read-write again. This won't
break criu and will fix this issue and is generally useful.
