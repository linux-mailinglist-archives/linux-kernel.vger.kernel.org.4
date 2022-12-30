Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D055659639
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiL3ITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiL3ISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:18:41 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAAD9B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:18:40 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id a64so17139633vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=snPiKqnaiN1WiMwQdheLRI2dNEuAuVQ7rQXTqdJG2aY=;
        b=jOmRVnnt+xickPH2XkTJztkw4Zi3hvRDUW1Z/bNDeaX/KxiBpbg/w+OqC5eYwzEGWa
         GE5WlyusMhcZshXyAKDY7DRT0Pd+InIwgp6eJMxiod2gxMAlfrcoUF7AWQzxWmeD6q6F
         N8nbJ3Y/8TtDzxqluZWAuxAOvDuq2Q2Ov7lr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snPiKqnaiN1WiMwQdheLRI2dNEuAuVQ7rQXTqdJG2aY=;
        b=Z9MB4o8/zvcfa2TOU+MxMjwBt0gBoG2awtg4e/SU1e9S7cqg6H7vgJ1bU0tH57B7vm
         o1MjetUjUQdR1ac8Z25F9iBm/f9kqQURrWsbqPQRdMkn+XV8Y1wY177o90EkXaItA5wk
         hd/5xDQx4s0okEGLNErlmN8WgDCW8Hxb6tlI9rvhuCJh3iwAeIem2sxxOXSEC21uZQQh
         I5/XjZdHmwN0UndatdJoV0HkSymfkFwWqI2UDMvK1ulA9yKI6LMde2OIexY98+mSrSbN
         492pr1SFfeX1vdIDeue4mwaHiGcQuM8GyX5ljEao++W15TNgVl92BtHG+QAC3p5uAgNm
         Jf2w==
X-Gm-Message-State: AFqh2kqGKCFuKOwdtmTzxvi7dPicmrXUhKgSPmzPQCx2kWuabuAHmyu8
        qQaCRNZBWx7wlSC+KiHs0LyVI1pT9bX1CBgX1dWYIA==
X-Google-Smtp-Source: AMrXdXvbPrrXMd2o6CdhgGa4mWDoeuZQzpLJ9wWmLbJ6KNXxRcDvEAw+MTtWhDWsPccnaAgosvj2akWxnseLI2V4qJo=
X-Received: by 2002:a05:6102:4427:b0:3b0:6da7:39ba with SMTP id
 df39-20020a056102442700b003b06da739bamr4341845vsb.26.1672388319884; Fri, 30
 Dec 2022 00:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-20-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:18:28 +0800
Message-ID: <CAGXv+5FzMe_W-p2NW2DWtcPY4KVUVucpc9iL322GOB4bY=w8jQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/23] clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
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
> Since the common simple probe function for MediaTek clock drivers can
> now register the MFG MUX notifier, it's possible to migrate MT8192's
> topckgen to that, allowing for some code size reduction.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
