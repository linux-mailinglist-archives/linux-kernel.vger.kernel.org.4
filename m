Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8386968CF58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBGGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:11:40 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60C303E5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:11:38 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id y8so15232079vsq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zP2ygbVdDON6yUIfexoROgjUPhLPhR3gUrJen46Rt4k=;
        b=njFbTgS2Fnz3eXZQG2IIJq44fTew4djBUK9I5vGRHno7jZJxYxJ1F+n/A6/9kRBU5+
         V5jzuzeDn1fRqBRoQ9ckiOYh3BaOU8U9oH1FdOkOana/r1CA4Db6gTTxjrwrr7JFCVWz
         CGBPbLeqbDDy2BWvEu3oUXn4Liaqav4bL4kdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP2ygbVdDON6yUIfexoROgjUPhLPhR3gUrJen46Rt4k=;
        b=U0Qv2Jz5ePUQXt7qZNrvJOaBgQXk8YVwkf+tOEqVBmULv5IB6pSblHzicCa1uhaZ/r
         6X8m1/8x9gTWoULg3zni6RRhV9qlLuNbZhRgUFJUTxQ9frpbWEtpEE+KaeHUSEk7nEOA
         UhPnkcn8VW5X+yHLctQP3bWESIiUrsXmepVNgA+khOyhUwYFw3P6O4ORdaCASHX3WXwl
         zr/3kNl7MZSCNaNrWeKMOHvYJ1C+CXJQ1536FoMpmEQ/H9OMfP77PeuJ7jI5IKsNf8Zf
         5eCaFr4FEejJCpBYnFQwkgFQMnHZ+q+TMGmenDqz1CT+xMnK4+JacnVzTl8fyzp43wW+
         9S6w==
X-Gm-Message-State: AO0yUKVfLq4kgxaA74jNfvrEXqBXKxtUjZRWaVRBdPECMiiJ7kOgfyBo
        ymstWGVoBHTv5bZdC1E+GbI/eDHbNnREKiYEGDR0HQ==
X-Google-Smtp-Source: AK7set/rPPS4UD3H+wPsyBdYQgSN6AGYtE3iy5mIdz5UsLRmTWNhHy9DVvsGzrlJ8515poglceCc81LaO1hE0/O0uFg=
X-Received: by 2002:a05:6102:3d18:b0:3f7:93c4:9e56 with SMTP id
 i24-20020a0561023d1800b003f793c49e56mr545453vsv.85.1675750297266; Mon, 06 Feb
 2023 22:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:11:26 +0800
Message-ID: <CAGXv+5FxX4tue8owuxbrA2NNxmQdCnYj7orbam8AUFismTA1jw@mail.gmail.com>
Subject: Re: [PATCH v1 04/45] clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
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
> Add support for divider clocks register/unregister in the common
> mtk_clk_simple_probe() and mtk_clk_simple_remove() functions.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
