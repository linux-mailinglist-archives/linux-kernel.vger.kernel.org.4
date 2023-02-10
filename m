Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6423691D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjBJLCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBJLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:02:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404B37F0F;
        Fri, 10 Feb 2023 03:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94A5DB824CE;
        Fri, 10 Feb 2023 11:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3026C433D2;
        Fri, 10 Feb 2023 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676026912;
        bh=0SjioCiP64GPWMqzyQ75xWspd1FmGySB99HbUwvewbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuWd6/7aDLHPNmEXDV+yyDNYQmxmenV6uugq1zrDc/NHIfE2NPNC+7OUX3N+7BcM6
         NLIFl+1kDo6H4q/SsQp4//GPRBpLMCvjHI0HIf50CBMUQSv1kXXMFAO/wyzUXfsxQe
         bS+1MAjZUrjPJKiXNvFevfKb4Agg1fZyiL3pSWyc=
Date:   Fri, 10 Feb 2023 12:01:49 +0100
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
Message-ID: <Y+YkHZASzN97QtUY@kroah.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
 <Y9jcYdc30G026/fs@kroah.com>
 <720aee1d-87e8-5291-c6a0-ef53e830a21d@linaro.org>
 <Y+YerQrfWgmwTErM@kroah.com>
 <06670a10-c8e9-6f87-9c16-e88a90a74469@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06670a10-c8e9-6f87-9c16-e88a90a74469@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:44:22AM +0100, Neil Armstrong wrote:
> On 10/02/2023 11:38, Greg Kroah-Hartman wrote:
> > On Fri, Feb 10, 2023 at 11:31:08AM +0100, Neil Armstrong wrote:
> > > On 31/01/2023 10:16, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 30, 2023 at 10:54:32AM +0100, Neil Armstrong wrote:
> > > > > Introduce the UCSI PMIC Glink aux driver that communicates
> > > > > with the aDSP firmware with the UCSI protocol which handles
> > > > > the USB-C Port(s) Power Delivery.
> > > > > 
> > > > > The UCSI messaging is necessary on newer Qualcomm SoCs to
> > > > > provide USB role switch and altmode notifications.
> > > > > 
> > > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > ---
> > > > >    drivers/usb/typec/ucsi/Kconfig      |   7 +
> > > > >    drivers/usb/typec/ucsi/Makefile     |   1 +
> > > > >    drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
> > > > >    3 files changed, 329 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > > > index 8f9c4b9f31f7..dee6069e46a2 100644
> > > > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > > > @@ -58,4 +58,11 @@ config UCSI_STM32G0
> > > > >    	  To compile the driver as a module, choose M here: the module will be
> > > > >    	  called ucsi_stm32g0.
> > > > > +config UCSI_PMIC_GLINK
> > > > > +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
> > > > > +	depends on QCOM_PMIC_GLINK
> > > > 
> > > > No way to test build this code without this option?
> > > 
> > > Nop, the QCOM_PMIC_GLINK is a build dependency, this can't be removed
> > 
> > Then perhaps the QCOM_PMIC_GLINK code needs to be fixed up to allow for
> > it to be built on all platforms properly?  Otherwise you are
> > guaranteeing you will not get much, if any, build coverage and api
> > changes will cause this code to stagnate over time :(
> 
> The QCOM_PMIC_GLINK deps are:
>         depends on RPMSG
>         depends on TYPEC
>         depends on DRM
>         depends on NET
>         depends on OF
>         select AUXILIARY_BUS
>         select QCOM_PDR_HELPERS
> 
> What would be the changes needed here ?

I do not know, try unwinding it and maybe just adding a COMPILE_TEST
build option in a few places is all that is needed?

thanks,

greg k-h
