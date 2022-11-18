Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859162F057
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiKRJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiKRI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:59:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A46E56D;
        Fri, 18 Nov 2022 00:59:49 -0800 (PST)
Received: from [192.168.15.130] (unknown [194.152.46.21])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABFFF660298A;
        Fri, 18 Nov 2022 08:59:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668761987;
        bh=pY5wDQwXBh4roXwwEbALMewclj3NF2pmv2R4/dvJQKQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OtF8pf0D/EQVlnl0YibM/uIgUa9WjgDm3SVux70mv6cEgUCYohCsXXCcvWrZYV1R8
         Ns66Dj+kH85x1w2f7RB+KB+diKVbUaencKpshPz/04ibtqqSv7VS0GHoWtyyKBjH1w
         dUgwfUI8QyuhsyDhbjVTQQXBUyRkWy+9gf/7xZqsIMx9rZIFeEix5cXp61f8TgGt1F
         e9uHC6ezjSA6ZMrXVgQBdz59vIW4bLAvgcZy/m1d+i62871JOJSTh3wh6zwtVaEcfg
         OiZ9QtJXZH35fZxcVZ7SlIu/gwm6MeV9SosdoR5oGKKOmC/fiHLAqHdTqJh5tv1KRR
         Ijer6C/nuaxwg==
Message-ID: <71ced60f-d43b-003a-843d-c2a8364dbf79@collabora.com>
Date:   Fri, 18 Nov 2022 09:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/3] usb: Add USB repeater generic framework
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
References: <20221116123019.2753230-1-abel.vesa@linaro.org>
 <20221116123019.2753230-2-abel.vesa@linaro.org>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221116123019.2753230-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

W dniu 16.11.2022 o 13:30, Abel Vesa pisze:
> With more SoCs moving towards eUSB2, 

Can you name a few?

such platforms will have to use
> a USB 2.0 compliance repeater. This repeater HW-wise usually deals with
> level shifting, but depending on the implementation it can do much more.
> So add a ganeric USB framework that would allow either a generic PHY or
> some USB host controller to control and get a repeater from a devicetree
> phandle. This framework will further be used by platform specific
> drivers to register the repeater and implement platform specific ops.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/usb/Kconfig             |   2 +
>   drivers/usb/Makefile            |   2 +
>   drivers/usb/repeater/Kconfig    |   9 ++
>   drivers/usb/repeater/Makefile   |   6 +
>   drivers/usb/repeater/repeater.c | 198 ++++++++++++++++++++++++++++++++
>   include/linux/usb/repeater.h    |  78 +++++++++++++
>   6 files changed, 295 insertions(+)
>   create mode 100644 drivers/usb/repeater/Kconfig
>   create mode 100644 drivers/usb/repeater/Makefile
>   create mode 100644 drivers/usb/repeater/repeater.c
>   create mode 100644 include/linux/usb/repeater.h
> 

<snip>

> diff --git a/include/linux/usb/repeater.h b/include/linux/usb/repeater.h
> new file mode 100644
> index 000000000000..e68e0936f1e5
> --- /dev/null
> +++ b/include/linux/usb/repeater.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USB Repeater defines
> + */
> +
> +#ifndef __LINUX_USB_REPEATER_H
> +#define __LINUX_USB_REPEATER_H
> +
> +struct usb_repeater {
> +	struct device		*dev;
> +	const char		*label;
> +	unsigned int		 flags;
> +
> +	struct list_head	head;

This member serves the purpose of a list _entry_, no?
The _head_ is static LIST_HEAD(usb_repeater_list);
Maybe call it "entry"?

> +	int	(*reset)(struct usb_repeater *rptr, bool assert);
> +	int	(*init)(struct usb_repeater *rptr);
> +	int	(*power_on)(struct usb_repeater *rptr);
> +	int	(*power_off)(struct usb_repeater *rptr);

Would you document these ops somehow? Potential driver writers need to
understand when they are called and what they are supposed to do.
In particular, how do these relate to what's in "Embedded USB2 (eUSB2)
Physical Layer Supplement to the USB Revision 2.0 Specification"?

Regards,

Andrzej
