Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BC682888
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjAaJRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjAaJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:17:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFB4859F;
        Tue, 31 Jan 2023 01:16:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FF616146B;
        Tue, 31 Jan 2023 09:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D69C433EF;
        Tue, 31 Jan 2023 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675156580;
        bh=Ih0PYVI/3v1QhepfBfxFY1m0AXsNHpDVO9Rf3HfzqBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WT+v+xoSece8tMv4HjZWh8n8CBdtY0Uzh9ZzJlggooz8th19r9/9y8xpxkb8JSJw2
         odAEqCizxdKCSiPmbsRaTYa/yv0O5XFAsGoTTWO+oPRoGWtRBSGAG/BbN5crUSbTod
         nhqU8/jlcOOn9O9aVnFwJd9NBMiagbC1rU2Do4uE=
Date:   Tue, 31 Jan 2023 10:16:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] usb: typec: ucsi: add PMIC Glink UCSI driver
Message-ID: <Y9jcYdc30G026/fs@kroah.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:54:32AM +0100, Neil Armstrong wrote:
> Introduce the UCSI PMIC Glink aux driver that communicates
> with the aDSP firmware with the UCSI protocol which handles
> the USB-C Port(s) Power Delivery.
> 
> The UCSI messaging is necessary on newer Qualcomm SoCs to
> provide USB role switch and altmode notifications.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/typec/ucsi/Kconfig      |   7 +
>  drivers/usb/typec/ucsi/Makefile     |   1 +
>  drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 329 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 8f9c4b9f31f7..dee6069e46a2 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -58,4 +58,11 @@ config UCSI_STM32G0
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_stm32g0.
>  
> +config UCSI_PMIC_GLINK
> +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
> +	depends on QCOM_PMIC_GLINK

No way to test build this code without this option?

> +	help
> +	  This driver enables UCSI support on platforms that expose UCSI
> +	  interface as PMIC GLINK device.

Module name when built?

A follow-on patch can be sent, this is minor.

thanks,

greg k-h
