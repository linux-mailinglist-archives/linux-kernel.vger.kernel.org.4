Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5FE5B7DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiINAoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINAoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:44:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7F117D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e5so13325147pfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JXX2yS5w/1K++xKOiGHpDn/FwBROGsdDBxX7sv52/PA=;
        b=QaZWAqqjlNSnM9eoLwGlfdcvS5Nm3ykDJiGkepiKjoJDuzOmgk+LeqWTuJlwQ2hnrN
         8RdxOL9ObiMEmA6sPW8bi2Iq/ETi05CQIn5QvWwuchqlHThXGXJWIPupmIWIdEzmbqqI
         FV9XsXAZ5+surbB9bBKoTYDFfdxjtW8Rx1wpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JXX2yS5w/1K++xKOiGHpDn/FwBROGsdDBxX7sv52/PA=;
        b=PryTJBriHpFeNiIE/WZGU4lms0K3v/UidzL1NUBI7bPzwEX6YhXphrbPj5izyvGFfF
         Rgm675bghvjn/a9V77+Bpuq3odHVUXzWfd40vHCNlTcAguI1gMaQ4lnrCqqc9T9itdX+
         ZOSI+uLcVgnvyVUny7HZYX9Sv6OwNckLa3DzRZeNQitFi0mbWRaUFvfY2KNVQCr25RR5
         yIviVw7dZGU/mWYXQHO0oIf/oGUfB6U5suC9x8fn0bDKw8oZWFEBmAoI8eWEpFYTywe3
         srFKIy+oIP6bzu0G5DVaZtl+8qUANatFi6IZw89XjvDCSuC/GzSSCNhwclEeD1ngbEPY
         irRg==
X-Gm-Message-State: ACgBeo3te047bAxPIJpLp1lsd9DwXX2I6NO/9P12lWXKCthZKf6PxBw+
        uRV5f3rqsrG7vqLW+br6/WXI0w==
X-Google-Smtp-Source: AA6agR6ajxSwu4MvfAwZmD5yw6opa0TwZ5rTZVuxPSBg77ll7+TMZQhGr2Z2ZdDujviVh4x3iCUFeg==
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id e132-20020a63698a000000b0041c8dfae622mr29387714pgc.465.1663116275332;
        Tue, 13 Sep 2022 17:44:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c6e2:a019:5c54:fb4c])
        by smtp.gmail.com with ESMTPSA id 21-20020a621515000000b0053e5ebafd5csm8462402pfv.189.2022.09.13.17.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 17:44:34 -0700 (PDT)
Date:   Tue, 13 Sep 2022 17:44:32 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: rockchip: i2s: use regmap_read_poll_timeout to
 poll I2S_CLR
Message-ID: <YyEj8FC9YtnCScWW@google.com>
References: <20220908151142.1479810-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908151142.1479810-1-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judy,

On Thu, Sep 08, 2022 at 03:11:42PM +0000, Judy Hsiao wrote:
> Use regmap_read_poll_timeout to poll I2S_CLR.
> It also fixes the 'rockchip-i2s ff070000.i2s; fail to clear' and
> return -EBUSY when the read of I2S_CLR exceeds the retry limit.
> 
> Fixes: 0ff9f8b9f592 ("ASoC: rockchip: i2s: Fix error code when fail
> to read I2S_CLR")
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

Thanks for the patch!

> ---
>  sound/soc/rockchip/rockchip_i2s.c | 39 +++++++++++++------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index f5f3540a9e18..02905eec615e 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -163,18 +163,14 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
>  						 I2S_CLR_TXC | I2S_CLR_RXC);
>  			if (ret < 0)
>  				goto end;
> -			regmap_read(i2s->regmap, I2S_CLR, &val);
> -
> -			/* Should wait for clear operation to finish */
> -			while (val) {
> -				regmap_read(i2s->regmap, I2S_CLR, &val);
> -				retry--;

I think you're leaving |retry| as a "set but unused" variable now.
Presumably some compile-testing bots will eventually complain at you
about that.

> -				if (!retry) {
> -					dev_warn(i2s->dev, "fail to clear\n");
> -					ret = -EBUSY;
> -					break;
> -				}
> -			}
> +			ret = regmap_read_poll_timeout(i2s->regmap,
> +						       I2S_CLR,
> +						       val,
> +						       val != 0,
> +						       20,
> +						       200);
> +			if (ret < 0)
> +				dev_warn(i2s->dev, "fail to clear\n");

Now would be a good time to print the return code, I think:

				dev_warn(i2s->dev, "fail to clear: %d\n", ret);

>  		}
>  	}
>  end:
> @@ -226,17 +222,14 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
>  						 I2S_CLR_TXC | I2S_CLR_RXC);
>  			if (ret < 0)
>  				goto end;
> -			regmap_read(i2s->regmap, I2S_CLR, &val);
> -			/* Should wait for clear operation to finish */
> -			while (val) {
> -				regmap_read(i2s->regmap, I2S_CLR, &val);
> -				retry--;
> -				if (!retry) {

Same.

> -					dev_warn(i2s->dev, "fail to clear\n");
> -					ret = -EBUSY;
> -					break;
> -				}
> -			}
> +			ret = regmap_read_poll_timeout(i2s->regmap,
> +						       I2S_CLR,
> +						       val,
> +						       val != 0,
> +						       20,
> +						       200);
> +			if (ret < 0)
> +				dev_warn(i2s->dev, "fail to clear\n");

Same.

>  		}
>  	}
>  end:

Otherwise, this is definitely a good change, since we have no timing
guarantee on the existing retry loop, which will surely make it flaky.
So, with those fixups:

Reviewed-by: Brian Norris <briannorris@chromium.org>
