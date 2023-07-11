Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C674F850
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGKTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKTRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:17:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B910C2;
        Tue, 11 Jul 2023 12:17:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b88faebso6899562f8f.3;
        Tue, 11 Jul 2023 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689103048; x=1691695048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSUy+2QLSZkyXGWTlb70qZpMsyDgtjtC0vWQLCNM99s=;
        b=JLqNrRCLg22oTon1ELMrG+YAPgAmFPmjfnWPjFMVIeJ3NDgkUOZv69eSQBCuq6ehby
         gfvj+DATBXAFeCluw1FzSu+8OJ9tdVW96/HDAQwk2oxeOXroVr2ZQyppBKXvkDYHOS54
         RmMZmZgVjI6TSqxy1xq+GMh2D2bHOFHo77vdF6FAi3cQHO+irkzfhFE1qOtQ6RJkI0NU
         JG6KccpLZe3oZIogXkW0gS5v5sWpeyYHmmJfBCX6/29d/gJetjo8A7ajWpjergc3bbng
         zmGWEjB3NphzAL2JR2VRV2kJA3jGOB4NKIPYEVAk9qgclY1LB/7DIUOsJR/BnA1PmIwv
         bANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689103048; x=1691695048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSUy+2QLSZkyXGWTlb70qZpMsyDgtjtC0vWQLCNM99s=;
        b=SAVNEZuvIwonp8DYvwMkGwXuMWsKHhuuVQVsMuIuFq7Ktya1P02nsMLkhr2NUQ8ZbZ
         wqPi3ri+4nrJT+O6aTHG75bUQNNdgCOmNgNFJrzB9DHGuQs0e1h/UWAYfTWtB6GBw+FG
         8IO5+vpKk3C+tiq9V60MakM63Xo1zRR5P3upkWvrcTpB8hIaxnumhPAJF2+pvS1KDHzy
         N7FtfeETdVmIGlOvDMxfmpGZ1Uig5ZxaKB+9m7IsZjyNBp8qBf3jTaQUphlkYUNZvFJU
         cowJ7aVyieC8xkRfAuxR6ixY8V84RrfPeUIK2bBS4UCqT7+a9BTGYMaXLqqt/jO97NAY
         DPGA==
X-Gm-Message-State: ABy/qLaWG1GhY79YKO3yN9udnpFWIs1ImRzEXL8RNbmRWulYFqOc0YFB
        clwR5QJh5cWAzU4nyUAmcX4=
X-Google-Smtp-Source: APBJJlFQ98K9vJ2fSMFaRy4heIAr/uAgzrBzN0S/+2G2XajhEljHNs+9+wAlK3JcuYzXdnAaeJI1Sw==
X-Received: by 2002:adf:fb01:0:b0:315:96ca:dcab with SMTP id c1-20020adffb01000000b0031596cadcabmr8506330wrr.35.1689103048303;
        Tue, 11 Jul 2023 12:17:28 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d4a86000000b0030e5bd253aasm2974302wrq.39.2023.07.11.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:17:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/sun8i: remove unneeded comments
Date:   Tue, 11 Jul 2023 21:17:26 +0200
Message-ID: <4278554.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20230626125515.18830-1-frank.li@vivo.com>
References: <20230626125515.18830-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 26. junij 2023 ob 14:55:15 CEST je Yangtao Li napisal(a):
> It's redundant, let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/thermal/sun8i_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..2c82bc744a24 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -56,8 +56,6 @@
>  #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & 
(x)) << 12)
>  #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
> 
> -/* millidegree celsius */
> -
>  struct tsensor {
>  	struct ths_device		*tmdev;
>  	struct thermal_zone_device	*tzd;




