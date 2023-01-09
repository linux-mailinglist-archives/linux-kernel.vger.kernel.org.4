Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001D662282
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjAIKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjAIKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:07:42 -0500
X-Greylist: delayed 962 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 02:07:11 PST
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5616585
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=message-id:references:in-reply-to:reply-to:subject:cc:to:from:date:
         content-transfer-encoding:content-type:mime-version:from;
        bh=2THwJGmKFrzACdd/4rv09Ql9uLxSgMHObb9/bAtrRuQ=;
        b=T0msTpsnBaNWeQ2ORuo/vneSVNmJmJsrSwyLyraL4w9ST91BdrD28G0MwJGf5H1rhIymDgH1QzVio
         4fWbgezuCpM6d/wk5DJC9yrRHlDRDXMR/nJzoRArMOM2DCy1XDhEd5H8j6PjEifyKFvM+ZkijpGuNm
         Nm5Y/b/dU3KQqFA7c49H++HYgNE1Zmolk5neq3w/pvHtXNKt665ls/55PMOhVdqZKSb4dN6D1YqLqy
         UDh1uuRBzMofJY0lxBPnXz7KpMtts4sAYb16iDxJWeRjdnEulyLntQ9Wp39MS51P67j9qe7FEq4/Th
         e63YNGyNiIcF3n5kfz9B5O16MMo0iOg==
X-MSG-ID: 22dfc9a8-9003-11ed-a275-0050569d3a82
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jan 2023 10:51:06 +0100
From:   Robin van der Gracht <robin@protonic.nl>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
Organization: Protonic Holland
Reply-To: robin@protonic.nl
Mail-Reply-To: robin@protonic.nl
In-Reply-To: <20230106143002.1434266-1-steve@sk2.org>
References: <20230106143002.1434266-1-steve@sk2.org>
Message-ID: <0b16391f997e6ed005a326e4e48f2033@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.1 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 15:30, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> This means that BL_CORE_SUSPENDED is now taken into account, as it
> should be.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> 
> Notes:
>     Changes since v1: mention BL_CORE_SUSPENDED.
> 
>  drivers/auxdisplay/ht16k33.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c 
> b/drivers/auxdisplay/ht16k33.c
> index 02425991c159..15ab118c80f5 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -314,14 +314,9 @@ static int ht16k33_initialize(struct ht16k33_priv 
> *priv)
> 
>  static int ht16k33_bl_update_status(struct backlight_device *bl)
>  {
> -	int brightness = bl->props.brightness;
> +	int brightness = backlight_get_brightness(bl);
>  	struct ht16k33_priv *priv = bl_get_data(bl);
> 
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> -		brightness = 0;
> -
>  	return ht16k33_brightness_set(priv, brightness);
>  }

Thank you Stephen (and Sam), looks good!

Reviewed-by: Robin van der Gracht <robin@protonic.nl>
