Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB05649663
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLKUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:54:54 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3FA457
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rpuyWNeaJOUx7FDjoJhzanYvKY9VOtW+rHkpLbAUuaA=; b=vGxXINjvL3PyDU9ELq5H7+QP4T
        hsemHvofrdiMPJxV3up9bTje6SLJ4824H/XU/ieByiUAR4VIMLL4pgIogH5j5CUgnJnjVFSQvTk6s
        tZ5MuIqIz90ikvCLbBo0Gw9XcS6ebqrL8GsrOij5Hu8Sjznq0ftQc6PzY1AIQUlvGmY4r8ghEuueM
        +H8D9NN4MT35/sBQq+un4j4KZIkvqkzYrI4gydeMc/WPN5f1tBHrm55qaeX9t5kA1/5VkjM8W+5gz
        WyFnhaM7Sr5RjF3JBxopbKDE93pht/C2IqeQE8xAmkYbLft+YqMAAtxnVmWyjHoh1Gqtom3pfhUiL
        oC33ml2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4TLK-00B694-0X;
        Sun, 11 Dec 2022 20:54:38 +0000
Date:   Sun, 11 Dec 2022 20:54:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5ZDjuSNuSLJd8Mn@ZenIV>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <Y5X7RBznTD6rPfro@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5X7RBznTD6rPfro@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 03:46:12PM +0000, Matthew Wilcox wrote:

> You've completely misunderstood Al's point.  He's not whining about
> being cc'd, he's pointing at this is ONLY USEFUL IF THE NTFS3
> MAINTAINERS ARE CC'd.  And they're not.  So this is just noise.
> And enough noise means that signal is lost.

Precisely.  Nobody asked for removing fsdevel from Cc, and I do read
what gets posted there.  That is not the problem.

Again, the problem is that extracting the information from those reports
is more inconvenient than it needs to be.

For anything that involves buzzing a specific filesystem the type of
that filesystem is highly relevant.  It's trivial to generate, it had
been (politely) asked for many times over the last months and it keeps
getting nowhere.

A combination of "email" and "cost-shifting" pushes the buttons you
really don't want pushed, because the output is not just occasional
all-caps repeats of original request - quiet .procmailrc rules tend to
stay around for a long time.

Cost-shifting is definitely there - one-time (and trivial, at that)
modification of the bot vs. O(number of fs developers * number of bot
reports that don't get marked).

From what I've seen in various discussions, the assumption of syzkaller
folks seems to be that most of the relevant information is in stack
trace and that's sufficient for practical purposes - anything beyond
that is seen as unwarranted special-casing.  Such assumption does not
match the reality.

For one thing, anything that involves fuzzing the filesystem with
corrupted image (which is a common enough class of reports) is highly
filesystem-specific.  Such reports *are* valuable - this is the area
that doesn't get anywhere near enough routine testing.  However, if
you consider the triage path for such report you get
	* OK, something's clearly wrong with the state of some
filesystem or VFS data structures.  Interesting.
	* Might be something in some specific filesystem, might
be something fs-independent in VFS, might be VFS mishandling a rare
but legitimate behaviour of some method.  Do we have anything to
narrow it down?  Nothing in the stack trace, more's the pity.
	* Has that code just returned from a method?  Yep - complains
about the state of rwsem it unlocks, which happens around the method
calls.  Definitely so in case of mkdir...  Filesystem type has
just become highly relevant - there are *many* ->mkdir() instances,
and each brings along its own set of helpers, etc.
	* No way to tell which fs type it is going by the stuff in
email body.  It's obviously on x86 and it's on mainline tree.  Which
doesn't say much.  Hell with it, the only way to tell is apparently to
follow a link in there.  Which is to say, cut'n'paste an URL from
xterm with ssh session with mutt(1) in it into shell (if I feel
like using lynx(1) or wget(1)) or into a new tab in chromium (which
I had running at the time).
	* ouch.
 https://syzkaller.appspot.com/bug?id=e8da337c58f1a620dce15898ae21af03e0a5ddb3
 # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
 #{"threaded":true,"repeat":true,"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false,"tmpdir":true}
 syz_mount_image$ntfs3(&(0x7f000001f180), &(0x7f00000000c0)='./file2\x00', 0x80008a, &(0x7f0000000300)=ANY=[@ANYRES64=0x0, @ANYRES8=0x0, @ANYBLOB="9bb8aca074f613bfd79072432703c68cf00d"], 0x1, 0x1f195, &(0x7f000001f1c0)=<PAGES AND PAGES OF LINE NOISE>

	Presumably somewhere past those pages of line noise there's
some information about what it does, but you know what?  By that point
I really don't give a rat's arse.  What that thing is doing is, by
the look of it, fuzzing ntfs3.  And there are very good odds that
it might be actually testing how well ntfs3 can cope with image
validation and with failure exits in general.
	fs/ntfs3 is still very rough in those areas; such reports
would be quite useful for NTFS3 maintainers.  Who are (again) not
Cc'ed on that.  Sure, they are probably reading fsdevel, and had
that report been brought to their notice, they might do something
useful with it.  The odds are, they would be able to ask reasonable
questions and would get help if needed.
	What the hell I am supposed to do with that, though?

Option 1: dig through ntfs3 ->mkdir(), try to make a guess about the
expected execution path, see what went wrong, etc.?  Sure, I can do that
- with a few days of RTFS I could probably familiarize myself with their
code enough to serve as emergency co-maintainer.  Been there, done that
for some of unsupported filesystems.  It doesn't scale.

Option 2: hope that ntfs3 folks had seen the same report, did the
same triage and arrived at "useful for us, let's deal with it".
REALLY does not scale, and here's why: it might as well had been
fuzzing xfs instead.  Or btrfs.  Or ext4.  Or any other filesystem.
Are all fs maintainers expected to decode that kind of reports,
even though there's not a damn thing to indicate that they might
be relevant to them?  With "wasted time - not ours" as outcome for
the majority of those people.

Option 3: ping ntfs3 folks, bringing the report to their attention.
Possible, and I'd done just that a couple of times.  Should I *AND*
an unpredictable amount of people on fsdevel take to spamming
ntfs3 folks every time such a report appears?  So every time something
of that sort gets reported, N people do that kind of triage, arrive
to "oh, it's ntfs3 fuzzing" and send N pings to maintainers?  Wonderful,
that...

Option 4: ask syzkaller folks to put the relevant information into
the mailed reports.  With "fuzzing $FILESYSTEM" somewhere it would
be instantly visible, ideally - with *additional* Cc (I'm not asking
to drop fsdevel, etc.) that would bring it to attention of maintainers
in question.  Tried that.  Quite a few times.  Got nowhere.

Option 5: just ignore the syzkaller reports.


That goes for me; similar analysis applies for other people on
fsdevel, except that those whose primary interest is in specific
filesystem are less likely to be interested in reports that refer
to VFS internals.

Face it, the underlying assumption is broken - for a large class
of reports the stack trace does not contain the relevant information.
It needs to be augmented by the data that should be very easy to
get for the bot.  Sure, your code, your priorities, but reports
are only useful when they are not ignored and training people to
ignore those is a bad idea...
