Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19767C5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjAZI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAZI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:26:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E146162
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:26:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29D3616D6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FC6C433D2;
        Thu, 26 Jan 2023 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674721564;
        bh=DHfeWeNpJKrZe+qWOWEDwKSe+AnhHeresahYGUERk5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K371VbZRd9aXmLvJUmkZ5jHMJ8qX4WX8hSO5Y1JsZFvV9HnWzrTXRDSciJ0Q8I4Ko
         jLQXDd61hoqz/QoYYVMLIN0T9LNOhmQoJiEHoBB5HebBLJYA81ve4JgdBBUq2xeoaq
         wyHj3OqR3WA/ii2xlkFZ/vWMiBMof5rvTrBy7eN6eEP9db+7Wvh1kA+rmK4Jc20lrH
         /rYq1tZhthzQxjnZhaQJAqH2gMEx/sfD2kTyXCpSD/ceMexyp7yN9SQ+REo9YORAZ+
         4Y+Rm77g91pgJCFHd3Wl2kg6MQqlRlbvKiCKiTKfio0kMa8XBLsDFGPrtqLJy/gC9a
         QSf/Tq2v/AnSw==
Date:   Thu, 26 Jan 2023 09:25:58 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        alexl@redhat.com, peterz@infradead.org, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <20230126082558.bipi5xt26nhrhdtd@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125152847.wr443tggzb3no6mg@senku>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:28:47AM +1100, Aleksa Sarai wrote:
> On 2023-01-24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> > Aleksa Sarai <cyphar@cyphar.com> writes:
> > 
> > > On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> > >> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> > >> processes to hide their own /proc/*/exe file. When this prctl is
> > >> used, every access to /proc/*/exe for the calling process will
> > >> fail with ENOENT.
> > >> 
> > >> This is useful for preventing issues like CVE-2019-5736, where an
> > >> attacker can gain host root access by overwriting the binary
> > >> in OCI runtimes through file-descriptor mishandling in containers.
> > >> 
> > >> The current fix for CVE-2019-5736 is to create a read-only copy or
> > >> a bind-mount of the current executable, and then re-exec the current
> > >> process.  With the new prctl, the read-only copy or bind-mount copy is
> > >> not needed anymore.
> > >> 
> > >> While map_files/ also might contain symlinks to files in host,
> > >> proc_map_files_get_link() permissions checks are already sufficient.
> > >
> > > I suspect this doesn't protect against the execve("/proc/self/exe")
> > > tactic (because it clears the bit on execve), so I'm not sure this is
> > > much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
> > > userns from accessing /proc/$pid/exe but the above attack makes that no
> > > longer that important).
> > 
> > it protects against that attack too.  It clears the bit _after_ the
> > execve() syscall is done.
> > 
> > If you attempt execve("/proc/self/exe") you still get ENOENT:
> > 
> > ```
> > #include <stdlib.h>
> > #include <stdio.h>
> > #include <sys/prctl.h>
> > #include <unistd.h>
> > 
> > int main(void)
> > {
> >         int ret;
> > 
> >         ret = prctl(65, 1, 0, 0, 0);
> >         if (ret != 0)
> >                 exit(1);
> > 
> >         execl("/proc/self/exe", "foo", NULL);
> >         exit(2);
> > }
> > ```
> > 
> > # strace -e prctl,execve ./hide-self-exe
> > execve("./hide-self-exe", ["./hide-self-exe"], 0x7fff975a3690 /* 39 vars */) = 0
> > prctl(0x41 /* PR_??? */, 0x1, 0, 0, 0)  = 0
> > execve("/proc/self/exe", ["foo"], 0x7ffcf51868b8 /* 39 vars */) = -1 ENOENT (No such file or directory)
> > +++ exited with 2 +++
> > 
> > I've also tried execv'ing with a script that uses "#!/proc/self/exe" and
> > I get the same ENOENT.
> 
> Ah, you're right. As you mentioned, you could still do the attack
> through /proc/self/map_files but that would require you to know where
> the binary will be located (and being non-dumpable blocks container
> processes from doing tricks to get the right path).
> 
> I wonder if we should somehow require (or auto-apply) SUID_DUMP_NONE
> when setting this prctl, since it does currently depend on it to be
> properly secure...
> 
> > > I think the only way to fix this properly is by blocking re-opens of
> > > magic links that have more permissions than they originally did. I just
> > > got back from vacation, but I'm working on fixing up [1] so it's ready
> > > to be an RFC so we can close this hole once and for all.
> > 
> > so that relies on the fact opening /proc/self/exe with O_WRONLY fails
> > with ETXTBSY?
> 
> Not quite, it relies on the fact that /proc/self/exe (and any other
> magiclink to /proc/self/exe) does not have a write mode (semantically,
> because of -ETXTBSY) and thus blocks any attempt to open it (or re-open
> it) with a write mode. It also fixes some other possible issues and lets
> you have upgrade masks (a-la capabilities) to file descriptors.
> 
> Ultimately I think having a complete "no really, nobody can touch this"
> knob is also a good idea, and as this is is much simpler we can it in
> much quicker than the magiclink stuff (which I still think is necessary
> in general).

It definitely but let's not tie our generic vfs apis to this problem.
