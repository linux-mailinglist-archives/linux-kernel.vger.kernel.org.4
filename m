Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3325F1A84
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJAHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJAHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:13:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41573C6954
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:13:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-356abb37122so30594347b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kHHAs8z9o03GW97wZcdGSq147rwO8mX8P39g1geDY7Y=;
        b=HmNj8+Qu+jozDXBHZ3WMI7lUi35CuBJ+wsS7hlPf4hcsx8ch6gKLu3B0soytiyI8hR
         FoBpedxs4nZZrsnIw8fyTeQJ17y36rINCMmqNqVYWu0v7qXY5QoQFm77KKrOItlDy01z
         vWLKRue2pFi2VvDhnVvlNYym3fJrEwliWyJ8cidhaguHONl24D+cY1riqeTSs7sTn2uB
         nPEYCFosEDYsnB/IShHF7/LmaNZ6DtZvbm0OJ+knk46cv6o49224hCRbVyx/oNiN9gSz
         JakMwswkh9p0HtRuWkR64y9rN5VuVsK9kLQPLHlbHn9KL5mAggIOeXkE6bARNYx6c8r6
         itXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kHHAs8z9o03GW97wZcdGSq147rwO8mX8P39g1geDY7Y=;
        b=5RaqZDGUXKl373+7/OYJ5ktUu22JM8iAxcpKH9IsRSlMoQIIruWBdkYf+coZ7JvIKf
         1OFLAhZ4RbEaT1jCSLU9mPcSrrj69ihp7CtIsUgyzBIIJUhfsMNx/OFOq9JQsF+SQCDv
         cieHKrDyOnirB2c6+EIXZi41CZEz8QH9KaiWZV6EFMElbLNcD2wCkJZ9pveOOk6/7Li1
         GqTJ8tnY3CB7QV9IuIZ1ngWXGrj2nlucQBmv3M3/kzTMWENpQl+DqSdSuG6xSJryFfwc
         4YAdrUEugIXIjtIWYjn5inHuzSMV6bjXuE8MxkgJfpuxSWDmpt9TRMr3KluzsDLfJSC5
         1pKQ==
X-Gm-Message-State: ACrzQf0U6DwpGpiyHWrKw3wZ9rPnmhb9DKnsOrTz3ZovexAqxF4DwpXY
        luB+j936pEG1+e115CoLML+3FE6Eq/WK4Pcl9OhkTA==
X-Google-Smtp-Source: AMsMyM5YuSPt8VxqmgnoLZzJmw0xHS9SQrJHd4MrI2PzZBCWU1QUan+joBtvnZfU84wUHG+k+5488i3G0pI9PdE0AGc=
X-Received: by 2002:a0d:f685:0:b0:343:bd3d:80b2 with SMTP id
 g127-20020a0df685000000b00343bd3d80b2mr11152029ywf.485.1664608414462; Sat, 01
 Oct 2022 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030602.28232-1-quic_molvera@quicinc.com> <20221001030602.28232-3-quic_molvera@quicinc.com>
In-Reply-To: <20221001030602.28232-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:13:23 +0300
Message-ID: <CAA8EJpopGgmThv1BUHAP-bYsgm-ojF0FJ_KVNgycwOAOj=_D4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add QDU1000/QRU1000 interconnect driver
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
> platforms.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig    |    9 +
>  drivers/interconnect/qcom/Makefile   |    2 +
>  drivers/interconnect/qcom/qdru1000.c | 1091 ++++++++++++++++++++++++++
>  drivers/interconnect/qcom/qdru1000.h |   95 +++
>  4 files changed, 1197 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qdru1000.c
>  create mode 100644 drivers/interconnect/qcom/qdru1000.h
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 25d5b4baf6f6..760f855d7618 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -200,5 +200,14 @@ config INTERCONNECT_QCOM_SM8450
>           This is a driver for the Qualcomm Network-on-Chip on SM8450-based
>           platforms.
>
> +config INTERCONNECT_QCOM_QDRU1000
> +       tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
> +       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +       select INTERCONNECT_QCOM_RPMH
> +       select INTERCONNECT_QCOM_BCM_VOTER
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
> +         and QRU1000-based platforms.
> +
>  config INTERCONNECT_QCOM_SMD_RPM
>         tristate
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 8e357528185d..85b7f0de473d 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -25,6 +25,7 @@ qnoc-sm8150-objs                      := sm8150.o
>  qnoc-sm8250-objs                       := sm8250.o
>  qnoc-sm8350-objs                       := sm8350.o
>  qnoc-sm8450-objs                       := sm8450.o
> +qnoc-qdru1000-objs                     := qdru1000.o

Alphabetic sorting

>  icc-smd-rpm-objs                       := smd-rpm.o icc-rpm.o
>
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> @@ -49,4 +50,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_QDRU1000) += qnoc-qdru1000.o

Alphabetic sorting.


-- 
With best wishes
Dmitry
