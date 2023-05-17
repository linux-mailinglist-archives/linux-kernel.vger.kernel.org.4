Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862D705EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEQEvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEQEvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDC30D2;
        Tue, 16 May 2023 21:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D8D64168;
        Wed, 17 May 2023 04:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81669C433D2;
        Wed, 17 May 2023 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684299060;
        bh=1A4N2cqACkxyyJfl2oSoqVFVLCI/m4E0p25SJpeFf2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSOHjdPa779g0yJZEwvB03PDRBr2erJQZ4vx7/pabYc16D1kgrh0ouKhtgd8dqI/e
         Su9cvdGXifPwY8MCRElYh5DpdNNjBFDsREb3O71TiZMg4WAoiFFXTUyd1szn1IWhx+
         xpzEhQyRarIBp7tBROziY7DpThOmbaG0fcEnWtao=
Date:   Wed, 17 May 2023 06:50:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v5 3/5] usb: misc: eud: Add driver support for SM6115 /
 SM4250
Message-ID: <2023051723-decibel-skiing-56ed@gregkh>
References: <20230516213308.2432018-1-bhupesh.sharma@linaro.org>
 <20230516213308.2432018-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516213308.2432018-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:03:06AM +0530, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.

Why is the subject line duplicated here?

> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 
> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/usb/misc/Kconfig    |  1 +
>  drivers/usb/misc/qcom_eud.c | 69 +++++++++++++++++++++++++++++++++----

Given that you didn't cc the usb maintainer, I'm guessing you don't want
this patch applied?

>  2 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 99b15b77dfd5..fe1b5fec1dfc 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
>  config USB_QCOM_EUD
>  	tristate "QCOM Embedded USB Debugger(EUD) Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_SCM

How well is that going to work on building on non-QCOM systems?  Can
QCOM_SCM build if COMPILE_TEST is enabled?  select is rough to get
right, are you sure it's correct here?  If so, some documentation in the
changelog would be appreciated.

>  	select USB_ROLE_SWITCH
>  	help
>  	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index b7f13df00764..10d194604d4c 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -5,12 +5,14 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/err.h>
> +#include <linux/firmware/qcom/qcom_scm.h>

There's no rule to keep these sorted, but it's your choice...

>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> @@ -22,23 +24,33 @@
>  #define EUD_REG_VBUS_INT_CLR	0x0080
>  #define EUD_REG_CSR_EUD_EN	0x1014
>  #define EUD_REG_SW_ATTACH_DET	0x1018
> -#define EUD_REG_EUD_EN2        0x0000
> +#define EUD_REG_EUD_EN2		0x0000

Why the coding style cleanup in the same patch?  Remember, changes only
do one thing, and you have already listed 2 things in your commit
message :(

>  
>  #define EUD_ENABLE		BIT(0)
> -#define EUD_INT_PET_EUD	BIT(0)
> +#define EUD_INT_PET_EUD		BIT(0)

Again, why this change?

thanks,

greg k-h
