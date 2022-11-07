Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBA61FC24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKGRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiKGRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:06 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A505252B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667843571; bh=58ErT4QpRqXdWTiUxomBj2IPCdd8QNB/JsnhQ4gVmuI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=MzYP0h4+syPx/Nby1i/2hY8QlHazvNLx7JxqB1ojnfmg0eZD2S6SaOmNiiWHHMWgz
         S+URdsYJEBopjph01agkD4sbyj1bYZgDmAL8xt+pYILSyIFENwBlJM6p9TOl1fYSaS
         Ef7YHt5WJuciDMS0hPie+4nYGUjxidDbEPXnR4tY=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 18:52:50 +0100 (CET)
X-EA-Auth: 9lejEj7kUnOJLlXO/mv+0blyfacoZBYDob5YtkXUEAdj8FhObVwkt+9O17zeDxBX6MFBl7Lb+Ypx6+KX/d4OUIsxwHxL+qLH
Date:   Mon, 7 Nov 2022 23:22:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: video: use min_t() for comparison and
 assignment
Message-ID: <Y2lF7dHx3aHfrSoB@qemulion>
References: <Y2iHl5CuqyR2vEc8@qemulion>
 <Y2kGG3zuvvDLZKWq@kadam>
 <Y2kf40kSbFWkWkLl@qemulion>
 <Y2kiixRDxjxSwFp+@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kiixRDxjxSwFp+@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:21:47PM +0300, Dan Carpenter wrote:
> On Mon, Nov 07, 2022 at 08:40:27PM +0530, Deepak R Varma wrote:
> > On Mon, Nov 07, 2022 at 04:20:27PM +0300, Dan Carpenter wrote:
> > > On Mon, Nov 07, 2022 at 09:50:39AM +0530, Deepak R Varma wrote:
> > > > Simplify code by using min_t helper macro for logical evaluation
> > > > and value assignment. Use the _t variant of min macro since the
> > > > variable types are not same.
> > > > This issue is identified by coccicheck using the minmax.cocci file.
> > > >
> > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >    1. Revise patch description. No functional change.
> > > >
> > > >  drivers/staging/most/video/video.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> > > > index ffa97ef21ea5..d5cc7eea3b52 100644
> > > > --- a/drivers/staging/most/video/video.c
> > > > +++ b/drivers/staging/most/video/video.c
> > > > @@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
> > > >  	while (count > 0 && data_ready(mdev)) {
> > > >  		struct mbo *const mbo = get_top_mbo(mdev);
> > > >  		int const rem = mbo->processed_length - fh->offs;
> > > > -		int const cnt = rem < count ? rem : count;
> > > > +		int const cnt = min_t(int, rem, count);
> > >
> > > TL;DR use size_t instead of int.
> >
> > Hi Dan,
> > Thank you for reviewing the patch. Please see my queries inline.
> >
> > >
> > > Using "int" here is wrong.  size_t is unsigned long meaning that it has
> > > 64 bits to use to represent positive values.  (Let's ignore 32 bit
> > > arches).  You have chopped it down to say that it now has 31 bits for
> > > positives and if BIT(31) is set then treat it as negative.  Everything
> > > which is larger than INT_MAX will be broken.
> >
> > I did worry about the truncation int might cause to the size_t variable,
> > however, as the result is being assigned to an int, I decided to go for int to
> > be the typecast for min_t.
>
> Let's ignore that other layers prevent "count" from being greater than
> INT_MAX.  mbo->processed_length is a u16.  Also if "fh->offs" is more
> than mbo->processed_length that's a separate bug and we are already
> screwed.

Yes, "u16 - u32" looks wrong on the face, but it should always evaluat
positive, else we would have had other issues down the line.

>
> So that means rem is a relatively small number.  A small number can
> easily fit in "int cnt".  So we are eating a big pie ("count") but we
> are taking small bites ("cnt").  Everything works fine.
>
> But if we chop the pie in half or treat it as negative pie then the
> math breaks.

That makes perfect sense. Thank you so much Dan for the explanation.

>
> >
> > Also, won't size_t will force the int rem to be treated as unsigned value which
> > will impact the comparison when rem indeed is negative. If rem will never be
> > -ve, my worry will be void.
>
> Is "-ve" the TikTok way of abbreviating negative?  Am I old?

No no... sorry. My fingers were catching up with the thoughts. :)

>
> The small bites are always positive.  But if we are eating negative
> pie then we take negative size bites.  min_t() should almost always use
> unsigned types.  Everything else is a headache.  I have often wondered
> why people do it but I think it's because of the 80 character rule and
> the word "int" is shorter than "unsigned long".

Understood. I will send in a revision with size_t type for min_t.
Thank you once again for the detailed answer. Much appreciate.

./drv

>
> regards,
> dan carpenter
>
>


