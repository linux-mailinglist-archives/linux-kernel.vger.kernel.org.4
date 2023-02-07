Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D486168CF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBGGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGGHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:07:10 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421AD40F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:07:09 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id v26so7407127vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Di8RlAFDXixiWPVVKjwmVmn+q3pmV1A/L5akLwyt7Nc=;
        b=L3HvVnbjZnijMz+CunEMzm/Ax4c+mMXjg3QtyAUys+a11FwAdOhoAPH6UfPlQgQIgh
         wpWsZQu3Bmn/ahQHtG4+RWaOXkKydro9IAQwKbNS2NVJxTus4x006vX3gxiqMtWQ7PQx
         FxaZM2NXbsla+cnc8M0ywf8TmQoaXN67AMlhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di8RlAFDXixiWPVVKjwmVmn+q3pmV1A/L5akLwyt7Nc=;
        b=z4pP7NHuyA2b14j0vHtgq86Aj6gD4VHEKjWSKb+ubTmA9xh2ZZ/zxMDshYADPONeBj
         CneZ2gjmOZfu+m12IXEkIKn7D5UVBOPGX9siUlSekNxyMzFsNOa3G/mbU1OMtdW0Qnqy
         ZN8J3EMndzIqwd4RaFRdP+DytyZhnh0qzildhDACio/GGJxTePp7/k6L/kpiYmcAQopy
         d34jZXYBLgqpskhVamTSTTTuxqYaXT1XwMojBFPA68fe5oyrh3YPzNk2GjSW4oehRKNl
         DnL+PgXbahw8P5nfULBKd1UXH3Is+Enn4m2PbUgn4p8HcAi7Gh8MfLSqg4oeXvQiHRm1
         mZVQ==
X-Gm-Message-State: AO0yUKV7wzseuv8tCpsRcNvvy/iUu8zH+NDkQ34tO1jh9p6Z3O9T9DUE
        +Ui8lVoUeiuMZvd7IOC0qXz5FgLMAmEATo8dJzjIfg==
X-Google-Smtp-Source: AK7set8CXMGyMBuUrs9+E2OARHA5fk6GumDiWDSvfiq0b4is11veuHt+ijbXPvTl5cbTV+LKFMCtwDYVY2nWTdkUzUc=
X-Received: by 2002:a05:6102:4b8:b0:3fe:ae88:d22 with SMTP id
 r24-20020a05610204b800b003feae880d22mr445813vsa.65.1675750028448; Mon, 06 Feb
 2023 22:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:06:57 +0800
Message-ID: <CAGXv+5HWpE+N8aFQkFB73_-L+O8JQGDczra0Gkmx173tH0EBqA@mail.gmail.com>
Subject: Re: [PATCH v1 03/45] clk: mediatek: Migrate to mtk_clk_pdev_probe()
 for multimedia clocks
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

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Reduce duplication and simplify all MediaTek multimedia clock drivers
> by migrating away from defining custom probe functions for each driver
> and instead use mtk_clk_pdev_probe().
>
> While at it, also add a .remove() callback to all of the multimedia
> clock drivers where missing.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
