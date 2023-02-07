Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4ED68CE7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBGFCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBGFBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:53 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2A46A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:01:47 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id d66so15020553vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 21:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JzZxhqIK8VhysJ5sWFrp6HBP0d2gguK8lzGF96oeeJY=;
        b=k9hUTA70o7Pv03Fw+mhKWYoNw4WzoTEgJU4opObsu/oieKz2vo8+0EzrZdclvkFM2l
         34zZdwyIUTed5eK+R6GWFBJhpEEHuBGkRvbui8S+7SDPNd5UnjVpL7aV5gN3N7DzoBx8
         H03d53epQkYi81+4qHff9il0/LWAUGelm3NRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzZxhqIK8VhysJ5sWFrp6HBP0d2gguK8lzGF96oeeJY=;
        b=Iv5TZdnTSsOfvnrISLwYkorC1w9GR9vnjLiNNEb9J0zdg8lmYHjJWmqR8cNsyvGp1A
         R+1Raji/KsyR0hNl3pQKgFcLteVvMvi4O8W0ku5srzXf6ICRUmSpGZxl9aslG4jRs28d
         wLrUwoMvXQBxGDDdS5kBIOj+JK/gtMxX6uv+LrAxWIeWaBBlwzqgJR96KkUWRn4WP151
         +ZqFoqo53IKK7d2lZnS6/HpNPgvC6p/tOSbZ5iD7MWfBK6FLAYfEmxzKDZoAMqC6y+bY
         02FrLYlyfr46oubhnK2hyUqNyf+uC883u/zeFJpUgjBD5SSjagVlSfB70uJW2dIOs6MT
         itCQ==
X-Gm-Message-State: AO0yUKU740GXa0CqOfS+36dUaFUakfymihoCv9BaTy7b1xNXMtkrW9aG
        7iKGDtAGMBV5QOCuKRMNDjwcUa7wvj9oMzVfUImoDw==
X-Google-Smtp-Source: AK7set9Z70LfNVS6WrBF5dXe2VuLYtlYTHr8qqFya8+8Mty35+VW4+2UeSbTXwSsqJOqw6PJvuPi/t/tzMePg+eAeOg=
X-Received: by 2002:a67:d206:0:b0:3ed:2cd6:deed with SMTP id
 y6-20020a67d206000000b003ed2cd6deedmr501277vsi.65.1675746106739; Mon, 06 Feb
 2023 21:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 13:01:35 +0800
Message-ID: <CAGXv+5H+dFdrXB1dWRwzU+CsBe6rE+ge1T7St08kueSgepA-kg@mail.gmail.com>
Subject: Re: [PATCH v1 01/45] clk: mediatek: clk-mtk: Switch to device_get_match_data()
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of using of_device_get_match_data(), switch to the generic
> device_get_match_data().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

though I don't think this does anything for the MediaTek platform lol
