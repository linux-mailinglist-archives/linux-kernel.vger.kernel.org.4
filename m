Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665866FC2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjEIJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjEIJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:29:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0341A4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:29:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9e2f227640so7234120276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683624588; x=1686216588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIuHokypvWm/IYbI4WWTbZbJNrdYy9622yc37Rs0HcY=;
        b=D9fDFwqsVuqVXdUmjfM20BJDxU0MKubgg7ROKoxXzbJKbbvYVl3ZqjVNH7TqqSDpO/
         NeV7IRmJtHQ8S8woeCTqU+k34DbDwTzLHRVpYyfwYln2WLkx4IFGKJ2FYT948a/d8Evb
         KWrYlIYmt1NUvXYJAAU3tWHofuZOK+1QuBm9cfiw3q7aVU8hzZxImVH1pYq9U+9aJIQ+
         5wazl1lybJjUgMTcO84ymoDQVg0ffm7ox9UKNd2NHAvDmcnsZ1zlFlCKofci8wIPQ6Xz
         m842mLMeYBXMvryFh2Np0oZgxpBf8aI9Y4xW/mOOfsYLxXU2ylu6LE6PRnsEEV1r75Ij
         42fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683624588; x=1686216588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIuHokypvWm/IYbI4WWTbZbJNrdYy9622yc37Rs0HcY=;
        b=O28GZT2sjulygKmuzp8Uerc0Uz2+CerosdJfA5BxiQBf0CZb42AUWWuBOWkblThTjY
         7SC6yosYG5v3Q0ipu/Yr2019vdwmrg0gvrU05SnUkP7EaVFZ/zWUcb6a+9yCOKeOud4H
         o/56m+eocSZ9WmDwKocEKHlAlAHb0cczDOGlELFfp/GfB9UCh3Zl2USP2QXOZHY7TKOB
         XSLQFXdu5XdjRcFRwyH5ZEQoxcFDILSZiAetfHA9w7XupmiG4QffIKmUsC85dO91OBo3
         gJEHjz315mHzveTcxL9lu0UirGFaEisFLjPuwlV880wFwssdjpMA9dLL4fM9Ee+dZNyT
         EvoQ==
X-Gm-Message-State: AC+VfDwiuUMQiEMCPx/p7y0s8IqTIcwR/iLFlBfSqhxes0iPHMCfJiHf
        N/68OpwyYg2d9i9T+fePf+6BzEcrN4mZ2JVA7AYsGg==
X-Google-Smtp-Source: ACHHUZ71iTfkcXGJZvdKmvPuaTPkPvF22/hZesnDPRnZh7PA7OSLKjrHtHGb839UQSzfT9m9mHIG92NLR6Wn6pkkz4U=
X-Received: by 2002:a25:dc43:0:b0:b92:388e:d2f4 with SMTP id
 y64-20020a25dc43000000b00b92388ed2f4mr12985810ybe.24.1683624587954; Tue, 09
 May 2023 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230419063048.10516-1-wenbin.mei@mediatek.com>
In-Reply-To: <20230419063048.10516-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 11:29:11 +0200
Message-ID: <CAPDyKFreikcPGVyhbrfU6LA+fATiA6M5M-5H6EhEHU3DbjkNVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: reduce CIT for better performance
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 at 08:30, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> CQHCI_SSC1 indicates to CQE the polling period to use when using
> periodic SEND_QUEUE_STATUS(CMD13) polling.
> The default value is 0x1000, now change it to 0x40, which can
> improve the performance of some eMMC devices.

Rather than just providing hexadecimal numbers, would you mind
explaining a bit what it translates into?

For example, "the default value 0x1000 that corresponds to x ms...,
... lets' decrease it to 0x40 that corresponds to x ms".

Moreover, it would be nice to have a comment in the code too,
explaining what 0x40 translates into.

Other than this, this looks good to me.

Kind regards
Uffe

>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..483353ea3a99 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2453,6 +2453,7 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static void msdc_cqe_enable(struct mmc_host *mmc)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +       struct cqhci_host *cq_host = mmc->cqe_private;
>
>         /* enable cmdq irq */
>         writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> @@ -2462,6 +2463,8 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>         msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>         /* default read data timeout 1s */
>         msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +       cqhci_writel(cq_host, 0x40, CQHCI_SSC1);
>  }
>
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> --
> 2.25.1
>
