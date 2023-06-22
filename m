Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D05739A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjFVIjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFVIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:39:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB51172C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:39:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so18181535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687423163; x=1690015163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0QqmAQxOCR9WmyA23FO0tDkyVaDJkVOchcGpmQ0H/8=;
        b=XMaCJjKqW64Yy/LmmNWkpqgOj2SUtVYd3epL2r3fO0e0ME7TIk+5jjo0YshG/cuL2u
         tG0j4wXaDWG4o1RJSVVJ9rZP95Lojji79Hd2LIIAdM1EFhizse5pJ4yIfLGIm1JKefF9
         Jb5o/pIP5JHLuMtj3gflBmdX6gcSSk+KQhDWAuCnE9yl7dEc/StdNxmFNppJA6vZKBJ5
         TMYfF0WqihTmrqsG1UFFD3aYi+QQ3QjNuyK8VZtCnImehzgd/SMi7MH47vPJ9IKpYupl
         +SuIw+C8gKIK95jV+z6mFX0PEOh/KW39qTClmuIbETjlz2mRPsh55XSKUfjTWz7qmmFp
         3QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423163; x=1690015163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0QqmAQxOCR9WmyA23FO0tDkyVaDJkVOchcGpmQ0H/8=;
        b=j/nR8svz5BqaHIA8jb71t9Yf/6cZqneH1fVK/KYZNJWzJ0nph9+IvPBeaG5exY37yP
         NWpuJ8T++9EB14JmWRusY3Erbx1aX6QIZlHuQMtrdxjQShf/PlqiVgSUoNiyrMnmfF6V
         SbwZPFh16blG48l4siCxeizYrgTRhLU+laC2wlvzT2qsWGy26qD5kCY0CHdA816Xzilr
         h/hyyditIK+4obQlngSzlu5TQb1DeG+oF2vSxMP/mRAoOJJS5fYPbDO/Jea2kdPNN71Q
         FNoJZc1Zm+iBKtFAQ4h86P9ZJEVJTEs9SeY8heHu0goAkg0xEGaTPXHGgVY7SWcaLhFB
         9ohQ==
X-Gm-Message-State: AC+VfDwfToJ4i1RBZdCGz5R+iQUDA4BKDvcIctCO2kIERnmFUv87HJce
        CyvP3xZwDivVdE0Jv5hc1KmhMw==
X-Google-Smtp-Source: ACHHUZ7mpwDUJPJ7OoyLIcf/xBMWHPZvalvdPraKrRy+zIL4pkaLJvM3fuZBbBMIi1AxFGcjtxYj1Q==
X-Received: by 2002:a7b:cd89:0:b0:3fa:77f2:e255 with SMTP id y9-20020a7bcd89000000b003fa77f2e255mr141451wmj.5.1687423163274;
        Thu, 22 Jun 2023 01:39:23 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id hn10-20020a05600ca38a00b003f60eb72cf5sm18433877wmb.2.2023.06.22.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:39:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:39:21 +0200
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
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v5 6/8] soc: mediatek: Add support for WAY_EN operations
Message-ID: <20230622083921.tc3wsl6jyluenmru@blmsp>
References: <20230619085344.2885311-1-msp@baylibre.com>
 <20230619085344.2885311-7-msp@baylibre.com>
 <590f9a11-a153-abaf-0f99-9496882ee929@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <590f9a11-a153-abaf-0f99-9496882ee929@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:29:18AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/06/23 10:53, Markus Schneider-Pargmann ha scritto:
> > From: Alexandre Bailon <abailon@baylibre.com>
> > 
> > This updates the power domain to support WAY_EN operations. WAY_EN
> > operations on mt8365 are using a different component to check for the
> > acknowledgment, namely the infracfg-nao component. Also to enable a way
> > it the bit needs to be cleared while disabling a way needs a bit to be
> > set. To support these two operations two flags are added,
> > BUS_PROT_INVERTED and BUS_PROT_STA_COMPONENT_INFRA_NAO. Additionally
> > another regmap is created if the INFRA_NAO capability is set.
> > 
> > This operation is required by the mt8365 for the MM power domain.
> > 
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c | 39 +++++++++++++++++++++++----
> >   drivers/soc/mediatek/mtk-pm-domains.h |  7 +++--
> >   2 files changed, 39 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 3cdf62c0b6bd..4659f0a0aa08 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -44,6 +44,7 @@ struct scpsys_domain {
> >   	struct clk_bulk_data *clks;
> >   	int num_subsys_clks;
> >   	struct clk_bulk_data *subsys_clks;
> > +	struct regmap *infracfg_nao;
> >   	struct regmap *infracfg;
> >   	struct regmap *smi;
> >   	struct regulator *supply;
> > @@ -127,13 +128,26 @@ static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
> >   		return pd->infracfg;
> >   }
> > +static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
> > +							const struct scpsys_bus_prot_data *bpd)
> > +{
> > +	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
> > +		return pd->infracfg_nao;
> > +	else
> > +		return scpsys_bus_protect_get_regmap(pd, bpd);
> > +}
> > +
> >   static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
> >   				    const struct scpsys_bus_prot_data *bpd)
> >   {
> > +	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> >   	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
> > +	u32 expected_ack;
> >   	u32 val;
> >   	u32 sta_mask = bpd->bus_prot_sta_mask;
> > +	expected_ack = (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO ? sta_mask : 0);
> > +
> >   	if (bpd->flags & BUS_PROT_REG_UPDATE)
> >   		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> >   	else
> > @@ -142,14 +156,15 @@ static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
> >   	if (bpd->flags & BUS_PROT_IGNORE_CLR_ACK)
> >   		return 0;
> > -	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> > -					val, !(val & sta_mask),
> > +	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
> > +					val, (val & sta_mask) == expected_ack,
> >   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   }
> >   static int scpsys_bus_protect_set(struct scpsys_domain *pd,
> >   				  const struct scpsys_bus_prot_data *bpd)
> >   {
> > +	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
> >   	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
> >   	u32 val;
> >   	u32 sta_mask = bpd->bus_prot_sta_mask;
> > @@ -159,7 +174,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
> >   	else
> >   		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
> > -	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> > +	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
> >   					val, (val & sta_mask) == sta_mask,
> >   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   }
> > @@ -173,7 +188,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> >   		if (!bpd->bus_prot_set_clr_mask)
> >   			break;
> > -		ret = scpsys_bus_protect_set(pd, bpd);
> > +		if (bpd->flags & BUS_PROT_INVERTED)
> > +			ret = scpsys_bus_protect_clear(pd, bpd);
> > +		else
> > +			ret = scpsys_bus_protect_set(pd, bpd);
> >   		if (ret)
> >   			return ret;
> >   	}
> > @@ -190,7 +208,10 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> >   		if (!bpd->bus_prot_set_clr_mask)
> >   			continue;
> > -		ret = scpsys_bus_protect_clear(pd, bpd);
> > +		if (bpd->flags & BUS_PROT_INVERTED)
> > +			ret = scpsys_bus_protect_set(pd, bpd);
> > +		else
> > +			ret = scpsys_bus_protect_clear(pd, bpd);
> >   		if (ret)
> >   			return ret;
> >   	}
> > @@ -377,6 +398,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
> >   			return ERR_CAST(pd->smi);
> >   	}
> > +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
> 
> If we don't expect infracfg-nao to be present, what's the point about trying to
> get a regmap handle and then failing only if we do expect it to be there?
> 
> At this point you can just do...
> 
> 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_INFRA_NAO)) {
> 		pd->infracfg_nao = syscon_regmap_lookup_by_phandle(...);
> 		if (IS_ERR(....))
> 			return ....
> 	}

Yes! My code looks stupid. Thanks!

> 
> > +	if (IS_ERR(pd->infracfg_nao)) {
> > +		if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_INFRA_NAO))
> > +			return ERR_CAST(pd->infracfg_nao);
> > +
> > +		pd->infracfg_nao = NULL;
> > +	}
> > +
> >   	num_clks = of_clk_get_parent_count(node);
> >   	if (num_clks > 0) {
> >   		/* Calculate number of subsys_clks */
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index 356788263db2..562d4e92ce16 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -11,6 +11,7 @@
> >   /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
> >   #define MTK_SCPD_ALWAYS_ON		BIT(5)
> >   #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
> > +#define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
> >   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> >   #define SPM_VDE_PWR_CON			0x0210
> > @@ -45,8 +46,10 @@
> >   enum scpsys_bus_prot_flags {
> >   	BUS_PROT_REG_UPDATE = BIT(1),
> >   	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
> > -	BUS_PROT_COMPONENT_INFRA = BIT(3),
> > -	BUS_PROT_COMPONENT_SMI = BIT(4),
> > +	BUS_PROT_INVERTED = BIT(3),
> 
> I get the reason why you're setting inverted as bit 3, but at that point you can
> just set BUS_PROT_COMPONENT_INFRA to bit 4 from the very beginning, instead of
> using bit 3 for that and then changing them all in a subsequent commit (this one).

Yes, I was torn between making the commits independent and avoiding this
move later on. I decided for the first. If you prefer I can set it to
the correct bits right from the beginning.

Best,
Markus
