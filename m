Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CE63B0E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiK1SPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiK1SPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:15:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09D27FE8;
        Mon, 28 Nov 2022 09:57:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a16so10829665pfg.4;
        Mon, 28 Nov 2022 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGYHL/uLgxqY/hmbsLGPFlswmvjTtEjEvO53BHY2clM=;
        b=Zy4YtCCsFe4vW1pmTteWWz0sKbQYRshwXXTwcDbsVKAHVpn5xH3D2+coKtOYIK8/hg
         1GMzs7P9QEQg0T50pJCy4qDYPVvUJhro+ZELoBeIx+LNGnhik8ADdnHeFzal94rFrvyF
         dWPfheYlBdXGxcnpBXFDeSNc1LfpVtqSRrjtTeDlC3LalrEbMxRZvAXkE3zAKmnzhZyR
         mLj0Yu9n6lB5ahGqa3HSr5Mg7U9dxEzDQYkhnKCpWpdz/McqM/z5DhMfH53rXf0+HoHe
         lGv+LVrTqyAp106UMnsAmZxndha3W/gy+4r9rOJjvpqhiiMp4BIlwMjqRhgnIbbZzpmd
         9XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGYHL/uLgxqY/hmbsLGPFlswmvjTtEjEvO53BHY2clM=;
        b=K7InDGCnuoGX8ejefDNknhQTNu9+GyWeJmN9+RFydR8RFuruUzFkPWayX8lmLfDMk/
         2zTGYzYaYNZ7WM3bU/iZzcY5Dpyt3VINdmLJOLgNKBaypacM7XvGERdwBpY93YPhrStM
         eLfqAmZb1HsHbhUOnuT4bbbW6sU9I5t8PMHeqwoUpc3gElER6iAi6U/HOu2maRH8oTTT
         DwmLtAiZ1g61/mkFR3A65X3FRTPz3szMngPxYQagsCJsqlVCXrTsnLN4PF4wsx+X7CDQ
         H/rjb2jgiZurH7LngLtqteUCkutA4921lf/RHftefcnMEMhnLke1oTgjM1msS/8JV40Y
         LOqg==
X-Gm-Message-State: ANoB5pnLWW5Iq0DbokimcT+MzIPmcmsqEqQGwQNrxpZBvZoN64V4Bqh3
        TD/0kNMlNMCtOkU48p8KSHLhBkJbFEM=
X-Google-Smtp-Source: AA0mqf5cx+Ejhggzq5N2LBS9KPJdQVVaseeYe904vd+bwBKZ1ACXB9hXyj5x4Xyn6rP4viJos42Q7g==
X-Received: by 2002:a05:6a00:198d:b0:569:92fa:cbbc with SMTP id d13-20020a056a00198d00b0056992facbbcmr33654896pfl.77.1669658275045;
        Mon, 28 Nov 2022 09:57:55 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fd7c:c075:f9ff:46c4])
        by smtp.gmail.com with ESMTPSA id b4-20020a62cf04000000b0057255b7c8easm8385819pfg.33.2022.11.28.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:57:54 -0800 (PST)
Date:   Mon, 28 Nov 2022 09:57:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eirin Nya <nyanpasu256@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved touchpad
 range on ELAN v3 touchpads
Message-ID: <Y4T2nygbxkhAQRvM@google.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-4-nyanpasu256@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014111533.908-4-nyanpasu256@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:15:33AM -0700, Eirin Nya wrote:
> On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
> v3 touchpad (dmesg says "with firmware version 0x450f02"), the reported
> size of my touchpad (in userspace by calling mtdev_configure() and
> libevdev_get_abs_maximum(), in kernel space
> elantech_device_info::x_max/y_max, either way 1470 by 700) is half that
> of the actual touch range (2940 by 1400), and the upper half of my
> touchpad reports negative values. As a result, with the Synaptics or
> libinput X11 driver set to edge scrolling mode, the entire right half of
> my touchpad has x-values past evdev's reported maximum size, and acts as
> a giant scrollbar!
> 
> The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
> sets up absolute mode and doubles the hardware resolution (doubling the
> hardware's maximum reported x/y coordinates and its response to
> ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
> coordinate system size using ETP_FW_ID_QUERY, which gets cached and
> reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
> touchpad size reported to userspace (and used to subtract vertical
> coordinates from) is half the maximum position of actual touches.
> 
> This patch splits out a function elantech_query_range_v3() which fetches
> *only* ETP_FW_ID_QUERY (touchpad size), and calls it a second time if
> elantech_set_absolute_mode() enables double-size mode. This means the
> first call is redundant and wasted if a second call occurs, but this
> minimizes the need to restructure the driver.

If the setting is indeed double resolution, can we simply multiply x_max
and y_max by 2 instead of re-querying it?

Also let's try adding one of Elan engineers for their take in this.
Phoenix, do you have any suggestions please?

> 
> Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
> Fixes: 37548659bb22 ("Input: elantech - query the min/max information beforehand too")
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
> ---
> 
> Notes:
>     Should we move (elantech_set_absolute_mode ->
>     elantech_write_reg(...0x0b or 0x01)) *earlier* into elantech_query_info()
>     before "query range information"? See discussion at
>     https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
> 
>  drivers/input/mouse/elantech.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 263779c031..a2176f0fd3 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1006,6 +1006,9 @@ static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
>  		psmouse_err(psmouse, "restoring reg_07 failed\n");
>  }
>  
> +static int elantech_query_range_v3(struct psmouse *psmouse,
> +				   struct elantech_device_info *info);
> +
>  /*
>   * Put the touchpad into absolute mode
>   */
> @@ -1047,6 +1050,14 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
>  		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
>  			rc = -1;
>  
> +		/*
> +		 * If we boost hardware resolution, we have to re-query
> +		 * info->x_max and y_max.
> +		 */
> +		if (etd->info.set_hw_resolution)
> +			if (elantech_query_range_v3(psmouse, &etd->info))
> +				rc = -1;
> +
>  		break;
>  
>  	case 4:
> @@ -1671,6 +1682,20 @@ static int elantech_set_properties(struct elantech_device_info *info)
>  	return 0;
>  }
>  
> +static int elantech_query_range_v3(struct psmouse *psmouse,
> +				   struct elantech_device_info *info)
> +{
> +	unsigned char param[3];
> +
> +	if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
> +		return -EINVAL;
> +
> +	info->x_max = (0x0f & param[0]) << 8 | param[1];
> +	info->y_max = (0xf0 & param[0]) << 4 | param[2];
> +
> +	return 0;
> +}
> +
>  static int elantech_query_info(struct psmouse *psmouse,
>  			       struct elantech_device_info *info)
>  {
> @@ -1826,11 +1851,8 @@ static int elantech_query_info(struct psmouse *psmouse,
>  		break;
>  
>  	case 3:
> -		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
> +		if (elantech_query_range_v3(psmouse, info))
>  			return -EINVAL;
> -
> -		info->x_max = (0x0f & param[0]) << 8 | param[1];
> -		info->y_max = (0xf0 & param[0]) << 4 | param[2];
>  		break;
>  
>  	case 4:
> -- 
> 2.38.0
> 

Thanks.

-- 
Dmitry
