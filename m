Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF46560A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiLZHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLZHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:07:23 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1E72623
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:07:22 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id c26so2211502uak.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc7UX5qQFKgxUp5GIPhkGqMn4OUOgloWMZmKzKsecYc=;
        b=F36ks6qgrclKiSq119LjQgu9DDYLk5CwlQlwTUbhE5kBes/fyuLFzf2adOZlVDDvZH
         4pwMnuHAkPHbxR/8o/VFR5Yswpv3I4g9VXlfbDbGA015CZQY333kwSZLDrNcrlzxfxCs
         oHpmv6xmktdygibJiDmwyOOUKvYzvkDEUmm1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kc7UX5qQFKgxUp5GIPhkGqMn4OUOgloWMZmKzKsecYc=;
        b=RG9ZtRuggrxXfHXV6G9Rd8KIubgsUXcED/AtXZYzhkRd5Ui+wR009J/VxHiHhRWcwz
         6Nl2dqRHxNyKDlGb1SdkNVQ+UIA+8N4TWYxm+OkMmmLIg1GhUtR3To2JUrSBkjzEY7Bx
         CD85qS31UNZV0At9CwGAruBgOUw6ZwVHcqzZJ4aFiJcMRzJOkjXTN6LUrCNX5bbFxAYB
         EaKKI7MyfVEJg8ctUkLBXOo8Hk3DL8won+21O7Lo5JLUmPjuQqZnX1nnHx5cM9uI9olW
         +zpHWAdNTXP0DbIeUD8Xdi55mc8QeMuB7/Rx4KMOKhSd8bLUfJtfjcuJ1If/jxKCUCo+
         HB7g==
X-Gm-Message-State: AFqh2kqzqXuMu4GhsQGHm0HYwZlCfgTy5+k+jlsqSHjheW3HP5a3DEJt
        XtUqLV0Whtb5N3vvZ4JDf9J+iUgfFu3S63SZmKgjEQ==
X-Google-Smtp-Source: AMrXdXv2VqQXGVz7UsmxIS87BTXQNUJ4d3yeAlvbMCKPSnAPa13HYbgf2LvkaebhY9B0OY4hysESqwW4AfdqoejLjw4=
X-Received: by 2002:ab0:7411:0:b0:418:b849:8187 with SMTP id
 r17-20020ab07411000000b00418b8498187mr1585399uap.43.1672038441665; Sun, 25
 Dec 2022 23:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 15:07:10 +0800
Message-ID: <CAGXv+5F8QZGc4oDKJAGbpvubqiewvngURpNhrenS3pcGQNrOYw@mail.gmail.com>
Subject: Re: [PATCH v2 04/23] clk: mediatek: cpumux: Propagate struct device
 where possible
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Take a pointer to a struct device in mtk_clk_register_cpumuxes() and
> propagate the same to mtk_clk_register_cpumux() => clk_hw_register().
> Even though runtime pm is unlikely to be used with CPU muxes, this
> helps with code consistency and possibly opens to commonization of
> some mtk_clk_register_(x) functions.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

As with the gates patch, could we make the |struct device *| parameter the
first one? Also for this case I think we could even drop the
|struct device_node *| parameter.


Regards
ChenYu
