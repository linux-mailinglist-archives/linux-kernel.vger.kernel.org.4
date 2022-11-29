Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF89A63B8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiK2DtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiK2Dse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:48:34 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 19:48:33 PST
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CB6A2124F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:48:32 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,202,1665417600"; 
   d="scan'208";a="1025443"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 29 Nov 2022 11:47:25 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(146853:0:AUTH_RELAY)
        (envelope-from <phoenix@emc.com.tw>); Tue, 29 Nov 2022 11:47:25 +0800 (CST)
Received: from 192.168.33.13
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(128278:1:AUTH_LOGIN)
        (envelope-from <phoenix@emc.com.tw>); Tue, 29 Nov 2022 11:47:23 +0800 (CST)
From:   "phoenix" <phoenix@emc.com.tw>
To:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>,
        "'Eirin Nya'" <nyanpasu256@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Josh.Chen'" <josh.chen@emc.com.tw>
References: <20221014111533.908-1-nyanpasu256@gmail.com> <20221014111533.908-4-nyanpasu256@gmail.com> <Y4T2nygbxkhAQRvM@google.com> <Y4T21vl0mJocdpdV@google.com>
In-Reply-To: <Y4T21vl0mJocdpdV@google.com>
Subject: RE: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Tue, 29 Nov 2022 11:47:23 +0800
Message-ID: <002001d903a5$4a39a800$deacf800$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQDbt+ppC1xC+keScPeVlOENSMuCUQN/vwKcAiwO8jQCAyhLLLASYmNw
Content-Language: zh-tw
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcODgwNTFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04Nzk0ZmU3ZS02Zjk4LTExZWQtYTkzZi04OGQ3ZjY1ODJkZmNcYW1lLXRlc3RcODc5NGZlODAtNmY5OC0xMWVkLWE5M2YtODhkN2Y2NTgyZGZjYm9keS50eHQiIHN6PSI1Njc4IiB0PSIxMzMxNDE2NzI0Mjg5MDc1NTciIGg9IkFod0hZWXJ3NFdLN3JzOGdWQkhVUVFnNlhHRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop Josh

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Tuesday, November 29, 2022 1:59 AM
To: Eirin Nya <nyanpasu256@gmail.com>; Phoenix Huang <phoenix@emc.com.tw>
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved
touchpad range on ELAN v3 touchpads

On Mon, Nov 28, 2022 at 09:57:51AM -0800, Dmitry Torokhov wrote:
> On Fri, Oct 14, 2022 at 04:15:33AM -0700, Eirin Nya wrote:
> > On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an 
> > Elan
> > v3 touchpad (dmesg says "with firmware version 0x450f02"), the 
> > reported size of my touchpad (in userspace by calling 
> > mtdev_configure() and libevdev_get_abs_maximum(), in kernel space 
> > elantech_device_info::x_max/y_max, either way 1470 by 700) is half 
> > that of the actual touch range (2940 by 1400), and the upper half of 
> > my touchpad reports negative values. As a result, with the Synaptics 
> > or libinput X11 driver set to edge scrolling mode, the entire right 
> > half of my touchpad has x-values past evdev's reported maximum size, 
> > and acts as a giant scrollbar!
> > 
> > The problem is that elantech_setup_ps2() -> 
> > elantech_set_absolute_mode() sets up absolute mode and doubles the 
> > hardware resolution (doubling the hardware's maximum reported x/y 
> > coordinates and its response to ETP_FW_ID_QUERY), *after* 
> > elantech_query_info() fetches the touchpad coordinate system size 
> > using ETP_FW_ID_QUERY, which gets cached and reported to userspace 
> > through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the touchpad size 
> > reported to userspace (and used to subtract vertical coordinates from)
is half the maximum position of actual touches.
> > 
> > This patch splits out a function elantech_query_range_v3() which 
> > fetches
> > *only* ETP_FW_ID_QUERY (touchpad size), and calls it a second time 
> > if
> > elantech_set_absolute_mode() enables double-size mode. This means 
> > the first call is redundant and wasted if a second call occurs, but 
> > this minimizes the need to restructure the driver.
> 
> If the setting is indeed double resolution, can we simply multiply 
> x_max and y_max by 2 instead of re-querying it?
> 
> Also let's try adding one of Elan engineers for their take in this.
> Phoenix, do you have any suggestions please?

Argh, adding Phoenix for real now.

> 
> > 
> > Link: 
> > https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5
> > kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
> > Link: 
> > https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-voi
> > d.nyanpasu256.gmail.com.beta.tailscale.net/
> > Fixes: 37548659bb22 ("Input: elantech - query the min/max 
> > information beforehand too")
> > Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
> > ---
> > 
> > Notes:
> >     Should we move (elantech_set_absolute_mode ->
> >     elantech_write_reg(...0x0b or 0x01)) *earlier* into
elantech_query_info()
> >     before "query range information"? See discussion at
> >     
> > https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-voi
> > d.nyanpasu256.gmail.com.beta.tailscale.net/
> > 
> >  drivers/input/mouse/elantech.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c 
> > b/drivers/input/mouse/elantech.c index 263779c031..a2176f0fd3 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1006,6 +1006,9 @@ static void
elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
> >  		psmouse_err(psmouse, "restoring reg_07 failed\n");  }
> >  
> > +static int elantech_query_range_v3(struct psmouse *psmouse,
> > +				   struct elantech_device_info *info);
> > +
> >  /*
> >   * Put the touchpad into absolute mode
> >   */
> > @@ -1047,6 +1050,14 @@ static int elantech_set_absolute_mode(struct
psmouse *psmouse)
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
> > @@ -1671,6 +1682,20 @@ static int elantech_set_properties(struct
elantech_device_info *info)
> >  	return 0;
> >  }
> >  
> > +static int elantech_query_range_v3(struct psmouse *psmouse,
> > +				   struct elantech_device_info *info) {
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
> >  			       struct elantech_device_info *info)  { @@
-1826,11 +1851,8 
> > @@ static int elantech_query_info(struct psmouse *psmouse,
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

