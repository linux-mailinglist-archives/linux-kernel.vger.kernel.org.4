Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F75656095
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiLZG45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiLZG4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:56:50 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA011173
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:56:49 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id q3so1423229uao.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1SnFH/lPjK8DkSzjFnZaeTI7PMR4Peim0SSBCAeoNI=;
        b=gpVfONHwSnhvI+o4Oswm1KdRr3vFgOt5mgU6LHjiuvn3rzTBYjJzr0Gz85lS4d9YPd
         Kxbz999P5+w/OV2qnWUaenSzULCc+id7R/d8frAkCqbUxnsaPLKZqWUkxhlnQIqSsrkz
         W5JAOZXn7/EThGJgUqWOiZ5S2SW8YH0PXBNb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1SnFH/lPjK8DkSzjFnZaeTI7PMR4Peim0SSBCAeoNI=;
        b=TjgF8VjPiwpVfiijcKGPbnaoc5z2izZRoZO+t0EU/r92fd0CPbwvRbryfO7odu1Loc
         4AxbBRlSblR+2QXaIMTospdqwQU+cvALJnjXQc8g2j3JEjcOYc4gl25VkxizQlKXWbx3
         9bUUVucg0sfX9eIXKLoKbiIs+lQMOcD8zfCVMk0W1Snux2z2hzNu6THYO+uOmOOM/BPV
         1fZxSZz4NRIY0R3vQEbO37QavU/HD1SMdldJjuxvGw5tWp1AV1pUwIoeRPR50otrFife
         cnoj69y50VBGj/DnwzU1zyMA8CKBIcRd2GjNtEzz9hyo+SKjOZ5llY/mbAeKrstPsgGn
         AB0Q==
X-Gm-Message-State: AFqh2kpo5CBXe9z8hWcehkw1bFrcryKRVgs1xkBn3HE5b9D+d3jEBAxR
        vgbIyw7CW2EFpIMGa2Gk9J1RXLjP1eqc1VWt+tkAeg==
X-Google-Smtp-Source: AMrXdXumnCdbt8Id7nVQr72ncvxGvcSqSPRDFYpUVKhiIspGshPFm1Id8SI1nyZQ+l8BnASdx7sBOZ9SXIDiFAYGgvU=
X-Received: by 2002:ab0:738b:0:b0:469:f0ea:c1f7 with SMTP id
 l11-20020ab0738b000000b00469f0eac1f7mr780278uap.0.1672037808572; Sun, 25 Dec
 2022 22:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 14:56:37 +0800
Message-ID: <CAGXv+5HTi14-AV38DAFKao+PBeMf3CpSgvD6OuNnzRygL2bvgw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] clk: mediatek: mt8192: Propagate struct device
 for gate clocks
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
> Convert instances of mtk_clk_register_gates() to use the newer
> mtk_clk_register_gates_with_dev() to propagate struct device to
> the clk framework.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
