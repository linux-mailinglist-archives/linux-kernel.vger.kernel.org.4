Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AABF65913C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiL2Tp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2TpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:45:24 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355391658A;
        Thu, 29 Dec 2022 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672343115;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XJILgGi4xeHtUxcRU/ADCLqTTzwi+IW/Z/vrPjHewv4=;
    b=B9ebXYJ7m/b44oyVE+23R8yR3oW+x/C2LwkSgdjK+MW9iYL8nD9qSGRcSaRnu9+yKT
    zmru2FHhWnYXgDxa+Y1OkHvW7FXo4spRZvB33l1HH7hLV0bQgTyYnUOcRAUsa16WXfB1
    YmIesRZfL81vqpHVIqmrUepYW6k3ccYHyaawFWyKZ43Mcv6mwmIsaSySSp2IwDkuN25Y
    wdlqiOUpDu0xyWVSmvMHXBEFS24bcz6HB64AM4/BZZ4W3KwpSVD74IP2s8fFiLZnljly
    1nPs9WozQy5TJ1LK7TzssuL/gQtjfY4cN1RBKD15byGvJ9XFd0PL3nAmrwGgtlzRKndP
    4DQg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBTJjFXmD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Dec 2022 20:45:15 +0100 (CET)
Date:   Thu, 29 Dec 2022 20:45:14 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom-usb-hs: Add qcom,dp-manual-pullup logic
Message-ID: <Y63uSgMdP4m6nvhL@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229183410.683584-3-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 06:34:10PM +0000, Bryan O'Donoghue wrote:
> Downstream has a flag called qcom,dp-manual-pullup which informs the
> downstream driver if it should toggle ULPI_MISC_A_VBUSVLDEXTSEL and
> ULPI_MISC_A_VBUSVLDEXT.
> 
> Downstream states:
> 
> "qcom,dp-manual-pullup: If present, vbus is not routed to USB
>         controller/phy and controller driver therefore enables pull-up
>         explicitly before starting controller using usbcmd run/stop bit."
> 
> Working with a system that has both an external Type-C port controller and
> an internal USB Hub results in a situation where VBUS is not connected to
> the SoC.
> 
> In this case we still need to set the DP pullup.
> 
> This patch enables and disables the DP pullup on PHY power_on and power_off
> respectively if the DT has declared the bool "qcom,enable-vbus-pullup"
> effectively replicating the downstream logic to the same effect.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

I think ideally you would add an extcon device (or equivalent, e.g.
power supply) somewhere in your Type-C setup so that the VBUS state is
set correctly and does not need to be forced permanently. The chipidea
USB driver will also benefit from this because AFAICT it uses that
information to power down the USB PHY and controller entirely when
in device mode and there is no USB cable connected.

But I agree that setting up a proper extcon device can be difficult,
especially during early bring-up where you just want USB to work and
don't care much about power saving. So I still think that making USB
work without extcon (like your patch does) is a useful change.

For the implementation, I think this flag should effectively emulate the
logic that is currently used if you assign an extcon, except that the
VBUS state is permanently forced active. Right now your
qcom_usb_hs_phy_enable_dp_pullup() function kind of duplicates logic
that already exists in the driver, which already has code to set
VBUSVLDEXTSEL and VBUSVLDEXT.

qcom_usb_hs_phy_set_mode() should be modified to use the else branch (as
if vbus_edev was set), which will set VBUSVLDEXTSEL for you. Without
extcon you currently use the if (!uphy->vbus_edev) branch, which will
enable the internal VBUS detection in the PHY (the ULPI_INT_SESS_VALID
code). This does not make any sense IMO if VBUS is not connected to the
SoC.

And then you basically just need to call qcom_usb_hs_phy_vbus_notifier()
to set the VBUSVLDEXT forcefully (rather than relying on the extcon
detection).

An alternative that I've occasionally used for early bring-up is to
simply use a dummy extcon driver [1] that permanently reports active
VBUS. The end result is the same. While it's clearly a hack perhaps this
makes it a bit more clear that ideally you really should try to assign
an extcon device, to avoid keeping the USB controller and PHY on
permanently.

Thanks,
Stephan

[1]: https://github.com/msm8916-mainline/linux/commit/3d029e6d4303e125aa013c501308d2d98e3cdc89

> ---
>  drivers/phy/qualcomm/phy-qcom-usb-hs.c | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> index 53e46c220a3aa..45c94f6722c66 100644
> --- a/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> @@ -37,6 +37,7 @@ struct qcom_usb_hs_phy {
>  	struct ulpi_seq *init_seq;
>  	struct extcon_dev *vbus_edev;
>  	struct notifier_block vbus_notify;
> +	u8 enable_dp_pullup:1;
>  };
>  
>  static int qcom_usb_hs_phy_set_mode(struct phy *phy,
> @@ -105,6 +106,23 @@ qcom_usb_hs_phy_vbus_notifier(struct notifier_block *nb, unsigned long event,
>  	return ulpi_write(uphy->ulpi, addr, ULPI_MISC_A_VBUSVLDEXT);
>  }
>  
> +static int qcom_usb_hs_phy_enable_dp_pullup(struct ulpi *ulpi, bool enable)
> +{
> +	u8 addr;
> +	int ret;
> +
> +	if (enable)
> +		addr = ULPI_SET(ULPI_MISC_A);
> +	else
> +		addr = ULPI_CLR(ULPI_MISC_A);
> +
> +	ret = ulpi_write(ulpi, addr, ULPI_MISC_A_VBUSVLDEXTSEL);
> +	if (ret)
> +		return ret;
> +
> +	return ulpi_write(ulpi, addr, ULPI_MISC_A_VBUSVLDEXT);
> +}
> +
>  static int qcom_usb_hs_phy_power_on(struct phy *phy)
>  {
>  	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
> @@ -154,6 +172,12 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>  			goto err_ulpi;
>  	}
>  
> +	if (uphy->enable_dp_pullup) {
> +		ret = qcom_usb_hs_phy_enable_dp_pullup(ulpi, true);
> +		if (ret)
> +			goto err_ulpi;
> +	}
> +
>  	if (uphy->vbus_edev) {
>  		state = extcon_get_state(uphy->vbus_edev, EXTCON_USB);
>  		/* setup initial state */
> @@ -180,10 +204,19 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>  static int qcom_usb_hs_phy_power_off(struct phy *phy)
>  {
>  	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
> +	struct ulpi *ulpi = uphy->ulpi;
> +	int ret;
>  
>  	if (uphy->vbus_edev)
>  		extcon_unregister_notifier(uphy->vbus_edev, EXTCON_USB,
>  					   &uphy->vbus_notify);
> +
> +	if (uphy->enable_dp_pullup) {
> +		ret = qcom_usb_hs_phy_enable_dp_pullup(ulpi, false);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	regulator_disable(uphy->v3p3);
>  	regulator_disable(uphy->v1p8);
>  	clk_disable_unprepare(uphy->sleep_clk);
> @@ -229,6 +262,9 @@ static int qcom_usb_hs_phy_probe(struct ulpi *ulpi)
>  	/* NUL terminate */
>  	uphy->init_seq[size / 2].addr = uphy->init_seq[size / 2].val = 0;
>  
> +	if (of_property_read_bool(ulpi->dev.of_node, "qcom,dp-manual-pullup"))
> +		uphy->enable_dp_pullup = 1;
> +
>  	uphy->ref_clk = clk = devm_clk_get(&ulpi->dev, "ref");
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
> -- 
> 2.34.1
> 
