Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEA714C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjE2O1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjE2O11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD47ED;
        Mon, 29 May 2023 07:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C3776108F;
        Mon, 29 May 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74932C433D2;
        Mon, 29 May 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685370438;
        bh=LCmcN44zu2yuo4XqoPyGygsVCbsY+Qs6nCuuIueHTtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSXCop9E8wErtX4kx1Fso7pWTN/Y9yeqoEHrUP6NIVK3BNt050vHPbtEC+JHUboOU
         GNv18nT8m0jQ5tR0KrgbbAYoMhYkpcVrmIi3/4c7lt/nqpOkxiHHTq5mtTNUTwnUOk
         oxGbk4o95JoJ9+avlSlEYSVwA45cJeDHxPAIXsAY=
Date:   Mon, 29 May 2023 15:27:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Message-ID: <2023052905-maimed-studied-3563@gregkh>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525022617.30537-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:26:02AM +0800, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of phy
> driver when usb port status change.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v1 to v2 change:
>     No change
> ---
>  drivers/usb/core/hub.c  | 13 +++++++++++++
>  include/linux/usb/phy.h | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 97a0f8faea6e..b4fbbeae1927 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -614,6 +614,19 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
>  		ret = 0;
>  	}
>  	mutex_unlock(&hub->status_mutex);
> +
> +	if (!ret) {
> +		struct usb_device *hdev = hub->hdev;
> +
> +		if (hdev && !hdev->parent) {
> +			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
> +
> +			if (hcd->usb_phy)
> +				usb_phy_notify_port_status(hcd->usb_phy,
> +					    port1 - 1, *status, *change);
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index e4de6bc1f69b..53bf3540098f 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -144,6 +144,10 @@ struct usb_phy {
>  	 */
>  	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
>  
> +	/* notify phy port status change */
> +	int	(*notify_port_status)(struct usb_phy *x,
> +		int port, u16 portstatus, u16 portchange);
> +
>  	/* notify phy connect status change */
>  	int	(*notify_connect)(struct usb_phy *x,
>  			enum usb_device_speed speed);

Why can't this be part of the same notify_connect() callback?

What makes it different somehow?  Please document this much better.


> @@ -316,6 +320,16 @@ usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
>  		return 0;
>  }
>  
> +static inline int
> +usb_phy_notify_port_status(struct usb_phy *x, int port, u16 portstatus,
> +	    u16 portchange)
> +{
> +	if (x && x->notify_port_status)

How can x ever be NULL?

thanks,

greg k-h
