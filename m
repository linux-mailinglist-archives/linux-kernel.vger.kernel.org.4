Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2683A5F7973
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJGOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJGOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405F1162D3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:06:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i81-20020a1c3b54000000b003c3c60c13f5so154464wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=42UOoaYvCKrSY8QCHpvIdYqFzUfaEmJe8f90SSssoH4=;
        b=FuaDLW1MudXTFeC6ASMevUBSEfZ8V/fcUz2gycxlGZEr8BOpchpM1XgKhpwzLyqfIG
         /k2HEp2gjyLWlsSJ2X48pJLUcfuYdJbOt3iYA2MSUjCuTCYziRtS5pHMMwKCQJi0aegg
         /vsVReTilciWWSyrUeAlrRyKAHyQiokxqWZ/9B+x5dWaA2v9Y2QoIT05NWIJpXQ6sJtP
         IpUMhHegYLtAO41tr8p9K+/4kgy5dkeTPL/Dyq6N0LOKpzgBUl7bX+h+CnLyvoPiVHeQ
         2YZph7ISez5Dc5N72JhXbbKy0Sm6Jc9f58mcjgfyvdEYgimPBw5Z42QYeemxZy/lIGdu
         jmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42UOoaYvCKrSY8QCHpvIdYqFzUfaEmJe8f90SSssoH4=;
        b=FrtyxsTibTtcQyV2v7G+vCK66TRNxWNej/v395RdC3/xv/ThSxwyzVRosXwJa7Tf9X
         Xi0rc83XCo4KBJmNDpFeYBmXalsFqzB4X+4Sapwa2A59IsIHIyFR3MkAZBlRkXsGLp2j
         pX5ChlnaHN8iaTi9vaVIOuhIC33gnut0fXw5a3LDKCFEs0MblWX0zvEA+eTaikIn9JWc
         06mONyxqgtQUw/4czMGuwlT++rwaFCK4qxUyh+CXsnP/7IiOGliKnmCDsqWhfjAUhCY2
         pJTRbHl2sNB79VUCdmWNpWDabk69EqGNJiReJA6nsZr4dEKoY0ibOImvPDaysOtUqlAl
         35pw==
X-Gm-Message-State: ACrzQf2f0vZzDw45HehfO9wPAnqN4ZieZ9e7nvyHWOV1KiQLlBIJmD5/
        u/yYVotd00bDq+zshjYN2L0pAA==
X-Google-Smtp-Source: AMsMyM5xnXhQGAo8H5E4oo4KoP4uqx5lcxPBOpR8QURYasH5zh5QDpEwp1xJRhaH/ugBAdhAluIKSA==
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id m28-20020a05600c3b1c00b003b4fef36a62mr3428754wms.129.1665151570566;
        Fri, 07 Oct 2022 07:06:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:5f1e:d910:dd1e:5b09])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe9ca000000b002286670bafasm2134420wrn.48.2022.10.07.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:06:09 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: Fix incorrectly halved touchpad range on
 ELAN v3 touchpads
In-Reply-To: <20220929082119.22112-4-nyanpasu256@gmail.com>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
 <20220929082119.22112-4-nyanpasu256@gmail.com>
Date:   Fri, 07 Oct 2022 16:06:08 +0200
Message-ID: <87czb37mpb.fsf@mkorpershoek-xps-13-9370.home>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:21, Eirin Nya <nyanpasu256@gmail.com> wrote:

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
>
> Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
>
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>

This seems like a candidate patch for stable kernels as well.

Maybe consider adding the following in the commit message footer:
Fixes: 28f49616113f ("Input: elantech - add v3 hardware support")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
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
> 2.37.3
