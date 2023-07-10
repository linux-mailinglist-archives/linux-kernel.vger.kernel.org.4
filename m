Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5374D00A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjGJIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjGJIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:35:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38992E56
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:34:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso14223201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688978042; x=1691570042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8qLO55Vr7jsbm09jztyw8xMmMihk27bt8iUnejOXKA=;
        b=Hvf3tsUJDgBDosylitVXgKWoTMFFxBZhO6B7AsY/+bfGJe/ri96PlWXoTZiRpo1oEe
         ilw+UiKiXAcQ1MSUpCs+GrFtJ1U/x0tTjB3/t7Bw173Uo874h1U96Lcs0sG8F/qe52og
         YhjJzXEZsu/NU2Od3zGihTccc/bAcukTtB4LXsUqhRdxc7RLAyExN88BswUT+vSgvrd1
         I5BuKydv5tA2lbQSsrPFMNGTSvfBAo574L6zLm4/zPW2NgdNX0nUmIHenpkohI9SXacy
         g7mWSvVQh8+mX9nV5Y4mADOXk++zSjaWs+xG2slVSVjhMc4KPEwO2+6On5vysbrinrA8
         qQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688978042; x=1691570042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8qLO55Vr7jsbm09jztyw8xMmMihk27bt8iUnejOXKA=;
        b=kiwQk53dvOgaOiD0mx154Hm2hwmBeHmd4qKDuFg+novL+lOSBFCZ6PL/ozofmisfhP
         fs0M+BAoPCQjNK5aMVBazYWwpGOSgmJI1Cyol5bOaK2EOOPMHZmLgX8WrIHXPw0MIiOC
         iNa5hFpuPd5c/t0WEyNC67UqUGhfxiQ91QNwWleVnTeo9mi+UxmlB856s27mEVV7ibzL
         tNTw6CO9M9lGmHxjak1Fs3OZyr0Jho7OQF1ZZdRlF4T2jnVHQQxQg+BtF1f6AJUaTuQe
         p9uw8EtSeu3nWWGwEiDIexWEm4KKfJweKoXbd5q7xytDj960jeA7qs3LEpEDUGSMzHrJ
         HZtg==
X-Gm-Message-State: ABy/qLYxUlMqC5ullKtOZjJN45Tvm/DibFroFsqOor3fDlmHQuWbGHSV
        baK5qQOcUvPVeS3Hq87sKFV2nA==
X-Google-Smtp-Source: APBJJlEwDXXbGl7RIZcFGrb5mR1IXJNqOS4jXW4DPrQNSeFwwlXhncUnFC4Cqg6Tp4eo0TCEFbFQnw==
X-Received: by 2002:a2e:7d15:0:b0:2b6:d7a0:c27d with SMTP id y21-20020a2e7d15000000b002b6d7a0c27dmr8530764ljc.37.1688978041895;
        Mon, 10 Jul 2023 01:34:01 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c218e00b003fa96fe2bd9sm9649160wme.22.2023.07.10.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:34:01 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:34:00 +0200
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
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v6 8/8] soc: mediatek: pm-domains: Add support for MT8365
Message-ID: <20230710083400.c24jnxxykxjsl47q@blmsp>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-9-msp@baylibre.com>
 <85ce05db-5392-79e0-1183-b40db641f3ae@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85ce05db-5392-79e0-1183-b40db641f3ae@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Tue, Jul 04, 2023 at 12:31:23PM +0200, AngeloGioacchino Del Regno wrote:
> Il 27/06/23 15:10, Markus Schneider-Pargmann ha scritto:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add the needed board data to support MT8365 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> 
> 
> ..snip..
> 
> 
> > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > index 07f67b3d8e97..f853397697b5 100644
> > --- a/include/linux/soc/mediatek/infracfg.h
> > +++ b/include/linux/soc/mediatek/infracfg.h
> > @@ -2,6 +2,47 @@
> >   #ifndef __SOC_MEDIATEK_INFRACFG_H
> >   #define __SOC_MEDIATEK_INFRACFG_H
> > +#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1				0x228
> > +#define MT8365_INFRA_TOPAXI_PROTECTEN_SET				0x2a0
> > +#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR				0x2a4
> > +# define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0				BIT(1)
> 
> Personally, I like this kind of indentation, but more like
> 
> #define REGADDRESS
>  #define REGMASK
> 
> instead of
> 
> #define REGADDRESS
> # define REGMASK
> 
> ...but this doesn't count, because this header doesn't follow *either* formats,
> not my preferred, nor yours: this means that, for consistency, you have to follow
> what's in there already, so you have to change that to
> 
> #define REGADDRESS
> #define REGMASK
> 
> ...so please change that to retain consistency across the infracfg.h header,
> after which:
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thank you for your review. I fixed both issues you pointed out for the
next version.

Best,
Markus
