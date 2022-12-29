Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C4659209
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiL2VLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL2VLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:11:22 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051312745;
        Thu, 29 Dec 2022 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672348266;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cQELnRpy1SY5PyLDwMbmrsmRP/hOwk6vEMc3pbubENM=;
    b=mUPrWc5IljxIRvNQW1luLAz1CXsZwdkyaxHlsV0iakKXM2c97WnsZQDVgfc561KRRf
    AmaCmZt7qchNUJjF8JRtP7J10BVFxO9AfG7SF6NhQp4rc/Nari+H1ud5fG/TMuHbv6Pe
    ElC4QCATBTxM8X1MldqTduMSjiSq1FQ6s6JJjEIiJqkVmtp3G5n62SxtqwBVxA9l4D29
    Mqzg4e/WBdysKUrdFGpbkZlZ44nvKGyPXoakpbKvngeqPnxxT04moIS9E0RJJtKT8Ybc
    CoJsEXtidIY2lG/xE13h3SQvrTIkU/wqooVgOy/F4nTnLy+8DA71iNapQDYVSMgLJuyK
    FB0g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBTLB5XqR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Dec 2022 22:11:05 +0100 (CET)
Date:   Thu, 29 Dec 2022 22:11:04 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom-usb-hs: Add qcom,dp-manual-pullup logic
Message-ID: <Y64CaOzWZXERrvkz@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-3-bryan.odonoghue@linaro.org>
 <Y63uSgMdP4m6nvhL@gerhold.net>
 <Y64AfHcUw192Pyr6@gerhold.net>
 <6061938c-b830-2fe0-2f4d-368e34c33676@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6061938c-b830-2fe0-2f4d-368e34c33676@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:05:23PM +0000, Bryan O'Donoghue wrote:
> On 29/12/2022 21:02, Stephan Gerhold wrote:
> > On Thu, Dec 29, 2022 at 08:45:15PM +0100, Stephan Gerhold wrote:
> > > On Thu, Dec 29, 2022 at 06:34:10PM +0000, Bryan O'Donoghue wrote:
> > > > Downstream has a flag called qcom,dp-manual-pullup which informs the
> > > > downstream driver if it should toggle ULPI_MISC_A_VBUSVLDEXTSEL and
> > > > ULPI_MISC_A_VBUSVLDEXT.
> > > > 
> > > > Downstream states:
> > > > 
> > > > "qcom,dp-manual-pullup: If present, vbus is not routed to USB
> > > >          controller/phy and controller driver therefore enables pull-up
> > > >          explicitly before starting controller using usbcmd run/stop bit."
> > > > 
> > > > Working with a system that has both an external Type-C port controller and
> > > > an internal USB Hub results in a situation where VBUS is not connected to
> > > > the SoC.
> > > > 
> > > > In this case we still need to set the DP pullup.
> > > > 
> > > > This patch enables and disables the DP pullup on PHY power_on and power_off
> > > > respectively if the DT has declared the bool "qcom,enable-vbus-pullup"
> > > > effectively replicating the downstream logic to the same effect.
> > > > 
> > > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > [...]
> > > 
> > > An alternative that I've occasionally used for early bring-up is to
> > > simply use a dummy extcon driver [1] that permanently reports active
> > > VBUS. The end result is the same. While it's clearly a hack perhaps this
> > > makes it a bit more clear that ideally you really should try to assign
> > > an extcon device, to avoid keeping the USB controller and PHY on
> > > permanently.
> > > 
> > 
> > BTW another nice trick that should work in all almost all cases is to
> > use the state of the PMIC USB_IN pin as VBUS detection. All battery-
> > powered devices I have seen route the USB VBUS to PM8916 USB_IN. And
> > even many boards like DB410c seem to do that or at least permanently
> > supply 5V there. In all these cases the &pm8916_usbin extcon will
> > report a VBUS state that should make USB work.
> > 
> > Have you tried using that on your MSM8939 board with the Type-C setup?
> > 
> > &pm8916_usbin {
> > 	status = "okay";
> > };
> > 
> > &usb {
> > 	status = "okay";
> > 	usb-role-switch;
> > 	extcon = <&pm8916_usbin>;
> > };
> > 
> > &usb_hs_phy {
> > 	extcon = <&pm8916_usbin>;
> > };
> > 
> > Stephan
> 
> I checked USBIN before my last email reply.
> 
> Its possible its connected but its not there on the 8939 schematic I have.
> 

Then it doesn't seem to be a particularly complete schematic. :-)
PM8916 definitely has USB_IN pads (pad # N13, P13). :-)
