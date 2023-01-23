Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40399678B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjAWWzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAWWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A005012F2A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674514502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIvo/zWu9LTvVe+n5RcGE99BoviIZX76AA5pr3c1PLk=;
        b=LcJ+pCjTmOiqtfXEotaCM86ne9eaaeVPUogln//Jn1xU0FFXvMNe7z8mXSCbDiLkuvf8gG
        waiCrzBwi0JcAWdIJ79l9HwhrgN7hGVCcyahEnHaR369kmQnCBcTgYLmC5swSHY6LT9n4X
        N1rwfB8Ba++f0v6Z9M5/knFvuA6xkhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-hmHGoLRlPzCI7H3gBpvoSw-1; Mon, 23 Jan 2023 17:54:59 -0500
X-MC-Unique: hmHGoLRlPzCI7H3gBpvoSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A37ED886461;
        Mon, 23 Jan 2023 22:54:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C29492C3C;
        Mon, 23 Jan 2023 22:54:57 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     "Colin Walters" <walters@verbum.org>
Cc:     linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
        bristot@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        brauner@kernel.org, "Aleksa Sarai" <cyphar@cyphar.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
References: <20230120102512.3195094-1-gscrivan@redhat.com>
        <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com>
        <874jshdpl3.fsf@redhat.com>
        <3839bced-74f7-4afb-8068-c1cdde7b61fe@app.fastmail.com>
Date:   Mon, 23 Jan 2023 23:54:56 +0100
In-Reply-To: <3839bced-74f7-4afb-8068-c1cdde7b61fe@app.fastmail.com> (Colin
        Walters's message of "Mon, 23 Jan 2023 17:07:13 -0500")
Message-ID: <87mt68dfpb.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Colin Walters" <walters@verbum.org> writes:

> On Mon, Jan 23, 2023, at 2:21 PM, Giuseppe Scrivano wrote:
>> "Colin Walters" <walters@verbum.org> writes:
>>
>>> On Fri, Jan 20, 2023, at 5:25 AM, Giuseppe Scrivano wrote:
>>>> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
>>>> processes to hide their own /proc/*/exe file. When this prctl is
>>>> used, every access to /proc/*/exe for the calling process will
>>>> fail with ENOENT.
>>>
>>> How about a mount option for procfs like `mount -t procfs procfs /proc -o rw,nosuid,nodev,magiclink-no-xdev`
>>>
>>> Where `magiclink-no-xdev` would cause all magic links to fail to cross a pid namespace or so?
>>
>> wouldn't that break also stuff like "/proc/self/fd/$FD" after you join a
>> different PID namespace?
>
> Ah, right.  Hmm.  But building on the reply to
> https://lwn.net/Articles/920876/
> maybe an opt-in flag like `-o magiclink-restricted=/proc/<pid>/ns/pid`
> that required callers to have CAP_SYS_ADMIN in the referenced
> namespace?  Then things like crun/runc would open a fd for
> `/proc/self/ns/pid` when they start (usually, this is the init ns),
> then pass the reference to that fd into magiclink-restricted.
>
> There may be a more elegant userspace API here; I think my overall point is reiterating what I mentioned in 
> https://github.com/containers/crun/pull/1105#issuecomment-1360085059
>
> "A minor worry I have with both is that any namespacing-based approach
> that controls visibility in /proc runs the risk of someone adding a
> new way to get to the binary; maybe it's something like us having a fd
> for ourselves open under /proc/pid/fd/ or so."
>
> So instead of hiding just /proc/self/exe, we add some sort of API that aims to restrict all other magic links that may be added in the future.
>
> The history of map_files is interesting here; it looks like https://github.com/torvalds/linux/commit/bdb4d100afe9818aebd1d98ced575c5ef143456c introduces a comment that says
>
> "* Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
>  * symlinks may be used to bypass permissions on ancestor directories in the
>  * path to the file in question."
>
> yet isn't there an inconsistency here in not applying the same restrictions on /proc/self/exe?
>
> Or another way to look at this is that if we were to add some sort of
> API like this on /proc, we'd also change the proc_maps code to also
> honor it *instead* if present instead of limiting to the init ns?

I realize it seems like a one-off fix, but it is done only for backward
compatibility.

Other paths under /proc/self/map_files require CAP_SYS_ADMIN in the
initial user namespace, or have CAP_CHECKPOINT_RESTORE in the user
namespace.  Sure, it is not future-proof, but it would look weird if
after CVE-2019-19814 there will be more ways to access files from the
host without requiring some capabilities.

One problem with having it as a mount option for procfs (so for the
/proc in the container) is that then the container runtime has the
the burden to verify that there are no other procfs mounts accessible
from the mount namespace as well as to check that the mount option is
available before attempting to use it from the container.  Potentially
it could also be a TOCTOU race since a proc mount could appear later,
e.g. parent mount with shared propagation.  If the runtime finds out
that another procfs is reachable, then it would have to fallback to
re-exec itself much later than what we do today.

With the prctl a runtime would just need to do the following and live
happily ever after:

__attribute__ ((constructor)) static void hide_self_exe (void)
{
	if (prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0) == 0)
		return;

	/* ...reexec as we do today... */
}

and we won't have to worry about what mount options are supported or
used by proc.

