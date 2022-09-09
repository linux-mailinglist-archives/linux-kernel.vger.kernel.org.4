Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635155B3100
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIIHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIIHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:54:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEE46D8F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6560FB82379
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFFCC433B5;
        Fri,  9 Sep 2022 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662709927;
        bh=B707Oq1VZIWz6dE8cYM+R0BLvoFrOBoqg9wu4br0J1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tp9qZjwIFKqgIt//K0WdYbn8iJ3Fd0/I0mTyYAsw04UEyX3SGijgMURm4EPFV+R5y
         sWZ7j7UwvnWXYJ+kc/21MZKFuZysPkz+h8FZ3RnJoKFqSWsmp33uU/Q6wew+cYOtV5
         PctQ2MYWN+EiA9DBHcKiaWhlHi4iudp01xsMxKV2svJxB4pVdFQTb2mkaHXA60Ji8H
         h1Se0zsCt1xTiPQigY00G8DKUjpEDK9KBFMyBIBSnkU8vnVOwGfYyAkco4eBvMh6Z6
         IlTVfiMQTthtd6hjKhkErYC632M+7d8yhK2NtQxh3UqUeTu0QtAvChBQo3lsbthuw0
         2WYSB3tO+j97w==
Date:   Fri, 9 Sep 2022 09:51:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <20220909075158.ed4linrpwwabxabl@wittgenstein>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
 <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
 <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
 <YxjRx3+MipdFOudw@gmail.com>
 <20220908081003.sjuerd5wiyge4jos@wittgenstein>
 <87v8pxa51n.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8pxa51n.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:13:08PM -0500, Eric W. Biederman wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Wed, Sep 07, 2022 at 10:15:51AM -0700, Andrei Vagin wrote:
> >> On Wed, Sep 07, 2022 at 08:33:20AM +0300, Alexey Izbyshev wrote:
> >> > > 
> >> > > That is something to be double checked.
> >> > > 
> >> > > I can't see where it would make sense to unshare a time namespace and
> >> > > then call exec, instead of calling exit.  So I suspect we can just
> >> > > change this behavior and no one will notice.
> >> > > 
> >> > One can imagine a helper binary that calls unshare, forks some children in
> >> > new namespaces, and then calls exec to hand off actual work to another
> >> > binary (which might not expect being in the new time namespace). I'm purely
> >> > theorizing here, however. Keeping a special case for vfork() based only on
> >> > FUD is likely a net negative, so it'd be nice to hear actual time namespace
> >> > users speak up, and switch to the solution you suggested if they don't care.
> >> 
> >> I can speak for one tool that uses time namespaces for the right
> >> reasons. It is CRIU.  When a process is restored, the monotonic and
> >> boottime clocks have to be adjusted to match old values. It is for what
> >> the timens was designed for. These changes doesn't affect CRIU.
> >> 
> >> Honestly, I haven't heard about other users of timens yet. I don't take
> >> into account tools like unshare.
> >
> > LXC/LXD does
> >
> > unshare(CLONE_NEWTIME)
> > // write offsets to /proc/self/timens_offsets
> > timens_fd = open("/proc/self/ns/time_for_children", O_RDONLY | O_CLOEXEC)
> > setns(timens_fd, CLONE_NEWTIME)
> > exec(payload)
> >
> > so I agree don't change the uapi, please.
> >
> > But as you can see what we do is basically emulating changing time
> > namespace during exec via the setns() prior to the exec call.
> 
> If I understand the description of lxc/lxd correctly the proposed change
> will not effect lxc/lxd, as the time namespace is already installed
> before exec.  If anything what is proposed would potentially allow
> lxc/lxd to be simplified in the future by removing the setns.
> 
> Are you then requesting the behavior of the time namespace not change
> when the proposed change will not effect lxc/lxd?

Don't change /proc/self/ns/time_for_children to a different name.
As stated above the proposed exec behavior we currently clearly emulate
in userspace. So that part is fine.
