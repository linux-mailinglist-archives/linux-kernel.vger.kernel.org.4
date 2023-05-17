Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894A6706AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjEQOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjEQOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:18:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCF7A9C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:18:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-759200f12baso92010485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684333113; x=1686925113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeihledOH06fF9rXlghvkbkJKeeeuSIzbFVA64CPmJo=;
        b=BJhF72OgxhA9w3gBY1guoV959YY4b6jgV78Tac/3G6eOxbRWJ7ICg7D2u+p4Yzqp9Y
         ubxGJ0Ped7udr+Dubp4BEg6gZPHQqLg17dT+HAfGhFygU+HV2PjrohHQmtBG2n5fjcDr
         59/5XG0QVYs36f7QdVwQIBWVREzsqq3Mzjx4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333113; x=1686925113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeihledOH06fF9rXlghvkbkJKeeeuSIzbFVA64CPmJo=;
        b=AC+zG5vAmDEPt/+YhefiA0ZeMSpH0kToe+PGqDPdRZAl1Gqo9rMLCK9uZxEEDWltGA
         yg+BV8yA+kt+Veu+W0lpdWunUkvas8SIzBwsRmruYVlcvDOMa0YhAVHTca3VsA1g54CN
         DbIKPxgWTOAo37bgCpBRAOpJZiKB2MkWrX7FvKBE1MS0BRZGoehFeb+8fOsuV+s8qWKX
         IO/k1JGOC2JTNHUg2qPeFxmv0K4xYbnQvCtMr4Rz68N6M2QeQKjDvde9GiAK21Q4zMYu
         SdzUI22lljxONQ96+ocKSd7zpb6P2r5F0f1ltRPAf9TvPi1oj0Z+q5cQ8DhgNLyTKLkf
         0BEw==
X-Gm-Message-State: AC+VfDwivje4dt4d3xpLlwiwh3Rq+88rHow2gQZovq8CIH5cqugFGqUm
        SjlKq1nrJVz+KYRo+X5dp9Mv4vc09RAdvxadP/0=
X-Google-Smtp-Source: ACHHUZ6jctYbzd8NKsPHALPsKBjdX7fVJGHopYXMp6506moal2tYvGZ4TpM2O0b33rSdGh2RJ0ZNPw==
X-Received: by 2002:ac8:5911:0:b0:3f5:4902:2175 with SMTP id 17-20020ac85911000000b003f549022175mr8791329qty.35.1684333112874;
        Wed, 17 May 2023 07:18:32 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8428b000000b003e4d9c91106sm7125142qtl.57.2023.05.17.07.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:18:31 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f38a9918d1so144681cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:18:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1892:b0:3ef:a55:7f39 with SMTP id
 v18-20020a05622a189200b003ef0a557f39mr358230qtc.12.1684333109945; Wed, 17 May
 2023 07:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com> <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 07:18:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
Message-ID: <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Add interfaces
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 5:18=E2=80=AFAM Vijaya Krishna Nivarthi
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
> v1 -> v2:
> - interfaces to take dma address as argument instead of its pointer
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----=
------
>  include/linux/soc/qcom/geni-se.h |  4 +++
>  2 files changed, 53 insertions(+), 18 deletions(-)

Mark and Bjorn will have to coordinate how they want to land this,
since normally patch #1 would go through the Qualcomm tree and patch
#2 through the SPI tree. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
