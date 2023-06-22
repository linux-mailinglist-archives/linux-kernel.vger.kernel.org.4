Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD07399D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjFVIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFVIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:32:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3E1BF7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:32:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so52320475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687422756; x=1690014756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVCCC/ET2vZCRXYaeBxoeygah0ZvHhm/aw9BYO+xH4Q=;
        b=ewqpaPdXsbF75TRw+tG4eU8EUK+3M5cU5emp/4l03AfgthstEObj+z2mqzA44KgXBI
         7sLrIoKYvhciwLG9mfVA/dIIsFsMjQ3GjBfvqgl3lzhHG5R2J720fYlZYH1006kn5WKL
         IgGot1DIUb/kiUN0HN/mypAdpW0AF59cix/+ZfkTbwI4wRshoeE3ec0EBafumeqgYhyl
         9+9bgB1++AIFyrX8pQHjQKQHjxUfzLUQBNUQmrE6pD6hXNrQ9eddgWGWTFyLpMQAoSZW
         xAm/UgeXvBne80u7oJA5rvePl3rzL+1toPNEjeKc9+4EsbcsctMO56vzcU6RnS1CWjFY
         jvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422756; x=1690014756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVCCC/ET2vZCRXYaeBxoeygah0ZvHhm/aw9BYO+xH4Q=;
        b=XnT0zsRYaJPwximELiLIxBy9a595oChOC/3pifq4kvsNKsFAOwhwKdOV9/z24wbV9I
         s/8rg3xFNPzzUbw0ZOv/cJ3/XGRv0i/0YteKmLSj6AE6Zd6PJTVO8uDsrbLKQjRGq3j8
         LDCXi3dvjq/PmgruaIbXepx8Dh+cSR8yB8a/bQ/eyyb2Tk75btgSLjLBbfKyWegALWSr
         DzIFjHkeXCZUlQrxMnxnCcmRRlDoZaNbyw5DiRo5h8QtNYjbn79ayYuvOW1mjTlbOYze
         XfhfvyF9xM4CnMz4bMjRYYrYJewVnABZ1xnmBCjQO+ONu8Z3QH7y1uTmHw91bmhU2nS7
         IWcw==
X-Gm-Message-State: AC+VfDyW3fl/3sDoTVfGNn/j1vQcYtPunTLSHph/p8cKjwEdNkw7czD1
        YgcE2pND474jqnPQsFTwHZEM9Q==
X-Google-Smtp-Source: ACHHUZ6WbZXuE9mdvDL1iT7GR6en4VqoFEuXTnH0uRDEdQS2VgEm6CkHh4dWEpEDb1W9Xp+TDNNSrg==
X-Received: by 2002:a7b:c7cb:0:b0:3f9:b0fe:7e12 with SMTP id z11-20020a7bc7cb000000b003f9b0fe7e12mr7679742wmk.4.1687422756372;
        Thu, 22 Jun 2023 01:32:36 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0031270cf1904sm6484857wrv.59.2023.06.22.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:32:35 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:32:35 +0200
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
Subject: Re: [PATCH v5 5/8] soc: mediatek: pm-domains: Unify configuration
 for infracfg and smi
Message-ID: <20230622083235.wmztbyl7nngfpufm@blmsp>
References: <20230619085344.2885311-1-msp@baylibre.com>
 <20230619085344.2885311-6-msp@baylibre.com>
 <b53d201d-6906-12f4-2f72-506fb742c585@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b53d201d-6906-12f4-2f72-506fb742c585@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:22:18AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/06/23 10:53, Markus Schneider-Pargmann ha scritto:
> > Use flags to distinguish between infracfg and smi subsystem for a bus
> > protection configuration. It simplifies enabling/disabling and prepares
> > the driver for the use of another regmap for mt8365.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mt6795-pm-domains.h |  16 +-
> >   drivers/soc/mediatek/mt8167-pm-domains.h |  20 +-
> >   drivers/soc/mediatek/mt8173-pm-domains.h |  16 +-
> >   drivers/soc/mediatek/mt8183-pm-domains.h | 198 ++++-----
> >   drivers/soc/mediatek/mt8186-pm-domains.h | 212 +++++-----
> >   drivers/soc/mediatek/mt8188-pm-domains.h | 518 +++++++++++------------
> >   drivers/soc/mediatek/mt8192-pm-domains.h | 262 ++++++------
> >   drivers/soc/mediatek/mt8195-pm-domains.h | 464 ++++++++++----------
> >   drivers/soc/mediatek/mtk-pm-domains.c    |  64 ++-
> >   drivers/soc/mediatek/mtk-pm-domains.h    |  37 +-
> >   10 files changed, 908 insertions(+), 899 deletions(-)
> > 
> 
> ..snip..
> 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index 4b6ae56e7c95..356788263db2 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -45,6 +45,8 @@
> >   enum scpsys_bus_prot_flags {
> >   	BUS_PROT_REG_UPDATE = BIT(1),
> >   	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
> > +	BUS_PROT_COMPONENT_INFRA = BIT(3),
> > +	BUS_PROT_COMPONENT_SMI = BIT(4),
> >   };
> >   #define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
> > @@ -56,17 +58,30 @@ enum scpsys_bus_prot_flags {
> >   		.flags = _flags					\
> >   	}
> > -#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> > -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, 0)
> > +#define BUS_PROT_INFRA_WR(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_INFRA)
> 
> What about doing that like
> 
> #define BUS_PROT_WR(_hwip, _mask, _set, _clr, _sta)
> 	_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_##_hwip)
> 
> ...so that instead of defining BUS_PROT_INFRA_WR, BUS_PROT_SMI_WR and
> BUS_PROT_ANOTHERIP_WR, we keep just one macro?
> 
> That'd be then like:
> 
> 	.bp_cfg = {
> 		BUS_PROT_WR(INFRA, MT8183_TOP_AXI_PROT_EN_1_DISP,
> 			    MT8183_TOP_AXI_PROT_EN_....
> 			    ....),
> 		BUS_PROT_WR(SMI, MT8183_SMI_COMMON_SMI_CLAMP_DISP,
> 			    .....),
> 	}
> 
> IMO, that's cleaner, less lines of code and more flexible for eventual
> future new variations of that.

Yes it would be much cleaner, though it is a bit more intransparent how
these macros are resolved. Anyways I think it being cleaner outweighs
that. I will change it for the next version.

Thanks,
Markus

> 
> Cheers,
> Angelo
> 
> > -#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_IGNORE_CLR_ACK)
> > +#define BUS_PROT_INFRA_WR_IGN(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> > +			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_IGNORE_CLR_ACK)
> > -#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_REG_UPDATE)
> > +#define BUS_PROT_INFRA_UPDATE(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> > +			  BUS_PROT_COMPONENT_INFRA | BUS_PROT_REG_UPDATE)
> > -#define BUS_PROT_UPDATE_TOPAXI(_mask)				\
> > -		BUS_PROT_UPDATE(_mask,				\
> > +#define BUS_PROT_SMI_WR(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_SMI)
> > +
> > +#define BUS_PROT_SMI_WR_IGN(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> > +			  BUS_PROT_COMPONENT_SMI | BUS_PROT_IGNORE_CLR_ACK)
> > +
> > +#define BUS_PROT_SMI_UPDATE(_mask, _set, _clr, _sta) \
> > +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
> > +			  BUS_PROT_COMPONENT_SMI | BUS_PROT_REG_UPDATE)
> > +
> > +#define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)				\
> > +		BUS_PROT_INFRA_UPDATE(_mask,				\
> >   				INFRA_TOPAXI_PROTECTEN,		\
> >   				INFRA_TOPAXI_PROTECTEN,		\
> >   				INFRA_TOPAXI_PROTECTSTA1)
> > @@ -90,8 +105,7 @@ struct scpsys_bus_prot_data {
> >    * @ext_buck_iso_offs: The offset for external buck isolation
> >    * @ext_buck_iso_mask: The mask for external buck isolation
> >    * @caps: The flag for active wake-up action.
> > - * @bp_infracfg: bus protection for infracfg subsystem
> > - * @bp_smi: bus protection for smi subsystem
> > + * @bp_cfg: bus protection configuration for any subsystem
> >    */
> >   struct scpsys_domain_data {
> >   	const char *name;
> > @@ -102,8 +116,7 @@ struct scpsys_domain_data {
> >   	int ext_buck_iso_offs;
> >   	u32 ext_buck_iso_mask;
> >   	u8 caps;
> > -	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
> > -	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
> > +	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
> >   	int pwr_sta_offs;
> >   	int pwr_sta2nd_offs;
> >   };
> 
