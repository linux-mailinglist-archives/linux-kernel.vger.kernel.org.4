Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2205F61CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJFHlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJFHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:40:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957E8E471
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:40:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so1310752wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=czZIXcSril+0S5W4kqc0onDmBGjrVJmOKnFUKeX4tsk=;
        b=6qjVyGLzJP2d40EpuWNyVT7l6T1hqaLdgmVpPaEvxGoI3eNCRgjZbGBoV/FQXGFiob
         p1/snStTlv9rq/9KQBEnbttDzx9aV9UFcCtCpTruw0x3LnutL5LIoByYqspkjd4myhFG
         o66132ZmNOgdoO+IlS/KPAboWUZ4rxmqEi5tZR2IqESw7F5zea9zC2XndyD0QwNfiMW+
         /nwbOLPLYFu+/Cky/cDEFK7gRRN0k+BrwlpQEh4ZaKLwj5dIr4NcKkO8p5HwaacjzsA6
         gZ0TzxilJw76mVoMKbn+T6w4zrLCe+y6EPNId2yu4f5oz1jz2r47ME95GEpCEBO05Q/r
         AVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czZIXcSril+0S5W4kqc0onDmBGjrVJmOKnFUKeX4tsk=;
        b=xbO9JcenXRBW1E/LRHcRnghXImSxfe1Z3td82WcZLzFgl8eZOBTViJ0FbBhlry3i/6
         zqXFb+gbTrwyPe1NeNsDzAnAtLNT82Xx2HbZq+1sV/2lWYwfsyzUfyif51WJA9HwuWvA
         dJVwZbK28GaWcqV6opZtZ40lJ0DhPi1KGwP+taoD7hM7OywYAHBtWjJDRRBuE4NBwo77
         +sOXIVMLmxU0JtvRv525opUB4Xp4wIXxYABGxKlL874aocnG7nx/EhPWcOMLfvW8lGDw
         KIdvczljiDOF6B9qqTzJ4OimOrKiHOclvymMUT/3GAdCsY96cx8OFsnpSL/Mn0hACGAJ
         Uzsg==
X-Gm-Message-State: ACrzQf3c3uUTa0FIQH17dWykLowHfOmG+0nsYyTNkJF+Z4KMNTLpW5ZW
        ddA15EtsDeJf07fJNHe+RFRFJg==
X-Google-Smtp-Source: AMsMyM6xxcX+Jw879ZvGrzE2zvbkaNBbDJ39qRVbXxY0XUtG9zHNqjzwrFb8JpJ5s9D9VO54lzi4fg==
X-Received: by 2002:a5d:404b:0:b0:22e:331e:1cba with SMTP id w11-20020a5d404b000000b0022e331e1cbamr2019320wrp.488.1665042051756;
        Thu, 06 Oct 2022 00:40:51 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003a601a1c2f7sm4346819wmq.19.2022.10.06.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:40:51 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v2 5/5] Input: mtk-pmic-keys: add MT6357 support
In-Reply-To: <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
Date:   Thu, 06 Oct 2022 09:40:50 +0200
Message-ID: <87czb5o0vx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 16:57, Alexandre Mergnat <amergnat@baylibre.com> wrote:

> From: Fabien Parent <fparent@baylibre.com>
>
> Add PMIC Keys support on MT6357 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 9b34da0ec260..2a63e0718eb6 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/mt6323/registers.h>
>  #include <linux/mfd/mt6331/registers.h>
> +#include <linux/mfd/mt6357/registers.h>
>  #include <linux/mfd/mt6358/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
> @@ -90,6 +91,19 @@ static const struct mtk_pmic_regs mt6331_regs = {
>  	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
>  };
>  
> +static const struct mtk_pmic_regs mt6357_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
> +				   0x2, MT6357_PSC_TOP_INT_CON0, 0x5,
> +				   MTK_PMIC_PWRKEY_RST),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
> +				   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
> +				   MTK_PMIC_HOMEKEY_INDEX),
> +	.pmic_rst_reg = MT6357_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
> +};
> +
>  static const struct mtk_pmic_regs mt6358_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> @@ -276,6 +290,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt6331-keys",
>  		.data = &mt6331_regs,
> +	}, {
> +		.compatible = "mediatek,mt6357-keys",
> +		.data = &mt6357_regs,
>  	}, {
>  		.compatible = "mediatek,mt6358-keys",
>  		.data = &mt6358_regs,
>
> -- 
> b4 0.10.1
