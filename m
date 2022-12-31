Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF265A5DA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiLaQ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLaQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:58:36 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D4EA1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 08:58:35 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BVGvlG2017379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Dec 2022 11:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672505879; bh=OZlI3LKt7qQwa7YKmknHkE9bQ2vjr1mCmTgEfEpMiwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kjAwo/UEpSbI0nz5oloeXgkkfC1aSjQja9YRWpf/OgYuuz97eZji+KGaNQ4MbOPSg
         9Qx5c0JXhstgfasvQn5kRdwqfhNSnn0tO5FtLpMnSDZBcJZKTCJuAMW0OZqMzeaNlo
         m8Qo1idEBuO+2z/TUNqy+Xq8yWN7tJRyjTZAKttUfPInsKcN03z0V+sVw/JZyfjHdh
         jYYwPEyhrIsp5cLJ4mQ3i9HpXv7MQyVvlSbncYV+5F57Dh8rysmfmNOrxJa9eegCRu
         ylaHgB4A2HMJ0dn25hxE//HHlc5p5TlBj8hb5SYbjTz5XQoNdQvjsLhxLm5cdJ3k72
         l3TTW3e52WaXw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 98A2F8C09BA; Sat, 31 Dec 2022 11:57:39 -0500 (EST)
Date:   Sat, 31 Dec 2022 11:57:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Marco Elver <elver@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y7BqAxMrtyigw6O8@mit.edu>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com>
 <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
 <Y5fY6BRTB9OfwFU0@ZenIV>
 <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
 <Y64D69VTnJEQuHwT@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y64D69VTnJEQuHwT@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 01:17:31PM -0800, Eric Biggers wrote:
> Thanks Aleksandr.  From what I can see, the fix is working for new filesystem
> bugs: the filesystem(s) involved get added to the title and the recipients.
> 
> One question: what happens to all the open bugs, like this one ("WARNING in
> do_mkdirat") that were reported before the syzbot fix?  Are they going to be
> re-reported correctly?  Perhaps any bug whose reproducer includes
> "syz_mount_image" and was reported before the date of this fix should be
> invalidated more aggressively than usual, so that it can be re-reported?

As a related request/wish, it would be nice if those dashboard pages
that were created before the new-style reporting which includes the
file system image, strace otuput, etc., could get regenerated.  For example:

https://syzkaller.appspot.com/bug?id=be6e90ce70987950e6deb3bac8418344ca8b96cd

Even if someone has already submitted a proposed fix, I often like to
double-check that the fix is really fixing the true root cause of the
problem, as opposed to just making a superficial change that blocks
the current syzbot reproducer, but which will eventually be tripped
again because code is still vulnerable.  (For example, we might block
a straightforward reproducer by adding a check at mount time, but if
the superblocks get corrupted during the journal replay, we'd still be
vulnerable.)  And having access to the corrupted file system image,
and other associated reporting data, is often super-helpful in that
regard.

Also, can we at some point have the C reproducer actually using proper
C strings instead of hex digits?  It will make the reproducer much
more human understandable, as well making it easier to edit the string
when the developer is trying to do a better job minimizing the test
case than syzbot.  For example:

  memcpy(
      (void*)0x20000000,
      "\x6e\x6f\x75\x73\x65\x72\x5f\x78\x61\x74\x74\x72\x2c\x61\x63\x6c\x2c\x64"
      "\x65\x62\x75\x67\x5f\x77\x61\x6e\x74\x5f\x65\x78\x74\x72\x61\x5f\x69\x73"
      "\x69\x7a\x65\x3d\x30\x78\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30"
      "\x30\x30\x38\x30\x2c\x6c\x61\x7a\x79\x74\x69\x6d\x65\x2c\x6e\x6f\x62\x68"
      "\x2c\x71\x75\x6f\x74\x61\x2c\x00\x3d\x93\x09\x61\x36\x5d\x73\x58\x9c",
      89);

Would be *much* more understable if it were:

  memcpy(
      (void*)0x20000000,
      "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,",
      80);

Of course, something like:

   char mount_options[] = "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,";

Would be even better (and more portable) than using random hex
addresses, but just simply using ASCII strings would be a good first
step.

Of course, filling in C structures instead of just a random memcpy of
hex garbage would be even *more* awesome, bunt I'll take what I can
get.  :-)

Another opportunity for improvement is to try minimizing mount
options, so it becomes more obvious which ones are required.  For
example, in the above example, a minimized mount option string would
have been:

  memcpy((void*)0x20000000, "debug_want_extra_isize=0x80,lazytime," 38);

Having a more minimized reproducer would improve the reliability of
the bisect, as well as making it easier for the developer to figure
out the true root cause of the problem.

Cheers,

					- Ted

