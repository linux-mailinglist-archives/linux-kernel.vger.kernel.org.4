Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC835738883
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjFUPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjFUPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:11:31 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157D55A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:06:58 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-471c9f2f47aso1244418e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687360014; x=1689952014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71z8LhgGLO2daEYFxMvnjOv3P6R9bwnVjy2+4M+RqPE=;
        b=VhykntzuF/uN4/tK93JbjlsAUtx26v9xgqpidGBDa1HRYYwrx7YaF1uDXBE5Bxdm5e
         TmaH8/4JjEtldkXbR/O7EF0O6ZSMZURv4Ay2Hm04JNOqwKK8l17SnLEEJBh5veQkqZIK
         53XlCVsUoiTz43JNFSEQ59R2bLDaYs3HOhg78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360014; x=1689952014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71z8LhgGLO2daEYFxMvnjOv3P6R9bwnVjy2+4M+RqPE=;
        b=OUZRRFcy94p2EHRkjZ/WQw6x++VJK9IdIN9uPtbRa43hspT327R227A/j+suGtBf5U
         dbsBKWv9dlceogHyBrvUz0pb7t7pLpFbOWzAwBS2Dr11c+g+h1foBAUM1j8wk1hlxpn5
         8CkuE41u9Yud7CcVZmEJ+4tG2jZ/2+pviNaUDVwRH4AHQz4RYwFOt0453+QKfz65jBcb
         WmkgcivzjhlEiITG7+/fZ72CyXb6AAb152Er0YjDtXRT2ApCTpZbcTUy1li6gLvLoWwD
         BQVlMfFcrRII/Fn1mVoiOTeSkw04wm9FK5znHOq13hK97ZcNVOdHCmyBhwTaLaF+96e1
         h76g==
X-Gm-Message-State: AC+VfDwldSsTobbVLk5gePCoVk60lBsCPnVglpYCAj6wg+FfwDVtTyzW
        xarDQqU9yTo4e6Wa1alkxW5fAiR+lcYmx7DpIqY=
X-Google-Smtp-Source: ACHHUZ40pm00cx+5QtNSdK+p1nl1iGTlL8sdLUPf0anon/otCr2jk9289Avlf7F6IwoMeQOYIoCJzQ==
X-Received: by 2002:a05:6602:91:b0:780:c787:637b with SMTP id h17-20020a056602009100b00780c787637bmr56097iob.0.1687359425648;
        Wed, 21 Jun 2023 07:57:05 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id p7-20020a0566380e8700b0042674500f87sm308659jas.123.2023.06.21.07.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:57:04 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:57:03 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <ZJMPv6Fm3On0ITFi@google.com>
References: <20230620-hx3-v2-0-76a53434c713@skidata.com>
 <20230620-hx3-v2-1-76a53434c713@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v2-1-76a53434c713@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 21, 2023 at 04:26:27PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> As some of the onboard hubs require multiple power supplies, provide the
> environment to support them.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Overall this looks good to me, a few nits inside.

> ---
> v2:
> - replace (err != 0) with (err)
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/usb/misc/onboard_usb_hub.h |  1 +
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 12fc6eb67c3b..3de30356a684 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -27,6 +27,12 @@
>  
>  #include "onboard_usb_hub.h"
>  
> +#define SUPPLIES_NUM_MAX 2

MAX_SUPPLIES?

add empty line

> +static const char * const supply_names[] = {
> +	"vdd",
> +	"vdd2",
> +};
> +
>  static void onboard_hub_attach_usb_driver(struct work_struct *work);
>  
>  static struct usb_device_driver onboard_hub_usbdev_driver;
> @@ -40,7 +46,8 @@ struct usbdev_node {
>  };
>  
>  struct onboard_hub {
> -	struct regulator *vdd;
> +	struct regulator_bulk_data supplies[SUPPLIES_NUM_MAX];
> +	unsigned int supplies_num;

num_supplies?

>  	struct device *dev;
>  	const struct onboard_hub_pdata *pdata;
>  	struct gpio_desc *reset_gpio;
> @@ -55,9 +62,9 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
>  {
>  	int err;
>  
> -	err = regulator_enable(hub->vdd);
> +	err = regulator_bulk_enable(hub->supplies_num, hub->supplies);
>  	if (err) {
> -		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> +		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
>  		return err;
>  	}
>  
> @@ -75,9 +82,9 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
>  
>  	gpiod_set_value_cansleep(hub->reset_gpio, 1);
>  
> -	err = regulator_disable(hub->vdd);
> +	err = regulator_bulk_disable(hub->supplies_num, hub->supplies);
>  	if (err) {
> -		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
> +		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
>  		return err;
>  	}
>  
> @@ -232,6 +239,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
>  	struct onboard_hub *hub;
> +	unsigned int i;
>  	int err;
>  
>  	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> @@ -246,9 +254,21 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  	if (!hub->pdata)
>  		return -EINVAL;
>  
> -	hub->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(hub->vdd))
> -		return PTR_ERR(hub->vdd);
> +	if (hub->pdata->supplies_num > SUPPLIES_NUM_MAX)
> +		return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
> +				     SUPPLIES_NUM_MAX);
> +	hub->supplies_num = 1;
> +	if (hub->pdata->supplies_num > 1)
> +		hub->supplies_num = hub->pdata->supplies_num;

Please change the above to:

	if (hub->pdata->supplies_num != 0)
		hub->supplies_num = hub->pdata->supplies_num;
	else
		hub->supplies_num = 1;

> +
> +	for (i = 0; i < SUPPLIES_NUM_MAX; i++)
> +		hub->supplies[i].supply = supply_names[i];
> +
> +	err = devm_regulator_bulk_get(dev, hub->supplies_num, hub->supplies);
> +	if (err) {
> +		dev_err(dev, "Failed to get regulator supplies: %d\n", err);
> +		return err;
> +	}
>  
>  	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>  						  GPIOD_OUT_HIGH);
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index aca5f50eb0da..657190bf1799 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -8,6 +8,7 @@
>  
>  struct onboard_hub_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
> +	unsigned int supplies_num;	/* num of supplies: 0 considered as 1 */

num_supplies?

s/num of/number of/

>  };
