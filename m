Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86886659502
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiL3F2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiL3F1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:27:37 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7ED1A80D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:24:04 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id a64so16887614vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2kO8pgMtBzZNlbzXFL36B4N197Fi4UW0BCO8fu4xqw=;
        b=Jl6Crh7Mm8B+2BMASpdiBuOTVnQhVFGCt9wvg6YWVF8Sn+/cS2kn+Qjmt1syT0QYVO
         vphIcYXev2LxGuz2zpb9Ea9eYlVyi5e94+rLvxxA2ltlA98SH9EnW2pGRYFziKBsiSyi
         18xo3AUt8+af1atgoRPWyHq/iyretmjX6m+zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2kO8pgMtBzZNlbzXFL36B4N197Fi4UW0BCO8fu4xqw=;
        b=2KNzPSja4hascGdQ8DKs+SDw3LsJMwg6NTSoZIrqEvOhi8d4A3bVgWLxB/96PuXG8O
         URLaLKEr4gevPHdhNxymAC3lfnYriBAfzPg2Horf06APngtqHmeW99j2h4doR/tSar7b
         TAVgIElYdh4Z/x3Py3/5BM5V6RHt0X3WPZQTsQt8ijgmHDykdtdfOcW/shNrUMhnE1XR
         DG0+cqjEqwVNAXVNwQkd+59MAwnX3BA8hxU3nuZNxZirbS7QYaSzTHsKrzprYibVP8Bl
         g3OVYYtGZjoJkn1140WMNtRn+1uuLFrrs6R+J3P2Y+a2fIFUv7Z7HJ0Xi1iv3aBev7yB
         t8bg==
X-Gm-Message-State: AFqh2kqKSt9G+eLf36lUOjqmQCrAdmF0p8MF1P16Wq4bUulqhawQukf3
        u1M7JnRCc02o3R12Qxv01wXvkgFnLX2N5Tf4uBTVSQ==
X-Google-Smtp-Source: AMrXdXsNEPEEDbmMNdTXQ66dzte31fV01YoUyu4VK+PpkfRFqDEmbhNsYqdkXtoVcZvmwH1OYa9y0JeRg/5FrrgR4TQ=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr2641293vsv.9.1672377843567; Thu, 29 Dec
 2022 21:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-23-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-23-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 13:23:52 +0800
Message-ID: <CAGXv+5GcBCrHRUJHZG1XAXbh+BJxGnuYSbF-QgPY6Sh5nPEt1A@mail.gmail.com>
Subject: Re: [PATCH v2 22/23] clk: mediatek: clk-mt7986-topckgen: Properly
 keep some clocks enabled
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
> Instead of calling clk_prepare_enable() on a bunch of clocks at probe
> time, set the CLK_IS_CRITICAL flag to the same as these are required
> to be always on, and this is the right way of achieving that.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
