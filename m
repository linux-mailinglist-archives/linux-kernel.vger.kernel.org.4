Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4E7107D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbjEYIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjEYIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:45:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A8E64;
        Thu, 25 May 2023 01:45:12 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79E2A6601B06;
        Thu, 25 May 2023 09:45:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685004310;
        bh=hOyOt1EoacKFH2fvLL5OIM0fKfkDQg3D/nNEqCtrASs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C2P8ypGHHTF8dDrtKSF1tL7UPrkuYijWh0FoMPieGkR0pLVBMcEE7deOo16pLLXvV
         /R/rn4oRcRE9+gb2uDeL6UDpYuST4a6LmFJ77owHsC8Zu8T4m4oJ7fNVjZyw2GbJyV
         SiJyZJc7zVvMP/mkxuh8rBgN0oDBvJaxYxKKnNNstbl1hVP1odtG6IQJ9FWWqHo6RM
         R6Mw897p4AMDnuHO1cTWQOwxlJc5fVW6qiiSkkNsIrhZzdBIJ2SVRAysVe5Dn5EX0U
         zd/Pkis5kPPmIQZ3v4BlsSc8R1ukmobmPuDxl15dkpst/6wFLxhHujVK863BZYR1om
         vpFBwIRIOkOkg==
Message-ID: <2117b7c4-d164-de17-5a2d-ef3d51304983@collabora.com>
Date:   Thu, 25 May 2023 10:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685004036-17273-1-git-send-email-quic_prashk@quicinc.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1685004036-17273-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 10:40, Prashanth K ha scritto:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, added a new constant in enum usb_role, last_role
> is set to USB_ROLE_UNKNOWN before performing initial detection.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

I'm sorry to make a call for v4, but you have to mention that you're touching
the cdns3 driver in the commit description, if you want to keep the entire
change set in one commit... otherwise you'll have to split it in two, one adding
the new entry to the enum and fixing cdns3; the other setting the last role to
unknown in usb-conn-gpio.c.

I can suggest text for keeping that in one commit, but the choice is yours;

"While at it, also handle default case for the usb_role switch
in cdns3 to avoid build warnings."

> ---
> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>      the test robot
> v2: Added USB_ROLE_UNKNWON to enum usb_role
> 
>   drivers/usb/cdns3/core.c           | 2 ++
>   drivers/usb/common/usb-conn-gpio.c | 3 +++
>   include/linux/usb/role.h           | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index dbcdf3b..69d2921 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -252,6 +252,8 @@ static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
>   		if (!vbus)
>   			role = USB_ROLE_NONE;
>   		break;
> +	default:
> +		break;
>   	}
>   
>   	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index e20874c..30bdb81 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, info);
>   	device_set_wakeup_capable(&pdev->dev, true);
>   
> +	/* Set last role to unknown before performing the initial detection */
> +	info->last_role = USB_ROLE_UNKNOWN;
> +
>   	/* Perform initial detection */
>   	usb_conn_queue_dwork(info, 0);
>   
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index b5deafd..221d462 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -8,6 +8,7 @@
>   struct usb_role_switch;
>   
>   enum usb_role {
> +	USB_ROLE_UNKNOWN = -1,
>   	USB_ROLE_NONE,
>   	USB_ROLE_HOST,
>   	USB_ROLE_DEVICE,


