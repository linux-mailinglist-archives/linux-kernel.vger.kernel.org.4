Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE161333B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJaKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJaKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:07:01 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF9DF76;
        Mon, 31 Oct 2022 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667210786; bh=HVFcKalrqVMRbmdZAkMzLwZC0a2WrrG0XS7qk33EsGE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=QCIc4XbmZ8KV7vNQ87djZ7QmPWllpqkFXsk8YI+xrr/sfBTIrJ202ch51OMWvTBxL
         hI37h1K+9uJ7nLPz1whq4WgZksQzyLCv5amOiiOMp1IeSYMPDZZJnN5Qa1QuQ4XSbm
         Tfqa9fzci/AcUmU55Vetwjp1SCjXdQB4+Cc68RFA=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 11:06:26 +0100 (CET)
X-EA-Auth: 1a5viqWGMQ4L4O2TH9RfFTgPhO6OEceNDEDbuwFwr9bd6cvaPQrORviVhAVhWL9/eY4g/AIWOHuGtdXjKlYl6p/gFcutTA1d
Date:   Mon, 31 Oct 2022 15:36:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Message-ID: <Y1+eHU9gcKcW2Zsf@ubunlion>
References: <Y1r4EaDvEipzhaaf@ubunlion>
 <Y1zbyJPF+YUY6xIh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1zbyJPF+YUY6xIh@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:52:40AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 28, 2022 at 02:58:49AM +0530, Deepak R Varma wrote:
> > do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> > which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> > to avoid a possible truncation. Issue was identified using the
> > coccicheck tool.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > index f177b20f0f2d..730bb31a20d8 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -196,7 +196,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
> >  	} dat;
> >
> >  	freqreg = (u64)freq * (u64)(1 << 27);
> > -	do_div(freqreg, st->mclk_hz / 4);
> > +	freqreg = div64_ul(freqreg, st->mclk_hz / 4);
> >
> >  	switch (reg) {
> >  	case AD5933_REG_FREQ_START:
> > --
> > 2.34.1
>
> No, this isn't ok, please read the mailing list archives for why these
> changes are not going to be accepted:
> 	https://lore.kernel.org/r/e2ec77060cc84a33b49d5fd11d7867f6@AcuMS.aculab.com
>
> Please always at least look at the archives of the past few weeks as to
> if changes like this are able to be accepted or not.

Hello Greg,
My apologies for not looking at the lore mailing archive. I only looked at the
past git commits and found a few similar changes accepted in the past. My bad. I
will always look at the mailing archive as well going forward.

There are other review comments from the experts on similar patches. I
appreciate everyone's time and comment. I will look at those and revert
accordingly.

Thank you,
./drv
>
> thanks,
>
> greg k-h


