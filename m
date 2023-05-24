Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F070F332
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjEXJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjEXJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:40:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AFA7;
        Wed, 24 May 2023 02:40:19 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F1116602B7B;
        Wed, 24 May 2023 10:40:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684921218;
        bh=lTT1BvxYVvnMQy5ylxlxFNGt4Z3KFLQE348e4gdRdEc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PRBBGLXq46hXr0PXg26mlxLIk3P8lO8h8yoTGLAeIb0t+pPu7Xd5uoDMh29A6UeHv
         xTF8BpbJUfP2eu438ApWAx15Dj9YZ8lUFlDAV8LZGjX8lan3Msf4rnH79gXbzSjdp7
         4G0bs3lMSyVXMU57chcebAaCRU+Cw9uu6kwPbIpd889JYVdmReXu+0airjhRLHsRox
         PJKFtTWxfVbRJEZz/b4OtIF1hVIKoeNl/exRU6fBPQZTdpZny1Vrviq9a2bezzOOHt
         p7nWCq5wjuTBIBKZtuIMVg0IV6QIHDfJ+3iuB1yBayF58T+mmmODtjWGx2FLSA++T2
         qhhGF9Awo9d9Q==
Message-ID: <ebbbee51-8792-6c35-c29b-adb7f83dda23@collabora.com>
Date:   Wed, 24 May 2023 11:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1684918441-14794-1-git-send-email-quic_prashk@quicinc.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1684918441-14794-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/23 10:54, Prashanth K ha scritto:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, last_role is set to USB_ROLE_UNKNOWN before
> performing the initial detection.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>   drivers/usb/common/usb-conn-gpio.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index e20874c..00af735 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -27,6 +27,8 @@
>   #define USB_CONN_IRQF	\
>   	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
>   
> +#define USB_ROLE_UNKNOWN	-1

I would add USB_ROLE_UNKNOWN to `enum usb_role` instead.

enum usb_role {
	USB_ROLE_UNKNOWN = -1,
	USB_ROLE_NONE,
	....
};

Regards,
Angelo

> +
>   struct usb_conn_info {
>   	struct device *dev;
>   	struct usb_role_switch *role_sw;
> @@ -257,6 +259,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, info);
>   	device_set_wakeup_capable(&pdev->dev, true);
>   
> +	/* Set last role to unknown before performing the initial detection */
> +	info->last_role = USB_ROLE_UNKNOWN;
> +
>   	/* Perform initial detection */
>   	usb_conn_queue_dwork(info, 0);
>   


