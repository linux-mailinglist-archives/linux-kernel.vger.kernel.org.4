Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DD7399B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFVI3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFVI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:29:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672610F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:29:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so88959921fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687422537; x=1690014537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUNHcEJG07SoCQaxwPGNbUW0t5R9cbW41hlRYoBzaus=;
        b=YOAd/JaQq9is9qjebHkTUkyQPTUOb+1259V/wKR2Ogpv/U3PqfIPnudJZlaS7SKngv
         SXFRLXHa/Kz19kxI9SQ64VN73I4YSfyi7ga10dg4GXZ9B4aRDVA4fzMeVGpphaiWXfWK
         CO9hBMnu89Jk01z4COz77oY3HInwcJUFecCO5HYvlWEade0SNxFhYYMjE6S4YUkCtsd+
         taMrYZkj2OMezaU90R+km5yRttOtZm+nRUYHthwmOJjtX9fq5aOoRyXtfZY4XmA8YbwX
         T8F3HtA6xdrZcWv5kJbkcvcibTOQtOEnUajfRJ4lSjw7MCCu7YZvVD7hdGUEwzNTe5rv
         xYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422537; x=1690014537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUNHcEJG07SoCQaxwPGNbUW0t5R9cbW41hlRYoBzaus=;
        b=arJEoj7TkcznZEHNWMyMWCVA4VzozvhqnR0hd9lpxJCg35r0cCZV982SbbyvC7D/PB
         LqCaDiiMlhr0ZqptRmm3Nn5fjphK+H7N/j3cDDvsh24od4meJxcfeZfAtxz+pMHRn/7y
         uDMiore8RKPTRSGKnC/G3szDqFmgDZAyA3Sn5Hilz1cyar9opHWToR64e7TEvBJbAFTO
         4u3g8K0rU8gn0J/MSbDBOLd5wbWEpGYdDAlJIQtqCM5r2nb/7hmav4yG1JwoyF95YIbw
         LOOY49oaOW6eKOJ4NquFp4A4Xn8bxSFpIJwrRul94yNh70vObSaTjeFkr4NHcoErp9o8
         PMpw==
X-Gm-Message-State: AC+VfDz0XKxVwqSB8l4G8blztZg4OMLCYMFOguXbUPFKASDsgJb/iOc2
        ZQJQSUbXG5CLxQTS8bKstyoBzw==
X-Google-Smtp-Source: ACHHUZ6ZhpjSmKGXscMdJ//8nPVkrLvdVZxes3XVpiJJmbryfmvcI2I5PLTcJA5Qu4NbEDIS55hb6g==
X-Received: by 2002:a19:2d58:0:b0:4f8:5755:5b22 with SMTP id t24-20020a192d58000000b004f857555b22mr10234981lft.27.1687422536244;
        Thu, 22 Jun 2023 01:28:56 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d5142000000b003113dc327fbsm6464461wrt.22.2023.06.22.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:28:55 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:28:54 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 2/8] soc: mediatek: pm-domains: Move bools to a flags
 field
Message-ID: <20230622082854.2767ujlhpzgejqn2@blmsp>
References: <20230619085344.2885311-1-msp@baylibre.com>
 <20230619085344.2885311-3-msp@baylibre.com>
 <3404135b-a893-523d-c776-3b6d10227049@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3404135b-a893-523d-c776-3b6d10227049@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Mon, Jun 19, 2023 at 11:32:18AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/06/23 10:53, Markus Schneider-Pargmann ha scritto:
> > To simplify the macros, use a flags field for simple bools. This is in
> > preparation for more flags.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c |  6 +++---
> >   drivers/soc/mediatek/mtk-pm-domains.h | 19 +++++++++++--------
> >   2 files changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 354249cc1b12..aa9ab413479e 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -128,7 +128,7 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
> >   		if (!mask)
> >   			break;
> > -		if (bpd[i].bus_prot_reg_update)
> > +		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
> >   			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> > @@ -165,12 +165,12 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> >   		if (!mask)
> >   			continue;
> > -		if (bpd[i].bus_prot_reg_update)
> > +		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
> >   			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
> > -		if (bpd[i].ignore_clr_ack)
> > +		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
> >   			continue;
> >   		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index 5ec53ee073c4..e26c8c317a6b 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -42,23 +42,27 @@
> >   #define SPM_MAX_BUS_PROT_DATA		6
> > -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
> > +enum scpsys_bus_prot_flags {
> > +	BUS_PROT_REG_UPDATE = BIT(1),
> > +	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
> > +};
> > +
> > +#define _BUS_PROT(_mask, _set, _clr, _sta, _flags) {		\
> >   		.bus_prot_mask = (_mask),			\
> >   		.bus_prot_set = _set,				\
> >   		.bus_prot_clr = _clr,				\
> >   		.bus_prot_sta = _sta,				\
> > -		.bus_prot_reg_update = _update,			\
> > -		.ignore_clr_ack = _ignore,			\
> > +		.flags = _flags					\
> >   	}
> >   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
> > +		_BUS_PROT(_mask, _set, _clr, _sta, 0)
> >   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
> > +		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_IGNORE_CLR_ACK)
> >   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
> > +		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_REG_UPDATE)
> >   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
> >   		BUS_PROT_UPDATE(_mask,				\
> > @@ -71,8 +75,7 @@ struct scpsys_bus_prot_data {
> >   	u32 bus_prot_set;
> >   	u32 bus_prot_clr;
> >   	u32 bus_prot_sta;
> > -	bool bus_prot_reg_update;
> > -	bool ignore_clr_ack;
> > +	u32 flags;
> 
> As far as I understand, we don't expect more than six bits to be populated as bus
> protection flags, so we can save some memory by changing that to u8...

Thank you. Yes, also we can change it later if we need more flags at
some point. I will change it. But I guess it won't save any memory as
the compiler probably aligns the struct.

Best,
Markus

> 
> ...after which:
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Regards,
> Angelo
