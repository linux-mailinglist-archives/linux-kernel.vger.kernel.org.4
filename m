Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB771110F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjEYQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF612F;
        Thu, 25 May 2023 09:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3867460B01;
        Thu, 25 May 2023 16:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513BBC433D2;
        Thu, 25 May 2023 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685032481;
        bh=GUwaXXSAawFzg0yzZvs8wwZZ+yUjaLMOOAZgyVFAxfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKxNoUCBOJBwOjsEycQDzvHguwrKAUnNJA3Yn90Gr4bTb8CMA0u4rlEwKCQESbH1/
         ZxL5SJEL56998qL6502OnFdWqbXPxFmtuVfo5EIpS6wP42ppQlGNsar4/NpcaABv9B
         Kesk7BqDRuIwieX06CQ86OVj7UvE7zjUdH557pbs=
Date:   Thu, 25 May 2023 17:34:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023052513-gestate-tartar-bf15@gregkh>
References: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:23:45PM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, added a new constant in enum usb_role, last_role
> is set to USB_ROLE_UNKNOWN before performing initial detection.
> 
> While at it, also handle default case for the usb_role switch
> in cdns3 to avoid build warnings.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v5: Update commit text to mention the changes made in cdns3 driver.
> v4: Added Reviewed-by tag.
> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>     the test robot.
> v2: Added USB_ROLE_UNKNWON to enum usb_role.
> 
>  drivers/usb/cdns3/core.c           | 2 ++
>  drivers/usb/common/usb-conn-gpio.c | 3 +++
>  include/linux/usb/role.h           | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index dbcdf3b..69d2921 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -252,6 +252,8 @@ static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
>  		if (!vbus)
>  			role = USB_ROLE_NONE;
>  		break;
> +	default:
> +		break;

No error if this happens?

>  	}
>  
>  	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index e20874c..30bdb81 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  	device_set_wakeup_capable(&pdev->dev, true);
>  
> +	/* Set last role to unknown before performing the initial detection */
> +	info->last_role = USB_ROLE_UNKNOWN;

Shouldn't last_role have already been set to 0?  If so, why not just
have this enum value be 0?


> +
>  	/* Perform initial detection */
>  	usb_conn_queue_dwork(info, 0);
>  
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index b5deafd..221d462 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -8,6 +8,7 @@
>  struct usb_role_switch;
>  
>  enum usb_role {
> +	USB_ROLE_UNKNOWN = -1,

Why is this explicitly set to a value?  What is magic about -1?  Why not
0x42?  Or something else?  Or as I mention above, 0?

thanks,

greg k-h
