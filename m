Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0E5E983F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiIZDXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIZDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:23:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F221148
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:23:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc7so11437431ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lxvp+T0nmPNAS5r7Bc6SkAzZFGyMPUN1eLVnGVUBPPc=;
        b=a4B7p662s2cugcXrV/HHOV8DNtByQMTkUBkwzRLjrJ400RI9k5DhbSdm+Y8nvVNGe1
         2GrIMo7f5EMtHnZ8zJ+VxBHnLbFRWe2U8xgptKsM1MnEkOKvXjRwenRDLAezNavD35TP
         4qQawu698yOuRu+1TQMjkGvKS70t8zxTM3a3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lxvp+T0nmPNAS5r7Bc6SkAzZFGyMPUN1eLVnGVUBPPc=;
        b=PuYwq7HpFdHD9zb8JpTCEADMe7QvXxL3dTDitKlLKqGx5nPEDtWtitzIRxfOc9wlNS
         CVD59uZqPv41tj2Lrbe5imL5lP5nkvs39Bt9XYhYTOeqnxeLC745QksMZTqEEYzruDy3
         qKW/ang3cekEJykJAu0pomFAj9s3Z8K0KXY8ufqDDWMjvyipoIscMovu73gJBgoiqsCC
         HRPQlpmH/1KETH2iACI+ZQfm73565/z5Di9uEGLlt3ilKE7ZrLCqfQOVGRwpuGI/oSRt
         IQr6b6qrybInLhqdCEZsYVlgxBZyw33RdSpFN5/GSpePdNa9pVcPhYBgAiAOlT61d4Y4
         fdOg==
X-Gm-Message-State: ACrzQf1CyQERwBaGWWFt7lW74mawDRz6lZ635i12w3SWUFi1zBCsWVM7
        cfUQMPzHnZD2Azn1FF/HzwKKxgJfS7Yhw0qm7Xvjlw==
X-Google-Smtp-Source: AMsMyM7614BUgahOMwJWu9MHtouT3NLfNy27XW7Lv6OZVc+xsfxGx4XppqGFaREEVBKwAdnU1WmvNJCHo+/NFhY0zHg=
X-Received: by 2002:a17:907:7f93:b0:781:dbee:dece with SMTP id
 qk19-20020a1709077f9300b00781dbeedecemr16502807ejc.323.1664162622513; Sun, 25
 Sep 2022 20:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com> <20220915072458.18232-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915072458.18232-11-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 11:23:31 +0800
Message-ID: <CAGXv+5EtRTux22ERqCXTDL-Ooo5qa6u=KWO5=m_s4U3sPoLp3g@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] clk: mediatek: clk-mt8192: Add clock mux
 notifier for mfg_pll_sel
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Following the changes that were done for mt8183, add a clock notifier
> for the GPU PLL selector mux: this allows safe clock rate changes by
> temporarily reparenting the GPU to a safe clock (clk26m) while the
> MFGPLL is reprogrammed and stabilizes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
