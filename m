Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE326F266E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjD2UZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2UZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:25:51 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212E10C1;
        Sat, 29 Apr 2023 13:25:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5552F3F3E9;
        Sat, 29 Apr 2023 22:25:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.109
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g91uDSAk5U-I; Sat, 29 Apr 2023 22:25:43 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4BC073F225;
        Sat, 29 Apr 2023 22:25:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id DA242A0CDD;
        Sat, 29 Apr 2023 20:25:42 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GLtElPNrzDkS; Sat, 29 Apr 2023 20:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 78AA9A0CD7;
        Sat, 29 Apr 2023 20:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 78AA9A0CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1682799940;
        bh=YnIJQOsfQm0efxbzTbCvVv9yuvHN4d+rjyJLsyaUdL8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QcCtWINQBr/FaGw6vE3x7dynIh7YcWCKEf/AZEQhRJEqIUtWVOAWj6Euu3PtQoYnA
         UZSEBfM1EMkTbGS30B215/ufxORvkeqDx0Q9KRgZE3YkFBwDY+2Djsx9/5x9lTjoVq
         hJehaas5tF/Ub1YjOL/0hLmWFJBXzl0mRIFIszj0MNapvp43PFs27I5eX+vMgZItLB
         wJyxZkGsURc23rzLJqn9PE2cdq6oXeyLvjT1sgoUVC0CqfZ++93b7CavD7N92JZG1V
         kqH3YsGjWVcs0iGYfl00FXCoseqLm8WQrsma6A002QXQZxQFIHb2h2ebHXB8eRGCiX
         cLtj8J+Z7fBHQ==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0LVYyFRwZBmi; Sat, 29 Apr 2023 20:25:40 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 0783CA0CCF;
        Sat, 29 Apr 2023 20:25:40 +0000 (UTC)
Date:   Sat, 29 Apr 2023 22:25:38 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas: fix off by one bugs
Message-ID: <20230429202538.GC1404696@dalakolonin.se>
References: <14fee94a-7db7-4371-b7d6-e94d86b9561e@kili.mountain>
 <20230423141124.3d4dc91d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141124.3d4dc91d@jic23-huawei>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 02:11:24PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Apr 2023 13:41:56 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Valid values for "adc_chan" are zero to (PALMAS_ADC_CH_MAX - 1).
> > Smatch detects some buffer overflows caused by this:
> > drivers/iio/adc/palmas_gpadc.c:721 palmas_gpadc_read_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16
> > drivers/iio/adc/palmas_gpadc.c:758 palmas_gpadc_write_event_value() error: buffer overflow 'adc->thresholds' 16 <= 16
> > 
> > The effect of this bug in other functions is more complicated but
> > obviously we should fix all of them.
> > 
> > Fixes: a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Looks good to me.  Slight shuffle at the moment will delay me applying this.
> 
> I'll wait for Linus to pick up Greg's pull request then rebase my fixes branch
> on top of that.  Otherwise I make a mess of linux-next ordering and things might
> blow up.
> 
> In meantime, Patrik, please take a look.

Sorry for the long delay.

The changes look good to me. I've checked all other uses of adc_chan in the
code and they all seem to be guarded by the checks below.

Best regards
Patrik

> 
> Jonathan
> 
> > ---
> > ---
> >  drivers/iio/adc/palmas_gpadc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> > index c1c439215aeb..7dfc9c927a23 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -547,7 +547,7 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
> >  	int adc_chan = chan->channel;
> >  	int ret = 0;
> >  
> > -	if (adc_chan > PALMAS_ADC_CH_MAX)
> > +	if (adc_chan >= PALMAS_ADC_CH_MAX)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&adc->lock);
> > @@ -595,7 +595,7 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
> >  	int adc_chan = chan->channel;
> >  	int ret = 0;
> >  
> > -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> > +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&adc->lock);
> > @@ -684,7 +684,7 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
> >  	int adc_chan = chan->channel;
> >  	int ret;
> >  
> > -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> > +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&adc->lock);
> > @@ -710,7 +710,7 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
> >  	int adc_chan = chan->channel;
> >  	int ret;
> >  
> > -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> > +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&adc->lock);
> > @@ -744,7 +744,7 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> >  	int old;
> >  	int ret;
> >  
> > -	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> > +	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&adc->lock);
> 
