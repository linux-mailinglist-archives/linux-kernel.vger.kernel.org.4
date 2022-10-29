Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C74612121
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ2Hvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ2Hvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD731726A0;
        Sat, 29 Oct 2022 00:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5728260CF2;
        Sat, 29 Oct 2022 07:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613DC433D6;
        Sat, 29 Oct 2022 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667029904;
        bh=IVYCEUyFNGvt9P7E4kn2YygjCjJ8FPO0YNOwwJNd4Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAoV7eUB1tTRPhFcdphtmUuG851jzTwwnizNydu/GTOP2TWWHCf5K0b99J9gfHqRB
         DCtN5/RunER84XlIqozB/bSgRywWxlCM+9WJtlJS6BZzdZg0FJSF8w691ts3yqRjPk
         b1Lvp4A9mNtFHQAmELkv++afpX77794kgLSTYCeA=
Date:   Sat, 29 Oct 2022 09:52:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Message-ID: <Y1zbyJPF+YUY6xIh@kroah.com>
References: <Y1r4EaDvEipzhaaf@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1r4EaDvEipzhaaf@ubunlion>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:58:49AM +0530, Deepak R Varma wrote:
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation. Issue was identified using the
> coccicheck tool.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index f177b20f0f2d..730bb31a20d8 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -196,7 +196,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
>  	} dat;
> 
>  	freqreg = (u64)freq * (u64)(1 << 27);
> -	do_div(freqreg, st->mclk_hz / 4);
> +	freqreg = div64_ul(freqreg, st->mclk_hz / 4);
> 
>  	switch (reg) {
>  	case AD5933_REG_FREQ_START:
> --
> 2.34.1

No, this isn't ok, please read the mailing list archives for why these
changes are not going to be accepted:
	https://lore.kernel.org/r/e2ec77060cc84a33b49d5fd11d7867f6@AcuMS.aculab.com

Please always at least look at the archives of the past few weeks as to
if changes like this are able to be accepted or not.

thanks,

greg k-h
