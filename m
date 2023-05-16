Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044770572A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjEPTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPTel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:34:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31673C14;
        Tue, 16 May 2023 12:34:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EEF14A9;
        Tue, 16 May 2023 21:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1684265664;
        bh=vD80TzppvxoCyqd+8/aeybtXUwrrIB5HylIddF58t+w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h5nxgy0YpdoD6W48hvSi0nTbiAsy+NTIckedqI8fvnsOWng7sjJYfKwdforRtG5tO
         WF172v862NgT2z4VEh0meU2begVV5fCOUWwqjSItNpD0lE3gWhhtdj0nDbAOQ91SIp
         AHvcbhZ8evkkVagBEwTBPhYDrldkL0TZc9q3dmE4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
Subject: Re: [PATCH RFC v2 0/6] media: v4l2-ctrls: add controls for complex lens controller devices
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 16 May 2023 20:34:32 +0100
Message-ID: <168426567274.727956.12078149879172832940@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

Quoting Michael Riesch (2023-04-25 10:45:10)
> Hi all,
>=20
> This patch series aims to add support for complex lens controllers in V4L=
2.
> Complex lens controllers usually feature one focus lens and one (or more)
> zoom lens(es), which are driven by motors (e.g., stepper motors). As a
> consequence, a few crucial differences to simple lens controllers (such as
> voice coil motor (VCM) drivers, which are already well supported in V4L2)
> arise:
>=20
>  - Focus and zoom are slow.
>=20
> Compared to a simple VCM driver, which reacts almost instantaneously, the
> motors that control the lens groups may require some time to reach their
> target position. Therefore, the control process in user space needs
> to receive feedback on the current status of each lens group, such as the
> current position and whether or not the lens group is moving. Patch 3/6
> adds volatile and read-only status controls for each lens group.
>=20
>  - The velocity of focus and zoom can be selected.
>=20
> In contrast to a simple VCM driver, the motors can move at different
> velocities. Since the produced noise depends on the velocity, the
> control process may want to optimize the chosen velocity. Also, some auto
> focus algorithms use different velocities in different phases (e.g., a
> coarse and fast scan vs. a slow and precise scan). Patch 4/6 adds speed
> controls for the focus lens group and the zoom lens group.
>=20
>  - Calibration may be required.
>=20
> Since moving mechanical parts are involved, calibration is most likely
> necessary. Patch 5/6 introduces controls to control calibration procedure=
s.
>=20
> In the scope of calibration, the relation between the lens positions may =
be
> fine-tuned. This requires the ability to control the individual lenses and
> gather feedback on their current status. Patch 6/6 introduces a pair of
> controls for five zoom lenses. (Five is a placeholder here. The most
> complex objective we had at hand happened to feature five zoom lenses.)

I realise the 'five' is a bit arbitrary at the moment. Have you looked
at if it's possible to expose each lens as a distinct subdevice?

That would give full control over each one at least. I'm not sure yet
what the implications are with the 'group' though. I would expect then
the media graph could show links/connections sequentially between each
lens portraying the path that light travels through them. Are they
always linear? (or maybe the better word is sequential?) or do they
arrange in different orders ... I hope there's not something as complex
as:

  1 -> 2 \
          6
  4 -> 5 /=20
 =20

>=20
> On the user space side, it is envisaged that libcamera operates the newly
> introduced controls. Please note that no tests with libcamera have been
> carried out yet, the integration will be discussed after the first round =
of
> feedback to this RFC.

If they are split into individual components then at least libcamera can
identify the arrangement from the media graph?

Will you expect applications to manage each lens manually? or would this
all be handled within libcamera (perhaps in some custom IPA?)


> Version 2 of this series include two new patches that fix mistakes in the
> documentation of existing controls. These mistakes have been pointed out
> during the review phase of the first iteration of this series.
>=20
> Looking forward to your comments!
>=20
> ---
> Changes in v2:
> - add patch 1/6 that fixes unit description of V4L2_CID_FOCUS_ABSOLUTE
> - add patch 2/6 that clarifies when to implement V4L2_CID_FOCUS_RELATIVE
> - remove compound controls _STATUS (struct) and add controls _STATUS
>   (bitmask) and _CURRENT (integer) instead
> - fix V4L2_CID_LENS_CALIB_STATUS documentation
> - Link to v1: https://lore.kernel.org/r/20230406-feature-controls-lens-v1=
-0-543189a680de@wolfvision.net
>=20
> ---
> Michael Riesch (6):
>       media: v4l2-ctrls: fix documentation of V4L2_CID_FOCUS_ABSOLUTE unit
>       media: v4l2-ctrls: clarify documentation of V4L2_CID_FOCUS_RELATIVE
>       media: v4l2-ctrls: add lens group status controls for zoom and focus
>       media: v4l2-ctrls: add lens group speed controls for zoom and focus
>       media: v4l2-ctrls: add lens calibration controls
>       media: v4l2-ctrls: add controls for individual zoom lenses
>=20
>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 129 +++++++++++++++=
+++++-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  41 +++++++
>  include/uapi/linux/v4l2-controls.h                 |  41 +++++++
>  3 files changed, 208 insertions(+), 3 deletions(-)
> ---
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> change-id: 20230406-feature-controls-lens-b85575d3443a
>=20
> Best regards,
> --=20
> Michael Riesch <michael.riesch@wolfvision.net>
>
