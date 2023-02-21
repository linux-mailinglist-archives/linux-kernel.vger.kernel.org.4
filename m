Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77769D9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjBUDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjBUDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:49:55 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E9261A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:49:33 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id n140so2273709vkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPoBAzOY7l81ilf6DvBo+V6oHlkpvntjBu0BjLr0NvA=;
        b=VtoDb0qi3qcRjGlBzBBUqnhe6uQSr398gnTnlzc2iewCSdq22ndDi3pbSxFV/2Y1x6
         yRYsqCfqawFjqoQYIEZxLBRxA/IOSuUZUDKBrnoCpioCqlHVCgx0E07C8y+cMKhmNwGV
         sXzYnlvp06VmHgdJJ7eLnzyLst0kMhc3o29gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPoBAzOY7l81ilf6DvBo+V6oHlkpvntjBu0BjLr0NvA=;
        b=UPCzCRJlu8hSUU68t9WO9L5u/YtuS8HekXPECt52+tBwfinhjtrWjKFwzGsxTRtTht
         6jrDBGwf/Kf586aTqFygv6YHmDTWZ/P623CYaTN8MP6W8t7sk/+4uZaK2ACauGAulZsD
         nOjyeK402+rWSNpzkOkgg9Ko88vULUABfBDQrOgSGJdmFWWoDGpNmFJAhtJJV3oUdZX9
         /TvIKUYPzWF/7z0Rn8ZyI+KaTaYxjBUm2yg/m7oARcKVWk5GxS+7r/XvSzZMYfT6jpa1
         vOIe1l7sQZLiZmoCgi0HcM/6yDKbC7uUqyGeJlMk6m2p/mV8Nal4yQTdOXNhQTUyItcu
         yV2Q==
X-Gm-Message-State: AO0yUKUA5tzfiOTQh2MrQTNAuRXgEI4GnER7B6I550Iys6XezYbjjAxK
        ZQzzcOWuVXFWPyF8TLvdUWRVa5R6YCtgIUPAyBvxWg==
X-Google-Smtp-Source: AK7set8Q7PtNTb6fxNMZPD61CAaqHdBZcNpoeaXFEaFzbmDAp9vIZ0gfeB0Nrm2cLOtunr0KW/yTajef/wfpYfrwpM4=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr811653vke.18.1676951373136;
 Mon, 20 Feb 2023 19:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-29-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-29-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:49:21 +0800
Message-ID: <CAGXv+5EzYrGzXR+YtQdQnp-nP722XtMYFu4fo1KNoqpY3hpAPw@mail.gmail.com>
Subject: Re: [PATCH v3 28/55] clk: mediatek: mt8516: Move apmixedsys clock
 driver to its own file
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
> In preparation for migrating mt8516 clocks to the common simple
> probe mechanism, convert the apmixedsys to be a separated
> platform driver and move it to clk-mt8516-apmixedsys.c.
> While at it, also fix some indentation issues.
>
> During the conversion, error handling was added to the apmixedsys
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
