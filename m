Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E078661B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 01:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjAIApo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 19:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAIApm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 19:45:42 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C6FD0A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 16:45:40 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3090jKeE026261
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Jan 2023 19:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673225131; bh=djY15wrWTJQ6gXpihxNWyBLFqVvyEdWiOV7Dm63sgDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nW5A9E1919cZ6odRyyyjraInl8Xfb+t9OuEcw3T+z8rS1Aro00IKdMwTroqMtLxlW
         qD6h6w/vtch4GOSVcsCwoxCHaoCybSFpBeBq/DvjVRtvGIyNDPAe15agBnHvWZE2Ht
         lRYKBcWcEMTiuQzb94NlFRDxgeuU20eo34STS5t5FLKA/pUoBwf0TJUzBiU/OAiilL
         hn0eAjRUrCYFuvABS4TO2oY5bWZPD4uQ4N2YiSQBX/WwWYA6wG4BY1Axh0ZJmpc4mM
         EPeyrcCoNSHwy/mH0/ZU2z/vxx6j0l6Jvsa0ts8zbyWjAkFPLo23/Zvy0u80Ry3U37
         Wu2hBzPKb0vwA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 866F38C084A; Sun,  8 Jan 2023 19:45:18 -0500 (EST)
Date:   Sun, 8 Jan 2023 19:45:18 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7tjnhs77o4TL5ey@mit.edu>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 07:47:07PM +0100, Pavel Machek wrote:
> > However, as this is not Linux-specific, how hard can it be to convince
> > your distro to include https://github.com/qris/dhrystone-deb.git?
> > Usually, when I have a full userspace available, I just clone the above,
> > and debuild it myself.
> 
> Dunno. I'd not solve it if package was in Debian, but it is not.

I would suspect the better long-term solution would be to get the
package into Debian, since that will be easier for people to use.  I
suspect the reason why most distros don't include it is because it
really is a **terrible** benchmark for most use cases.

(I'm not even convinced that using it to try to auto-tune the schedule
by including a random dhrystone number in a device tree is reallty all
that useful, but hey, I'm not a scheduler expert.)

So I took a quick look at dhrystone-deb.git, as well as the original
version of the Dhrystone source code at [1], and I do see huge red
flag show-stopper that would prevent it from getting it into Debian.

There are no copyright license notices anywhere in the source code,
and from what I can tell, it was originally published in ACM's SIGPLAN
Notices --- which even today is behind a paywall, so I presume it's
under an ACM copyright.

Which makes me wonder --- did someone get copyright clearance from ACM
and/or the original authors before this was published in a linux git
tree?  And if not, we should get this clarified before someone sends a
pull request to Linus with a potential copyright licensing problem.

     	     	      	     	       		 - Ted

[1] https://netlib.org/benchmark/dhry-c

P.S.  This is problem is not unique to Dhrystone.  This is also one of
the reasons why xfstests will probably never be packaged in Debian ---
one of the file system exerciser code has been contaminated by code
copyrighted by Avadis Tevanian while he was at NeXT, which means that
the copyright is now with Apple.  There is a much older version of
fsx.c that is fully in the public domain if I remember correctly from
the last time I looked at it.  But someone would have to do a
clean-room reimplementation of the enhancements made by Avie from the
public domain version, and then layer on all of the changes made by
SGI, and Linux developers since then.  The last time I asked about
whether SGI had managed to get copyright clearance for fsx as I recall
there was a lot of mumbling and everyone has decided to let sleeping
dogs lie.

However, there are people who use the Linux kernel who are much
touchier about copyright concerns, so if we can't build a Linux kernel
without including lib/dhrystone.c, and we don't have copyright
permission from ACM, I suspect some corporate lawyers would
be.... uneasy.
