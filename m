Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D5669A4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjBQENo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBQENY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:13:24 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977CE166C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:13:07 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id v16so3180684vss.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G77BTcHhRQ4+lEDvCbYMyefKE9aJZN3Px+TFcwY1b+Q=;
        b=GmE7DywGVi2M05n5axYkyIEpPCl1yojCDqSZmlOqptPf+FIFQ9rwtUdwxWVNS6H77u
         dzfEzQL86KPfQAtyLi/gV4sE56JKW+aO2yoEXsGyFC4VUrzAGcNoyEcYPTAmtBaVHk/X
         UvraMVqeQKqeM42juOuw7oD2urjx3xzrmHMFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G77BTcHhRQ4+lEDvCbYMyefKE9aJZN3Px+TFcwY1b+Q=;
        b=mxwF/YqkWsIuwQ0jn4t6Xv4a2ZDTN9NShNmbf/hJKu8D/CkHWWrtCxZubuEcKdC4zA
         GqC9vqiJS8tLDIAdwDAosdFgc/fpjYTjYQtBPzY3JeYav/CfyJG2ChpIqddkZlvM0Qxv
         fbRBg5caQVBKHzRAt6sNWH2oXt8LZimZA1scWyns0POzEti1kZ1miXM5NjHZhelQQ6+/
         Mn3DTumiURdrgXodhfAnlP94WeIR0C49vMF57wOmOmcPefljcVMt7tXMftCeQnoXhfWP
         J3iYjB6VF8v9Z+BybgoM7D4KQmAoqucGUulOnC5sDqBVg5upVXfz0ieEy8BcdwCkIIfj
         OcQQ==
X-Gm-Message-State: AO0yUKVvjW13e97+rfnRoU3rWYq7jlXZPK/bu3QGFxsM5zU6YONsZdVP
        AUX/qSX8U3MGRyuud86QRlBU20uahrhDC/kX3cTUCw==
X-Google-Smtp-Source: AK7set8uu4LzlZOAeWltZx2kP6ZaURwx0xlX/YzXa4JbBvWynMHCgpza3Ox/yPiXCrWVfH0XBgVzD7yS+XwLI5tG3Os=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1525580vso.60.1676607182607; Thu, 16 Feb
 2023 20:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-34-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-34-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:12:51 +0800
Message-ID: <CAGXv+5GYnxxT+Z7mCYD6eJYvFT-J-uKEa8MOiZT5VRCDw-GsjQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/47] clk: mediatek: mt8186-mcu: Migrate to common
 probe mechanism
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
> Convert MT8186 MCUSYS clocks to the common mtk_clk_simple_probe().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
