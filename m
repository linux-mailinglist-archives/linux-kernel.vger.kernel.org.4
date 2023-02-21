Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6A69D9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjBUD7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjBUD7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:59:06 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB4225940
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:58:39 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id g12so4711629vsf.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676951913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7Tcyr5dOvP+6P4gxGkarZtN6wcj1ZBVjR/UVVwdfS8=;
        b=IGCWsSkkutgh0okrfT7uNFy1RET6SsVtvhWs/LxdEJVE8B7tM6E3UEw//b+M/52lAZ
         l66CsyZgEsgVv0gZWtiop9xYWuA1CQw/7tUTKesUiToMpqgi57toBLVQOxWgj787HSjH
         MS6+Q7uiQAejEqu1bQJqsIfCOQQWiq1wvAvRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676951913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7Tcyr5dOvP+6P4gxGkarZtN6wcj1ZBVjR/UVVwdfS8=;
        b=3t6cNnhruHZdqeEagQVsjYk2s/eUoVYUIevofdNew1X3hZo8XxIzMC8zcVeS0nOvgV
         xijwSdezV47VKW42994sGtGqMbos+a7YWk7tAtR2+tVrwQ30iHOyx0CsFXUIgC3pSf2P
         nv+xHv14BwX1/24IeO3lPP71rPldp4g4q2Be+0iJ+G5CcZZv/tSplENpRPoj8P6GfZyK
         cDdJljQvlH8fXWMoBHZMKu5Pcm99XuHIXKjUV6Xg0ufVD0dmm1RBi3g7XbVLLHxDQXXK
         92F+5vo6aemk15F98YsKOEy3IW5an5fDg++ZlKrdP4OMiyU5g2QJ4vcVWjfwPyC21UPE
         7fQQ==
X-Gm-Message-State: AO0yUKXqZGVhL4qUPU3WIvdwU8FkuCYNlzxL8rdwKpo5K0K/C1Oht9Bb
        1OsvEP6T+AojbRKJm6uGx4gXDOM42BS0HcLhOmLQLQ==
X-Google-Smtp-Source: AK7set/CV/ZM7hd/l3fjmImnECupChh8gWI0Feh0+HOI2S1BX5lITZZjvlZgjwhlppcpeUrVOzbCiYwLLNVX2ZFcm+U=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr834615vso.44.1676951912861; Mon, 20 Feb
 2023 19:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-54-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-54-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:58:21 +0800
Message-ID: <CAGXv+5Ge2aLLTLHajzdwRYtWU3akcZuo8e8z2niVqKMhzR4x5Q@mail.gmail.com>
Subject: Re: [PATCH v3 53/55] clk: mediatek: mt8135: Join root_clk_alias and
 top_divs arrays
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

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for converting this driver to the common simple probe
> mechanism, join the root_clk_alias and top_divs mtk_fixed_factor
> arrays.
>
> This commit brings no functional change.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
