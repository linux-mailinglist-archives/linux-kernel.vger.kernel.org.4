Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83226A5ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjB1OUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjB1OUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83B2312D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNviAByVz8Habxn9AnMKkGvfHVR6171aneQPYKUhvx0=;
        b=hSwri2PBmPo1/UmNcz1zXaGWyaaCUKH3ZFSer+2s9GDg+mAjyb4g7InJDOjmXbRyP50Nmi
        ZzUOHLJ1W70jXxlFc7Z67z1gaiyxf4ON44WOxIUFd1N7h3Y50nC57/QJpnM2ew8p+09+on
        YQ6r4KwHRSCeUrCPv4/2bKvSLaH2b0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-vR58EcWIO9SfVbE9rnyOIg-1; Tue, 28 Feb 2023 09:19:36 -0500
X-MC-Unique: vR58EcWIO9SfVbE9rnyOIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D448858F09;
        Tue, 28 Feb 2023 14:19:35 +0000 (UTC)
Received: from localhost (unknown [10.39.194.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1EF404BEC5;
        Tue, 28 Feb 2023 14:19:34 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Larsson <alexl@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
References: <20230120102512.3195094-1-gscrivan@redhat.com>
        <20230124015348.6rvic5g6ymsfvj4e@senku> <87h6wgcrv6.fsf@redhat.com>
        <20230125152847.wr443tggzb3no6mg@senku> <871qnibmqa.fsf@redhat.com>
        <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
        <20230129165812.sqypj6nzam7o33lf@wittgenstein>
        <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
        <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
        <20230130100602.elyvs6oorfzukjwh@wittgenstein>
        <Y/lV53Dc+zwj2dla@gmail.com>
Date:   Tue, 28 Feb 2023 15:19:32 +0100
In-Reply-To: <Y/lV53Dc+zwj2dla@gmail.com> (Andrei Vagin's message of "Fri, 24
        Feb 2023 16:27:19 -0800")
Message-ID: <871qm96fez.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:

> On Mon, Jan 30, 2023 at 11:06:02AM +0100, Christian Brauner wrote:
>> On Mon, Jan 30, 2023 at 10:53:31AM +0100, Christian Brauner wrote:
>> > On Sun, Jan 29, 2023 at 01:12:45PM -0500, Colin Walters wrote:
>> > >
>> > >
>> > > On Sun, Jan 29, 2023, at 11:58 AM, Christian Brauner wrote:
>> > > > On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
>> > > >>
>> > > >>
>> > > >> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
>> > > >> >
>> > > >> > After reading some comments on the LWN.net article, I wonder if
>> > > >> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
>> > > >> > namespace or if in this case root should keep the privilege to inspect
>> > > >> > the binary of a process.  If a container runs with that many privileges
>> > > >> > then it has already other ways to damage the host anyway.
>> > > >>
>> > > >> Right, that's what I was trying to express with the "make it
>> > > >> work the same as map_files".  Hiding the entry entirely even
>> > > >> for initial-namespace-root (real root) seems like it's going
>> > > >> to potentially confuse profiling/tracing/debugging tools for
>> > > >> no good reason.
>> > > >
>> > > > If this can be circumvented via CAP_SYS_ADMIN
>> > >
>> > > To be clear, I'm proposing CAP_SYS_ADMIN in the current user
>> > > namespace at the time of the prctl().  (Or if keeping around a
>> > > reference just for this is too problematic, perhaps hardcoding
>> > > to the init ns)
>> >
>> > Oh no, I fully understand. The point was that the userspace fix protects
>> > even against attackers with CAP_SYS_ADMIN in init_user_ns. And that was
>> > important back then and is still relevant today for some workloads.
>> >
>> > For unprivileged containers where host and container are separate by a
>> > meaningful user namespace boundary this whole mitigation is irrelevant
>> > as the binary can't be overwritten.
>> >
>> > >
>> > > A process with CAP_SYS_ADMIN in a child namespace would still not be able to read the binary.
>> > >
>> > > > then this mitigation
>> > > > becomes immediately way less interesting because the userspace
>> > > > mitigation we came up with protects against CAP_SYS_ADMIN as well
>> > > > without any regression risk.
>> > >
>> > > The userspace mitigation here being "clone self to memfd"?  But that's a sufficiently ugly workaround that it's created new problems; see https://lwn.net/Articles/918106/
>> >
>> > But this is a problem with the memfd api not with the fix. Following the
>> > thread the ability to create executable memfds will stay around. As it
>> > should be given how long this has been supported. And they have backward
>> > compatibility in mind which is great.
>>
>> Following up from yesterday's promise to check with the criu org I'm
>> part of: this is going to break criu unforunately as it dumps (and
>> restores) /proc/self/exe. Even with an escape hatch we'd still risk
>> breaking it. Whereas again, the memfd solution doesn't cause those
>> issues.
>>
>> Don't get me wrong it's pretty obvious that I was pretty supportive of
>> this fix especially because it looked rather simple but this is turning
>> out to be less simple than we tought. I don't think that this is worth
>> it given the functioning fixes we already have.
>
> btw: can we use PR_SET_MM_EXE_FILE or PR_SET_MM_MAP (prctl_map.exe_fd) to
> set a dummy exe. Will it have the required effect?

if I am understanding it correctly, that seems a bit more complicated,
we first need to unmap the current executable and then replace it with
its copy?

Creating the dummy exe could also be a problem since we need a new copy
each time we want to hide the executable.

Or are you suggesting using it differently?

Thanks,
Giuseppe

>> The good thing is that - even if it will take a longer - that Aleksa's
>> patchset will provide a more general solution by making it possible for
>> runc/crun/lxc to open the target binary with a restricted upgrade mask
>> making it impossible to open the binary read-write again. This won't
>> break criu and will fix this issue and is generally useful.

