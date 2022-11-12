Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62C626C25
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKLWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKLWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:15:53 -0500
Received: from mailfilter01-out31.webhostingserver.nl (mailfilter01-out31.webhostingserver.nl [141.138.168.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B08F589
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:15:51 -0800 (PST)
X-Halon-ID: 8facb85a-62d7-11ed-a6af-001a4a4cb906
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter01.webhostingserver.nl (Halon) with ESMTPSA
        id 8facb85a-62d7-11ed-a6af-001a4a4cb906;
        Sat, 12 Nov 2022 23:15:48 +0100 (CET)
Received: from 2a02-a466-68ed-1-a5fa-fe38-3b47-f838.fixed6.kpn.net ([2a02:a466:68ed:1:a5fa:fe38:3b47:f838])
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <fntoth@gmail.com>)
        id 1otymz-003a5N-07;
        Sat, 12 Nov 2022 23:15:49 +0100
Message-ID: <1800f8ea-2dde-a420-3e99-56237bde1bb0@gmail.com>
Date:   Sat, 12 Nov 2022 23:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: dwc3: core: configure PHY before initializing host
 in dwc3_set_mode
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221112102506.34990-1-sven@svenpeter.dev>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20221112102506.34990-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NICE_REPLY_A,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

Op 12-11-2022 om 11:25 schreef Sven Peter:
> Usually, first the PHY is set to the correct mode and then the host or
> device side of the controller is initialized afterwards. Otherwise a PHY
> that's already used has to be reconfigured.
> dwc3_core_init_mode() does this correctly for both host and device and
> __dwc3_set_mode() does it correctly when switching to device mode.
> When setting up host mode however it first initializes xhci and only
> then changes the PHY's mode. Let's also do the operations in the correct
> order here.
> 
> Fixes: 958d1a4c40dd ("usb: dwc3: core: program PHY for proper DRD modes")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/usb/dwc3/core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index ad4d644e21a4..759d23d908fa 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -212,14 +212,15 @@ static void __dwc3_set_mode(struct work_struct *work)
>   
>   	switch (dwc->desired_dr_role) {
>   	case DWC3_GCTL_PRTCAP_HOST:
> +		if (dwc->usb2_phy)
> +			otg_set_vbus(dwc->usb2_phy->otg, true);
> +		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> +		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> +
>   		ret = dwc3_host_init(dwc);
>   		if (ret) {
>   			dev_err(dwc->dev, "failed to initialize host\n");
>   		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>   			if (dwc->dis_split_quirk) {
>   				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>   				reg |= DWC3_GUCTL3_SPLITDISABLE;
This patch breaks usb host mode on Intel Merrifield platform. I am 
testing this on top of v6.0 +
* my 2 "usb: dwc3: core: defer probe on ulpi_read_id timeout" patches 
(otherwise tusb1210 will not be probed on this platform)
* Revert "usb: dwc3: disable USB core PHY management" (with/without this 
patch makes no difference)
* usb: dwc3: Do not get extcon device when usb-role-switch is used 
(with/without this patch makes no difference)

ftrace shows tusb1210 is indeed still probed, nevertheless in host mode 
it seems vbus is not powered as my connected smsc95xx based hub is not 
active (seems not plugged).

Flipping the switch to device mode gadgets work fine.

Could it be dwc3_host_init() needs to be called prior to otg_set_vbus()?
