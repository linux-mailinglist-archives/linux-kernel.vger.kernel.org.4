Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4D5F5E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJFBu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJFBuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241032C67C;
        Wed,  5 Oct 2022 18:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62096B81F7E;
        Thu,  6 Oct 2022 01:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45094C433C1;
        Thu,  6 Oct 2022 01:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665021051;
        bh=QcwagBeSbuvRCsWJIUdcRzilPwxU7LcEOFNF7wVbWwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spjou0Ke2vUCPkkiik+9LyrmcFtV2qX+eyjNqeSQc5B3afnB7a1l+Ef8K8XKMBxXA
         dF1LCcWmpnBr5piKgGuIeq38stk/+3Bzl1jx9ixZm52goyH88eYzJZl5ac01+vkMUo
         EMNRThZHgEfO1M0QQkoxTK4NmnlPNXGPkZ5cUa+mwSDulhi6VhCaJHzxDvuCEf31Bi
         ScPxxm4vuABATmr0ZRYL+CbY1jkQLaJEhT+p97jYSDNC3T9gPZgPGz1YbjxC7YDTN4
         e7zRydw0Ym1Z0fktYN7zr9Ykn61a8HCcnirWEz2NKI8omimuLDqG++h0lyT838uc8d
         rBYQNqFYxz8Tw==
Date:   Wed, 5 Oct 2022 20:50:47 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Message-ID: <20221006015047.4ten7sjsth7sw6s7@baldur>
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-3-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001030546.28220-3-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:05:46PM -0700, Melody Olvera wrote:
[..]
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.c b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
> new file mode 100644
> index 000000000000..8b931ff80bb4
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-msm.h"
> +#include "pinctrl-qdru1000.h"
> +
> +static const struct msm_pinctrl_soc_data qdru1000_tlmm = {
> +	.pins = qdru1000_pins,
> +	.npins = ARRAY_SIZE(qdru1000_pins),
> +	.functions = qdru1000_functions,
> +	.nfunctions = ARRAY_SIZE(qdru1000_functions),
> +	.groups = qdru1000_groups,
> +	.ngroups = ARRAY_SIZE(qdru1000_groups),
> +	.ngpios = 151,
> +};
> +
> +static int qdru1000_tlmm_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &qdru1000_tlmm);
> +}
> +
> +static const struct of_device_id qdru1000_tlmm_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-tlmm", },
> +	{ .compatible = "qcom,qru1000-tlmm", },
> +	{ },
> +};
> +
> +static struct platform_driver qdru1000_tlmm_driver = {
> +	.driver = {
> +		.name = "qdru1000-tlmm",
> +		.of_match_table = qdru1000_tlmm_of_match,
> +	},
> +	.probe = qdru1000_tlmm_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init qdru1000_tlmm_init(void)
> +{
> +	return platform_driver_register(&qdru1000_tlmm_driver);
> +}
> +arch_initcall(qdru1000_tlmm_init);
> +
> +static void __exit qdru1000_tlmm_exit(void)
> +{
> +	platform_driver_unregister(&qdru1000_tlmm_driver);
> +}
> +module_exit(qdru1000_tlmm_exit);
> +
> +MODULE_DESCRIPTION("QTI QDRU1000 TLMM driver");
> +MODULE_LICENSE("GPL v2");

"GPL" only please.

> +MODULE_DEVICE_TABLE(of, qdru1000_tlmm_of_match);

Please add this next to qdru1000_tlmm_of_match.

> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.h b/drivers/pinctrl/qcom/pinctrl-qdru1000.h

I'm not able to see why this is in a header file and the commit message
doesn't give a clue. Please align with the customary form, or motivate
your choice.

[..]
> +
> +enum qdru1000_functions {
> +	msm_mux_gpio,
> +	msm_mux_CMO_PRI,
> +	msm_mux_SI5518_INT,
> +	msm_mux_atest_char_start,
> +	msm_mux_atest_char_status0,
> +	msm_mux_atest_char_status1,
> +	msm_mux_atest_char_status2,
> +	msm_mux_atest_char_status3,

For anything that denotes different pins in one function, please drop
the suffix and make this a list of functions.

[..]
> +	msm_mux_qspi_data_0,
> +	msm_mux_qspi_data_1,
> +	msm_mux_qspi_data_2,
> +	msm_mux_qspi_data_3,
> +	msm_mux_qup0_se0_l0,

E.g. msm_mux_qup0_se0 is enough, giving each pin its own function means
that we need to define each pin separate in DT.

Regards,
Bjorn
