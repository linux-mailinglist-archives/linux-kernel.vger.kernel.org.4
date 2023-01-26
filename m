Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0267CC78
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAZNmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAZNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:42:40 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C56E43A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:42:33 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 123so1971583ybv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpcudo7gJTTbbuTXM+JjARhwoG+S0cT/6fCk8EgJ3Lc=;
        b=NK0yPEUk/K6ONN9dNsc7JvUHaQ170Ni3OGZnighVNStfLllS5t/BteesuDgU0TUPjq
         1JibIBpLF8B3H1QqiDDXr7Q2PvxrlVdt/PFFLxLQLlJNmaMMQUwl/4FFyDSzzGZDieKV
         iL2rMydR6smmLgq9A0pnwS+2Qv15DqPrzx0oquj/Fdj02FgmAVcSvQrLcdw6GuzV6+CZ
         lpN/PSxKvls8df7RSa6ZFYyCSlf513RU5e5D4rLwxCUoF6w6NQrFlcf3Go95U6yWnpcL
         llWWxEfozzz30onyyGQpyx2Rz4bw2DdH7F8h8rRFdb/UMgmY6UUSy2yM0EBBAn/3Pcz8
         y+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tpcudo7gJTTbbuTXM+JjARhwoG+S0cT/6fCk8EgJ3Lc=;
        b=dqfPXt74Sxm4FSBxXv4/mO0cdDAR/IYhBp04+iya9pLXWST32gxq2YDPHcZljSqLAk
         pIF/W89AXETLVIrzChDXchYhKeRqttPJyAjMScGbzcFmWUhpEkwYQa08upJv9aLsDC3v
         2DG7Sj2lkmT290tcHtycbCZdjln6xYPd0RJIKvw98TvG3Yv+co5eBOQksRpCweMQ4xyh
         CLbpQXD+OEoII/5YHpLlZ0+hC9ymJ4gMtCwt9egEK+YvUbJPcS4zcygQKivs9BDLqWtU
         DVwjoaguBmBuM15wn+Jm0dfH6o0PWA5/H4Wy6rI9YaLwktRGIA9s5920JSzIjKOujBRG
         es+Q==
X-Gm-Message-State: AO0yUKVS0sqKTxHXmDkBchmI5IuroTzT+aLixgMseKmBT6622fXbgILA
        9PoX9E/IaReGLdRv/L0E3Fu9QFgmgrY6p5izmpHh/w==
X-Google-Smtp-Source: AK7set8QbLRvblkAO9Y2WdUOE4AoqHwyG/MzmEgbUt/H7gmbHQ71M9dyBUWLCRrIyD1+N2KqvKysQXtvT1Hqg9ksT0M=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr750152ybd.24.1674740552288; Thu, 26 Jan
 2023 05:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20230118062116.26315-1-Guodong.Liu@mediatek.com>
In-Reply-To: <20230118062116.26315-1-Guodong.Liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 14:42:21 +0100
Message-ID: <CACRpkdZeRPaYN2aN=kBskkLJ0VjFCRZc8ccf0bBW+0sposVn7A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix the drive register definition of
 some Pins
To:     Guodong Liu <Guodong.Liu@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:21 AM Guodong Liu <Guodong.Liu@mediatek.com> wrote:

> The drive adjustment register definition of gpio13 and gpio81 is wrong:
> "the start address for the range" of gpio18 is corrected to 0x000,
> "the start bit for the first register within the range" of gpio81 is
> corrected to 24.
>
> Fixes: 6cf5e9ef362a ("pinctrl: add pinctrl driver on mt8195")
> Signed-off-by: Guodong Liu <Guodong.Liu@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
