Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7269E1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjBUNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBUNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:50:06 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4BD25E1D;
        Tue, 21 Feb 2023 05:50:03 -0800 (PST)
Date:   Tue, 21 Feb 2023 13:49:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676987401;
        bh=S2iWEccI9i9e80XBMS0y68qwXtQXkTdPmUQB1jtGT1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPUXtvZcub8sVIkvu5NUbgGlF16GbdXjBZIiqhs0LRVpwZVqqyzj0Y8HcgHvMB9i5
         mtAUIflfjLDiKd2UfPmw+bDlof/e/Ks32dlxDL5EmH56UbeNEJ1jlKQGRI1lVjLy4w
         2Z1wY6tBVF9y2nmluP9KguxoFhoRrUd6SduVj1O8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <0a8530ab-854c-4a90-b905-904b307acea7@t-8ch.de>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <dcaaf7d5-b2d5-dbb9-f3fe-2232ee525cc8@kernel.org>
 <2094ecec-f63c-4e8a-ba97-da77c5266da1@t-8ch.de>
 <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:30:11AM -0500, George Kennedy wrote:
> 
> 
> On 2/20/2023 11:34 AM, Thomas Weißschuh wrote:
> > +Cc people who were involved in the original thread.
> > 
> > On Mon, Feb 20, 2023 at 12:48:59PM +0100, Jiri Slaby wrote:
> > > On 20. 02. 23, 7:46, linux@weissschuh.net wrote:
> > > > From: Thomas Weißschuh <linux@weissschuh.net>
> > > > 
> > > > Commit 226fae124b2d
> > > > ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> > > > moved the call to vcs_vc() into the loop.
> > > > While doing this it also moved the unconditional assignment of
> > > > "ret = -ENXIO".
> > > > This unconditional assignment was valid outside the loop but within it
> > > > it clobbers the actual value of ret.
> > > > 
> > > > To avoid this only assign "ret = -ENXIO" when actually needed.
> > > Not sure -- I cannot find it -- but hasn't George fixed this yet?
> > Indeed there was a proposed fix at
> > https://lore.kernel.org/lkml/1675704844-17228-1-git-send-email-george.kennedy@oracle.com/
> > 
> > Linus had some suggestions so it was not applied as is.
> > 
> > I'm not sure what the current state is.
> > George, do you have something in the pipeline?
> 
> Yes, that is in the pipeline:
> https://lore.kernel.org/lkml/1675774098-17722-1-git-send-email-george.kennedy@oracle.com/
> 
> Linus suggested the fix, which was tested and submitted.
> 
> Jiri commented on the patch, which I believe was directed at Linus as he
> suggested the fix.

Thanks for the pointer!

I searched for it by its Fixes: tag.
The v2 has a different one than the v1.
To me the v1 Fixes: seems more correct, was the change
intentional?

> George
> > 
> > I also tested the patch proposed by Linus as attachment and that works.
> > (The small inline patch snippet doesn't)
> > 
> > > > Reported-by: Storm Dragon <stormdragon2976@gmail.com>
> > > > Link: https://lore.kernel.org/lkml/Y%2FKS6vdql2pIsCiI@hotmail.com/
> > > > Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > 
> > > > ---
> > > > 
> > > > @Storm Could you validate this patch?
> > > > ---
> > > >    drivers/tty/vt/vc_screen.c | 5 +++--
> > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> > > > index f566eb1839dc..2ef519a40a87 100644
> > > > --- a/drivers/tty/vt/vc_screen.c
> > > > +++ b/drivers/tty/vt/vc_screen.c
> > > > @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > > >    		unsigned int this_round, skip = 0;
> > > >    		int size;
> > > > -		ret = -ENXIO;
> > > >    		vc = vcs_vc(inode, &viewed);
> > > > -		if (!vc)
> > > > +		if (!vc) {
> > > > +			ret = -ENXIO;
> > > >    			goto unlock_out;
> > > > +		}
> > > >    		/* Check whether we are above size each round,
> > > >    		 * as copy_to_user at the end of this loop
> > > > 
> > > > base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> > > -- 
> > > js
> > > suse labs
> > > 
> 
