Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB067F01A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjA0VEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjA0VEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA687584;
        Fri, 27 Jan 2023 13:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B390B821E4;
        Fri, 27 Jan 2023 21:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B36C433D2;
        Fri, 27 Jan 2023 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674853446;
        bh=HcXwt0i+kUfy0f1PBf0o3d1ir570XX3AABLd24dKqyY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E/aZat8YGlrEHSPjbcfF4DJBor5cnQpuMXMoF8xAbd7JOHCMD61P0sr9wQHgv3+/h
         FDT3bq7mHlrLiZ2xAfp8yTsl36rrCkvU220jlwcQu44hcLgC9unFelDjiEq81Ib+6y
         uy5Tg1OX7K3xWUYYFniv+TjnoJKAF6/VwV+vzMfjNvoRXHuEn8NSmbuZHYDqgGwsfs
         ro4OazFU3aGCgBZN3OJ+YqvoRgjRucxIHaV7jPF9ri9YS09mBCyyklzgYkDZ93KbCa
         kY4xMr0msevdZvxn7F+bw7DhChuYdRkIa1cyaOdYiL4HK2u6RkWcOoK7kS7PUPbg8Z
         IMizvaKISocGQ==
Message-ID: <91341053a892fa3ac5e7f5b719ad870a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230126230319.3977109-8-dmitry.baryshkov@linaro.org>
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org> <20230126230319.3977109-8-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Fri, 27 Jan 2023 13:04:03 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-01-26 15:03:19)
> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8=
996.c
> new file mode 100644
> index 000000000000..48d22572b6ae
> --- /dev/null
> +++ b/drivers/clk/qcom/apcs-msm8996.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm APCS clock controller driver
> + *
[...]
> +
> +       /*
> +        * This clock is used during CPU cluster setup while setting up C=
PU PLLs.
> +        * Add hardware mandated delay to make sure that the sys_apcs_aux=
 clock
> +        * is stable (after setting the divider) before continuing
> +        * bootstrapping to keep CPUs from ending up in a weird state.
> +        */
> +       udelay(5);
> +
> +       /*
> +        * As this clocks is a parent of the CPU cluster clocks and is ac=
tually
> +        * used as a parent during CPU clocks setup, we want for it to ge=
gister

s/gegister/register/

> +        * as early as possible, without letting fw_devlink to delay prob=
ing of
> +        * either of the drivers.

Ok, good to know fw_devlink is the problem in this case.

> +        *
> +        * The sys_apcs_aux is a child (divider) of gpll0, but we registe=
r it
> +        * as a fixed rate clock instead to ease bootstrapping procedure.=
 By
> +        * doing this we make sure that CPU cluster clocks are able to be=
 setup
> +        * early during the boot process (as it is recommended by Qualcom=
m).
> +        */
> +       hw =3D devm_clk_hw_register_fixed_rate(dev, "sys_apcs_aux", NULL,=
 0, 300000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
