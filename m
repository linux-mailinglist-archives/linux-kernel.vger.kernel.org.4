Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72566A5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAMWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAMWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:19:59 -0500
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6B7466F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=v3QDitUA4wN1IWADVWoFuNQpKI6WSkYy+DTcgrYXugA=;
        b=tQyMs21idV5n6rct7sk2lu8MrQIOYwG9+SfJynzQrShySNc4pERUOk+6RSsJMkDJ49FHK1uSPYKuI
         D8RoZiB8MPIgYmIu/mwywk+UYasbzqqVnigYaluWoYtz9I49nn47j897z5nuDZaF6zk6SiUUZfpXPH
         BO6UQaP6JZtcRpY6XbAwiSsCkJPjN7upXYpD4eW85WpRWyTjcN8HvwsDmjSPtX6rkJBEIvjEQJvUCe
         Za1FYwvF1f1nzV4XMJBvzGzjrIKrjh28+3y6d+wW2T6Kzsy4qK8JrwFCKtOvwN7EIhP8qLXugw2pcd
         0pJ39OvuelMMXGRYm+mJT4zXZsSWkOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=v3QDitUA4wN1IWADVWoFuNQpKI6WSkYy+DTcgrYXugA=;
        b=rEvqpvxUs7+aZ3mvuNVnY2hZoFfdbrZfJ2S80qy0fHJG0qcy2xJ681d+aJ4iAZE1DssFDVC/iayDp
         V9w8j/UBQ==
X-HalOne-ID: 678aa501-9390-11ed-9761-11abd97b9443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 678aa501-9390-11ed-9761-11abd97b9443;
        Fri, 13 Jan 2023 22:19:55 +0000 (UTC)
Date:   Fri, 13 Jan 2023 23:19:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joel Selvaraj <jo@jsfamily.in>,
        Robert Chiras <robert.chiras@nxp.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Mentz <danielmentz@google.com>
Subject: Re: [RFC PATCH] drm/dsi-mipi: Fix byte order of DCS set/get
 brightness
Message-ID: <Y8HZCiGyubrEChXz@ravnborg.org>
References: <20230113041848.200704-1-mailingradian@gmail.com>
 <Y8GIL56Ahg1I8WCN@ravnborg.org>
 <Y8HMB3KDSiUMqtzn@radian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HMB3KDSiUMqtzn@radian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
On Fri, Jan 13, 2023 at 04:24:23PM -0500, Richard Acayan wrote:
> On Fri, Jan 13, 2023 at 05:34:55PM +0100, Sam Ravnborg wrote:
> > Hi Richard/Daniel.
> Not sure if you saw the original commit that I linked.
> 
> This patch was written in 2017 for the Pixel 3 and Pixel 3 XL
> smartphones. I didn't contact the original author before sending this,
> since the kernel that this patch originated from is EOL.
> 
> This greeting is still fine because it would be great if the original
> author took responsibility for getting this patch applied.
> 
> >
> > On Thu, Jan 12, 2023 at 11:18:48PM -0500, Richard Acayan wrote:
> >> From: Daniel Mentz <danielmentz@google.com>
> >> 
> >> The MIPI DCS specification demands that brightness values are sent in
> >> big endian byte order. It also states that one parameter (i.e. one byte)
> >> shall be sent/received for 8 bit wide values, and two parameters shall
> >> be used for values that are between 9 and 16 bits wide.
> > It is only a few week ago someone write they needed a byteswap to use
> > the kernel provided mipi_dsi_dcs_set_display_brightness(). I did not
> > realize then that this is because it is buggy.
> I didn't even consider sending this patch when I initially saw it. I
> would have performed the byte swap in a new S6E3FA7 panel driver just
> like in SOFEF00.
> 
> >
> > Some comments on the patch:
> > - It would be nice to split it up so first patch fixes that the
> >   parameters are in big-endian. This would go for both set and get.
> The brightness is only big endian if it's 16-bit.
> 
> Most MIPI panel drivers in the kernel tree only send an 8-bit
> brightness, or none at all. For these panels, the brightness can be sent
> as a 16-bit integer in little endian, as it has the same effect as an
> 8-bit integer, with a zero byte appended. The original MIPI brightness
> functions work properly with no changes for 8-bit brightness panels
> only.
> 
> If we want separate 8-bit (original) and 16-bit functions, the 8-bit
> functions shouldn't pass the brightness in big endian. That doesn't mean
> we shouldn't change them at all.
Agree, the brightness is passed exactly as returned by
backlight_get_brightness(), and the helper take care of the correct byte
ordering.

> 
> >
> > - Second patch could then introduce the possibility to a driver to
> >   use a variant that matches the display.
> >   I would suggest to go for two functions:
> >   mipi_dsi_dcs_set_display_brightness()
> >   mipi_dsi_dcs_set_display_brightness_two()
> I'm thinking of a "_large" or "_wide" suffix instead. This would make a
> 32-bit suffix tricky though, if it is ever needed.
_large is way better than _two, and would be my choice.

> 
> >   So it is obvious when you go for the two byte version without adding a
> >   bool parameter.
> >   If the implementation is done using a helper or two independent
> >   functions are up to you.
> These get_display_brightness and set_display_brightness functions are
> already helpers. I'll have them duplicated.
> 
> >
> > The patch split would be nice, but at least we should have two functions
> > and not a bool parameter.
> Yes, that was a bad idea on my part. With separate functions for 16-bit
> brightness, there is no API change, less panel driver touching, and
> panel driver changes can happen in separate patches. Thank you for the
> suggestion.
Great, looks forward for the patches.

	Sam
