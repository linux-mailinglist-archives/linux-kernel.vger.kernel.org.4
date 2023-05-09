Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83B6FCBD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjEIQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjEIQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:54:09 -0400
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00D59CC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=cOysKkMBNzDpcv5J2MsGIrd6IfUZXEEIlgYWc9yAK1I=;
        b=Amwj4o2W9+x26XSYidQ/xfjam9GfElktepI4/ezdc6Di/JAz0kJvOa7H9OAIf56tAysvU/tXe3M3v
         TL6HeGLz5FevtuATssXRb92xxS76qq6gZToR06QaFb/wP8fAXgXV0m9im8bvPTRqoSyBZK7HyKGK6S
         CuHuha/2o4ihYd9eE2fi8mtqptzxnx18mq0BWuzXNryagE+Xu8OrA2aAHo4jK/aUX/qJco4VJThz9+
         mndVlUyRZiPAzF55bOhzBkfWYjGCUpnED5au0AGdjZFJzKJsAaxFdL9HpOJeNPcfxXWwBAfmvBNwgi
         djeMx/mSgSVtHhAVDZ8hmQeuwErhIow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=cOysKkMBNzDpcv5J2MsGIrd6IfUZXEEIlgYWc9yAK1I=;
        b=qafW83QT/OqXnpLt+q4/N/9s/XB8IE/qbub0+3tIQ4iXiI+0eetRFTeoUfa7/wjKNHSdig+xPcFDo
         bqfTGNdCQ==
X-HalOne-ID: e4221e17-ee89-11ed-90db-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id e4221e17-ee89-11ed-90db-6f01c1d0a443;
        Tue, 09 May 2023 16:52:34 +0000 (UTC)
Date:   Tue, 9 May 2023 18:52:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH v1] backlight: lm3630a: turn off both led strings when
 display is blank
Message-ID: <20230509165232.GA1072872@ravnborg.org>
References: <20230505185752.969476-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185752.969476-1-mweigand2017@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:57:52PM +0200, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
> 
> Use display_is_blank() to determine if the led strings should be turned
> off in the update_status() functions of both strings.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index d8c42acecb5d..5498b57329f9 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -202,7 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  	usleep_range(1000, 2000);
>  	/* minimum brightness is 0x04 */
>  	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
> -	if (bl->props.brightness < 0x4)
> +
> +	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))
You could replace bl->props.brightness with backlight_get_brightness(bl)
to avoid direct access to the properties.

> +		/* turn the string off  */
>  		ret |= lm3630a_update(pchip, REG_CTRL, LM3630A_LEDA_ENABLE, 0);
>  	else
>  		ret |= lm3630a_update(pchip, REG_CTRL,
> @@ -277,7 +279,9 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
>  	usleep_range(1000, 2000);
>  	/* minimum brightness is 0x04 */
>  	ret = lm3630a_write(pchip, REG_BRT_B, bl->props.brightness);
> -	if (bl->props.brightness < 0x4)
> +
> +	if (backlight_is_blank(bl) || (bl->props.brightness < 0x4))
Same here

	Sam
