Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469BE69A4CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBQEUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBQET6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:19:58 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF56E3A0B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:19:56 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id j40so2315885vsv.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sTtq7wFwfGuxLqDxyAbIt3LJdsd3KOuYS5ANkRiYHw=;
        b=IWaIjlWzGtsANAL7ZOY9G0Rlf7IIg1kBFaN6cS2/4Wfm4q1nVRLdAzybjw9kIFtWdC
         QuXTT8lfhSiRPRiYZNkQyHOMU+ziG8o3fw6NXxM/XgySm9IyIZGJheJIsm3gC3vkFK/H
         AZ1W/3GqLzmGhXO7wC4wThyN1L/P5FvnMxMtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sTtq7wFwfGuxLqDxyAbIt3LJdsd3KOuYS5ANkRiYHw=;
        b=56dSkUxfQh9ap2qqh5mP9KdFsY9pef25NGVqeiu2ip9SUC4j5B7icHyMrESUntHzu4
         YDTeItg06gJyQ/r3gfmjP/M3oGvzkMSPmE9/jvuTQVra5xPDRme8/++KGgtmVH1e0VDU
         W3kbiE5B1kF7yhLamRwi7zOV2+OqjwUOfIV7+3ympeySrzayWLbmtJBNbrkIha3XIDr1
         nVYHR9q701lmffTaknjRqfbyGJELrMDNUlLpaawQvMRppRuMdeN2HVTRoTiMGL8+Q3EB
         wIJCfzGWJTyQDUMYhHIvKnz1/nxW7uVT3Sw4TN7yW4Zfe3o2igPV80l3KrPj7YzpgWCZ
         1otQ==
X-Gm-Message-State: AO0yUKVPJIHL1SKNzqHet1goUGBaYNIeXRsaSOeExKZiVtMFRv2DWJQY
        YXfyupgYsnNIBLsRR4mFfjzsgRu5QB/GRsJdiJU5ew==
X-Google-Smtp-Source: AK7set+TWoZwk25NxtdG8DrZrA0ocSyVUePkzShg/KIelJ15xWrmFKfqafySgze6zE4nGexNOj4qAqkDHQsO0OWilTE=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1527880vso.60.1676607595777; Thu, 16 Feb
 2023 20:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-35-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-35-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:19:44 +0800
Message-ID: <CAGXv+5E3KCRyaRpkYab0XmT8XDZQO21RYBpKVgCcGtWmZ+dv3g@mail.gmail.com>
Subject: Re: [PATCH v2 34/47] clk: mediatek: Switch to module_platform_driver()
 where possible
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Lots of clock drivers have got both .probe() and a .remove() callbacks:
> switch from builtin_platform_driver() to module_platform_driver() so
> that we actually register the .remove() callback.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt2701-aud.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-bdp.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-eth.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-g3d.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-hif.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-img.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2701-mm.c           | 3 +--
>  drivers/clk/mediatek/clk-mt2701-vdec.c         | 3 +--
>  drivers/clk/mediatek/clk-mt2712-bdp.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2712-img.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2712-jpgdec.c       | 3 +--
>  drivers/clk/mediatek/clk-mt2712-mfg.c          | 3 +--
>  drivers/clk/mediatek/clk-mt2712-mm.c           | 3 +--
>  drivers/clk/mediatek/clk-mt2712-vdec.c         | 3 +--
>  drivers/clk/mediatek/clk-mt2712-venc.c         | 3 +--
>  drivers/clk/mediatek/clk-mt6765-audio.c        | 3 +--
>  drivers/clk/mediatek/clk-mt6765-cam.c          | 3 +--
>  drivers/clk/mediatek/clk-mt6765-img.c          | 3 +--
>  drivers/clk/mediatek/clk-mt6765-mipi0a.c       | 3 +--
>  drivers/clk/mediatek/clk-mt6765-mm.c           | 3 +--
>  drivers/clk/mediatek/clk-mt6765-vcodec.c       | 3 +--
>  drivers/clk/mediatek/clk-mt6797-img.c          | 3 +--
>  drivers/clk/mediatek/clk-mt6797-mm.c           | 3 +--
>  drivers/clk/mediatek/clk-mt6797-vdec.c         | 3 +--
>  drivers/clk/mediatek/clk-mt6797-venc.c         | 3 +--
>  drivers/clk/mediatek/clk-mt7622-aud.c          | 3 +--
>  drivers/clk/mediatek/clk-mt7622-eth.c          | 3 +--
>  drivers/clk/mediatek/clk-mt7622-hif.c          | 3 +--
>  drivers/clk/mediatek/clk-mt7629-eth.c          | 1 -

This one looks fishy. It wasn't converted to the simple probe library.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
