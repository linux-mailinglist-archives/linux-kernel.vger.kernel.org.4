Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC16594B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiL3EoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiL3En6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:43:58 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85415FC6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:43:57 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id e24so4576346uam.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzc2DHU2nXa3yiV9mMwKUPwKVgPRmW21x4yoJc20iDQ=;
        b=O+5j9m2EbbdN1CTgzG9n6p7QaEu/2bzOyhgVdgBnfNFK3U7HDhsFqkDYWE4gR0f0bF
         hW+O7JWn6lS6NF4XGdWV+bp450v7+1oB7HtLLlJr1EgBX79cN+aov/EQWlyE+fSdDHQP
         62aGlzXzflNwo2OGQ77bdaJSsJ7a+AI48H8A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hzc2DHU2nXa3yiV9mMwKUPwKVgPRmW21x4yoJc20iDQ=;
        b=UmrMzI6ZcnZKgCyBwioblEUKk7NNrTQaGp3muxO3FDwz8NMAEmHWo1SJXhV6ELTprB
         g6ectlAgoneS8CqajiJkHWsqLoKh9fIRSROnauD8D6mHaek0ZXLybXBIUWOC54X5tXoI
         /AjCwpe26Bp9QfA7sKMeWVwaZ/5gK2FbuewlQHdMfW1Jxo3PxM7vVTbCvEvjHl7bhug4
         ncxfVsZVWMf6k4c0iaXl042HHOcFX0KWKQGLeohroq8no/e0pqavD+kOzFWHDMn7NCws
         5nAKOIcrmwjlqLHkSHSOhgTBnht1jicZm0kmJnJbcE/7fJacg6zE6NZ29VXoybnTT4+9
         KVnA==
X-Gm-Message-State: AFqh2kpb5WrbkcXbCkJLXzTsvWvWRFet7CXfNzoc/2jfA9vPGVPQbXWC
        IljnrKXT2pq96PnQ1Uwq67v8eOEKHIxqJwMfYcvbyw==
X-Google-Smtp-Source: AMrXdXtiQs6PVwO0EZw+110kG9yVpobNEk4D1l2z90lqtFZxqIG86YeOf7CwLTDHKuMvSgSq/MqegjK/bf+r4H56iww=
X-Received: by 2002:a9f:386b:0:b0:419:1620:be75 with SMTP id
 q40-20020a9f386b000000b004191620be75mr2785460uad.78.1672375436164; Thu, 29
 Dec 2022 20:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 12:43:45 +0800
Message-ID: <CAGXv+5FPDxxSd54478+6t0r9P7ytFYn7u6H3ezi4jYU=0R2CpA@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] clk: mediatek: clk-mux: Propagate struct device
 for mtk-mux
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
> Like done for other clocks, propagate struct device for mtk mux clocks
> registered through clk-mux helpers to enable runtime pm support.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Same comment as the previous patches, could we move struct device
to the first parameter?

Otherwise this looks good to me.

ChenYu
