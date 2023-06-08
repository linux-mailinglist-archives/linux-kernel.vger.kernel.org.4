Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69E72844B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbjFHPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjFHPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:54:10 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5B30F8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:53:45 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-559409cc490so456098eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686239620; x=1688831620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxePCXhbkXDkGLZszuq4c29muOAB+INqMiCN3qHM0SM=;
        b=WzaTNE+2AyDdAiv4hIj6pu6kIJRvQQbxLsvHBdBrMu2hTP3olWmRJ0STyfyIrPLcrK
         w1lhJJOaseGCvxWcn3GGjbXfSP16U6dolkqAjc1qMxEDa7Rnvnz31cbV6B93vxXVTwFX
         ALijgHlJexuCb7j46KfX14okNdAXqpqlUHfvswzpjD/Y3ql+EWBPpu+s+WbDJJDMyfWy
         wXHeSeD9pt930/YbmuOPRq4lIpsb5iA6FMQ39SyCQXL18PbumCSEeoSIR8nLhdA7axbh
         w1cnbvu9EXw5mRghXN7VecD5YEBZOOuWcC/km75GQr1IaxmcsbWX2qB7gkUbTkXjB5P0
         f/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239620; x=1688831620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxePCXhbkXDkGLZszuq4c29muOAB+INqMiCN3qHM0SM=;
        b=M+fjOCo7VyNnIMJvnzSBkqng9E/HkaCR/Gq3SoZNSqScnvZmPuAaw5HOlZvH9zd3NK
         gvYrc9ERZ8CGFPmj2RvIyctY2IMlJPHrLWISdvdUOaHae6Qkhgh97o2JE3pNpnCJSG+I
         NiDFKhEfM97qBM+NVmac7mpacOymTZWOCbYyfCOmGLkBLhqlwFXDwETO2fq9NjwG1mXL
         qjase90weksMxWZ4JCCrrmsaVzNyLMRNElSQEaqhoGxhWBGDq6Sk/25blaoyD92i7jzH
         cu8PzK1R2461SfZfw2u9VwhPOimJdooVryKrb4o0ryH51+Bh1uhhFMXhGwcIH4H1eYwM
         16TA==
X-Gm-Message-State: AC+VfDyVV1omCgWcTjeSGmL2h2p5DzvHAKzoMqSdflYwyGxZ072XgqpD
        UREaa0Q/uouv2zLPZEC8DcWu4sAtytKUUEOkgrTiFg5qIAI3FNFr
X-Google-Smtp-Source: ACHHUZ5YF3Ao/7acozgV6L51hJxYa/6ScWl1+FQJ9Sv8c4ZIP5hX4Xekiyrud6NhTqgG7h4SrXBaT/cTIprI5VqwTls=
X-Received: by 2002:a54:480e:0:b0:39a:bcbd:d0d5 with SMTP id
 j14-20020a54480e000000b0039abcbdd0d5mr6349007oij.51.1686239620304; Thu, 08
 Jun 2023 08:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230523111114.18124-1-chevron_li@126.com>
In-Reply-To: <20230523111114.18124-1-chevron_li@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 17:53:04 +0200
Message-ID: <CAPDyKFrAi04_4d-F+kNncE183ZZuD9ERL2qTb+M-nj_dNfojGA@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
To:     Chevron Li <chevron_li@126.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shaper.liu@bayhubtech.com,
        justin.wang@bayhubtech.com, Chevron Li <chevron.li@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 13:12, Chevron Li <chevron_li@126.com> wrote:
>
> From: Chevron Li <chevron.li@bayhubtech.com>
>
> Bayhub SD host has hardware limitation:
> 1.The upper 32bit address is inhibited to be written at SD Host Register
>   [03E][13]=0 (32bits addressing) mode, is admitted to be written only at
>   SD Host Register [03E][13]=1 (64bits addressing) mode.
> 2.Because of above item#1, need to configure SD Host Register [03E][13] to
>   1(64bits addressing mode) before set 64bit ADMA system address's higher
>   32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.
>
> The hardware limitation is reasonable for below reasons:
> 1.Normal flow should set DMA working mode first, then do
>   DMA-transfer-related configuration, such as system address.
> 2.The hardware limitation may avoid the software to configure wrong higher
>   32bit address at 32bits addressing mode although it is redundant.
>
> The change that set 32bits/64bits addressing mode before set ADMA address,
>   has no side-effect to other host IPs for below reason:
> The setting order is reasonable and standard: DMA Mode setting first and
>   then DMA address setting. It meets all DMA setting sequence.
>
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Applied for next, thanks!

Is this material for stable kernels too, as it fixes a real problem, no?

Kind regards
Uffe


> ---
> Change in V1:
> Set dma mode configure before set dma address
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3241916141d7..ff41aa56564e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1167,6 +1167,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>                 }
>         }
>
> +       sdhci_config_dma(host);
> +
>         if (host->flags & SDHCI_REQ_USE_DMA) {
>                 int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
>
> @@ -1186,8 +1188,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>                 }
>         }
>
> -       sdhci_config_dma(host);
> -
>         if (!(host->flags & SDHCI_REQ_USE_DMA)) {
>                 int flags;
>
>
> base-commit: cc3c44c9fda264c6d401be04e95449a57c1231c6
> --
> 2.25.1
>
