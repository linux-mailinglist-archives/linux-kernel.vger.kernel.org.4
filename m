Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6520F625AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKKM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiKKM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:57:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C457C8F0;
        Fri, 11 Nov 2022 04:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCEF461FB0;
        Fri, 11 Nov 2022 12:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E697C433D6;
        Fri, 11 Nov 2022 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668171475;
        bh=zwR2CVETYVKkhlVS2uKhYwwfZN8Fws7SwH+daDdD7Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6Hc3y/dSgnkCRu5sF+3+R1DG4UiTP6y1TS1S68pMerhilYcO9WRKyr16tCVpYuqm
         RZpKJPWmk122BX/lVxLXQVHKMCjXydkTJL/OvUDyA7PiFwUnKSiDbAO8GPfc7iFCP6
         DyVe29q/MGMMF5WoUjXD10vdjxrdPc/lMfe8j7vuWmr+pSWyw5DeDaOd+WK+a/MT1G
         I6RAXsZLwmL5rF1tzlPNAhCeG0unjbPPKMySl+Prn7OLvQ5U1QVB07LtvPT25xV8bB
         2V21njP6uSaGbZLZgi4zzIDhq2TUDDgIHIO+1ve2TDfBC2ebu9uZ3g9PMoY+cizfgh
         7vZPk5K+MTNcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1otTb5-00012W-8l; Fri, 11 Nov 2022 13:57:27 +0100
Date:   Fri, 11 Nov 2022 13:57:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK
 driver
Message-ID: <Y25Gtwaws9wDU4a+@hovoldconsulting.com>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818031512.319310-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending to Bjorn's current address. ]

On Wed, Aug 17, 2022 at 08:15:10PM -0700, Bjorn Andersson wrote:
> The PMIC GLINK service runs on one of the co-processors of some modern
> Qualcomm platforms and implements USB-C and battery managements. It uses
> a message based protocol over GLINK for communication with the OS, hence
> the name.
> 
> The driver implemented provides the rpmsg device for communication and
> uses auxilirary bus to spawn off individual devices in respsective
> subsystem. The auxilirary devices are spawned off from a
> platform_device, so that the drm_bridge is available early, to allow the
> DisplayPort driver to probe even before the remoteproc has spun up.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig            |  14 ++
>  drivers/soc/qcom/Makefile           |   1 +
>  drivers/soc/qcom/pmic_glink.c       | 336 ++++++++++++++++++++++++++++
>  include/linux/soc/qcom/pmic_glink.h |  32 +++
>  4 files changed, 383 insertions(+)
>  create mode 100644 drivers/soc/qcom/pmic_glink.c
>  create mode 100644 include/linux/soc/qcom/pmic_glink.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e0d7a5459562..2289f5e0d5ad 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -91,6 +91,20 @@ config QCOM_PDR_HELPERS
>  	tristate
>  	select QCOM_QMI_HELPERS
>  
> +config QCOM_PMIC_GLINK
> +	tristate "Qualcomm PMIC GLINK driver"
> +	depends on RPMSG
> +	depends on TYPEC
> +	depends on DRM

You should add

	select AUXILIARY_BUS

here as this driver will not compile without it. Then you can drop the
corresponding select from the battery driver.

> +	select QCOM_PDR_HELPERS
> +	help
> +	  The Qualcomm PMIC GLINK driver provides access, over GLINK, to the
> +	  USB and battery firmware running on one of the coprocessors in
> +	  several modern Qualcomm platforms.
> +
> +	  Say yes here to support USB-C and battery status on modern Qualcomm
> +	  platforms.

Johan
