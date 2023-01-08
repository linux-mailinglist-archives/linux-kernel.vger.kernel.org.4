Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B466194D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjAHU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjAHU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:26:41 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB90E31
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0Oz9SWY2JCaWSnIle2Meml1ISZbxlYPbGXUmEDFt7b8=;
        b=c4k0VDpxJMQjtdxfViIx8A4vMqEbPLJ0Sq3DyrBnuHwdXBmsuYmxJ0mgIijMxw920JZFjygLve5RX
         URLMTmnVnSjkgoU+0vL9dllcJEw2bAGMxN8dMV8uKuodEI0CQ70gZ82sBi4XUSnk5DihUj8lSmlxg3
         sgUzA2J1yEisx714es4oV7j9eveKW/sPclA58anYo8xJowPRrGFHI1etKHjped0gNixlWX75/91nJu
         TyiPd9rMgC6S4IbTa2fGXjvmVw1k013QfD6fNt7BmPrD4YP/7xQ77PkJv6ahbIPyBTGp510nmjfkaT
         7+MJr7Q779Lz3Bcx/tDnhmxA6aI4BUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0Oz9SWY2JCaWSnIle2Meml1ISZbxlYPbGXUmEDFt7b8=;
        b=8bywcp24ZOE+2c7c1Vg1sP1h7ookPnbOgjKq1sM5xNiCxjrSNN8hMTywYKr2r+1SXf71v0cxxxiuY
         OXp1pTxAQ==
X-HalOne-ID: bf923e41-8f92-11ed-a312-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id bf923e41-8f92-11ed-a312-7703b0afff57;
        Sun, 08 Jan 2023 20:26:37 +0000 (UTC)
Date:   Sun, 8 Jan 2023 21:26:36 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Stephen Kitt <steve@sk2.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-omap@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Lee Jones <lee@kernel.org>, linux-staging@lists.linux.dev,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Message-ID: <Y7sm/EJcTbw3Ic4n@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
 <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
 <Y7nb2q6SDota/rTU@ravnborg.org>
 <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

> > 
> > Helge - could you pick the reviewed patches from:
> > https://lore.kernel.org/all/20220607192335.1137249-1-steve@sk2.org/
> > [This is the same mail as Stephen refer to above - looked up via lore].
> 
> I just pulled those 7 patches into fbdev/for-next.
> If you need more, please let me know,

Thanks, we have one pending patch for atmel_lcdfb, but it need a small
adjustment before it is ready.

With this all fbdev drivers have the backlight_properties.fb_blank
removed.

	Sam
