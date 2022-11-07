Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9964F61F75C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKGPPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiKGPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:15:37 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F21EAF8;
        Mon,  7 Nov 2022 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667834105; bh=jv4L3CMeB4iLALBmYv14TMVcf39jXzd1TidE3Takkv4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Ia4gLgAFQpTDBH6+JLLSOZxZNBdVFuEzqSypZeFYPEzFM6O1lmzAi0JE6e/srpXTj
         /2xc+xGctFYUCfblUIsTIELcxwpMQ0wJVoqHAK1tuxpedPCOst+ZeS85jlBdNlVeRI
         bNR974G2RUjeQtOKYTVxp1MaRaD2+Vma40LcqL2Y=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 16:15:05 +0100 (CET)
X-EA-Auth: MrUVv6JFM3UQRU8f0izViYsX4i9dq+0Kl5xYHlgXIlPtB/51k3XCAWeWfHnd4CB3gHATy+AJR4jDoNRz5Ft0sRJvECjcN/TQ
Date:   Mon, 7 Nov 2022 20:45:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: use min() for comparison and
 assignment
Message-ID: <Y2kg9JTuw2erSrpW@qemulion>
References: <Y2iFGA3A1w+XMlYU@qemulion>
 <Y2kDTxE38epBN368@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kDTxE38epBN368@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:08:31PM +0300, Dan Carpenter wrote:
> On Mon, Nov 07, 2022 at 09:40:00AM +0530, Deepak R Varma wrote:
> > Simplify code by using recommended min helper macro for logical
> > evaluation and value assignment. This issue is identified by
> > coccicheck using the minmax.cocci file.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > index a9a06e8dda51..a6ce7b24cc8f 100644
> > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > @@ -61,7 +61,7 @@ static int ade7854_i2c_write_reg(struct device *dev,
> >  unlock:
> >  	mutex_unlock(&st->buf_lock);
> >
> > -	return ret < 0 ? ret : 0;
> > +	return min(ret, 0);
>
> The original code is better.
>
> If it's a failure return the error code.  If it's not return zero.
>
> You can only compare apples to apples.  min() makes sense if you're
> talking about two lengths.  But here if ret is negative that's an error
> code.  If it's positive that's the number of bytes.  If the error
> code is less than the number of bytes then return that?  What???  It
> makes no sense.

Thanks for your view point. I agree.

>
> In terms of run time, this patch is fine but in terms of reading the
> code using min() makes it less readable.

Okay, The proposal does not make much difference, so will leave the original
line as is.

Thank you,
./drv

>
> regards,
> dan carpenter
>


