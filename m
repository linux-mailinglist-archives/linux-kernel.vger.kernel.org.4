Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B316A5105
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjB1CS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjB1CSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:18:23 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D9A5FC;
        Mon, 27 Feb 2023 18:18:20 -0800 (PST)
Date:   Tue, 28 Feb 2023 02:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677550698;
        bh=M6DbHO+PeywxABD2rLvdeB8pVgOEidTHxi8y5J0nZ7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9pbiEkv4aT4jJ3hyrNCr5GPqcRL8nDqobRz4+3qRr/5auhAaTgB5RYprY3BzJWG6
         LytGoIeP3k9XiCjQRc/VoY+dzH4Q1Y3IA0iX2buKDpS4Epd1PJunUR7PGeDAaPKyYH
         XdXecx0lioG8Wb/0uiDAhgo66/duT3MCDp/faKs4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     George Kennedy <george.kennedy@oracle.com>, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
Message-ID: <64981d94-d00c-4b31-9063-43ad0a384bde@t-8ch.de>
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
 <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
 <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 05:58:12PM -0800, Linus Torvalds wrote:
> On Mon, Feb 27, 2023 at 5:46 PM <linux@weissschuh.net> wrote:
> >
> > This still seems to be broken for me.
> 
> Looks that way.
> 
> > I still need the patch from
> >
> > https://lore.kernel.org/lkml/20230220064612.1783-1-linux@weissschuh.net/
> 
> .. and that has the same problem with "what if the error happens
> during an iteration that wasn't the first, and we already succeeded
> partially".

Indeed.

> The "goto unlock_out" is bogus, since it jumps over all the "update
> pos and check if we read something".
> 
> It was the correct thing to do *above* the loop, but not inside the loop.
> 
> IOW, I think the proper patch is to also turn the "goto unlock_out"
> into a "break". Mind testing something like this (whitespace-damaged,
> but you get the idea):

Makes sense and seems to work correctly.

Tested-By: Thomas Weißschuh <linux@weissschuh.net>

(Or feel free to use my patch from above and fixup the goto/break line)

> 
>     --- a/drivers/tty/vt/vc_screen.c
>     +++ b/drivers/tty/vt/vc_screen.c
>     @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user
> *buf, size_t count, loff_t *ppos)
>                 unsigned int this_round, skip = 0;
>                 int size;
> 
>     -           ret = -ENXIO;
>                 vc = vcs_vc(inode, &viewed);
>     -           if (!vc)
>     -                   goto unlock_out;
>     +           if (!vc) {
>     +                   ret = -ENXIO;
>     +                   break;
>     +           }
> 
>                 /* Check whether we are above size each round,
>                  * as copy_to_user at the end of this loop
> 
> which hopefully really fixes this (at least I don't see any other
> "goto unlock_out" cases).
> 
>               Linus
