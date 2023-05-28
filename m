Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E246E713B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjE1RQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1RQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A51B1;
        Sun, 28 May 2023 10:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797E760C2E;
        Sun, 28 May 2023 17:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A5FC433EF;
        Sun, 28 May 2023 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685294163;
        bh=QymTZLOdk4+8f9DlR3EZDLBNA9Q41r5+dqZ3Xj8eYv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7ejmL4oVaKREEyWRLRvA/TkriUb62jLjaSMjnug4T83YaJSSlWBBrhAup/+nKNHa
         hYj2XZ798Pe3isC8RhJTpJ4GOFfNxuEjugIow0QOooYyN7RMuejMoIxfui3/grpnmb
         UWFrgJjXNwSyPm9+4+F3elHq4DGojTv1kaWApnnyPO29c2jQQ+/8essiC7kXg4VzUZ
         N8or61LvcsqEUM/6/dWIR/iHyhmIofY6q5nXCW2H3SntTBCRkCbwB8OU3J2wptELUI
         xU1xl2LVO0UYCUT5xMVkfAw4mqpeiQhaKs+WX6aydu62ipuL1C9SGdM1kw9drrXoF6
         kBF1CYO2fOXTA==
Date:   Sun, 28 May 2023 18:32:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/9] iio: inkern: Check error explicitly in
 iio_channel_read_max()
Message-ID: <20230528183221.36407e8d@jic23-huawei>
In-Reply-To: <20230523151223.109551-4-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-4-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 17:12:17 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The current implementation returns the error code as part of the
> default switch case.
> This can lead to returning an incorrect positive value in case of
> iio_avail_type enum entries evolution.
> 
> In order to avoid this case, be more strict in error checking.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
It's an odd code construct, so in the interests of robustness this
looks like a good improvement to me.

Given the later patch you need for this series will see some fuzz
I think if I pick this up separately I'll currently assume this whole
series will go together.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/inkern.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 872fd5c24147..f738db9a0c04 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  		val2 = &unused;
>  
>  	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
> +	if (ret < 0)
> +		return ret;
> +
>  	switch (ret) {
>  	case IIO_AVAIL_RANGE:
>  		switch (*type) {
> @@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  		return 0;
>  
>  	default:
> -		return ret;
> +		return -EINVAL;
>  	}
>  }
>  

