Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA804732A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjFPIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjFPIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:51:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06D30C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:51:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a324beca6so587575a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686905467; x=1689497467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+CFo3A2Oynws7qBN6wqUi/Hm2JvW7rwW8Ek/sxYPrA=;
        b=xp+d4kWfW2lh8gA77lSwp+QpbjTsV6q8Chpk1g+OOPT7jvm9j0hhEn5/zQyN8BMPaH
         Dx2bQ5+TGTXAw/zpARqubUyMZgBszWnv4veggKJz9RfWh7RkgQP6mfLwdH6jk0w3AnUs
         3436FebMYZiTWzmtGAk+UCTsjzgMUCfYUGOFCLFRxlL3N8H29vn6lUmJgKmSPpmv1BPI
         hWpK+rEVGqCDPK70jg7+wtLMSqDFdq9Er+wrcBFQ5wnvM4GvL7g8qp/d7uRM3bBwUv+3
         5OFS1PCnsw9tf03kxXhrJdcvIPp680F7DvrERMaOiX8RVMKLQxKgSUt/kpOaFHwoObC8
         TiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686905467; x=1689497467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+CFo3A2Oynws7qBN6wqUi/Hm2JvW7rwW8Ek/sxYPrA=;
        b=SH3gQJFRkDzh0VkqwYW+t9d/6Njr8hRCBl8VTLtZ+cZA8NI45GAEnuwa33BD4oGl2j
         AP0m1xI4K1DXuYOLnvqKfQbZ62+e8/qGV+O/PsO8fycIkJb6Q8uchfdRJJ0B3wQU93WS
         9r7jmWU8IjZetafra8GLifUgpJ25xLYk7tOJdhBF8rubK6JjycaPwPL+umcpapC5a+cq
         5V7P9QYnaqvH9MPYEQbhkRQjqLnM2GEBeu+H6X+QNgRNBH4/UsMhSx13QJlr6Jtb7aM6
         HJm1sfqedyXOB82jevzv7NhF6L1228keP8gveW8duKJbBax5oRzZhqSaNxHQ7JQaHvNp
         TJLA==
X-Gm-Message-State: AC+VfDzNC2VJsFvCbQZ/dASUghEmLXIc2s1tMT/WFrQ2Q+poYiL2B8Yr
        esN9WmbcENbitiEop2G4SVW6xQ==
X-Google-Smtp-Source: ACHHUZ5s6nb5u3oL/lmxvtKXzM48Gt46GFv/+kYzbWM9jRdu4S9zR7XWN3Sq4RQHkGz+l1oAr9mspw==
X-Received: by 2002:aa7:c314:0:b0:516:3261:17d with SMTP id l20-20020aa7c314000000b005163261017dmr723581edq.20.1686905466853;
        Fri, 16 Jun 2023 01:51:06 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:802c:7f03:2fe0:bd27:d746])
        by smtp.gmail.com with ESMTPSA id h23-20020a50ed97000000b0051a409e752asm5628edr.17.2023.06.16.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:51:06 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:51:04 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not
 released issue
Message-ID: <20230616085104.mjlt63e24ebzslsz@blmsp>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
 <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, Jun 15, 2023 at 02:20:51PM +0200, AngeloGioacchino Del Regno wrote:
> In case of error after of_ioremap() the resource must be released:
> call iounmap() where appropriate to fix that.
> 
> Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver and common probe")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> index ba1386e70a24..1bbb21ab1786 100644
> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> @@ -151,8 +151,10 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> -	if (IS_ERR_OR_NULL(clk_data))
> +	if (IS_ERR_OR_NULL(clk_data)) {
> +		iounmap(base);
>  		return -ENOMEM;

More of a nitpick, but I would prefer if you would use the same error
catching style as the rest of the probe function:

		if (IS_ERR_OR_NULL(clk_data)) {
			r = -ENOMEM;
			goto unmap_io;
		}
	...
	unmap_io:
		iounmap(base)
		return r;


Best,
Markus
