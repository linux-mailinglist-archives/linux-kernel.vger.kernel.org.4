Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A566A2579
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBYA1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBYA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:27:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0956F03A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:27:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u20so467928pfm.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7imomsGhYVx3/JSl/FyH9/lFO1lKu8iotm2Oy6VkN0w=;
        b=aeKg7DhtLl97cOgt2SUx5er1ahPkr0ANXeTCJenpj/Yyhgk+iDkLe8wPpw9TXXBHdF
         uzNREuvOK8g6z9GPpss98jZmBh33akwkaw8F4wHNCXsGR3PkR52TF8MoL6ESWuWcKDq7
         pOOAGfhiTDnfA1X4PEyCrrvgHWGg0tkvBl3qjXPdViSnDW/YCnt07BaUAGJ3HX3tlJ4o
         Jm0SztEOMb1GSkLjGKx4M6Hv+u3NxWJw8/Uf/81xIZjBMGWvKKFeiq3sph810A4zxrri
         /BfapUw/6qDSCoOT0tpaDT0ppfOOGuVoRo7Q5vb1JQnYuuF7JWu5bsk49JMBrEJMacoR
         +ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7imomsGhYVx3/JSl/FyH9/lFO1lKu8iotm2Oy6VkN0w=;
        b=ogGOlWQhNiVR1SdI58nDQAaQkJVHrtznULeIlyHbCxgpooIFgpPRm+mVoHMo+4+LGq
         Gb1e5mwacXhUDEgEcawex3VSpDv/Exzl2UDnoqtxyWa/Tgqx3cM6ng6iwNHyFS+KQIDE
         YEOLYfqs+egw4QEsAPOx9BrnAVrolMitSWC0+qOWEf5ZR9Lsveh75L3tmJvFvZ1y3eHl
         Y5Jcrnnrb1trLCPP5ZpISQIh0m7m1nhNBDhWxGIbq2ucUgjHkPR7UJR90VMZuLVDASbh
         cKHNKERpPNvbxZoUU8zrIbOydx3hWvqWjlzbt/Lie3XggPNM4hYwf51YhWMSZklB5scp
         V9ZQ==
X-Gm-Message-State: AO0yUKUxKxQ7dnzp1YVgbHP4FzE4qx5KLfJidQEUPOBBRY3Hiym1UTex
        R0xYkTOZJiJ/RLKboJRaUeU=
X-Google-Smtp-Source: AK7set/35G++W+DHFJI+SBH6YN76kPsYA33MUom6cAhbS1azanquMiDSLqkalkke99nXZ1T5CcYBuQ==
X-Received: by 2002:a05:6a00:2302:b0:594:26a7:cbd2 with SMTP id h2-20020a056a00230200b0059426a7cbd2mr1842234pfh.8.1677284842633;
        Fri, 24 Feb 2023 16:27:22 -0800 (PST)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78397000000b0058bca264253sm119518pfm.126.2023.02.24.16.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:27:21 -0800 (PST)
Date:   Fri, 24 Feb 2023 16:27:19 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Larsson <alexl@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <Y/lV53Dc+zwj2dla@gmail.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku>
 <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
 <20230129165812.sqypj6nzam7o33lf@wittgenstein>
 <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
 <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
 <20230130100602.elyvs6oorfzukjwh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230130100602.elyvs6oorfzukjwh@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:06:02AM +0100, Christian Brauner wrote:
> On Mon, Jan 30, 2023 at 10:53:31AM +0100, Christian Brauner wrote:
> > On Sun, Jan 29, 2023 at 01:12:45PM -0500, Colin Walters wrote:
> > > 
> > > 
> > > On Sun, Jan 29, 2023, at 11:58 AM, Christian Brauner wrote:
> > > > On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
> > > >> 
> > > >> 
> > > >> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
> > > >> > 
> > > >> > After reading some comments on the LWN.net article, I wonder if
> > > >> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
> > > >> > namespace or if in this case root should keep the privilege to inspect
> > > >> > the binary of a process.  If a container runs with that many privileges
> > > >> > then it has already other ways to damage the host anyway.
> > > >> 
> > > >> Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.
> > > >
> > > > If this can be circumvented via CAP_SYS_ADMIN 
> > > 
> > > To be clear, I'm proposing CAP_SYS_ADMIN in the current user namespace at the time of the prctl().  (Or if keeping around a reference just for this is too problematic, perhaps hardcoding to the init ns)
> > 
> > Oh no, I fully understand. The point was that the userspace fix protects
> > even against attackers with CAP_SYS_ADMIN in init_user_ns. And that was
> > important back then and is still relevant today for some workloads.
> > 
> > For unprivileged containers where host and container are separate by a
> > meaningful user namespace boundary this whole mitigation is irrelevant
> > as the binary can't be overwritten.
> > 
> > > 
> > > A process with CAP_SYS_ADMIN in a child namespace would still not be able to read the binary.
> > > 
> > > > then this mitigation
> > > > becomes immediately way less interesting because the userspace
> > > > mitigation we came up with protects against CAP_SYS_ADMIN as well
> > > > without any regression risk. 
> > > 
> > > The userspace mitigation here being "clone self to memfd"?  But that's a sufficiently ugly workaround that it's created new problems; see https://lwn.net/Articles/918106/
> > 
> > But this is a problem with the memfd api not with the fix. Following the
> > thread the ability to create executable memfds will stay around. As it
> > should be given how long this has been supported. And they have backward
> > compatibility in mind which is great.
> 
> Following up from yesterday's promise to check with the criu org I'm
> part of: this is going to break criu unforunately as it dumps (and
> restores) /proc/self/exe. Even with an escape hatch we'd still risk
> breaking it. Whereas again, the memfd solution doesn't cause those
> issues.
> 
> Don't get me wrong it's pretty obvious that I was pretty supportive of
> this fix especially because it looked rather simple but this is turning
> out to be less simple than we tought. I don't think that this is worth
> it given the functioning fixes we already have.

btw: can we use PR_SET_MM_EXE_FILE or PR_SET_MM_MAP (prctl_map.exe_fd) to
set a dummy exe. Will it have the required effect?

> 
> The good thing is that - even if it will take a longer - that Aleksa's
> patchset will provide a more general solution by making it possible for
> runc/crun/lxc to open the target binary with a restricted upgrade mask
> making it impossible to open the binary read-write again. This won't
> break criu and will fix this issue and is generally useful.
