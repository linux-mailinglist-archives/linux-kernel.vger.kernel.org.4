Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03A6CCFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjC2CPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2CPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:15:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2D2D46;
        Tue, 28 Mar 2023 19:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 571D6B81088;
        Wed, 29 Mar 2023 02:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135A3C433EF;
        Wed, 29 Mar 2023 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680056111;
        bh=mmaj+tYf3L24Jfgcy+JEgm6ISFS2CI7kguFMstQHqE0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IJmMIO3UosSjTvoqQNhEdIbe5ssCUtGU4td0tz1/bOyMjMkGF4+VtXT9Rg9baFN8R
         7UHWQMknV+asmp4bajLNihXMn5zkg6SgwUlydPvkIVeOEClE6reA3IeILvmCIDmDlo
         zNxUkh65Nh1vBz6WTDIFJtAqRfzWNEUaLiemmyAS307GZxwv/1YZryiUcE2NCQIqfL
         saL+Cb+UBjurcPY/t21Pkfv1K2FFM/qP5QUqmo4XnuL1Q1u6H3fg0SJMmO+2BfXBSi
         w6URsWeq3UwyBw3Cou37UJv+rU8pzLffLSbvLLEa/KPDktg2IHlGdavBOFISNU0Ske
         sA/yItP0fV8Aw==
Message-ID: <72286603300630b890705c99b42f05a4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230328193632.226095-3-brgl@bgdev.pl>
References: <20230328193632.226095-1-brgl@bgdev.pl> <20230328193632.226095-3-brgl@bgdev.pl>
Subject: Re: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 19:15:08 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2023-03-28 12:36:27)
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 449bc8314d21..5e1919738aeb 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -437,6 +437,14 @@ config SA_GCC_8775P
>           Say Y if you want to use peripheral devices such as UART, SPI,
>           I2C, USB, UFS, SDCC, etc.
> =20
> +config SA_GPUCC_8775P
> +       tristate "SA8775P Graphics clock controller"
> +       select SA_GCC_8775P

Should select QCOM_GDSC as well.

> +       help
> +         Support for the graphics clock controller on SA8775P devices.
> +         Say Y if you want to support graphics controller devices and
> +         functionality such as 3D graphics.
> +
>  config SC_GCC_7180
>         tristate "SC7180 Global Clock Controller"
>         select QCOM_GDSC
> diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa=
8775p.c
> new file mode 100644
> index 000000000000..46d73bd0199b
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sa8775p.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights =
reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/clk.h>

Is this include used? If not, remove it as this is a clk provider and
not a clk consumer.
