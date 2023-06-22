Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FE73A48B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFVPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjFVPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:14:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567CE7E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:14:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7624012c0b4so581562385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1687446883; x=1690038883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPZpg+35E+j0KKzuhFHq3OOOec54Shj4O+ADCVoNm6s=;
        b=PIm0d1sfiSLqxiqrSLk9w/10am6T9bYICOxplX6FT4IQ5q294aHqhAKIaycEvn+5rT
         tJFJd9COqp/oM0NY3w1M+RBzLt4p+sRYKkRRW/JCLcHeRAeHma0ApF7pgSAd01vJlzfv
         cUSxDb7u6E8vus6Pn00ADEVvwFCAdGCF82kUXdcIz+dr3n8MYo1xvd6o3EVONvsHLA69
         BlIDO1z34TuXeMudNXES5/nhZbmFQdWDuyA5Q12Lwxc+cCZes9aLiCRydL6/Eole9SVy
         m7Uc6y092dcFHC+f7k2y29UjCYeR47MARTBoeX2p1LTXtkDBbEumaorBAylqVwo3rm/+
         Pdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446883; x=1690038883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPZpg+35E+j0KKzuhFHq3OOOec54Shj4O+ADCVoNm6s=;
        b=YThQASiZ92+JquDYMSlDgoGZ/5kw7qy6dJSwXW3OM9KBVGd10SwpRLqWRVpuYFmRa1
         ZG1XeDoNQwDpuacxaHjklw7akJ+FXWZXdfyznJbC+aI8emvZEjPYOqC/fCaDZkSL47uV
         0f9kM62uY7avYb69rYm5eHzzwjCy2lQvPtu/QC26GqIDkwKik+aC89hS9pGeX5na+Q1a
         o/DyDQ71JzhQoMuKRQ7DWwBUiqUeWqSpCmVzDi5tbvMmsYIMrmFB071w7MDBTbcuQF2J
         M/W1kFjTA6OHL5pOpyBOB7+VhamWnRuH1mfPVdnLIhC1X7zOga8Mn12QnuQY/iRMZH5T
         AT1w==
X-Gm-Message-State: AC+VfDySzrH9UcrvqZ/szNiU9PUe4rTIzGHjaeiH6cJb01ru0cbxQWq+
        FFL3gb+9BKryHWLqEGNL+kEIiw==
X-Google-Smtp-Source: ACHHUZ4Gn45E5Af5fILCwLhEitkR9Z/U+L2oY0MCvwQ6Qo8iBVAOs1MvFIIja4rwWGuqdS5Pt5px8g==
X-Received: by 2002:a05:620a:831f:b0:75b:23a0:e7cb with SMTP id pa31-20020a05620a831f00b0075b23a0e7cbmr15240835qkn.44.1687446882724;
        Thu, 22 Jun 2023 08:14:42 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:c623::7a9])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00754b7ee6922sm3500475qkl.9.2023.06.22.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:14:42 -0700 (PDT)
Message-ID: <5f7873743042cb302c2cb55cdb7ea5e9b26966f0.camel@ndufresne.ca>
Subject: Re: [PATCH WIP RFC v2 0/2] media: uapi: Add V4L2_CID_VTOTAL control
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Bara <bbara93@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Date:   Thu, 22 Jun 2023 11:14:41 -0400
In-Reply-To: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
References: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 22 juin 2023 =C3=A0 09:12 +0200, Benjamin Bara a =C3=A9crit=C2=A0:
> Hi!
>=20
> This series adds new controls for the vertical and horizontal total
> size. Camera sensors usually have registers regarding the total size and
> not the blanking size. Also user space prefers to calculate with total
> frame sizes. Therefore, this would simplify implementations on both
> sides and could be seen as a replacement or upgrade for V4L2_CID_VBLANK.
> Additionally, its value is independent from format changes and therefore
> simplifies calculations in user space.

The naming is getting more and more generic. We need to find a way to give =
these
controls a name that associates them to their usage field (sensors). If we =
keep
growing the control list this way, in few years it will be terribly hard to
understand what is used for what.

What about, V4L2_CID_SENSOR_VTOTAL/HTOTAL ? I'm expecting the last bit of t=
he
name to come from very well known specification, otherwise, its not a great=
 name
either in my opinion.

>=20
> For v2, I added a little bit more documentation and my personal
> expectations to 1/2. As I am fairly new to the camera world, they might
> be a little bit naive so please correct me if this is utopical. I added
> the RFC tag for that reason. However, my intention is to define a
> documented behaviour regarding the values and limits which could
> basically depend on HTOTAL. Currently, HBLANK is always set to the
> minimum in libcamera (I guess to simplify calculations). I think with
> HTOTAL, we could always use WIDTH_MAX(all modes) + HBLANK_MIN(WIDTH_MAX)
> as default to enable a constant frame size. If the current HTOTAL value
> differs from the default, we could infer that the user wants to either
> have a higher frame rate, or a higher exposure and could adapt to that.
> E.g. use the minimums to get the highest frame rate possible if the
> current values are outside of the possible range, or not limiting the
> exposure control by the current vertical blanking as it is done now. I
> guess this would help the driver to "understand" the needs of the user
> space, and therefore allow it to react in a defined and expected manner.
>=20
> 2/2 is a WIP (same as in v1) and currently implements VTOTAL for the
> imx290, basically extending the current V4L2_CID_VBLANK implementation.
>=20
> Thanks Dave for the feedback, insights and the examples (ov5647,
> ov9282). I might need some time to skim through the data sheets to learn
> why they do stuff like it is done now.
>=20
> ---
> Changes in v2:
> - 1/2: add HTOTAL
> - 1/2: add documentation about expectations
> - Link to v1: https://lore.kernel.org/r/20230609-v4l2-vtotal-v1-0-4b7dee7=
e073e@skidata.com
>=20

Do you have an link to an example user of this new API ?

Nicolas

> ---
> Benjamin Bara (2):
>       media: uapi: Add V4L2_CID_{V,H}TOTAL controls
>       media: i2c: imx290: Add support for V4L2_CID_VTOTAL
>=20
>  Documentation/driver-api/media/camera-sensor.rst   | 11 ++++-
>  .../media/v4l/ext-ctrls-image-source.rst           | 16 ++++++++
>  drivers/media/i2c/imx290.c                         | 47 ++++++++++++++++=
------
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  2 +
>  include/uapi/linux/v4l2-controls.h                 |  2 +
>  5 files changed, 64 insertions(+), 14 deletions(-)
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230609-v4l2-vtotal-eb15d37cafea
>=20
> Best regards,

