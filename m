Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E169D9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjBUD6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBUD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:58:24 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E972595C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:57:52 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v3so2613193vse.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676951871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbe8qXQKMrVpJkOf3jrVoLuxZbFldgdnsONLwx23aA4=;
        b=GJRd2vTgRLB7Meg2mjAcO0LWEXqrYp0jZW+JDujL7OoOJvzjyHipO8tJHeVDniyNu8
         q//VIfiCaBP7w/NcQRau97s9Xak0lggHo57uzLgQeTxFpepxUeycmE66CATQ7As0zHRi
         5XIMt8ljZEVVWtyL7lr0E24bNkmc9eLcO8OUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676951871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sbe8qXQKMrVpJkOf3jrVoLuxZbFldgdnsONLwx23aA4=;
        b=QRKu+cDCUxQFI2nYRExfOCkVLujgL22kyM/QxQAD1aQixfj7e9gRW+hzLqP8B7hfEf
         GFNyRLwubvQUBa5NnjGRWU3cD6KeCsg47qdWJF5n76VQr5OMSF5CQpCRVdfDQhm3VOHh
         UojjUsdGPMjAankfIqNeJamf8NAJs+ZZJUpEZjCxAX0xQ1w0MC+xDpv4uIcVYC6BvHr4
         7d32h/4cxHNNP4C4AW2rHSb6s13blTtpf9sb5CkPs+RUDehE9bCiai3Lajz3s+FltgdS
         5dIJwcF1FnInkWRSJMOh5EHvSruy9xmJ2kVCLPnTxSO23JbPJknKEabJIYFJSJnAZp2o
         yMeQ==
X-Gm-Message-State: AO0yUKW27wLJnpu8gno7TGM0HJe9h9SWakdI5HT+J2FaGMIVYjlWgZ2i
        I36eW0+YRY9GU8dG/AM28ZH1ijUYmT1ROCARdIp70A==
X-Google-Smtp-Source: AK7set/Oytljy1v3YJXFROUZlTwsYws5TsLkkfjMaDGrWjewbhAS+n2E1Ju5JPAijfSBy4C0MZ9A8Y5Gh6nAi6EZlfo=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr834379vso.44.1676951871830; Mon, 20 Feb
 2023 19:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-53-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-53-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:57:40 +0800
Message-ID: <CAGXv+5FnZMZFt31zhKx=wja5F9Bm9YjEOh8K_wDf6QaoSW1dwA@mail.gmail.com>
Subject: Re: [PATCH v3 52/55] clk: mediatek: mt8135-apmixedsys: Convert to
 platform_driver and module
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

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Convert apmixedsys clocks to be a platform driver; while at it, also
> add necessary error handling to the probe function, add a remove
> callback and provide a MODULE_DESCRIPTION().
>
> This driver is now compatible with an eventual module build.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
