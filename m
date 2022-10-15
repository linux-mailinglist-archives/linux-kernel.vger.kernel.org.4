Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FF5FF798
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJOAUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJOAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9D2ED75;
        Fri, 14 Oct 2022 17:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D639B82454;
        Sat, 15 Oct 2022 00:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3815C433D7;
        Sat, 15 Oct 2022 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665793208;
        bh=DLWGZUFypnQ4qJlqqqtH3Qnp1z+7q42ZDrSIyieCc8g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mllW1ZnrQ4EDhPWJhgVvnsWecaadIuLz2ioGthtSsax+ri6AaDEEh+OLQiuK7MeFW
         novruXrSMi1zh0pwTh2rAkMB8fQderiZGYwv6fMNtLqBngOITkIqjuE8d5k0Ir/6n8
         TLJrc5UuW2+eF31iy2+AAtNNVM7c+j/eQqrXDObnIo6ay+LVdK2/ft/NIV23V6rwP0
         WrLNtcqguxV4exUt3ViT3T2q+Qw1I+Ao6xdKX9YJp5YKzTzUEKd9Nv+cvmKZ8kyp/6
         CKO4A9/zFSjLgB4VgVrHXnFwnpTusO6ah8AxDe8graqUOMcdess4xk4XM6HVLVubT1
         Hi6TMK1Lka/2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221014221011.7360-4-quic_molvera@quicinc.com>
References: <20221014221011.7360-1-quic_molvera@quicinc.com> <20221014221011.7360-4-quic_molvera@quicinc.com>
Subject: Re: [PATCH v2 3/6] clk: qcom: branch: Add BRANCH_HALT_INVERT flag support for branch clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 14 Oct 2022 17:20:06 -0700
User-Agent: alot/0.10
Message-Id: <20221015002007.E3815C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Melody Olvera (2022-10-14 15:10:08)
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index f869fc6aaed6..b5dc1f4ef277 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reser=
ved.
>   */
> =20
>  #include <linux/kernel.h>
> @@ -56,6 +57,10 @@ static bool clk_branch2_check_halt(const struct clk_br=
anch *br, bool enabling)
> =20
>         if (enabling) {
>                 val &=3D mask;
> +
> +               if (br->halt_check =3D=3D BRANCH_HALT_INVERT)
> +                       return (val & BRANCH_CLK_OFF) =3D=3D BRANCH_CLK_O=
FF;
> +
>                 return (val & BRANCH_CLK_OFF) =3D=3D 0 ||
>                         val =3D=3D BRANCH_NOC_FSM_STATUS_ON;
>         } else {
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 17a58119165e..4ac1debeb91e 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reser=
ved. */
> =20
>  #ifndef __QCOM_CLK_BRANCH_H__
>  #define __QCOM_CLK_BRANCH_H__
> @@ -33,6 +34,7 @@ struct clk_branch {
>  #define BRANCH_HALT_ENABLE_VOTED       (BRANCH_HALT_ENABLE | BRANCH_VOTE=
D)
>  #define BRANCH_HALT_DELAY              2 /* No bit to check; just delay =
*/
>  #define BRANCH_HALT_SKIP               3 /* Don't check halt bit */
> +#define BRANCH_HALT_INVERT             4 /* Invert logic for halt bit */

How is it different from BRANCH_HALT vs. BRANCH_HALT_ENABLE?
