Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0465A5DC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiLaREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLaREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:04:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7585631C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+eA7UEumfrhwZvnLMy8o4eWh1GCDZs4DHFXhV0mGrRY=; b=3gp0WBQK/ZGzjJm41N+msNiPyr
        VgUFQ0ajeJkzwEYPUWBMaPEufnCcONp0/UUgM/I/UjJoKSjjlIx5RoSEA6I9Da3FBm/aIT8wFcafI
        JNuWNZqfQELgMSCLuPluKMv9jsI7b6PEIgptjaQLVFJkce0FZLn0evNO1f04XYg7hHAz4ody/4GpB
        waseApCmZtsWaJiFG58+J9Wq9wgB3f7YTOxKME3sJsM5ryLKFXC6ywu1kuTmt79Ajb6YCuQv0jVdM
        JRB+J17pZ+QznVt0CpE8LL46iYUV+cIgCNsfF7IFC/54t5nBPR+ZIlqC2dWKCOncmxxoD3ZnOVFEH
        NeWYF5zg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBfH2-007nIR-4f; Sat, 31 Dec 2022 17:03:56 +0000
Message-ID: <2e739a3f-b892-3fdd-634d-a1010c41dab2@infradead.org>
Date:   Sat, 31 Dec 2022 09:03:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] WARNING in do_mkdirat
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Aleksandr Nogikh <nogikh@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Marco Elver <elver@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com> <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
 <Y5fY6BRTB9OfwFU0@ZenIV>
 <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
 <Y64D69VTnJEQuHwT@sol.localdomain> <Y7BqAxMrtyigw6O8@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y7BqAxMrtyigw6O8@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/22 08:57, Theodore Ts'o wrote:
> On Thu, Dec 29, 2022 at 01:17:31PM -0800, Eric Biggers wrote:
>> Thanks Aleksandr.  From what I can see, the fix is working for new filesystem
>> bugs: the filesystem(s) involved get added to the title and the recipients.
>>
>> One question: what happens to all the open bugs, like this one ("WARNING in
>> do_mkdirat") that were reported before the syzbot fix?  Are they going to be
>> re-reported correctly?  Perhaps any bug whose reproducer includes
>> "syz_mount_image" and was reported before the date of this fix should be
>> invalidated more aggressively than usual, so that it can be re-reported?
> 
> As a related request/wish, it would be nice if those dashboard pages
> that were created before the new-style reporting which includes the
> file system image, strace otuput, etc., could get regenerated.  For example:
> 
> https://syzkaller.appspot.com/bug?id=be6e90ce70987950e6deb3bac8418344ca8b96cd
> 
> Even if someone has already submitted a proposed fix, I often like to
> double-check that the fix is really fixing the true root cause of the
> problem, as opposed to just making a superficial change that blocks
> the current syzbot reproducer, but which will eventually be tripped
> again because code is still vulnerable.  (For example, we might block
> a straightforward reproducer by adding a check at mount time, but if
> the superblocks get corrupted during the journal replay, we'd still be
> vulnerable.)  And having access to the corrupted file system image,
> and other associated reporting data, is often super-helpful in that
> regard.
> 
> Also, can we at some point have the C reproducer actually using proper
> C strings instead of hex digits?  It will make the reproducer much
> more human understandable, as well making it easier to edit the string
> when the developer is trying to do a better job minimizing the test
> case than syzbot.  For example:
> 
>   memcpy(
>       (void*)0x20000000,
>       "\x6e\x6f\x75\x73\x65\x72\x5f\x78\x61\x74\x74\x72\x2c\x61\x63\x6c\x2c\x64"
>       "\x65\x62\x75\x67\x5f\x77\x61\x6e\x74\x5f\x65\x78\x74\x72\x61\x5f\x69\x73"
>       "\x69\x7a\x65\x3d\x30\x78\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30"
>       "\x30\x30\x38\x30\x2c\x6c\x61\x7a\x79\x74\x69\x6d\x65\x2c\x6e\x6f\x62\x68"
>       "\x2c\x71\x75\x6f\x74\x61\x2c\x00\x3d\x93\x09\x61\x36\x5d\x73\x58\x9c",
>       89);
> 
> Would be *much* more understable if it were:
> 
>   memcpy(
>       (void*)0x20000000,
>       "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,",
>       80);
> 
> Of course, something like:
> 
>    char mount_options[] = "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,";
> 
> Would be even better (and more portable) than using random hex
> addresses, but just simply using ASCII strings would be a good first
> step.
> 
> Of course, filling in C structures instead of just a random memcpy of
> hex garbage would be even *more* awesome, bunt I'll take what I can
> get.  :-)
> 
> Another opportunity for improvement is to try minimizing mount
> options, so it becomes more obvious which ones are required.  For
> example, in the above example, a minimized mount option string would
> have been:
> 
>   memcpy((void*)0x20000000, "debug_want_extra_isize=0x80,lazytime," 38);
> 
> Having a more minimized reproducer would improve the reliability of
> the bisect, as well as making it easier for the developer to figure
> out the true root cause of the problem.

Amen to all of that. for so many good reasons.
Thanks.

-- 
~Randy
