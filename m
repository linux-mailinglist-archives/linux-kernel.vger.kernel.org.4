Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B904068BAFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFLJe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Feb 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:09:32 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B229913D71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:09:31 -0800 (PST)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 59B52A0C66;
        Mon,  6 Feb 2023 11:09:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 0C6A220027;
        Mon,  6 Feb 2023 11:09:27 +0000 (UTC)
Message-ID: <bbdf99df867786510f709473fa2c3744dbf27bb4.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 06 Feb 2023 03:09:26 -0800
In-Reply-To: <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
         <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
         <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
         <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0C6A220027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: bnxitis48kesjoeto6hdrcmypydkzqmz
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1//DDzdb6fyz0gA5ivMPJw+xCLvCwbCB3Y=
X-HE-Tag: 1675681767-752193
X-HE-Meta: U2FsdGVkX19Q90r1YzDwYExj8K7CXjQNFc18ipJ0EFKsYG5TvvbNyI00CKzqWTuvGYpjxP10LFmjpgUpb99OBg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-06 at 09:38 +0100, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Sat, Feb 4, 2023 at 5:59 PM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
> > > On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
> > > > By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
> > > > hashes with 13 digits, because of the number of objects.
> > > > 
> > > > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
> > > 
> > > NAK without updating the process docs first.
> > 
> > btw: it looks like 12 will still be sufficient for awhile yet
> > 
> > $ git count
> > total 1154908
> 
> Hmm, Ubuntu git too old?

Don't think so

$ git --version
git version 2.39.1

More likely just using Linus' tree and not a
development tree with a bunch of branches.

I've got a -next tree with history back to next-20151106
with a bunch of missing dates because I don't fetch it
every day.  It has:

$ git tag | grep next | wc -l
1134

There I get:

$ git -c core.abbrev=5 log --pretty=format:%h | \
  perl -nE 'chomp;say length' | sort | uniq -c | sort -n -k2
      6 5
 542082 6
 568573 7
  51124 8
   3249 9
    217 10
     14 11
      1 12

> I've been using core.abbrev=16 for a while, and some maintainers
> reject my patches with Fixes: tags because of that...

Perhaps because that's not the documented format?

> Is it really worthwhile to save on the number of hexits, making lookup
> of some commits more inconvenient?
> 
> Note that while "git show edb9b8" suggests edb9b8f[...],
> gitweb says bad object id:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edb9b8

hmm.  Not here.

$ git show edb9b8
tree edb9b8

Kconfig
Makefile
fmvj18x_cs.c


