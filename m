Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4C678252
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjAWQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjAWQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:54:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB6B76D;
        Mon, 23 Jan 2023 08:54:29 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F371D2D9;
        Mon, 23 Jan 2023 17:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674492867;
        bh=DEIsYAdzjE5R62Z2EIoklE1UuDpML7s7ZziMIR2i0Tk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=spZCZjqgWsIrZZ8DCDJgVSoz+o5bHQbhdEJSHZdi17ndQeSv68aJl8jFYraY+0U7c
         XVqRgFVcSs5MHwsvLK+bYyj48Fa8GqvjJ0E6JOTmz/NGIBmUdIxkkSmjkeYuhgcmjF
         PqFDkWYDXv199SXuQapuKlzksaPPh5dMS/wBqxHs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d4867882-4eff-e926-e1eb-3217e608f091@i2se.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com> <d5363f85-44e1-eee1-f7a5-61102637ef53@i2se.com> <167440481093.3533645.5465896340839457121@Monstersaurus> <d4867882-4eff-e926-e1eb-3217e608f091@i2se.com>
Subject: Re: [RFC PATCH 0/4] Drop custom logging
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Date:   Mon, 23 Jan 2023 16:54:24 +0000
Message-ID: <167449286433.135671.17893045578331831111@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Quoting Stefan Wahren (2023-01-22 18:07:03)
> Hi Kieran,
>=20
> Am 22.01.23 um 17:26 schrieb Kieran Bingham:
> > Hi Stefan,
> >
> > Quoting Stefan Wahren (2023-01-22 14:21:05)
> >> Hi Umang,
> >>
> >> Am 18.01.23 um 12:58 schrieb Umang Jain:
> >>> Drop custom logging from the vchiq interface.
> >>> Mostly of them are replaced with dev_dbg and friends
> >>> and/or pr_info and friends.
> >>>
> >>> The debugfs log levels (in 4/4) are mapped to kernel
> >>> logs levels (coming from include/linux/kern_levels.h)
> >>> Would like some thoughts on it as I am not sure (hence
> >>> marking this is RFC)
> >>>
> >>>   From drivers/staging/vc04_services/interface/TODO:
> >>>
> >>> """
> >>> * Cleanup logging mechanism
> >>>
> >>> The driver should probably be using the standard kernel logging mecha=
nisms
> >>> such as dev_info, dev_dbg, and friends.
> >>> """
> >> at first i want to thank you for the work on vchiq so far.
> >>
> >> There is something which is not directly related to this series, but it
> >> is also about debugging. The driver has a buffer which is accessed by
> >> it's own DEBUG_* macros. The content of this debug buffer can be dumped
> >> via the /dev/vchiq which is also used by ioctl. I would appreciate to
> >> move this dump feature into a new debugfs entry.
> > Do you have a full list of the tasks you'd like to see completed ?
> > (including/or above drivers/staging/vc04_services/interface/TODO)
>=20
> i consider every point except of point 1 (importing new drivers) as=20
> necessary to leave staging.

Thanks

> Additionally there is the additional point (i can add them to the TODO)=20
> above. Unfortunately i don't have a complete insight, how vchiq should=20
> be to be acceptable. Sorry, if i can't help you further with possible=20
> resource planning.
>=20
> Are some points on the TODO list unclear?

I believe the list is fine, but I was enquiring if there were anymore
additional tasks above the scope listed in
drivers/staging/vc04_services/interface/TODO which are required. I don't
think you need to send a patch for the task above - unless there are a
lot more tasks required, or it becomes too much to do now.

The goal is to get the ISP upstream to support libcamera, and it would
help to know how deep the rabbit hole really is ;-)

--
Kieran
