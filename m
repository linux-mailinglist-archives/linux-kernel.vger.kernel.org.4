Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9769A4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjBQEKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBQEKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:10:13 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A32367D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:10:11 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id 89so682628uao.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oGBLPshZPGMrS1uWiQyc0lNEwV+H+9iGELbs6/oqYEE=;
        b=AcI0DMBS+/8O38CDGd3KCIk92zOU6tfwU6NbqMhu2JUhWe77Vhh81T2y1DTRAiwgx+
         2hnqx+Sgd4LCgmOmMAd3UYsr+V98siDYvfRf0eT80lANMitKBGpnwvDiQ3bD7bY3Arbn
         BMkMTihpdrBeQjYAbmMW1a26t+ktCH4Yb5T5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGBLPshZPGMrS1uWiQyc0lNEwV+H+9iGELbs6/oqYEE=;
        b=we3nTAc2mk5pt6QOjC7i0yCVFcK3nCkq8sMnaNCd7mT+n2SjbbYwyzgOCuylWasGk4
         AFyYvbMcd4ndDUhjmymzymoQgWGbZKDmK5ClWDueuTWSN7nTG8NO9hM5GVjio1R+DsSX
         zBATb1mZM41IhTdIMFyR+JO9uQq8HJQq+J3qrZqvt9nCsmjXFw2BahqkHOlaLNkL+wbt
         37KSUzqJQb1e+X5ZAngdCDG4/wTFVVIZKwIt3cxlfSVjhmVT5UjY0X+lrPp3vNehD6lx
         DBH5smlpLhXyMvB6UxLB5/CinUUW2FzY2iOnlatJtKZ+m4EvLX3f9gl0ED7YX4rmClQR
         dnnQ==
X-Gm-Message-State: AO0yUKUAGLSwJIUo9Reoo7qQ4UX2CXouPIvE27ngoz0u7taQ9JRKwr+U
        8M+Q37eUoCiuDrC3nxSYqFYqpZ4iBq/2vE83gBl+0w==
X-Google-Smtp-Source: AK7set98SeNGl96EZizNQbwyR9dDOavG0wqLsoG9BX82J6+26nzoNTPbkoI/Xm8xERtgLUXiCG8Vl/Crx/a2DbTjOIo=
X-Received: by 2002:ab0:318e:0:b0:688:c23f:c22f with SMTP id
 d14-20020ab0318e000000b00688c23fc22fmr1246817uan.1.1676607010310; Thu, 16 Feb
 2023 20:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-30-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-30-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:09:57 +0800
Message-ID: <CAGXv+5EEO2RMzwkknMEwYZmtO7PbDhOTj_=yRrU0UHeCdc==iw@mail.gmail.com>
Subject: Re: [PATCH v2 29/47] clk: mediatek: Propagate struct device with mtk_clk_register_dividers()
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Propagate struct device for divider clocks registered through clk-mtk
> helpers to be able to get runtime PM support for MTK clocks.

Sidenote: I think we still need to call pm_runtime_enable() (or some other
function) on the underlying device before any clk_hw_register() calls are
made for the clk core to pick up runtime PM support?

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
