Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030669D9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjBUDz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBUDz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:55:56 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD821942
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:55:55 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id e10so2494631vkm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yTTUfpY5FBze/ZdJsTMclUwYRTvL4mC8YWDC0HHBaDo=;
        b=LdWHnd2Swi3aDPIeLDYDnQy/SdWrk5WWezojEhx3GNTFL/Z3ampZ38AUjhpG7kOPLh
         a2zMHNXGNT59i9PFUvBYLBzBWZKMsmXxWEjLKmjLWdGY0KyrntMpaqMf/pB1xiF1gfwU
         Sjsi5pSdY2BAlMpDKBiPt/GxCIuqAPEGEqQZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTTUfpY5FBze/ZdJsTMclUwYRTvL4mC8YWDC0HHBaDo=;
        b=ngx8+lBuvG63zgVI6A6ljQD7jyGXGrnPbhZP3oVIXGJOeYVa3gjpBHL+UycluK+FtM
         iLxbqxBnNS5453sr4LjgpQiD1L/tDkuzyNLaSqbhq769z4j5bAq2Jd7T+SFWrmtFU6Ep
         MaLNBBIYV3763HQlnxiGQ5mjSYNMd9b+BpsZVO/noXv6ms9iTFPzSC6qvY2dR85kfthK
         0FRPQSRQkGcYOp2nxXXHoS8JhAbbz/wZ/af/yPriJDkbMzvKKZo8SaHQxNRtbSHAQdOD
         m8RhD5tADu+SuZY6vCk1QuLt0Tu9Y1C1FWj9iQs6ZG8GUa/I214WSgv9qco6zmkc+0Es
         X7lQ==
X-Gm-Message-State: AO0yUKVo8PqIV3fu9peBTIc3ya4l4KLxF9jRtm/GgXJ0ojW4X60/6qmP
        W1R5uqXeneew8MvXBwCckIKt7yhYKd+obffKOLfPyQ==
X-Google-Smtp-Source: AK7set8Jj9rIJ0M1z0qzvgZyXsHbOHSifaxMAF2WDRHnciHO2wQ0GHx1+ow3JKQ1jckTrglgegfQO/AUz+jddSbN0Vw=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr813692vke.18.1676951754153;
 Mon, 20 Feb 2023 19:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-47-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-47-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:55:43 +0800
Message-ID: <CAGXv+5FHQG6CBcRVUYdNXdxRQVRpmnVN_EiQ=knm48B_7ugHqA@mail.gmail.com>
Subject: Re: [PATCH v3 46/55] clk: mediatek: Split configuration options for
 MT8186 clock drivers
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

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> When building clock drivers for MT8186, some may want to build in only
> some of them to, for example, get CPUFreq up faster, and some may want
> to leave out some clock drivers entirely as a machine may not need the
> Warp Engine or the camera ISP (hence, their clock drivers).
>
> Split the various clock drivers in their own configuration options,
> keeping MT8186 configuration options consistent with other MediaTek
> SoCs.
>
> While at it, also allow building the remaining clock drivers as modules
> by switching COMMON_CLK_MT8186 to tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
