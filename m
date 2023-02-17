Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460769A4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBQEKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBQEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:10:36 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2A3BD9D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:10:35 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id c22so1456215vsk.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=biYLXd6zLKOEnttLE3/cOU8elHlE+31ZWmdhQJR3c0g=;
        b=jXG1EnjySiZNlkImd2oRt2F05M1sX6iZ+1TAE3lOLJ18zaa8kVvrNECMIzjAeVEjdM
         ewMQHA5biBEwJzBbqHS9+OtOnca2urVimkY1pRAtermRsdwgkAILk7H4tPYzM+c1u7+I
         2lg2c1k2PE7GOjl4zEwclFgZOxcMG35sHFHIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biYLXd6zLKOEnttLE3/cOU8elHlE+31ZWmdhQJR3c0g=;
        b=QrZmmG1yQFSPb4BuFbJUNRwTjrLlSkPMvLZZ/ex+197xXR/CRa53We/vf4VQhSadZa
         bR/si/DkmmEPdH1LAzYSditkynQI7UbSDu1lyDV02xfJEYkoiz0bjLEeajn/oG5wwOdx
         dN5uo+e6D7C8Zht8eFbLx4A7kISxL8JHK1OarCvhABdX5IQ+GLCupL1tcuKDieJD1K3p
         RAKVyGCAULs8oO8AKQXVDSfG8pDvrTClPHEmOlbChtQyyqPkS+PiRX8F3sVQOjb8mW3C
         LcGUEX9O0kIuKdfUvkIECwxXYD5JHWEFZpbqD5TmOPQF+GiQBhQvVOYezGLJZo9a51E3
         X1Bg==
X-Gm-Message-State: AO0yUKUb5GDEaqfy0PO+mqwL8BchkpIzT2KzwEtG1llrmImvk8D54V7/
        BVZIioCgiDzUTlPRbG78oG0rgSqaGaWp26FhmG910A==
X-Google-Smtp-Source: AK7set88DOusSbZcPo23P4TEtI/y5yijtupuoFWWF6867RetZ53dzqg0jKJ0+NELE4AX7JEyQJcRvQvZ7O2nrBwZax0=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1524838vso.60.1676607034730; Thu, 16 Feb
 2023 20:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-31-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-31-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:10:23 +0800
Message-ID: <CAGXv+5G+QXoG__8bSDcQxOUDThcQGpaVZoQy7h-BN_GASq8y+Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/47] clk: mediatek: mt7986-apmixed: Use PLL_AO flag
 to set critical clock
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
> Instead of calling clk_prepare_enable() at probe time, add the PLL_AO
> flag to CLK_APMIXED_ARMPLL clock: this will set CLK_IS_CRITICAL.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
