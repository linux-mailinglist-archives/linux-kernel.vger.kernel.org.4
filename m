Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0400E6F4305
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjEBLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEBLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119983;
        Tue,  2 May 2023 04:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A14616C9;
        Tue,  2 May 2023 11:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A35C433D2;
        Tue,  2 May 2023 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683028094;
        bh=3kyH1W+UzFVD6G6EyaZ+boLKcJ0HvmBDVvQXrP6u1dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4PZdjU1vyAVpd+DGdFRNTTtGZLknQ4SkJwkn/sjSZ8ngE17xYpB0aNFeBDOq99fD
         5syZ65V0u9ik07QFAhmBux9DIbzu1lVaU99X/grjm5fV0vk6DpjUZvbutkmN02cSqE
         pIquQjFycnjQIDnwfydJM31XPSKe4Ah963n3mqePywHueWP0lyPh5anIh3YE8ZYsKV
         tLTy5zCcIPSvF4wRc+pVCUQn5VxZup4HfE/8nqOKvhJDoAbM3/vkSDbqwZp2O+G+Ky
         SI+wWfNM+G1TYObsVNyfTtn8hJ8Bh+u0L9+2HoPfuDOteUH+i0J8LOqJ5stHGHwQKr
         N3E/e0U9EtTYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptoUS-0003WC-Tz; Tue, 02 May 2023 13:48:16 +0200
Date:   Tue, 2 May 2023 13:48:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: qcom-qmp-combo: Introduce orientation variable
Message-ID: <ZFD4gM9dUQwBmSUe@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-4-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-4-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:06PM -0700, Bjorn Andersson wrote:
> In multiple places throughout the driver code has been written in
> prepration for handling of orientation switching.
> 
> Introduce a typec_orientation in qmp_combo and fill out the various
> "placeholders" with the associated logic. By initializing the
> orientation to "normal" this change has no functional impact, but
> reduces the size of the upcoming introduction of dynamic orientation
> switching.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 +++++++++++++----------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7280f7141961..6748f31da7a3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -19,6 +19,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/usb/typec.h>
>  
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  
> @@ -63,6 +64,10 @@
>  /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
>  #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
>  
> +/* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
> +#define SW_PORTSELECT_VAL			BIT(0)
> +#define SW_PORTSELECT_MUX			BIT(1)
> +
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
>  struct qmp_phy_init_tbl {
> @@ -1323,6 +1328,8 @@ struct qmp_combo {
>  	struct clk_fixed_rate pipe_clk_fixed;
>  	struct clk_hw dp_link_hw;
>  	struct clk_hw dp_pixel_hw;
> +
> +	enum typec_orientation orientation;
>  };
>  
>  static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
> @@ -1955,29 +1962,23 @@ static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
>  static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
>  {
>  	u32 val;
> -	bool reverse = false;
> +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;

Adding parentheses around the right-hand side should make this a little
easier to parse.

It also looks like these callbacks end up being called without holding
the qmp->phy_mutex via phy->power_on(). Perhaps there is no risk for a
concurrent switch notification and dp phy power-on but it's not that
obvious.

> +	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;

Also could you add these before u32 val to maintain an approximation of
reverse xmas style?

And similar below.

Johan
