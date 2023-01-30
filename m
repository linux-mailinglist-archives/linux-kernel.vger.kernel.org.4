Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454E66809FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjA3Jxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjA3Jxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:53:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF084C25
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:53:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFADB60F08
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C339C433EF;
        Mon, 30 Jan 2023 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675072411;
        bh=fod0UtQt3Fp1Ruoeyfec2DCmzd/K/Wzjg3StZGxV4UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiuGrwp4WZuypvM/R9GXfsF551Cm95PbrBkqmcUlRwkRaTP33N/Or5iB6X3GYaqHQ
         9zN/60G6n1gcgoyO004OMvCnd/EkbZFCYJz+7M8RTXrMz7IawNNQiNohlSlwLQF+hd
         aLgn9xHEYPKqhpwWoZP7qArvoE2eoVi+DHaTHkLSFmSlFQyPoaZCLYmThHO70UQf14
         VJv28Xznk5wi/0wc6Q0dL4vcj7O2YCxiABHo7aBRYGrjoGMghXQaQGkPmKwH4JGs5Y
         u102u4KNuHMqzlRfmKkZQY5smOEoHxEghtk0FblPLvHAZ+ZEApQqp7PJF5jCX7sMG8
         fMgx+Z2No0ioQ==
Date:   Mon, 30 Jan 2023 10:53:24 +0100
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
Message-ID: <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku>
 <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
 <20230129165812.sqypj6nzam7o33lf@wittgenstein>
 <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 01:12:45PM -0500, Colin Walters wrote:
> 
> 
> On Sun, Jan 29, 2023, at 11:58 AM, Christian Brauner wrote:
> > On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
> >> 
> >> 
> >> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
> >> > 
> >> > After reading some comments on the LWN.net article, I wonder if
> >> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
> >> > namespace or if in this case root should keep the privilege to inspect
> >> > the binary of a process.  If a container runs with that many privileges
> >> > then it has already other ways to damage the host anyway.
> >> 
> >> Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.
> >
> > If this can be circumvented via CAP_SYS_ADMIN 
> 
> To be clear, I'm proposing CAP_SYS_ADMIN in the current user namespace at the time of the prctl().  (Or if keeping around a reference just for this is too problematic, perhaps hardcoding to the init ns)

Oh no, I fully understand. The point was that the userspace fix protects
even against attackers with CAP_SYS_ADMIN in init_user_ns. And that was
important back then and is still relevant today for some workloads.

For unprivileged containers where host and container are separate by a
meaningful user namespace boundary this whole mitigation is irrelevant
as the binary can't be overwritten.

> 
> A process with CAP_SYS_ADMIN in a child namespace would still not be able to read the binary.
> 
> > then this mitigation
> > becomes immediately way less interesting because the userspace
> > mitigation we came up with protects against CAP_SYS_ADMIN as well
> > without any regression risk. 
> 
> The userspace mitigation here being "clone self to memfd"?  But that's a sufficiently ugly workaround that it's created new problems; see https://lwn.net/Articles/918106/

But this is a problem with the memfd api not with the fix. Following the
thread the ability to create executable memfds will stay around. As it
should be given how long this has been supported. And they have backward
compatibility in mind which is great.
