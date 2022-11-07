Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1461F73F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiKGPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiKGPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:10:47 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEAC1DA6F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667833832; bh=fWGybKtDfFOGqUPr2kqL0W0MYyr0KbOZJ5Z2jYMekJ4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=M9QgzjQVdQicyx93zppupqrqFPXs5xJoRQ0zP7QEwCbcvGzTvvPO+b25MpxpNcGNw
         UbOi/a11rLOOgW7jUifRPyOFAxR690VkjIq8z8RB8GF66eTH0OB6e7rTo61kYe5u4z
         HiRiA6nkAkXAonJnezo1eWRXqqFbYMkErCtbhEOA=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 16:10:32 +0100 (CET)
X-EA-Auth: louSqubUNPz5fcm9qrxopjABB2mp36VSUHdMcMhAB1qPpzUuCC1SPAaRJmtObPWxOX6uc3fSslaudEn05EyD/wfCZZRxKPAM
Date:   Mon, 7 Nov 2022 20:40:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: video: use min_t() for comparison and
 assignment
Message-ID: <Y2kf40kSbFWkWkLl@qemulion>
References: <Y2iHl5CuqyR2vEc8@qemulion>
 <Y2kGG3zuvvDLZKWq@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kGG3zuvvDLZKWq@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:20:27PM +0300, Dan Carpenter wrote:
> On Mon, Nov 07, 2022 at 09:50:39AM +0530, Deepak R Varma wrote:
> > Simplify code by using min_t helper macro for logical evaluation
> > and value assignment. Use the _t variant of min macro since the
> > variable types are not same.
> > This issue is identified by coccicheck using the minmax.cocci file.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >
> > Changes in v2:
> >    1. Revise patch description. No functional change.
> >
> >  drivers/staging/most/video/video.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> > index ffa97ef21ea5..d5cc7eea3b52 100644
> > --- a/drivers/staging/most/video/video.c
> > +++ b/drivers/staging/most/video/video.c
> > @@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
> >  	while (count > 0 && data_ready(mdev)) {
> >  		struct mbo *const mbo = get_top_mbo(mdev);
> >  		int const rem = mbo->processed_length - fh->offs;
> > -		int const cnt = rem < count ? rem : count;
> > +		int const cnt = min_t(int, rem, count);
>
> TL;DR use size_t instead of int.

Hi Dan,
Thank you for reviewing the patch. Please see my queries inline.

>
> Using "int" here is wrong.  size_t is unsigned long meaning that it has
> 64 bits to use to represent positive values.  (Let's ignore 32 bit
> arches).  You have chopped it down to say that it now has 31 bits for
> positives and if BIT(31) is set then treat it as negative.  Everything
> which is larger than INT_MAX will be broken.

I did worry about the truncation int might cause to the size_t variable,
however, as the result is being assigned to an int, I decided to go for int to
be the typecast for min_t.

Also, won't size_t will force the int rem to be treated as unsigned value which
will impact the comparison when rem indeed is negative. If rem will never be
-ve, my worry will be void.

Can you please correct if my understanding is wrong?

Thanks,
./drv

>
> Fortunately, in this code the value of count will never go higher than
> "INT_MAX - PAGE_SIZE" because Linus understands that it's easy to
> introduce bugs like this.
>
> regards,
> dan carpenter
>
>


