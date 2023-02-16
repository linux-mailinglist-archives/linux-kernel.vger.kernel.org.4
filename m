Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC83699295
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBPLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBPLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:01:12 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB013504
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:01:07 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id z15so1482346vsj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1UJuDxc/dW2NAAvPvyR0ggXJqGR2HNPP1/APrqV7r0=;
        b=nLnemLAnXuuMt0ZWOuk2BSImf2AMv0Hl6mdw/A2xfsn3fwTmtKH4Tz28yMOCkbBNjD
         CWhmtnqkOd2l4M3Rsc6M+xJaTujSJXYREN7Eo7R3lrld4ZWkUOAJa77crSkVoF4qVVrZ
         2bsfet+4pY9pzAohpk7SC6Kzny+PCOKpwIL1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1UJuDxc/dW2NAAvPvyR0ggXJqGR2HNPP1/APrqV7r0=;
        b=tvvItAhbj4nodb4z29ftqB/4R5dyz1F0XUiJIRh1HWFNXosQCISM4aJ4Hn9SRfCz39
         4chFaaiKokLK7dNy4JX+6JLyulIRv7ynj4av5VO9RDX4W6NFOdsbezHKmlpUb/KT0f6H
         NPyVQD6K6EdBgV1nePGnqoWYGcZnthEphCu475JPWO4Nx5LrpY+hWu1vk40cdIWHXzZ4
         qkgpjY7PdKhPkEz58mmwl+HvILTKwWmkdrbrTQw9e/GY7jn5RPjw1atGVDft6OHB+WkR
         X4O9eSaKnFTNg0RdfBaknkHxdPvgkfLrCP7fzx+fOysk6hqqaIebafWGXjUzc+k73Etp
         rozw==
X-Gm-Message-State: AO0yUKVkHJVfuDSDwxSEFhdSs0A3HvRX8/2DTXA/Xur3HHYW2v6aORiW
        xx+dzWiAKeE42ZGjvZqd2ab94otOmPnSdDYECzEQ/w==
X-Google-Smtp-Source: AK7set/OCcT2HX+FgGe/T2X4Ge6Yj21L72BELhl7RL8tasIGkQlgdaMzHof52fg1wx/ikQdVVp6Lm/jGEQn7wHo+e+4=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1015296vso.60.1676545266969; Thu, 16 Feb
 2023 03:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-28-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-28-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 19:00:55 +0800
Message-ID: <CAGXv+5EzvWtEPyeGZJHtg0D9CvDd-j=N+C5cLoSuTUWxKL3-Hg@mail.gmail.com>
Subject: Re: [PATCH v2 27/47] clk: mediatek: mt8516: Convert to platform
 driver and simple probe
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
> Convert the MT8516 clock drivers to be platform drivers and use the
> common probe mechanism.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

But wow this diff is hard to read.
