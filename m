Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60546FA30D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEHJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjEHJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:14:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751749ECF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:14:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f415a90215so23401375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683537276; x=1686129276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqn1KEnwyqGdeTv677y/SImyCACSQbNkaaVgC/3IO8U=;
        b=I3L+5FeYMvJvQuU7Qu76mdUd1ATQsaT9+QYqpPqVQCMhlS/mcRnqixhHa683tVS/4N
         YQOWLHE85n94zlIOvHipGq05bHg0SvQaQ18qsTZ6xtHTrsAawJjB9fRDkmQMpMopgfKh
         RXbVV6hTqiY28pLZJKjxgL1UV50T/rXjFX/DAcHhczTQQ9l1FspCaz165MJpGnIBdGxL
         Efs9wVDZ6Qsghu2p/lelXDhn4FoxqKDDwINEbHU7hNtBNW/eMuE0h6VVPMntkaVPUBNF
         Flo3MPGYfD9+v7IIF6O8g3HA3V1wWT1RndHZVqUjRHRTEDX1FYelWwn9mptOQVzo7HSr
         szYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537276; x=1686129276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqn1KEnwyqGdeTv677y/SImyCACSQbNkaaVgC/3IO8U=;
        b=GjN5cBRasEiRdfnwzed+tvykW6QTXtDS7aF2erznZKIHqZpawdiFa8o5AvM1TeAbJB
         EBRSf9S/dDHDjcDnTEvZuJB8jq2NKO5h8UQixG0mjZ6cx4s39Fmq1wBGN7XSy3meut8g
         X8KEBWKf57g57ioz8LAvdCWvyv2PDbE4mzOmLoumoNrlQSN67P7XIEYBt4Axy/kFacIh
         Gtvx1mV+zWXJ9rDKBVnX/+BqENlDatOaUXmn5FW5+tM+6xZFKZKeUZvvvN5z1UqY+9vn
         jxa17SxXKNJFDijaZlqhYH+wwyBeiSx0ItVBG5mDJbDMzYW+Y4i8PpuJMt+U8MsOxq2V
         TShg==
X-Gm-Message-State: AC+VfDz2fY0tkB6EaGIqrNOdgJtarB2iMbkzpV1LfF9mxQNt4sPmVdDA
        MtruwkwD7R6CD3Uquh6la7BIxg==
X-Google-Smtp-Source: ACHHUZ6YDKha54Cnz2LFGQT9b+BTJJ2/To/WjHC1YJxC5/mfCRn08nzx5DVpzj12Y38H9kkmeh5Brg==
X-Received: by 2002:adf:f4c3:0:b0:2ef:bc0b:e70 with SMTP id h3-20020adff4c3000000b002efbc0b0e70mr6656855wrp.54.1683537275955;
        Mon, 08 May 2023 02:14:35 -0700 (PDT)
Received: from blmsp ([2001:4090:a246:80f3:ef71:25ff:df82:9cc9])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b003063db8f45bsm10662309wrt.23.2023.05.08.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:14:35 -0700 (PDT)
Date:   Mon, 8 May 2023 11:14:34 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, chun-jie.chen@mediatek.com,
        mandyjh.liu@mediatek.com, miles.chen@mediatek.com,
        zhaojh329@gmail.com, daniel@makrotopia.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        Garmin.Chang@mediatek.com, yangyingliang@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT
 flag
Message-ID: <20230508091434.ww2o2nsavpineko3@blmsp>
References: <20230505093733.221922-1-angelogioacchino.delregno@collabora.com>
 <20230505093733.221922-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505093733.221922-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Fri, May 05, 2023 at 11:37:32AM +0200, AngeloGioacchino Del Regno wrote:
> The clk-mux driver was forcing the CLK_SET_RATE_PARENT flag even for
> the GATE_CLK_SET_UPD_FLAGS() macro, as in mtk_clk_register_mux() the
> flag was unconditionally added.
> 
> In preparation for a change on MSDC clock muxes, stop forcing this
> flag and, where necessary, update clock drivers to add it so that
> with this commit we introduce no functional changes for the currently
> supported SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt6765.c          |  8 +++---
>  drivers/clk/mediatek/clk-mt6779.c          |  6 ++---
>  drivers/clk/mediatek/clk-mt8183.c          |  6 +++--
>  drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 ++++-----
>  drivers/clk/mediatek/clk-mt8188-topckgen.c | 24 +++++++++++------
>  drivers/clk/mediatek/clk-mt8192.c          |  6 ++---
>  drivers/clk/mediatek/clk-mt8195-topckgen.c | 30 ++++++++++++++--------
>  drivers/clk/mediatek/clk-mux.c             |  2 +-

After grepping through the files, I think you missed
drivers/clk/mediatek/clk-mt8365.c.

After adding that file to this patch:

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

