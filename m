Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D767DCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjA0Dyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Dyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:54:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03761D6A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UXDcvt68HiLDs4ZZpIJ8dsIy/orhEaF8thBQp0geZTY=; b=KkqzDzHVKzLt1WbKBXmgy7A3HY
        RMc+0/t+dO+UgXyvZYNNZM+JK+67JWieO5oa0Nna1lXwEegPamCNilUtsvRxQIiQuVlfRfM9KLGIY
        VmVyoyY3owl0mjDSwpSsEIIQ/ijPMakGkrE1qnTLoQSiQRH5OrRPrQZ3mwd4hlUB42r7J+Vr7xqw7
        HOmigI3OeZ3J6xOmfV75ZKeSAMKNLSx2W9lf1HJrv1l9ge9/UAIaBpa/fXtSNUNzRCdr5CbG4NctB
        CSM8cHITLrvP1hqjbGU6k/8m0s0fjJMWg/Z92146etqJFEB9Vz5t50yZb7rXyrHroKeJH8dXDUnUe
        4hxW5cZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLFp1-004N7e-2y;
        Fri, 27 Jan 2023 03:54:40 +0000
Date:   Fri, 27 Jan 2023 03:54:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Message-ID: <Y9NK/2Wv0o67KA2w@ZenIV>
References: <20230118150703.4024-1-ubizjak@gmail.com>
 <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com>
 <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:36:26AM -0800, Linus Torvalds wrote:

> HOWEVER. There is one special exception that might be interesting and
> that has never been done: 'fstat()' and friends could possibly avoid
> the "try_to_unlazy()" even for the last component.
> 
> IOW, we might be able to do fstatat() without ever even finalizing the
> RCU state of the pathname, and actually looking up the stat
> information while still in RCU mode, and instead of doing the actual
> final lockref_get_not_dead() to turn an RCU path into a real
> ref-counted path, we could just do the "get the stat info, then do
> read_seqcount_retry() to verify that the RCU walk _and_ the stat info
> is still valid".
> 
> But I'm not convinced that final complexity would be worth it. It
> sounds like a potentially fun and interesting exercise (Al Viro added
> to particupants so that he can say "No! That's not 'fun and exciting',
> that's just crazy!") if somebody really wants to, but see above: the
> last path component is very seldom something that sees contention. You
> look up the same root/pwd over and over again, but nobody sane looks
> up the same full pathname over and over again.
> 
> And extending the LOOKUP_RCU window all the way over the stat info
> gathering would require a lot of care, and force us to expose the
> kinds of things we do for LOOKUP_RCU in namei.c to fs/stat.c too.

Interesting...  So basically a variant of filename_lookup() that
fills struct kstat instead of doing that to struct path?

Not impossible, but will take some care; in particular, I'd consider
non-default ->getattr() as "fall back to non-RCU *now*, we are not
going there" - otherwise it becomes too nasty.  STATX_DIOALIGN on
block devices is even worse...

Need to check what struct user_namespace and associated stuff looks
like wrt RCU; OTOH, I wouldn't expect too much headache there,
given that things like may_follow_link() already cover most (if
not everything) of what we'd need in generic_fillattr().

Looks like the main obstacle is how to deal with duplication between
that thing and vfs_getattr{,_nosec}(); one possibility would be to
teach vfs_getattr about the possibility of being called from RCU
mode, and have it used by that new thing.  However, I really want
to avoid passing struct nameidata to that sucker.  Hmmmm...

OK, so what are the reasons for falling out of RCU mode there and
how early can we detect those?
	1) non-NULL ->getattr() (OK, corresponding new bit in
->i_opflags).  Can be seen immediately.
	2) STATX_DIOALIGN combined with S_ISBLK().  Also can be
seen immediately.
	3) security_inode_getattr().  That can get unpleasant -
it exposes apparmor and tomoyo to operating in RCU mode.  Until
now they had been spared that.  OTOH, they can just fail with
-ECHILD if they see whatever indicator of "you are called in RCU
mode" we end up choosing...

Hell knows - that just might be doable.  vfs_getattr() grows a flag
(not sure where - passing inode separately looks like a plausible
approach, with non-NULL meaning "we are in RCU mode").  If it
sees the indication of being called in RCU mode it should return -ECHILD
ASAP if it can't handle things.  Old callers just pass it
NULL for inode; filename_statx() (in RCU mode) does something like
	err = vfs_getattr(nd->path, nd->inode, ....);
	if (err == -ECHILD)
		if (!try_to_unlazy(nd))
			sod off and restart in non-RCU mode
		err = vfs_getattr(nd->path, NULL, ....);
	if (!err && (nd->flags & LOOKUP_RCU)) {
		do a trimmed-down variant of try_to_unlazy, just checking
		the seq counts and not grabbing anything.
	}

Oh, wait - there's the rest of the stuff done by complete_walk()...
Ugh...  ->d_weak_revalidate() part obviously means "no RCU for you",
but it needs to be handled for non-RCU modes and there's LOOKUP_IS_SCOPED
part...

I'll poke around at some point, but I've a bunch of other pending crap
at the moment.  It _might_ be doable without too much ugliness, but
then this is just from a cursory look - there might be dragons.
