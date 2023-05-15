Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB87032BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbjEOQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbjEOQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:19:26 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBE2105
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:19:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-759413d99afso480540685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684167557; x=1686759557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Csg34yXmywWZKLFZGnKi20BPomzFwSWjkUKyBVPL+Vk=;
        b=aWuwpDdhBcQ8EMf+ZB/Bpr65DT/5ZrnM8ZuaJe9hujdD5d01fi2o2IInRbH2f/61qj
         TU7Y/FBAFcpT8W+J2VkgxfE3XWjIxzu18Yu8n+W5UGAxUPSUtNuLDw5ubNx6TCOjOuCk
         o/nrHf7PwPRxYYN3jnNpIG3zgGNj3IXb96CaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167557; x=1686759557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Csg34yXmywWZKLFZGnKi20BPomzFwSWjkUKyBVPL+Vk=;
        b=Tr6CECfd9u2JzVg8b36GT7ZctmDC5qf+b9Lf0iWhg/3Y0xLEZi/XD4Om/sbDgGaGyB
         rjDqVKDR0F6Hx0aYSfOhNO0UCHVUmIKdm5rkE4dJQptGkYT+TKaRtaZ3JIDUvy19Tuao
         xftXz96lU4zannHqltpE1oS3Hyw2yhJrCkM3jiGqveD2MPoZ4jHDrPLMC7yuM+OIXRbd
         xchfk4V1qkBGf6jemLSBvvfMAVMEGjjN7tWHOPPx+oyOE/khBl+7GRZCw9xLg6wnXHyj
         /fgrp3vMi/WB/dcrvGT0RaX1OZU5xT6emBiWqLbxgoeSl9e4Q7lysjlp7L9XV/5RJWg9
         N3BA==
X-Gm-Message-State: AC+VfDwTd8Qun1nKFWsQX4mHX4N16lDn4nDxv0NHmflmZj355uXoR1y+
        frqMJU0GitkoWFKuICgwSNkrsXR6CxAc69hUkmU=
X-Google-Smtp-Source: ACHHUZ5T6SXnkzPs5nCpWFYlzruxrNAaEsVyjmO/OxAbtrE7A+V1MUI+XiwLhXPENYL8SGAKOtyejg==
X-Received: by 2002:a05:6214:48d:b0:621:54d:23e1 with SMTP id pt13-20020a056214048d00b00621054d23e1mr60529143qvb.14.1684167557690;
        Mon, 15 May 2023 09:19:17 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a01f400b007595614c17bsm44533qkn.57.2023.05.15.09.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:19:17 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f51ea3a062so256021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1456:b0:3ed:6bde:9681 with SMTP id
 v22-20020a05622a145600b003ed6bde9681mr1303834qtx.0.1684167216167; Mon, 15 May
 2023 09:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com> <1683911265-3395-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1683911265-3395-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 09:13:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WbMFDsC7dVjLNrtwi-hDEbSx9R8XzVGFW902OSKSFWjA@mail.gmail.com>
Message-ID: <CAD=FV=WbMFDsC7dVjLNrtwi-hDEbSx9R8XzVGFW902OSKSFWjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside
 driver, use framework instead
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> @@ -836,35 +858,24 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>         geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
>
>         if (mas->cur_xfer_mode =3D=3D GENI_SE_DMA) {
> +               dma_addr_t dma_ptr_sg;
> +               unsigned int dma_len_sg;
> +
>                 if (m_cmd & SPI_RX_ONLY) {
> -                       ret =3D  geni_se_rx_dma_prep(se, xfer->rx_buf,
> -                               xfer->len, &mas->rx_se_dma);
> -                       if (ret) {
> -                               dev_err(mas->dev, "Failed to setup Rx dma=
 %d\n", ret);
> -                               mas->rx_se_dma =3D 0;
> -                               goto unlock_and_return;
> -                       }
> +                       dma_ptr_sg =3D sg_dma_address(xfer->rx_sg.sgl);
> +                       dma_len_sg =3D sg_dma_len(xfer->rx_sg.sgl);
> +                       geni_se_rx_init_dma(se, &dma_ptr_sg, dma_len_sg);

nit: probably don't need local variables if you change patch set #1
like I suggested and don't pass in a pointer for the iova.


One last question: should you call:

dma_set_max_seg_size(dev, INT_MAX)

...in your probe function? I don't think you have any limitations of
maximum segment size, right? Right now if you don't set anything it
looks as if it considers your max to be 64K. That would cause the SPI
framework to break things up into multiple chunks which would make you
fall back to FIFO mode, right?

Other than that this looks good to me.

-Doug
