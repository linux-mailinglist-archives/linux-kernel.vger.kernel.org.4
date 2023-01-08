Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2918661947
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjAHUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjAHUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:24:25 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D255F5AB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9OaC5fUVjOcmXpBQANWBWYj1FAjD2dw4nLoh5knK1rQ=;
        b=a3Tr/5THw9+sAm+Z+Gy/e4LPnpKQjtoLtN8tz6vefonrvI2Pg0DkrGp7CRZv9nUmr2A1eqptG9QOW
         1f/HZoXSd3iAonj5rqD6hm8MfIqs+HGA74YZTEWBqQ8zPgFaXkRXZXdnxCyMaH5GiAqtxqK9Df6AX9
         3m+LbJKf5IvUctgd9+rBTMF5HCdyq41ptarJEFEIxZnSoPgNbm9JF71Uqwz6qa4eukWv6jkTxzMAYs
         0ekB9siEZdEjgGlQRCnZjJI9Gm+DPZrbVZFfhiiBbLrw2rGTdikvsqCerKtoliTSrMwPUfeZ8oSV+u
         SlL0aFFxR/YyVglkXoExkwRnS6zazdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9OaC5fUVjOcmXpBQANWBWYj1FAjD2dw4nLoh5knK1rQ=;
        b=kycKAXjH4J9Dm+t0vV22ddvwFXvBpt2IbPP9ed4AbUh/FX4raML677FAsMHuNHPU0gcasnEY0VNwR
         z0AhnIABQ==
X-HalOne-ID: 6e82c542-8f92-11ed-a2f5-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 6e82c542-8f92-11ed-a2f5-7703b0afff57;
        Sun, 08 Jan 2023 20:24:21 +0000 (UTC)
Date:   Sun, 8 Jan 2023 21:24:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin van der Gracht <robin@protonic.nl>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Message-ID: <Y7smdFs2xgJwwVQO@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
 <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
 <Y7nb2q6SDota/rTU@ravnborg.org>
 <366FC0B8-21E2-4642-A5A5-CF4B6AB046B0@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366FC0B8-21E2-4642-A5A5-CF4B6AB046B0@sk2.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen.

 
> Here are my pending patches from last June on lore:
> 

All patches are handled I think except this:
> * https://lore.kernel.org/lkml/20220608205623.2106113-1-steve@sk2.org/

Can I ask you to drop the assignment that is not needed, and resend with
the collected acks/r-b.

With this, then all fbdev patches are handled.

	Sam
