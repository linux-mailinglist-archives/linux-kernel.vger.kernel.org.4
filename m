Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3269D447
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBTTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjBTToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:44:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB3E047
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:44:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n31so1622923wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fx6Cy3cfwtLc2tIkcYv2b/6D80WxggLsKcXv+WH52kA=;
        b=Yzr32MycoFefeV/s5hGlruGe4mCnnO/LjwL2l8oZAJaeg9M+kOHt1A9JP6b1LjIyJi
         ZBD3GzBYVzqpXOzA3eq3W8nKGr2ZmAInCdp7lNPsuDhiFIj36DJQwsxsKpXid7dL/CrC
         q20SDqdEx6TDdM9x0EiMagmv4/BH/htFIVWRX+1T43WRniojzL/kkSmMdIMFFL5L3Zsi
         SBLziUP+GmnAbXFaUGfaERO3oS000f9I5alU8bLG13OlhF+YHbL+RHuY42AB711IPh5k
         2AUqcRNZ6kXtZcAB40EMv2yQGV/OiOpU97JgraWxzEGL+CSDxP+1SrMlSf4q2/vggpXy
         vXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx6Cy3cfwtLc2tIkcYv2b/6D80WxggLsKcXv+WH52kA=;
        b=1QIHUQ9PGtqU+t7+lfblCWyPWwtLKzsRL2Fycgn3eLm1CvBpsiD7QhVCMJpIc5qkLT
         V2qOpoxX2ROzUNLZ6r++bDGbymvD536d8TjxEX2Ecyq1meXRfcTEHTljmHNbAKIIB+74
         df3evEWSKMtJv7X5rxBtwR+XRGDyGCSeuqCPqfzhfvJn0IKdzvM56wKpobAMZ5GLN2pP
         MoX7Gnvj2pZc3ClGS3PsICDtCBTj3xSuR9XeQUUpGYz2hLfJJoB54LbL8mXRQBACqmDD
         isAiwsGX0rNF8vuxNlBolDjQdETCaMBSePdcdgtElSYft0TESL5GWKZGEbUlz0x8m85f
         wpoQ==
X-Gm-Message-State: AO0yUKXwM88HUP1bN2e7f+pNcO/QIcub+jqpyTdsFC2hdH7S0iQtOVab
        Tnh3pKBjesPZ8HKX6LzghVd9Zw==
X-Google-Smtp-Source: AK7set81wWp/nPh3uqn5YDsno1xkj3omzQM9DY1JIhAnX8EuPDIa6IJRQOWOHx81vBlsHWmBpa7Bkw==
X-Received: by 2002:a05:600c:4f44:b0:3e1:df8d:e022 with SMTP id m4-20020a05600c4f4400b003e1df8de022mr1754669wmq.9.1676922282285;
        Mon, 20 Feb 2023 11:44:42 -0800 (PST)
Received: from blmsp ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id s10-20020a7bc38a000000b003dc1a525f22sm14871414wmj.25.2023.02.20.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:44:41 -0800 (PST)
Date:   Mon, 20 Feb 2023 20:44:41 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 8/8] soc: mediatek: pm-domains: Add support for MT8365
Message-ID: <20230220194441.2564ct25qsxvvvic@blmsp>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-9-msp@baylibre.com>
 <07a16be1-3f96-374c-3a9b-e3920bb4b437@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07a16be1-3f96-374c-3a9b-e3920bb4b437@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Feb 03, 2023 at 01:22:38PM +0100, Matthias Brugger wrote:
> 
> 
> On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add the needed board data to support MT8365 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mt8365-pm-domains.h | 147 +++++++++++++++++++++++
> >   drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
> >   2 files changed, 152 insertions(+)
> >   create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
> > 
> > diff --git a/drivers/soc/mediatek/mt8365-pm-domains.h b/drivers/soc/mediatek/mt8365-pm-domains.h
> > new file mode 100644
> > index 000000000000..8735e833b15b
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mt8365-pm-domains.h
> > @@ -0,0 +1,147 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
> > +#define __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
> > +
> > +#include "mtk-pm-domains.h"
> > +#include <dt-bindings/power/mediatek,mt8365-power.h>
> > +
> > +/*
> > + * MT8365 power domain support
> > + */
> > +
> > +static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
> > +	[MT8365_POWER_DOMAIN_MM] = {
> > +		.name = "mm",
> > +		.sta_mask = PWR_STATUS_DISP,
> > +		.ctl_offs = 0x30c,
> > +		.pwr_sta_offs = 0x0180,
> > +		.pwr_sta2nd_offs = 0x0184,
> > +		.sram_pdn_bits = GENMASK(8, 8),
> > +		.sram_pdn_ack_bits = GENMASK(12, 12),
> > +		.caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_WAY_EN,
> > +		.bp_infracfg = {
> > +			BUS_PROT_WR(BIT(16) | BIT(17), 0x2a8, 0x2ac, 0x258),
> > +			BUS_PROT_WR(BIT(1) | BIT(2) | BIT(10) | BIT(11), 0x2a0, 0x2a4, 0x228),
> > +			BUS_PROT_WAY_EN(BIT(6), 0x200, BIT(24), 0x0),
> > +			BUS_PROT_WAY_EN(BIT(5), 0x234, BIT(14), 0x28),
> > +			BUS_PROT_WR(BIT(6), 0x2a0, 0x2a4, 0x228),
> 
> 
> BUS_PROT_WR(BIT(6), 0x2a0, 0x2a4, 0x228) repeates several times in the
> definition. Would it make sense to create a new define like we did with
> BUS_PROT_UPDATE_TOPAXI()? Are this offests are used in other SoCs.
> 
> In any case instead of magic numbers the values should be defined in
> include/linux/soc/mediatek/infracfg.h or appropiate header files.

Thanks, you are right, I got rid of all the magic numbers and introduced
some helper defines as well.

Thank you,
Markus
