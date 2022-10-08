Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553E5F8611
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJHQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJHQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:34:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0E1007B;
        Sat,  8 Oct 2022 09:34:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so7054387pls.4;
        Sat, 08 Oct 2022 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm5C8mA0SryqwkYsawMIvdX1VR1hwGLrtCvkGai7Lq8=;
        b=P4IjxEilNHfsXgJzuPJZp809d5qSrsWN5bmDim+UDPLi52tC3y16lCPx5z+ptQ5C83
         fYLvi9TshwFo2lpuh6wSVn8pTWjXgU02rSjNSrOv2oHj/paTHTy8Tj964LHZ//KihXlX
         0FTYcRiK331Wdt/S4Zblu7hnmU1xJhZyIKuJdpg7Ep1G675FSzvcgdXpxN7HbS4EAR/5
         eZwq9vs1mziJLE1EZAtmWH0OkA5vvD4SMehAs7DbLK3Xvd1PEc3z3R8MjzsxZUQG5BOE
         LD/r0UAAa7MADXJ6rvfWGt+Gbl/pZ8xAiRI54qksYRK4ZjtkLxNWOxFoQfhZNFOgwiup
         citA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm5C8mA0SryqwkYsawMIvdX1VR1hwGLrtCvkGai7Lq8=;
        b=ekNxislYhu++I9lAR6a/f8SViqD8OIyon8U20OQVY8IuTzKAreT9Uwpxev66xIbOTI
         ujk4keJ3x3XuzVCdRuRlibR4a0SR9sea5BFWQTzTq8rE2jjdFpZuzQqGeA7KI1KEJu9g
         kK5obJisFEZ5pBWJY+K1s0KuXs2SrZ1Uq+m4ALMi1ijJ9BzryVQif4Uqn4wJXnJa3gdp
         TQ6ZW9A/i3/S+Mm3jzW+0K66JJYk8BNaMhXRAnAhvGFKKOPUACrKyPByj/CeGhU2JIDb
         CRHfGS6l+c2Enbf6Ii1skLpA5yBSYX9T3r+WFgiZaRAR49p8ymigNv1RdU6m9Kf9DMcO
         13iQ==
X-Gm-Message-State: ACrzQf3DeAbqGGCJSHEBKDnqDIYHf3dUp+wlYnnFC5t8fvhPUGNsC0iB
        QjJySa8i1z7Gd/opi4UbG62cjmEdvTrZO8R7
X-Google-Smtp-Source: AMsMyM7W9jaaQJBuSrf/2LZooYKkbKCDFW1oZ6dI3CvrwYxx+cOpGhS6zwPM5TkoNPaeoA88VBFlVA==
X-Received: by 2002:a17:902:7481:b0:180:fde5:98a8 with SMTP id h1-20020a170902748100b00180fde598a8mr3588409pll.81.1665246886765;
        Sat, 08 Oct 2022 09:34:46 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b00172cb8b97a8sm3565661plb.5.2022.10.08.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 09:34:46 -0700 (PDT)
Date:   Sat, 8 Oct 2022 09:34:37 -0700
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH 3/3] Input: Fix incorrectly halved touchpad range on
 ELAN v3 touchpads
Message-ID: <20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net>
In-Reply-To: <87czb37mpb.fsf@mkorpershoek-xps-13-9370.home>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
        <20220929082119.22112-4-nyanpasu256@gmail.com>
        <87czb37mpb.fsf@mkorpershoek-xps-13-9370.home>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022 16:06:08 +0200
Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> On Thu, Sep 29, 2022 at 01:21, Eirin Nya <nyanpasu256@gmail.com>
> wrote:
> 
> > On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an
> > Elan v3 touchpad (dmesg says "with firmware version 0x450f02"), the
> > reported size of my touchpad (in userspace by calling
> > mtdev_configure() and libevdev_get_abs_maximum(), in kernel space
> > elantech_device_info::x_max/y_max, either way 1470 by 700) is half
> > that of the actual touch range (2940 by 1400), and the upper half
> > of my touchpad reports negative values. As a result, with the
> > Synaptics or libinput X11 driver set to edge scrolling mode, the
> > entire right half of my touchpad has x-values past evdev's reported
> > maximum size, and acts as a giant scrollbar!
> >
> > The problem is that elantech_setup_ps2() ->
> > elantech_set_absolute_mode() sets up absolute mode and doubles the
> > hardware resolution (doubling the hardware's maximum reported x/y
> > coordinates and its response to ETP_FW_ID_QUERY), *after*
> > elantech_query_info() fetches the touchpad coordinate system size
> > using ETP_FW_ID_QUERY, which gets cached and reported to userspace
> > through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the touchpad size
> > reported to userspace (and used to subtract vertical coordinates
> > from) is half the maximum position of actual touches.
> > ...
> 
> This seems like a candidate patch for stable kernels as well.
> 
> Maybe consider adding the following in the commit message footer:
> Fixes: 28f49616113f ("Input: elantech - add v3 hardware support")

Interestingly, if I understand correctly, the bug was actually *not*
introduced by 28f49616113f ("Input: elantech - add v3 hardware
support"). In that commit, elantech_init called
(elantech_set_absolute_mode -> elantech_write_reg(...0x0b)) to set
absolute double-size mode, though bit 3 controlling double-resolution
was not documented at this point, then (elantech_set_input_params ->
elantech_set_range -> ETP_FW_ID_QUERY) *after* enabling double-size
mode. This code structure was maintained through 36189cc3cd57 ("Input:
elantech - fix touchpad initialization on Gigabyte U2442"), which
introduced etd->set_hw_resolution.

By the time of f07875920116 ("Input: elantech - split device info into
a separate structure"), elantech_setup_ps2 called
(elantech_set_absolute_mode -> elantech_write_reg(...0x0b or 0x01)
(later changed to 0x03)) before (elantech_set_input_params ->
elantech_set_range -> ETP_FW_ID_QUERY).

The bug was actually introduced by 37548659bb22 ("Input: elantech -
query the min/max information beforehand too"), which removed
elantech_set_range() and moved ETP_FW_ID_QUERY into
elantech_query_info(). At this point, elantech_init_ps2() for non-SMBus
touchpads calls (elantech_query_info() -> ETP_FW_ID_QUERY) before
(elantech_setup_ps2 -> elantech_set_absolute_mode ->
elantech_write_reg), so now the size is queried *before* setting
doubled size for the touchpad.

Why was this change made? The commit message says:

> For the latest generation of Elantech touchpads, we need to forward
> the min/max information from PS/2 to SMBus.

I don't know which generation of touchpad that is, and whether it
correlates with protocol version 3 vs. 4 or not. I'm guessing that in
the process of adding/fixing support for newer touchpads, Benjamin
Tissoires subtly broke size queries for older v3 PS/2 touchpads. At
this point, is it worth asking him about this bug?

In any case, given the complexity of this code designed to handle
multiple hardware types, including SMBus Elan touchpads I cannot test
myself, I now feel that my surgical patch is the safest way to fix v3
touchpads. It's probably error-prone to *conditionally* query size
later on in elantech_set_input_params for v3 (and below?) touchpads,
without breaking hardware fixed by 37548659bb22.

Should we move (elantech_set_absolute_mode ->
elantech_write_reg(...0x0b or 0x01)) *earlier* into
elantech_query_info() before "query range information"? I don't know if
that will break anything either, since I can't test on anything but v3
touchpads. But it's an option to explore if you want to avoid querying
range twice.
