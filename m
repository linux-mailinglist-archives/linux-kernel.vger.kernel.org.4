Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191469D96E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjBUDoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBUDoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:44:13 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69A1043A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:44:04 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id y8so2159673vsn.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676951044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xlugm3pXAui3DilCpKF18YnSL5Zk3BvOl+coQBmpVo=;
        b=kcl1T8GcpUTdYh29tvrYlgWXtNo8FgluIlnTF49/6hRsUxJFXwTTlD7wcbrqnSs4Y6
         fT3SZ9RH/rzmeSVYkBn1V/Cyngr9Ci06ZdeiQtnFca+U1+D7bt0rdOF8vvlQFn2tF7pQ
         XWhk/d//Dm6K+b0ryelYpCe6PDay2rOuf94lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676951044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xlugm3pXAui3DilCpKF18YnSL5Zk3BvOl+coQBmpVo=;
        b=B8SSli/X8cyhUIK/oOvSg/lrLvzmEc0G5JPnxdyuGS1SqSvs7EUWOMXBCfyvJZ8tzZ
         rdfVl5x4iM4+vEWJj2FbT210dy5eiMOyqgRbkXtQZo0vpOa9Aa+gCctWzUFaNJLnn/ur
         cjsH9CPzWV0ZE+B4GU0HQ97VLFxcKw5slVuE71K7PIKMFS+hG5I3YaNQWvpgAgwXhPiE
         SbiYXpd9cWJMQs0nWbajAdbS1QeX7k3fhFl9SYfDh/e9o95HBXMx95KG/z2dxsZTJZDT
         lRNxAPnBrNbVbsCU4jXbXnYf+HQ/FaV+BUhsaM7PhLuRaYqTeTg2jYUItpldtSz/zm37
         UtdQ==
X-Gm-Message-State: AO0yUKVar8Fmm+aaXj9r4zQPx1aKJ2rf9/Txj+GYMR3tkiTbD1Ni3w5H
        NzhvrWgGsvwfYVInYb29i5BBZTDPO/HZp98X4t7O9w==
X-Google-Smtp-Source: AK7set99PgQG/skcb8vDBY1z3nQ+BRz+fEyyfxl+F96z8xZG8IfiTHWVCnPD+wJav+iNFejJ1+D8eL+9Ev5yb6xerm0=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr829792vso.44.1676951043909; Mon, 20 Feb
 2023 19:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-27-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-27-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:43:52 +0800
Message-ID: <CAGXv+5GpkOvOkEg5cnFguHaMCtBH-2v44gO7O8Hd__6Ffg1Zgg@mail.gmail.com>
Subject: Re: [PATCH v3 26/55] clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
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

On Mon, Feb 20, 2023 at 11:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The infracfg driver cannot be converted to clk_mtk_simple_probe() as
> it registers cpumuxes, which is not supported on the common probing
> mechanism: for this reason, move it to its own file.
> While at it, also convert it to be a platform driver instead; to do
> so, also add a .remove() callback for this driver.
>
> During the conversion, error handling was added to the infracfg
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
