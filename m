Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08304626A87
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiKLQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiKLQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:23:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1619C2E;
        Sat, 12 Nov 2022 08:23:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 990E6B80978;
        Sat, 12 Nov 2022 16:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31CFC433C1;
        Sat, 12 Nov 2022 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668270199;
        bh=ULEmB1FW0KlLdnUt5H3h44QkFXaR6Myza7m5uFRsYfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sygqL7MJ2Ld0QScVoqKAGf2MU9CWm0YUHkr4j4boeHR0Z7uppC5RnmzRxH02Af20e
         paEbcgdRr/yBcFl3lJEoRm9nOPtZnwzTO7Y3NhhFC+sqFKI9Gi8ucgOzIFdN6ZUrJC
         rNvcCtrI5H3p6ax8fgt/v/2tJcX4mBjrqgZuXWT63IdspR2RbyaUgcQHbvFj0DO9GI
         fEuXWRCD5q9gw60nPqPMmeonrx5qP12g1TRleaFp2QSxT+8INngCH9RVSZgY5ECsqZ
         up8WS4IzRu5iZnfbAS6CmuWZtU2uLolC20ThXb/5b1xWk00OL9Gy7xR5h2kXC+/+jv
         QRSluJq8qQN6A==
Date:   Sat, 12 Nov 2022 16:35:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: use min() for comparison and
 assignment
Message-ID: <20221112163532.16a4dd12@jic23-huawei>
In-Reply-To: <Y2p3eIQjdyBWs1xD@ubunlion>
References: <Y2iFGA3A1w+XMlYU@qemulion>
        <Y2px0THYSMaU4gyZ@kroah.com>
        <Y2p3eIQjdyBWs1xD@ubunlion>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 21:06:24 +0530
Deepak R Varma <drv@mailo.com> wrote:

> On Tue, Nov 08, 2022 at 04:12:17PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 07, 2022 at 09:40:00AM +0530, Deepak R Varma wrote:  
> > > Simplify code by using recommended min helper macro for logical
> > > evaluation and value assignment. This issue is identified by
> > > coccicheck using the minmax.cocci file.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > > index a9a06e8dda51..a6ce7b24cc8f 100644
> > > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > > @@ -61,7 +61,7 @@ static int ade7854_i2c_write_reg(struct device *dev,
> > >  unlock:
> > >  	mutex_unlock(&st->buf_lock);
> > >
> > > -	return ret < 0 ? ret : 0;
> > > +	return min(ret, 0);  
> >
> > As others have said, this isn't ok, and I hate ? : usage, so if you
> > want, spell that out please.  
> 
> Hello Greg,
> Just want to make sure I am getting it right:
> Are you suggesting me to resubmit the patch with revised patch description?
> 
> Should I consider using the "if" based evaluation rather than using min() macro?

For IIO staging drivers, I'd take a cleanup that moved to

	if (ret < 0)
		return ret;

	return 0;

As others have suggested though, not a good idea to do this broadly as it
would be a lot of noise.  We don't mind noise so much for staging drivers :)

Jonathan

> 
> Thank you,
> ./drv
> 
> >
> > thanks,
> >
> > greg k-h
> >  
> 
> 

