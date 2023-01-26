Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6E67D1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjAZQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAZQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05472127;
        Thu, 26 Jan 2023 08:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC00FB81EAD;
        Thu, 26 Jan 2023 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28DCC4339B;
        Thu, 26 Jan 2023 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750667;
        bh=Tm20dHbAFf/pXPytexrgAnAHrgWKBBgE48u5vZAscGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1ecaBNcHoRmufYHj10lOotbnn0rWIQC85lVIDoK4Jm1+YCHjDUbSzDYa1M7Lb2eZ
         5zKnI4ZD6kA0Sx3frT3CCnQhLrRlyTcK2v/Tysoqavyjp2/XGir4/+wORpaH9Di7NP
         X875HViKzvPZ4wp3hh21NVyv8azAYawVFTzXj5WBkP6ScuV/NFaipOxjxoZMEsvPow
         Oq80oSIW4Ng994V3as2N1R37s7/KdSBZOK0qTummzoIvwhx2VMaA342NYcdZtQ0Voa
         OpSYzhQrqciYSeDQvRYwJ5vY24jDZatfR0MgTeoqE4uP/w0LRqaHYBANBXcRT02F7w
         D7Osl9C/KWIdQ==
Date:   Thu, 26 Jan 2023 16:30:59 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 15/15] backlight: backlight: Drop the deprecated fb_blank
 property
Message-ID: <Y9Kqw7ey6I7rQuZu@google.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
 <Y9KNziZJxMjCffbs@google.com>
 <Y9KmTFl5YbypgMZy@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9KmTFl5YbypgMZy@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023, Sam Ravnborg wrote:

> Hi Lee,
> On Thu, Jan 26, 2023 at 02:27:26PM +0000, Lee Jones wrote:
> > On Sat, 07 Jan 2023, Sam Ravnborg via B4 Submission Endpoint wrote:
> > 
> > > From: Sam Ravnborg <sam@ravnborg.org>
> > > 
> > > With all users gone remove the deprecated fb_blank member in
> > > backlight_properties.
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee@kernel.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  drivers/video/backlight/backlight.c |  2 --
> > >  include/linux/backlight.h           | 22 ----------------------
> > >  2 files changed, 24 deletions(-)
> > 
> > Applied, thanks
> 
> Some of the dependent patches in this series are not yet applied.
> I have them queued up for processing this weekend, but I missed the -rc6
> window for drm-misc so they will likely not hit upstream in the upcoming
> merge window.
> I can try to expedite it.
> 
> But if you have not yet pushed it, please revert this patch.
> Then I will resend only when the remaining patches are upstream.

Thanks for the info.  Dropped.

-- 
Lee Jones [李琼斯]
