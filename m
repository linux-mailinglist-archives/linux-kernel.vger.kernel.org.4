Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6E698E39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBPIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBPIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:01:39 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE36183
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:01:38 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id m81so833273vkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yeus9HGhMFXg91Mu8k0KRBkqLS/oz0WZH65lxIAAuJ4=;
        b=fTLKg5kLU68Zmml8hKrfx4b3q25rkw8FQ3LD2kEO+bvOdm5i9zCH+LVNaofNI86K/b
         44ssSWiBlkNTF0SFpRSG0JfsJXnR8OWbE0Dsp+JZ5IAa4kN5/OoxHKZFg4DNSwMvFkxd
         W2NPydnU3jvW614Q+PZI0H+NpYLfDLZ/L0TeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yeus9HGhMFXg91Mu8k0KRBkqLS/oz0WZH65lxIAAuJ4=;
        b=zFmpdWjWiWvjch6F/PN0tTya/nJgo+JEWl7Jup1qob4fPPoKByb0iC8/2XY+o1V5MP
         lQU+tbxapeFa03u/CqBrtVPKBQH0Z0SvSamHiOCWKmto7b6SW61emhc4vo9IEyIvz3FR
         r/KrWQU278DqAEYLsACUdc+KkM/63SxMftkjy7IvTteZ9g+B04PEysOGd1d/uRQEIsPp
         Oy+QgX267qyV/eQ464ZYDfpsjMXdYTUWlahHOT8+CmbYwjZ3Ga7bbI70mxxWjrFfcoQD
         IUonugfZfBqMMRCnXj6sMpIXYpxVRZwp/ppo7+7yd2InmA6xhoEsM2rzHscqbvKYcURr
         MOyA==
X-Gm-Message-State: AO0yUKVCQ/Ewqs8G5+hK6oGMD+Wk102Uj25fr6F01aeLzydM/TZWn7ck
        efgyJYHBMyZMHiyvgNmAYGCsrgw6A4OfBiv8hoZyRw==
X-Google-Smtp-Source: AK7set8MjxO55yFgtHWdPlTTau1K5AmbjLybjRWoEF/cRynJ0TSRLk4s+xuSxJmb3mqmZlt+EtAJ2do0nFQHLfogWFE=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr782890vke.2.1676534497366; Thu, 16 Feb
 2023 00:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-18-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 16:01:26 +0800
Message-ID: <CAGXv+5H1Nz6Z4h4qbiuxxZEQJwDjMw4JykbDoNRGEkN3LS69Cg@mail.gmail.com>
Subject: Re: [PATCH v2 17/47] clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Convert topckgen and infracfg clock drivers to use the common
> mtk_clk_simple_probe() mechanism and change this from the old
> "static" CLK_OF_DECLARE to be a platform driver, allowing it
> to eventually be built as a module.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
