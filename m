Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535271582D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE3IRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjE3IRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:17:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A52BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:17:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so1905965a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685434648; x=1688026648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dej/FFOhlE209KZmIstjtLDQxOMnp2DLbpIJPYah0A=;
        b=rEufenXkmE+fxdBlKUC1YtyC9X07+Ci2rPmXRsV3WUV9jRjRbQuIrPDnNZvxSM2mxf
         X3RNTWjoWWpRxl8BL/JW5dYXMmPsneBLDl1Dmc6BP2bPa1lDf2bE33qwb4Prv3FsTbML
         /71z6JhU30309RGtVFkstiUwREa1kJ5ofNQ6vN5Dlh/dhVBM23xvaiD/ufCjCYPAjBF3
         XI4+MVi9AXdyxrFKwYuvqgdQ96YEo1lXf5Xs7b+rTjAiHGiy8iOscayzY2bWxOH5iwrW
         pLzGv8SgZ58jXBhoR0tSMtOHn3g+APVxq/t6A9dCV+PFv/YPhbCNsejnl+LzPM1udCKI
         1dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434648; x=1688026648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dej/FFOhlE209KZmIstjtLDQxOMnp2DLbpIJPYah0A=;
        b=bUTeak0UqWL9x4EvdTrd1uWOff72zr3EPIMpgof71q+32O22XeJ0RYrHbTO4C/+P6d
         dv81OJ9rdzoNg8ibLZXqFATv0bF3jhZbLBBPJ9MBPNN1W6J6DhvrHBALR3nt7oUbvYkb
         ztFtyrCkARXmmhVrLraq5/gJZfSQSCD24LVf8xSwcANYitND0ea8eqjmiqzvpGpn+9/G
         S12f6fQQYvlvbGgxy6tfTgLevaXkYYIlhYk+asNTlkZH8a3cq9p6sofbG1PG2e5/X0LT
         egG5yns1ADjC2OQBKiRJj2m2Lo8JHyMWr5RCsVd4mMk1ZqIHTjEsLbfwtR+rtyITpVSa
         3cEg==
X-Gm-Message-State: AC+VfDy4BaNa1D1Vl0K9e25xHa+zLp/0ybPGva/5BZbvZ8eCcvvv44Hq
        qbbRPHf5xlnwtZqZLnsj1TTu4Q==
X-Google-Smtp-Source: ACHHUZ4yZU/IUfHWVCAaHSvVKWusYU73uAxcR1RUnuf/v1Ip6xt3HYUd1Y/9cpLkPOB1X4DLiH0K1A==
X-Received: by 2002:a17:907:784:b0:96f:a412:8b03 with SMTP id xd4-20020a170907078400b0096fa4128b03mr1486035ejb.5.1685434648674;
        Tue, 30 May 2023 01:17:28 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:802c:bc2b:8db8:9210:41eb])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b0095807ab4b57sm7116229ejt.178.2023.05.30.01.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:17:28 -0700 (PDT)
Date:   Tue, 30 May 2023 10:17:27 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] clk: mediatek: mt8365: Fix index issue
Message-ID: <20230530081727.br3fm6zombgipjer@blmsp>
References: <20230517-fix-clk-index-v3-1-be4df46065c4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517-fix-clk-index-v3-1-be4df46065c4@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:10:43PM +0200, Alexandre Mergnat wrote:
> Before the patch [1], the clock probe was done directly in the
> clk-mt8365 driver. In this probe function, the array which stores the
> data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
> the clock lists [2]. Currently, with the patch [1], the specific
> clk-mt8365 probe function is replaced by the mtk generic one [3], which
> size the clock data array by adding all the clock descriptor array size
> provided by the clk-mt8365 driver.
> 
> Actually, all clock indexes come from the header file [2], that mean, if
> there are more clock (then more index) in the header file [2] than the
> number of clock declared in the clock descriptor arrays (which is the
> case currently), the clock data array will be undersized and then the
> generic probe function will overflow when it will try to write in
> "clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
> function returns an error in the log which looks like:
> "of_clk_hw_onecell_get: invalid index 135", then this clock isn't
> enabled.
> 
> Solve this issue by adding in the driver the missing clocks declared in
> the header clock file [2].
> 
> [1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
>      mtk_clk_simple_{probe,remove}()")
> [2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
> [3]: drivers/clk/mediatek/clk-mtk.c
> 
> Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()")
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus
