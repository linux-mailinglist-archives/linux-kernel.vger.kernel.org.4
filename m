Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8164AD50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiLMBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiLMBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:44:27 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036E15FD8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oZhnyIx6FZ/d9c0hcACv5/lZB73n75q4YswuEdSIHpE=; b=nyJaWbpY3X7xZn+iD8xVkZUZde
        UTcxqm2Wz8mVnIOi26FZZ55XqVT0jLJ0OGGc07qkyYO4RCGcaYV5g8J4bxWhbFhqbEpJnxHSvDKZ2
        4gXctIiwRgpgJMKFIayEjxh9bNBohX5owOBsT2j+kDqwtw8No3BYSMjXHxdTWBTB98dt0qhWF3weO
        F3YmX957O6V3eUi0/drDxGognma6SuXnFbBu/JmZAb4u9Jzk1Mm6JQuEDdJ+VSrSuTG+lht34jmC1
        212fSAFajLqQHXUXbtD+h4ihquTAurTp58pFaKdnOPkJIqsRm2c2MljpKnqSzuY/0fYfCp78olhxn
        /kqifUyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4uL2-00BVAb-2o;
        Tue, 13 Dec 2022 01:44:08 +0000
Date:   Tue, 13 Dec 2022 01:44:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Marco Elver <elver@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5fY6BRTB9OfwFU0@ZenIV>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com>
 <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 08:29:10PM +0100, Marco Elver wrote:

> > > Given the call trace above, how do you know the ntfs3 guys should be also
> > > Cced in addition to AV? What if it would take more than three months for
> > > syzbot to learn the skills in your mind?

Depends.  If you really are talking about the *BOT* learning to do
that on its own, it certainly would take more than 3 months; strong AI
is hard.  If, OTOH, it is not an AI research project and intervention of
somebody capable of passing the Turing test does not violate the purity
of experiment...  Surely converting "if it mounts an image as filesystem
of type $T, grep the tree for "MODULE_ALIAS_FS($T)" and treat that
as if a function from the resulting file had been found in stack trace"
into something usable for the bot should not take more than 3 months,
should it?

If expressing that rule really takes "more than three months", I would
suggest that something is very wrong with the bot architecture...

> Teaching a bot the pattern matching skills of a human is non-trivial.
> The current design will likely do the simplest thing: regex match
> reproducers and map a match to some kernel source dir, for which the
> maintainers are Cc'd. If you have better suggestions on how to
> mechanize subsystem selection based on a reproducer, please shout.

Er...  Yes?  Look, it's really that simple -
for i in `sed -ne 's/.*syz_mount_image$\([_[:alnum:]]*\).*/\1/p' <$REPRO`; do
	git grep -l "MODULE_ALIAS_FS(\"$i\")"
done | sort | uniq
gets you the list of files.  No, I'm not suggesting to go for that kind
of shell use, but it's clearly doable with regex and search over the source
for fixed strings.  Unless something's drastically wrong with the way the
bot is written, it should be capable of something as basic as that...

If it can't do that kind of mapping, precalculating it for given tree is
also not hard:
git grep 'MODULE_ALIAS_FS("'|sed -ne 's/\(.*\):.*MODULE_ALIAS_FS("\([_[:alnum:]]*\)".*/syz_mount_image$\2:\1/p'
will yield lines like
syz_mount_image$ext2:fs/ext2/super.c
syz_mount_image$ext2:fs/ext4/super.c
syz_mount_image$ext3:fs/ext4/super.c
syz_mount_image$ext4:fs/ext4/super.c
etc.  Surely turning *that* into whatever form the bot wants can't
be terribly hard? [*]

All of that assumes that pattern-matching in syzkaller reproducer is
expressible; if "we must do everything by call trace alone" is
a real limitation, we are SOL; stack trace simply doesn't have
that information.  Is there such an architectural limitation?

[*] depending upon config, ext2 could be mounted by ext2.ko and ext4.ko;
both have the same maillist for bug reports, so this ambiguity doesn't
matter - either match would do.
