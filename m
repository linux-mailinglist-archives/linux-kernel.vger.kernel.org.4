Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3B5FF8A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJOFy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 01:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJOFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 01:54:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A621558C3;
        Fri, 14 Oct 2022 22:54:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15DDD499;
        Sat, 15 Oct 2022 07:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665813263;
        bh=DZYzkqs5Jujshbu03ccubh/EURrg2D906VTI6AMeaGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLbFtvqNcXY8xoVfdJV6XGCD5oA7vO5jGK1L9VhEi+cFQydJpDh50H//opx1SUKMd
         g9MaZwTCEq0l390EaHnxRUp8lpc4RuE8gTgEaWIyFjJRfJSmnr/2LNphABXyDELefH
         7ItT3PftxdOZ7N0Waq7mBn0k7WAL7ulM31oVmVKk=
Date:   Sat, 15 Oct 2022 08:54:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645
 binding to a schema
Message-ID: <Y0pLDFMsFmHhC/R8@pendragon.ideasonboard.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
 <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
 <20221014214029.GA2937999-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014214029.GA2937999-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 14, 2022 at 04:40:29PM -0500, Rob Herring wrote:
> On Fri, Oct 14, 2022 at 10:27:53PM +0100, Lad, Prabhakar wrote:
> > On Fri, Oct 14, 2022 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Convert the simple OV5645 Device Tree binding to json-schema.
> > > >
> > > > The previous binding marked the below properties as required which was a
> > > > driver requirement and not the device requirement so just drop them from
> > > > the required list during the conversion.
> > > > - clock-frequency
> > > > - enable-gpios
> > > > - reset-gpios
> > > >
> > > > Also drop the "clock-names" property as we have a single clock source for
> > > > the sensor and the driver has been updated to drop the clk referencing by
> > > > name.
> > >
> > > Driver requirements are the ABI!
> > >
> > > This breaks a kernel without the driver change and a DTB that has
> > > dropped the properties.
> > >
> > I already have a patch for the driver [0] which I missed to include
> > along with the series.
> 
> You completely miss the point. Read the first sentence again. Changing 
> driver requirements changes the ABI.
> 
> This breaks the ABI. The driver patch does not help that.

I'm not following you here. If the DT binding makes a mandatory property
optional, it doesn't break any existing platform. The only thing that
would not work is a new DT that doesn't contain the now optional
property combined with an older driver that makes it required. That's
not a regression, as it would be a *new* DT.

> > > Also, with 'clock-names' dropped, you've just introduced a bunch of
> > > warnings on other people's platforms. Are you going to 'fix' all of
> > > them?
> > >
> > Yes I will fix them, once the patch driver patch [0] is merged in.
> 
> Why? You are just making extra work. We have enough warnings as-is to 
> fix.

I agree that a DT binding change should patch all in-tree DTS to avoid
introducing new warnings.

-- 
Regards,

Laurent Pinchart
