Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68F703265
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjEOQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbjEOQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:11:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC13586
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:11:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7577ef2fa31so2729729285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684167058; x=1686759058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHHGh5czrg9Hn8ruae6+tSUOYEqC66Bkk4Dqa3XiSlo=;
        b=JhMjZxegyrf5rehgwrbG6ncxyoN3uqAachJItEUwJeA6jcG1cpWalyMdEhRpzegf6V
         rCKw0I471GzY7yMWmXFYn3Wz2SnW0CWCxs4eAkzbT7KzEks8WBuI49zPwViXzMM/0ZYB
         MKp3mUE9LNq08SqGHIkdjpAhm+Ubc439jtcvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167058; x=1686759058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHHGh5czrg9Hn8ruae6+tSUOYEqC66Bkk4Dqa3XiSlo=;
        b=BDLsS6tR4aY168pbOpGI+q++LvKQGkYccTa/ErfuTOHOCGIkHhpSZe9MRvl7hJlLON
         8RXhWKd9N3i29qEzkN/Q8aEUwkIaT3BEkiBd6nwUV3LX+rMRibklvBt6/INjJHbjbvdg
         RX3yuveS/iS0CgRKraPy7tslJQuIjj9JXdb21RpyV8Th8piX6fCRJs9bGbhsUbWpReoJ
         1tuB3x40+1kvuNGraP1xeVk7EX0bJsSpjienbcaJrOhDmeFcaD0J0OEBPqjh3MUD969s
         yg/anT5DSCDxPumsT9iY++Nx1dXpJe6LovGzR/BHWXCivvjzhClsnSJkQAI7uJWjUPBv
         Cfpw==
X-Gm-Message-State: AC+VfDyITPT7CLtrPhdqsYJDgYfzNp4Z22WvPRsmCsQfspqKXdctiDt4
        enz8qKwabigWhQ9HWaW2EWM9oKdG5IrHeheNBoo=
X-Google-Smtp-Source: ACHHUZ6SKlcWSJzqsnKo6b3aiYIYk2aJ6sjKmUkYwurZECtS4EK12CtKT4gJ350YykIHxCbMk8wvdg==
X-Received: by 2002:a05:622a:210:b0:3e2:1005:c6b with SMTP id b16-20020a05622a021000b003e210050c6bmr55645547qtx.22.1684167058614;
        Mon, 15 May 2023 09:10:58 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id j12-20020ac8404c000000b003eeff94e2f8sm5521744qtl.0.2023.05.15.09.10.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:10:57 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f38824a025so1503131cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:10:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1a96:b0:3bf:e4e0:26a0 with SMTP id
 s22-20020a05622a1a9600b003bfe4e026a0mr1191894qtc.14.1684167056984; Mon, 15
 May 2023 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com> <1683911265-3395-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1683911265-3395-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 09:10:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY31FCpj7HP+erKBA3SCGGgUxO=msTaVDjsGYB1eKmiA@mail.gmail.com>
Message-ID: <CAD=FV=VY31FCpj7HP+erKBA3SCGGgUxO=msTaVDjsGYB1eKmiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Add interfaces
 geni_se_tx_init_dma() and geni_se_rx_init_dma()
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 10:07=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
> initiating DMA transfers. This is not suitable for spi where framework
> is expected to handle map/unmap.
>
> Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----=
------
>  include/linux/soc/qcom/geni-se.h |  4 +++
>  2 files changed, 53 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 795a2e1..adfcd6e 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -682,6 +682,30 @@ EXPORT_SYMBOL(geni_se_clk_freq_match);
>  #define GENI_SE_DMA_EOT_EN BIT(1)
>  #define GENI_SE_DMA_AHB_ERR_EN BIT(2)
>  #define GENI_SE_DMA_EOT_BUF BIT(0)
> +
> +/**
> + * geni_se_tx_init_dma() - Initiate TX DMA transfer on the serial engine
> + * @se:                        Pointer to the concerned serial engine.
> + * @iova:              Pointer to store the mapped DMA address.

We're not returning the "iova" from this function, so it shouldn't say
"Pointer to store".


> + * @len:               Length of the TX buffer.
> + *
> + * This function is used to initiate DMA TX transfer.
> + */
> +void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t *iova, size_t le=
n)

There is no reason to pass iova as a pointer, right? Change it to just
"dma_addr_t"


Same comments on the RX side of things.


-Doug
