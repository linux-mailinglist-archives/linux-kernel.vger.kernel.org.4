Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE2675E00
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjATT01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjATT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:26:24 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F3D88D3;
        Fri, 20 Jan 2023 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=Hqia+NJ2QC41heYLi0dUCzudrgUsuC/RibFBeRL/VTE=; b=Nfquy
        pxJ5APteHJ9Ee87rK2D8vicN6ZLnqLUEUWJ9RUN/jFnGWkrXh2ScdSzSQdS5ntDt6IOdLS02jpETE
        ZXX+iQZOXbhWA+euupZrvN0yJB32vsOYUOdbyjvBAY7tsnX/YPgR1gFEJ5OWL8ywYffrR9Id4pt+w
        XOAXOTzmlZRC4imNEq0k5UaLG+QfolJsIrxN24F7BIyxrN5deILBhAjcs4TIpvBgyTUN+l2CmZsRP
        ds/rqKb3a4mB4PAK0HMmRcekUkmz1H0HkTsnt4QxrAJ1IOG5clAWS/THrKbJSnZT3FS634Dr6FIc6
        n6DNvHpclHrXDY3pVZB0rGwviKnLQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pIx1I-00013J-Oc;
        Fri, 20 Jan 2023 19:25:48 +0000
Date:   Fri, 20 Jan 2023 19:25:47 +0000
From:   John Keeping <john@metanate.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: gadget: Move kstrtox() out of lock
Message-ID: <Y8rqu7osxWsdN/PA@donbot>
References: <20230120182434.24245-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120182434.24245-1-andriy.shevchenko@linux.intel.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:24:34PM +0200, Andy Shevchenko wrote:
> The kstrtox() calls operate on local (to the function) variables and do
> not need to be serialized. We may call them out of the lock.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: John Keeping <john@metanate.com>

> ---
>  drivers/usb/gadget/configfs.c | 72 +++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 78e7353e397b..63dc15b4f6d8 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -808,15 +808,15 @@ static ssize_t webusb_use_store(struct config_item *item, const char *page,
>  	int ret;
>  	bool use;
>  
> -	mutex_lock(&gi->lock);
>  	ret = kstrtobool(page, &use);
> -	if (!ret) {
> -		gi->use_webusb = use;
> -		ret = len;
> -	}
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&gi->lock);
> +	gi->use_webusb = use;
>  	mutex_unlock(&gi->lock);
>  
> -	return ret;
> +	return len;
>  }
>  
>  static ssize_t webusb_bcdVersion_show(struct config_item *item, char *page)
> @@ -832,10 +832,12 @@ static ssize_t webusb_bcdVersion_store(struct config_item *item,
>  	u16 bcdVersion;
>  	int ret;
>  
> -	mutex_lock(&gi->lock);
>  	ret = kstrtou16(page, 0, &bcdVersion);
>  	if (ret)
> -		goto out;
> +		return ret;
> +
> +	mutex_lock(&gi->lock);
> +
>  	ret = is_valid_bcd(bcdVersion);
>  	if (ret)
>  		goto out;
> @@ -862,15 +864,15 @@ static ssize_t webusb_bVendorCode_store(struct config_item *item,
>  	int ret;
>  	u8 b_vendor_code;
>  
> -	mutex_lock(&gi->lock);
>  	ret = kstrtou8(page, 0, &b_vendor_code);
> -	if (!ret) {
> -		gi->b_webusb_vendor_code = b_vendor_code;
> -		ret = len;
> -	}
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&gi->lock);
> +	gi->b_webusb_vendor_code = b_vendor_code;
>  	mutex_unlock(&gi->lock);
>  
> -	return ret;
> +	return len;
>  }
>  
>  static ssize_t webusb_landingPage_show(struct config_item *item, char *page)
> @@ -956,15 +958,15 @@ static ssize_t os_desc_use_store(struct config_item *item, const char *page,
>  	int ret;
>  	bool use;
>  
> -	mutex_lock(&gi->lock);
>  	ret = kstrtobool(page, &use);
> -	if (!ret) {
> -		gi->use_os_desc = use;
> -		ret = len;
> -	}
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&gi->lock);
> +	gi->use_os_desc = use;
>  	mutex_unlock(&gi->lock);
>  
> -	return ret;
> +	return len;
>  }
>  
>  static ssize_t os_desc_b_vendor_code_show(struct config_item *item, char *page)
> @@ -980,15 +982,15 @@ static ssize_t os_desc_b_vendor_code_store(struct config_item *item,
>  	int ret;
>  	u8 b_vendor_code;
>  
> -	mutex_lock(&gi->lock);
>  	ret = kstrtou8(page, 0, &b_vendor_code);
> -	if (!ret) {
> -		gi->b_vendor_code = b_vendor_code;
> -		ret = len;
> -	}
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&gi->lock);
> +	gi->b_vendor_code = b_vendor_code;
>  	mutex_unlock(&gi->lock);
>  
> -	return ret;
> +	return len;
>  }
>  
>  static ssize_t os_desc_qw_sign_show(struct config_item *item, char *page)
> @@ -1113,15 +1115,15 @@ static ssize_t ext_prop_type_store(struct config_item *item,
>  	u8 type;
>  	int ret;
>  
> -	if (desc->opts_mutex)
> -		mutex_lock(desc->opts_mutex);
>  	ret = kstrtou8(page, 0, &type);
>  	if (ret)
> -		goto end;
> -	if (type < USB_EXT_PROP_UNICODE || type > USB_EXT_PROP_UNICODE_MULTI) {
> -		ret = -EINVAL;
> -		goto end;
> -	}
> +		return ret;
> +
> +	if (type < USB_EXT_PROP_UNICODE || type > USB_EXT_PROP_UNICODE_MULTI)
> +		return -EINVAL;
> +
> +	if (desc->opts_mutex)
> +		mutex_lock(desc->opts_mutex);
>  
>  	if ((ext_prop->type == USB_EXT_PROP_BINARY ||
>  	    ext_prop->type == USB_EXT_PROP_LE32 ||
> @@ -1138,12 +1140,10 @@ static ssize_t ext_prop_type_store(struct config_item *item,
>  		   type == USB_EXT_PROP_BE32))
>  		ext_prop->data_len >>= 1;
>  	ext_prop->type = type;
> -	ret = len;
>  
> -end:
>  	if (desc->opts_mutex)
>  		mutex_unlock(desc->opts_mutex);
> -	return ret;
> +	return len;
>  }
>  
>  static ssize_t ext_prop_data_show(struct config_item *item, char *page)
> -- 
> 2.39.0
> 
