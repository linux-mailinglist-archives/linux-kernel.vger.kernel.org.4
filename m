Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66469920E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBPKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjBPKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:46:12 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2E55E5B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:41 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id k4so1482649vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OikyZqRmoD0C+GYQ1KT5tc2T2n1ELXXRZ8rYdWGUuJk=;
        b=RrQPWJV+c8IYzi438eFajsT0qqU5972irIrlYlC+toscyWM63GRyvTL2iUyy2NnSmv
         8bNPm7/rdH8yqPmCLipD3iwwKr7YDXiLOYe08og59qJqL+hurOB73DB3AJqMqS0CTZX3
         BkwxDqvs7v7rYRkRl51UkdXSinlG7mblKQuLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OikyZqRmoD0C+GYQ1KT5tc2T2n1ELXXRZ8rYdWGUuJk=;
        b=ppzNB6z6esdP1UhJQRzBAaTEMAgzUplUrLL5fDZob+gswmBFwVpJW6xUXchOy0/T6y
         ITihGwFxEWeJzrhJQ1Jl1MAQrcCY8eqRG22omxIUxdQYERlT//QOTwHtz3D8bF77xVwK
         B1GJByxWWwEUNj6dJc8hl561i2RCCBWFex5TovHBWPoYVap5CqlgmUrk5jdziVgnZhnA
         hBjcbnAgaag2f0hpiWUttJRuxeq47ursM9CB0SA3BPNaqU3tgu32JI2QuBG7HAYReLJ2
         YrFVdz4jgZwQDUdrjF+kuob3c0tJnnEIhvXDdWKU/xrUb9zL5J8B+WaBoLHnLcZFUD+9
         W4kw==
X-Gm-Message-State: AO0yUKUeEcs8pn7Kmz3hI9CfYJ7dqOE5tpqGxiL27xJKgAvQ4m3wW7Xi
        tBgLiAfsPdDZBTUVJrtAxNJVxOs+o9TI6PTHEnabCA==
X-Google-Smtp-Source: AK7set9oX9ednFxOPyR1C2ACJClKhPaeGavzOb7y1NTEL3RKv/WKFcHuJe8veNw15alFWHK4vAigihyINbLkC/m5MLU=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1008836vso.60.1676544338052; Thu, 16 Feb
 2023 02:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-23-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-23-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 18:45:27 +0800
Message-ID: <CAGXv+5FcBHur0sS7aS5TQ8jDLbAXKk36BC=GMQ6Y0-NmsQQ5wg@mail.gmail.com>
Subject: Re: [PATCH v2 22/47] clk: mediatek: mt7622: Properly use
 CLK_IS_CRITICAL flag
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of calling clk_prepare_enable() for clocks that shall stay
> enabled, use the CLK_IS_CRITICAL flag, which purpose is exactly that.
>
> Fixes: 2fc0a509e4ee ("clk: mediatek: add clock support for MT7622 SoC")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
