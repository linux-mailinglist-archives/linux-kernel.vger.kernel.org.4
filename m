Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAE6B769A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCMLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCMLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:50:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECC19F32
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:50:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so7650732wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678708194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2e76SVF27ZugGmUDflwqLOuHVazSHBJvoHoACHILcw=;
        b=SHO5FThiChWqlKWWisdxKbcKmWAq5E7zsKeOUnXcnwQBkwC47QFequMG0bYlwzsER8
         ZXVtPSWZxaliGD1jWU+bemIkR5WPBWIzCkE54EZNrfkDwvlpOpMyAGHEpjdnGzZteM7j
         D/4JP3omJq8WZ/WqShov0gsd+cytY3CLyYbZDTbVK1Tm1tPQjmoAjDMTebXg+X3CDBv7
         VTk+q8kFRWLHcqkMoP8bVzuYeuN8BzJ2z3bPsRpVryiAQU9c7Vr4W77NVNQH11jaSxVI
         OA0/i1wDBQUVN1Mn0skO5xps8iDNOB87TDD/VCrgxRT4XMJzoGZZlx632mT/+VIxU2qB
         hzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2e76SVF27ZugGmUDflwqLOuHVazSHBJvoHoACHILcw=;
        b=BTMtLLYTYDh9DvyBWP/v/ZbbX4B9FwLsA1anhlvp+Bjenl7LLis3xwaDftZXkVEvU7
         l5WT7kqF40p3Fdi2iziH1x9wlVZQm7Uar2XrbbpkqXITp8FWkhve+5d0pHw1yuBt+fd2
         X1v5l+GUzZdUEd4r490vpDtITHrD9h2HQqbeqdLvHtF+1rk7v+StmCtNyUXHzJqfHuQo
         ig43nA0AoEEJCuwMfhdc6K5hqT9ykheChTmHujQk1M4nue0MamK5TEV6YMB44YoYtS+L
         IbB5X66x8QqJnryyjiv+PwLbgbo3bWUJbeKCSz0ABBdNOnk/AxV3Hu/4sDs39O1aDGYk
         jnng==
X-Gm-Message-State: AO0yUKW+8YpqT1t6J+aHhHoO2sLQQIRiZG3L+Vt3CCy9Ky89L9mZZeXk
        1litEZ/OYFSKCqnIZUDhO08jpw==
X-Google-Smtp-Source: AK7set8meTjPh/Br20yfI40uXRcIqhSc5RR5NsQ7qx9l4QuOIWQ99K59We2ke8ThU4vOtSCCxDgBsw==
X-Received: by 2002:a05:600c:3c9e:b0:3e1:f8af:8772 with SMTP id bg30-20020a05600c3c9e00b003e1f8af8772mr10250341wmb.9.1678708194053;
        Mon, 13 Mar 2023 04:49:54 -0700 (PDT)
Received: from blmsp ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003e209186c07sm9889227wms.19.2023.03.13.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:49:53 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:49:52 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/8] soc: mediatek: pm-domains: Create bus protection
 operation functions
Message-ID: <20230313114952.b6o4qngyyd7eup6d@blmsp>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-4-msp@baylibre.com>
 <fb36ce3f-dd67-32b5-7ce0-ad15dd3b540a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb36ce3f-dd67-32b5-7ce0-ad15dd3b540a@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Feb 03, 2023 at 01:32:11PM +0100, Matthias Brugger wrote:
> 
> 
> On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> > Separate the register access used for bus protection enable/disable into
> > their own functions. These will be used later for WAY_EN bits.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c | 68 +++++++++++++++------------
> >   1 file changed, 39 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 4333cd297405..999e1f6c86b0 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -117,26 +117,50 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
> >   					MTK_POLL_TIMEOUT);
> >   }
> > +static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
> > +				    struct regmap *regmap)
> > +{
> > +	u32 val;
> > +	u32 sta_mask = bpd->bus_prot_sta_mask;
> > +
> > +	if (bpd->bus_prot_reg_update)
> > +		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> > +	else
> > +		regmap_write(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> > +
> > +	if (bpd->ignore_clr_ack)
> > +		return 0;
> > +
> > +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> > +					val, !(val & sta_mask),
> > +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +}
> > +
> 
> NIT: please move this function below
> static int scpsys_bus_protect_enable(struct scpsys_domain *pd) {...}
> 
> This allows for better readability.

With the WAY_EN patch later in this series scpsys_bus_protect_enable()
is going to use scpsys_bus_protect_clear(). So I would need to add a
signature in that patch for scpsys_bus_protect_clear() or move it back
up. I would prefer to avoid adding a signature or moving so I added it
above these functions here. I could swap scpsys_bus_protect_set() and
scpscpsys_bus_protect_clear() if that helps readability.

Thank you,
Markus

> 
> > +static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
> > +				  struct regmap *regmap)
> > +{
> > +	u32 val;
> > +	u32 sta_mask = bpd->bus_prot_sta_mask;
> > +
> > +	if (bpd->bus_prot_reg_update)
> > +		regmap_set_bits(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
> > +	else
> > +		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
> > +
> > +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> > +					val, (val & sta_mask) == sta_mask,
> > +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +}
> > +
> >   static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> >   {
> >   	int i, ret;
> >   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> > -		u32 val;
> > -		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> > -		u32 sta_mask = bpd[i].bus_prot_sta_mask;
> > -
> > -		if (!set_clr_mask)
> > +		if (!bpd[i].bus_prot_set_clr_mask)
> >   			break;
> > -		if (bpd[i].bus_prot_reg_update)
> > -			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
> > -		else
> > -			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
> > -
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, (val & sta_mask) == sta_mask,
> > -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +		ret = scpsys_bus_protect_set(&bpd[i], regmap);
> >   		if (ret)
> >   			return ret;
> >   	}
> > @@ -161,24 +185,10 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> >   	int i, ret;
> >   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> > -		u32 val;
> > -		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
> > -		u32 sta_mask = bpd[i].bus_prot_sta_mask;
> > -
> > -		if (!set_clr_mask)
> > -			continue;
> > -
> > -		if (bpd[i].bus_prot_reg_update)
> > -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
> > -		else
> > -			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
> > -
> > -		if (bpd[i].ignore_clr_ack)
> > +		if (!bpd[i].bus_prot_set_clr_mask)
> >   			continue;
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, !(val & sta_mask),
> > -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
> >   		if (ret)
> >   			return ret;
> >   	}
