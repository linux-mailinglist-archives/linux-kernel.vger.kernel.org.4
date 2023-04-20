Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B26E8E61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjDTJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDTJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:41:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271283E2;
        Thu, 20 Apr 2023 02:39:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8399e963so423818e87.1;
        Thu, 20 Apr 2023 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681983590; x=1684575590;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4YI2xNJSwdtyEq4FM4NbZY/YRRBhSZSqXM6DksJejI=;
        b=C+2gZp34K76dxZETKdgKmZ92czCGk0XdCWz+UQVbZrQU86cxD4ol6ZAGOjyjBpUqmd
         naRrsy9+Bx0M+W55w0DKitMp35rSlaH7vCwN8F2n59cnJkJqCSHXniAbgr2J/47Rf1kb
         IsYBYvnVmsSxWlcTBeGkfRe4N+RfxYVfkhA5E7m+5jbXTOjJrPkrMiqm4G1/ixjo4tb0
         x4lo1jxH4rjnml0LI/cYs1uBUIXYLX9D2qM0Ubo1gBq4YmKOzm8F/u1RuWpJA6nC6IKV
         B+DKikRh+YCm2nbBHDsd39uQN8YnivmS0WEkSzTm6vTMEofv4Jo+lymoSAwOw1O72LJ3
         q/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983590; x=1684575590;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4YI2xNJSwdtyEq4FM4NbZY/YRRBhSZSqXM6DksJejI=;
        b=koZIez8WyYDVfhGIsr6ukjIYXgLblghAoR+7OTKS6ETb969wyvH9WwVawRHUGDhQiL
         dzp1gYGt479wLHyhKGcsSVPhefJKVKgl5hT6EEq4QCPnjq9Rolo5aR0URNSXVZjtJgQh
         j+CGHOZbTK0KF/PzvwrHDDI4aPewa/ar95NXIfeANchI276VDprIwpaXqWW85TzfSkxb
         LJN0mEbya/cLp5Uof89vQugHcR+d1Qd83F2+8R+eFgLK3dgsIJAzYeehFeord6yWcbk7
         fit+60D6wAzGEz6N5rX8zsE6aDYck6vii5WibxEEaW0CaFrWOqHscuhc+xKCb2vG4Tud
         ikAQ==
X-Gm-Message-State: AAQBX9eEVS5ikhhPBciqQtnv3t5GEaN3SREcfX69F5eJUD2Ee1uNwCh+
        2A63JWlV3sfUP0Yc8Y8w2Gg=
X-Google-Smtp-Source: AKy350bDjEUYD3r2S1j+tn6+TRFVQiS3W6+Om0puZZmHg18LvN6iW8x2EtSEu+AWkzd/eleFPVQsWQ==
X-Received: by 2002:a05:6512:250:b0:4ed:d4ac:1e17 with SMTP id b16-20020a056512025000b004edd4ac1e17mr334564lfo.49.1681983590204;
        Thu, 20 Apr 2023 02:39:50 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.73.255])
        by smtp.gmail.com with ESMTPSA id t15-20020ac243af000000b004edc485f86bsm154482lfl.239.2023.04.20.02.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:39:49 -0700 (PDT)
Subject: Re: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c853436a-85c7-d0f8-0990-bc64977cbd47@gmail.com>
Date:   Thu, 20 Apr 2023 12:39:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 8:21 PM, Weitao Wang wrote:

> Add U1/U2 feature support of xHCI for zhaoxin.
> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
[...]

> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6307bae9cddf..730c0f68518d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
[...]
> @@ -4938,6 +4938,27 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
>  	return 0;
>  }
>  
> +static int xhci_check_zhaoxin_tier_policy(struct usb_device *udev,
> +		enum usb3_link_state state)
> +{
> +	struct usb_device *parent;
> +	unsigned int num_hubs;
> +
> +	/* Don't enable U1/U2 if the device is on an external hub. */
> +	for (parent = udev->parent, num_hubs = 0; parent->parent;
> +			parent = parent->parent)
> +		num_hubs++;
> +
> +	if (num_hubs < 1)
> +		return 0;
> +
> +	dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
> +			" below external hub.\n");
> +	dev_dbg(&udev->dev, "Plug device into root hub "
> +			"to decrease power consumption.\n");

   Please don't break up the message strings.

[...]
> @@ -4965,6 +4986,8 @@ static int xhci_check_tier_policy(struct xhci_hcd *xhci,
>  {
>  	if (xhci->quirks & XHCI_INTEL_HOST)
>  		return xhci_check_intel_tier_policy(udev, state);
> +	else if (xhci->quirks & XHCI_ZHAOXIN_HOST)

   *else* not needed after *return*.

> +		return xhci_check_zhaoxin_tier_policy(udev, state);
>  	else
>  		return 0;
>  }

MBR, Sergey
