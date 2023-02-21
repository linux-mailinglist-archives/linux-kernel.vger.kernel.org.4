Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02869D952
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjBUDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUDjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:39:45 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23222000
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:39:44 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 6so3055425vsv.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676950783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eyR7hb6+4nnohx1Os+xJuDUE4j0WlgtLqxQEIptIJGc=;
        b=EH9Gs94+bMfCqoMpwo0blYpUtwBOlTqv5J56zeGIbkMnPE2IWzW0qkSqhNjrmciPj5
         NinIep+5pkpc1/y6LpPdT66tfyHugn+Tbcr2qiB5AZggTM4yT/xmLE1T5if0wKxoFZgJ
         GfNpN1vpgHOjyrQtbH5Reh1C1Hu8vyf19mdx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676950783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyR7hb6+4nnohx1Os+xJuDUE4j0WlgtLqxQEIptIJGc=;
        b=PE2B+1KN1u6Km+5NhEGOa747hRA6VpnuCkltrd4yLlFIV3CENc5kIL78/EwbHWjOHB
         TGoHiSt6eQVrzuQsHXrjsGqBC6Gh92LiA+WO9ru2Yy/ZuP8fdRMMjb3Uod0Dxz43VVPt
         uGjuWqPJBC8qRgnXtLaOOg4aigTAK4FA/xeOKtQOPag8lp/og0m8VHI4tBfbnnhKasby
         MWA23v34vSnrDT1Y+AGMMNOkRwcHugI+pwB/UOcj9eAf4BYw/CR8y4fKrh8E7eNvuN2l
         padVeVU9WV2kLbnOAwjS5BlYZQeUvfkE2TS6SZyj3GqzzwtaGKUXex3k1TbFYFe+c4CM
         LPYQ==
X-Gm-Message-State: AO0yUKVNVZrHvljfY77KP8Vm3N3U1XW2AMH2UI+NA0ntN7qbY1/aMsZH
        eZ5XazgPEjRFOh8SPHwVMB43d4fDDVAF++bnlESPDg==
X-Google-Smtp-Source: AK7set+D349/5265yL0xKdvrfFIsomu5l6hLeBBkm5qE9AONzbCuJgnYXdR0E3W2E+MqupsPm0Wi6fjuhGasUAmEV/k=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr828458vso.44.1676950783217; Mon, 20 Feb
 2023 19:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-20-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:39:32 +0800
Message-ID: <CAGXv+5FhOnGfCOuWfNY8EgSzJ9Su7peukJh5YGQWJ4ZFV9u0Bw@mail.gmail.com>
Subject: Re: [PATCH v3 19/55] clk: mediatek: mt8183: Move apmixedsys clock
 driver to its own file
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating all other mt8183 clocks to the common
> mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
> While at it, use the builtin_platform_driver() macro for it and fix
> some indentation issues in the PLLs table.
>
> During the conversion, error handling was added to the apmixedsys
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
