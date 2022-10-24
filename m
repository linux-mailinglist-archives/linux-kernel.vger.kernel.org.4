Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB660BF20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJXX6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJXX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:57:49 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC7340C8E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:12:58 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id y20so5217288uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+gEm7VONyS7UVuTvPLRkcNvl41HQoqLdSHbzsMHTSs=;
        b=L3OSNOGMw4rOVmweIhebxGViBIgNhvyR7qzGaKgUw7RRl//uC1ARvYqlv1B6DAI1BS
         m5BT0qCELCZs/zAsS7JKiewTklsvv+bD/SVebEh2sCIBcm0zyOhHgrqmM58CUBQ2nHAm
         fOPt9JPgaFukt2vCQv1bnnfXkmpIpv6g4q6O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+gEm7VONyS7UVuTvPLRkcNvl41HQoqLdSHbzsMHTSs=;
        b=R1rmFUuwRpL6wNEdOaGuktVqv5pyB/ZbXYGu0pea7XRR9CtZs94dpdTPT5G9YWUo6z
         mAVThdCxKYQGU1+BhcdAPjbL9DSt6rZ3cxnSvAjnfwh8jqy4IT6W5ZArteMQqFkA2dxi
         /QMsTrrZd/hLMMacQtDbaIhZUOPcmIGQErX9u42Zzfue707rh0Rv2DxQBzYjtN0oJfZx
         rNMI3xRNBwUiaG5uq3NZ7D71XZ4N5Io0UCSApVR8WvouCCqd9jtVpWNgvFqISjALeuk1
         om/LLgFLY4xZ90UpPgmM87vRoZxv0abPnk7u5p5zDP9TwoD8TUhCqskOq90kvjlIuxab
         qPqg==
X-Gm-Message-State: ACrzQf2nMleiWseHouyJN64l1buo7qFgrLdlSiaQRO6/AKuCHSSrjale
        v1PUfWIZT0jkZZXguHmhB/0UECDsIxC/CsoX41lcIA==
X-Google-Smtp-Source: AMsMyM5HAWHqJDUUEN4IizBWaZrMz7exN/+WucGtaa+xWdXV1aB7+frNt8M+3SYIkfMvqtKI2U2+EXEtnsKLuJ2uOgQ=
X-Received: by 2002:a9f:29a3:0:b0:3d6:4c6f:9d92 with SMTP id
 s32-20020a9f29a3000000b003d64c6f9d92mr20097126uas.43.1666649577519; Mon, 24
 Oct 2022 15:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-11-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:12:46 -0700
Message-ID: <CAGXv+5HoMAyLJ=25weerEsHNUt-pZj1E7Aj-mWvM+hoCvovpOA@mail.gmail.com>
Subject: Re: [PATCH 10/10] clk: mediatek: mt8186-topckgen: Add GPU clock mux notifier
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:23 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Following the changes done to MT8183, MT8192, MT8195, register a
> clock notifier for MT8186, allowing safe clockrate updates for the
> MFG PLL.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
