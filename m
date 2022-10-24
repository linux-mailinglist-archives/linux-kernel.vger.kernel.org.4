Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C460BEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJXXh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJXXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:37:31 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946B15A302
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:57:40 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so9179950vsh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mie0dwILOoL5NP5Cg3Tf9BLyHE4I1j5avRUFdQRyJZQ=;
        b=gNXcO91AfhdJU+tqEckzPK3JYjWSz1Js/FUQZO3PvIsUgwYmnA80qUARF9QI7nqyrK
         7aDzrWPVkNNS9jt3kjz3H/2gbEyMAFDMxioj5GYU9tN+InKZaAywQuBlsdxCD8up/ZC1
         cARm+ZNoI+B5/t+4cl+QXzAJHzscPydD8zxqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mie0dwILOoL5NP5Cg3Tf9BLyHE4I1j5avRUFdQRyJZQ=;
        b=QVJ85/kuzJcG7dWOEuMfnAtCpqFRuCapCiHPe8nwdPBM4JIS45mMhWacM/qjjh59AM
         jp7eXpJ5ebae5qlLWGQH6q1FZct9G1XrZvSb1ybCc1ymlqu75N1Jcb1pzbywRQ1Yadv4
         0WlNgkn/EGbT7KfbGekahdaZKzm6G7sLALanMMpi1I2GH+S8ksd84MOLIZPFf2pf/mCE
         bFLmBuUGr64gBdvaEHB7i2CS4k94/5jiSrsHdQ3rFGyIzqj4pdMyAZL6a8I71XsahgG1
         LSaJZ1TtchVRno/WhGGLLptpz/nWb6ZQ+DzSxmOCSpCYwWiKyvltagFSq7+teu/I/kCo
         kBMg==
X-Gm-Message-State: ACrzQf3SXiFNe9At3Bm7PGt3k2Q3ZeYIpa3zwLxLJb+UHZvgXBuyesAJ
        A+4oG/EuBD1Zsu3Yvud5ZteKD4Ww/Wh2//jOI0BmCg==
X-Google-Smtp-Source: AMsMyM6PPYTAcOUSy3ZKM+pzj2N+X3xlMfiu8aQLbFXu3p60GkgOWzwhnMJsay3y56pkP1gHlZx4uqvmP7yqCYRajpU=
X-Received: by 2002:a67:fa14:0:b0:3aa:1ba5:4ab0 with SMTP id
 i20-20020a67fa14000000b003aa1ba54ab0mr3994142vsq.77.1666648640519; Mon, 24
 Oct 2022 14:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 14:57:09 -0700
Message-ID: <CAGXv+5HnJgmoX=8596OJZki_0qDaipP+cbbTWpkVxuOkErSBdA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: mediatek: clk-mtk: Allow specifying flags on
 mtk_fixed_factor clocks
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
> Before this change, every mtk_fixed_factor clock forced clock flags to
> CLK_SET_RATE_PARENT: while this is harmless in some cases, it may not
> be desired in some others, especially when performing clock muxing on
> a clock having multiple parents of which one is a dedicated PLL and the
> others are not.
>
> This is especially seen on the GPU clocks on some SoCs, where we are
> muxing between multiple parents: a fixed clock (crystal), a programmable
> GPU PLL and one or more dividers for the MAINPLL, used for a number of
> devices; it happens that when a rate change is called for the GPU, the
> clock framework will try to satisfy the rate request by using one of the
> MAINPLL dividers, which have CLK_SET_RATE_PARENT and will set the rate
> on MAINPLL itself - overclocking or underclocking many devices in the
> system - and making it to lock up.
>
> Logically, it should be harmless (and would only reduce possible bugs)
> to change all of the univpll and mainpll related fixed factor clocks
> to not declare the CLK_SET_RATE_PARENT by default but, on some SoCs,
> this is also used for dividers of other PLLs for which a rate change
> based on the divider may be desired, hence introduce a new FACTOR_FLAGS()
> macro to use custom flags (or none) on selected fixed factor clocks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
