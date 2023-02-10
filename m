Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62078691CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBJKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjBJKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:38:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9B173E;
        Fri, 10 Feb 2023 02:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE8861D62;
        Fri, 10 Feb 2023 10:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A54C433D2;
        Fri, 10 Feb 2023 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676025525;
        bh=6tn5sYUfcKRQPPvhKNh4pyzZJ6r3nQvdlm1gZGvGnHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikem2CG4I18LkpaZ0OREA9uosnBJogirtUIGiF8TCS9Xsd6v7mRLQ0OrEfpbGVCWi
         h9sxf3/5UJ0Uef6ixExyO/D/Rj3DsZFTyjzVjh+wGnOXptHSjNACN+3TJ2PFubw/0/
         LZzQT1dAYNqSe37MJH1qIjUVH08YsDVQRJJM4cPg=
Date:   Fri, 10 Feb 2023 11:38:37 +0100
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
Message-ID: <Y+YerQrfWgmwTErM@kroah.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
 <Y9jcYdc30G026/fs@kroah.com>
 <720aee1d-87e8-5291-c6a0-ef53e830a21d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720aee1d-87e8-5291-c6a0-ef53e830a21d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:31:08AM +0100, Neil Armstrong wrote:
> On 31/01/2023 10:16, Greg Kroah-Hartman wrote:
> > On Mon, Jan 30, 2023 at 10:54:32AM +0100, Neil Armstrong wrote:
> > > Introduce the UCSI PMIC Glink aux driver that communicates
> > > with the aDSP firmware with the UCSI protocol which handles
> > > the USB-C Port(s) Power Delivery.
> > > 
> > > The UCSI messaging is necessary on newer Qualcomm SoCs to
> > > provide USB role switch and altmode notifications.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/usb/typec/ucsi/Kconfig      |   7 +
> > >   drivers/usb/typec/ucsi/Makefile     |   1 +
> > >   drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 329 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > index 8f9c4b9f31f7..dee6069e46a2 100644
> > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > @@ -58,4 +58,11 @@ config UCSI_STM32G0
> > >   	  To compile the driver as a module, choose M here: the module will be
> > >   	  called ucsi_stm32g0.
> > > +config UCSI_PMIC_GLINK
> > > +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
> > > +	depends on QCOM_PMIC_GLINK
> > 
> > No way to test build this code without this option?
> 
> Nop, the QCOM_PMIC_GLINK is a build dependency, this can't be removed

Then perhaps the QCOM_PMIC_GLINK code needs to be fixed up to allow for
it to be built on all platforms properly?  Otherwise you are
guaranteeing you will not get much, if any, build coverage and api
changes will cause this code to stagnate over time :(

thanks,

greg k-h
