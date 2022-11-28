Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF07A63B0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiK1SQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiK1SPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:15:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4B2CE3B;
        Mon, 28 Nov 2022 09:58:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so10946621pli.0;
        Mon, 28 Nov 2022 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAaWM7FjzhXI5hu1lj7hupKR/eVUoASO6A++IUNjH+w=;
        b=IL0RzKEylZRGgIjW+xXamEN/UaOoBvPpZT6TY0hGxhqwiNWWcHaOoX/rcqzlvNKn09
         eSsnFYo3YrrGmpPkIFu3iIpOjWUpPgHEHjCL3Bfqo/+/Z61YVcoLglZWl66xdoyIEuGh
         5HS4cD0O9DCwZwd5pO7G4oFjBELxxN4T4+jDnKpSvZ+FWJKU+WliD8wXneM2FZQhwk4A
         xjA1w3ck8kqbnHV8z5n+WultMIP0UeqmfwGMpvkZ5mqd5URMGb6M6uPeFVAvyhbI73Xt
         spyO1GFntruFfb2yVu5qTCEuoRwm3pjspUC38fGiJMxra84ViYxaOA8cDjKcU3hOYpw0
         /CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAaWM7FjzhXI5hu1lj7hupKR/eVUoASO6A++IUNjH+w=;
        b=BiWnBo61lVeg2QbopRBxg7l18EgvzLSzXMAby3Ay7Gbs1cDBuYwZaQvF9J01QOfPLL
         MiIiz3HtU1B317vvKtMhC/NnTjL+iyLe88KwQuHVZ6uLxZaCPb16Sf77tywNm9lZFVRn
         lTDYrjA2zVLrAw8Pq6+8TJC+9JnN3F9VAQwkMqw8ubBxH84WAzFsw+sBBmo1mhOfqXwL
         +enpSYGEIiSlCgYeuX5mZT+dzO7UX5vfmF2vfCuN0L9ecz4B61BBRu+aB9fQHSjE4lhF
         WgQ/oU/isqQigZ9mJfQvRGbejoCCne5ify5sk7DTu/LpSiJZGO77VX3vGoA7Z7II9M+Q
         q3fg==
X-Gm-Message-State: ANoB5pn7HmJkppVc4zIBeqfE/X3IjyeHr9wxyhsIwRkqLgpeXMirx5Tz
        FxLb3zf/ogHKZiKT3aLt5bA=
X-Google-Smtp-Source: AA0mqf5NlrjOyHsMWhaaQpxIAL+7psFfMHiQtNj5qf3Zsrshq/t0AuXoVxuHf+DZXW8/M3ir5xX5ig==
X-Received: by 2002:a17:902:f792:b0:186:b32c:4cdc with SMTP id q18-20020a170902f79200b00186b32c4cdcmr33386744pln.166.1669658329699;
        Mon, 28 Nov 2022 09:58:49 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fd7c:c075:f9ff:46c4])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090a710a00b00205db4ff6dfsm7794269pjk.46.2022.11.28.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:58:48 -0800 (PST)
Date:   Mon, 28 Nov 2022 09:58:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eirin Nya <nyanpasu256@gmail.com>,
        Phoenix Huang <phoenix@emc.com.tw>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved touchpad
 range on ELAN v3 touchpads
Message-ID: <Y4T21vl0mJocdpdV@google.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-4-nyanpasu256@gmail.com>
 <Y4T2nygbxkhAQRvM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4T2nygbxkhAQRvM@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:57:51AM -0800, Dmitry Torokhov wrote:
> On Fri, Oct 14, 2022 at 04:15:33AM -0700, Eirin Nya wrote:
> > On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
> > v3 touchpad (dmesg says "with firmware version 0x450f02"), the reported
> > size of my touchpad (in userspace by calling mtdev_configure() and
> > libevdev_get_abs_maximum(), in kernel space
> > elantech_device_info::x_max/y_max, either way 1470 by 700) is half that
> > of the actual touch range (2940 by 1400), and the upper half of my
> > touchpad reports negative values. As a result, with the Synaptics or
> > libinput X11 driver set to edge scrolling mode, the entire right half of
> > my touchpad has x-values past evdev's reported maximum size, and acts as
> > a giant scrollbar!
> > 
> > The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
> > sets up absolute mode and doubles the hardware resolution (doubling the
> > hardware's maximum reported x/y coordinates and its response to
> > ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
> > coordinate system size using ETP_FW_ID_QUERY, which gets cached and
> > reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
> > touchpad size reported to userspace (and used to subtract vertical
> > coordinates from) is half the maximum position of actual touches.
> > 
> > This patch splits out a function elantech_query_range_v3() which fetches
> > *only* ETP_FW_ID_QUERY (touchpad size), and calls it a second time if
> > elantech_set_absolute_mode() enables double-size mode. This means the
> > first call is redundant and wasted if a second call occurs, but this
> > minimizes the need to restructure the driver.
> 
> If the setting is indeed double resolution, can we simply multiply x_max
> and y_max by 2 instead of re-querying it?
> 
> Also let's try adding one of Elan engineers for their take in this.
> Phoenix, do you have any suggestions please?

Argh, adding Phoenix for real now.

> 
> > 
> > Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
> > Link: https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
> > Fixes: 37548659bb22 ("Input: elantech - query the min/max information beforehand too")
> > Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
> > ---
> > 
> > Notes:
> >     Should we move (elantech_set_absolute_mode ->
> >     elantech_write_reg(...0x0b or 0x01)) *earlier* into elantech_query_info()
> >     before "query range information"? See discussion at
> >     https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
> > 
> >  drivers/input/mouse/elantech.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> > index 263779c031..a2176f0fd3 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1006,6 +1006,9 @@ static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
> >  		psmouse_err(psmouse, "restoring reg_07 failed\n");
> >  }
> >  
> > +static int elantech_query_range_v3(struct psmouse *psmouse,
> > +				   struct elantech_device_info *info);
> > +
> >  /*
> >   * Put the touchpad into absolute mode
> >   */
> > @@ -1047,6 +1050,14 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
> >  		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
> >  			rc = -1;
> >  
> > +		/*
> > +		 * If we boost hardware resolution, we have to re-query
> > +		 * info->x_max and y_max.
> > +		 */
> > +		if (etd->info.set_hw_resolution)
> > +			if (elantech_query_range_v3(psmouse, &etd->info))
> > +				rc = -1;
> > +
> >  		break;
> >  
> >  	case 4:
> > @@ -1671,6 +1682,20 @@ static int elantech_set_properties(struct elantech_device_info *info)
> >  	return 0;
> >  }
> >  
> > +static int elantech_query_range_v3(struct psmouse *psmouse,
> > +				   struct elantech_device_info *info)
> > +{
> > +	unsigned char param[3];
> > +
> > +	if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
> > +		return -EINVAL;
> > +
> > +	info->x_max = (0x0f & param[0]) << 8 | param[1];
> > +	info->y_max = (0xf0 & param[0]) << 4 | param[2];
> > +
> > +	return 0;
> > +}
> > +
> >  static int elantech_query_info(struct psmouse *psmouse,
> >  			       struct elantech_device_info *info)
> >  {
> > @@ -1826,11 +1851,8 @@ static int elantech_query_info(struct psmouse *psmouse,
> >  		break;
> >  
> >  	case 3:
> > -		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
> > +		if (elantech_query_range_v3(psmouse, info))
> >  			return -EINVAL;
> > -
> > -		info->x_max = (0x0f & param[0]) << 8 | param[1];
> > -		info->y_max = (0xf0 & param[0]) << 4 | param[2];
> >  		break;
> >  
> >  	case 4:
> > -- 
> > 2.38.0
> > 
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Dmitry
