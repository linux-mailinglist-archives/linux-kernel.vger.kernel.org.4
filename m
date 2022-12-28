Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE86571B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiL1Boz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiL1Bow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:44:52 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3714D2FC;
        Tue, 27 Dec 2022 17:44:51 -0800 (PST)
Date:   Wed, 28 Dec 2022 01:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1672191887; x=1672451087;
        bh=oLeUZ2Tm7OdAxYY/+wU18/U6sCAVhgxK8vg5WvQ6Bvw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N6fxuBqZFchnD+fBbpaE3Tdwz6PA9J9yJgJbHA1tql7NPPTNY4A4xCY0C9QHfkRGm
         n8G6TaZXxqJyAZHPOwMkmsR8kAOiZsEM9+/pharEJ26vIzCrVw0mEqU9MRoxC4fPR6
         nEOvAhxlVhqnu8NwBU0xdnbkO3f2VdBzv7R/Y/O2nCVmkNcUv0aHiKVc1QoxQs48cz
         0u7VngxapAtY9BMf5U9UnDVEm5puVX34DjT8gXhT3zN9gWl2/CW+JZW55vjttRXDTn
         Gb9Pl28c7TzxYbvLeKPHbJ0x+QAzfaI1wxYxHFyXiSm7uOVIvco3sdwOHdMnhG6lfo
         DaJGdK2zPuvdQ==
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
Message-ID: <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com>
In-Reply-To: <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com> <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On 2022. december 26., h=C3=A9tf=C5=91 10:52, Laurent Pinchart wrote:

> Hi Kieran,
>=20
> Thank you for the patch.
>=20
> On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
>=20
> > Provide a streaming attribute to allow userspace to interogate if a dev=
ice
> > is actively streaming or not.
> >=20
> > This will allow desktop notifications to report if a camera or device
> > is active on the system, rather than just 'open' which can occur when
> > configuring the device.
> >=20
> > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669
> > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > ---
> >=20
> > This is a quick POC to see if such a facility makes sense.
> > I'm weary that not all video devices may have the queues registered on
> > the struct video_device, but this seems like an effective way to be abl=
e
> > to determine if a device is actively streaming on a system.
>=20
>=20
> I can imagine multiple problems, from race conditions to permissions and
> privacy. In order to comment on the fitness of this solution to address
> the problem you're trying to solve, could you describe the actual
> problem ?


The issue is explained in the following thread:
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#note_1697388

In short, the user wants to show a "camera-in-use" indicator when the lapto=
p camera
is used. The script that the user previously had only checked if /dev/video=
0
was open in any process, if it was, the indicator was shown. However, libca=
mera
- at least at the moment - keeps the file descriptor open as long as the Ca=
mera
object exists, which pipewire keeps alive for the entire lifetime of the de=
vice,
therefore the "camera-in-use" indicator is always shown.

> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
