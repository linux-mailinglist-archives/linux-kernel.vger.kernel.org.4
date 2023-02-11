Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25869325E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBKQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBKQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:21:26 -0500
X-Greylist: delayed 33228 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Feb 2023 08:21:25 PST
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7920059;
        Sat, 11 Feb 2023 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676132463; bh=CnozGf696smlnqdIfOsGrj7K/FPRT6au4EHQagIVyR8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=ieZuF5e6yke93hydMcktjOeyTVMvX2Xxlrjv+1F94XS3wuBuax5yU3z7+YFmnjP2n
         A7Ve/uxMy5tL7TIbkQJ6roVroxlFLa6qx/0axhgU8oq14I9DtyzAiiYnJEcCf65E8i
         Glz2nBZkZDbq9nS8xvuZ1XoyTqVMW+KScWruhzIk=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 17:21:03 +0100 (CET)
X-EA-Auth: ks8YNUkFdpg7ViiM4CJQXhdMIZE0fEKRUJdSGq0D5uhEGOoj5TtI6YGtls3HF1PwSMpnuRE2b30/kzt6Y8d3kVTlh5sHRzbm
Date:   Sat, 11 Feb 2023 21:50:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] iio: frequency: adf4377: remove duplicate/repeating
 constant
Message-ID: <Y+fAa5N3YbMW6yJt@ubun2204.myguest.virtualbox.org>
References: <Y+c+mwNnlPpSH49/@ubun2204.myguest.virtualbox.org>
 <1f9d31ad-db91-a6b9-3a70-cfc983cd99b7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f9d31ad-db91-a6b9-3a70-cfc983cd99b7@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 03:57:51PM +0100, Christophe JAILLET wrote:
> Le 11/02/2023 à 08:07, Deepak R Varma a écrit :
> > Constant ADF4377_0000_SOFT_RESET_R_MSK is unnecessarily or'ed with
> > itself. Remove the redundant constant from the expression.
> > Issue identified using doublebitand.cocci Coccinelle semantic patch.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >   drivers/iio/frequency/adf4377.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> > index 26abecbd51e0..caefd7ea6b14 100644
> > --- a/drivers/iio/frequency/adf4377.c
> > +++ b/drivers/iio/frequency/adf4377.c
> > @@ -495,8 +495,8 @@ static int adf4377_soft_reset(struct adf4377_state *st)
> >   		return ret;
> >   	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> > -					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
> > -					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
> > +					!(read_val & ADF4377_0000_SOFT_RESET_R_MSK),
> > +					200, 200 * 100);
> 
> Based on the code just above, it is likely that one is expected to be
> ADF4377_0000_SOFT_RESET_MSK.

Hello CJ,
I agree, that appears to be a close possibility. I also tried looking to the
data sheet, but could not conclude.
How can I make sure if the other one should be ADF4377_0000_SOFT_RESET_MSK?

Thank you,
./drv

> 
> CJ
> 
> >   }
> >   static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
> 


