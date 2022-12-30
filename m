Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CB659622
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiL3IN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiL3INz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:13:55 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73CE192B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:13:54 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 128so20596971vsz.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BW5cwmKaNCVLs9nRl+n6ibFBEWSsqnffbwe6y2wYCQ=;
        b=nGPjclbubWrpPTtxt8FKiL1BFgbol42KKil8hX/0VmVLK0i8/1yA/SP4ogoO1eSLpR
         OFPrEwUbyH9DylcRkRPvTa8+iLlXVqsLLYJ2/h0vxjUCsgedaM3/JW8hI8EkozA1MS2O
         UnOJedj+iKcCyGhpeAaF5RccFV3t/B7LWrrAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BW5cwmKaNCVLs9nRl+n6ibFBEWSsqnffbwe6y2wYCQ=;
        b=Fcy0KQTU7ogQMi/bClM/1cEkPE47FPymHyaLidweQXOBE2HEtAR8h0VKzO2r9bsMUi
         YcCmciTsmsKWPMcCmv/TX8D4TXrDKRWXFFPlAynoFOFFC6rtP6/B8SHyR69XeMAEAeUq
         MEAap1V8TSkjoCu62/26HQmlV8lxMvaCBQPUa+M8EqO3u1lmPLtkKfhvMEr5JVrwTH5x
         2dl5qWQL/+3ETCMjCMoynX91X4h1vd2R66H398tqQagsIBpjKN/j5h2U+gzgU50XpYz/
         C5hPp5ic75GRrsMMWrjKAaVPOu6zhOX2chjjL3GvesJf9CNNet145+tQA36uP3mfAiKh
         V+rw==
X-Gm-Message-State: AFqh2kr4uHbCPD/uuGLqi6086o/GyVLvXVovl9AGL3G2/TzA+179Aoto
        zZbq32QyOEL9J5AgfsjudZ6I4mFKMUxAJbNfqxh5Ug==
X-Google-Smtp-Source: AMrXdXv7CHafuypiXlQL438o48Sf7M0d8IvDMBWqWekllpFk+gsVlFTfotR7uZXiHjjbfDtmSkoKdZZraclEPUo0lLw=
X-Received: by 2002:a05:6102:74b:b0:3ad:3d65:22b with SMTP id
 v11-20020a056102074b00b003ad3d65022bmr4419162vsg.65.1672388034106; Fri, 30
 Dec 2022 00:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-22-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-22-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:13:42 +0800
Message-ID: <CAGXv+5Eoiaf7RovpHeizYxpFO-xw2NHneig_CUc4cxL-i7Xhew@mail.gmail.com>
Subject: Re: [PATCH v2 21/23] clk: mediatek: clk-mt6795-topckgen: Migrate to mtk_clk_simple_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
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

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Migrate away from custom probe functions and use the commonized
> mtk_clk_simple_{probe, remove}().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
