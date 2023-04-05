Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B606D7281
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjDECax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjDECau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:30:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97317BB;
        Tue,  4 Apr 2023 19:30:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 622C2905;
        Wed,  5 Apr 2023 04:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680661841;
        bh=92JxqutkaA7MOBZzEsI8JVLAVvvA2FVlO8U5Q3EjmSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWO+SH7/XV27sw9R9Rw+KgqItm8rURI5GQYFV1sl6pR8XqDB6GW41gIU2YwetbYJf
         AtRC/91JVGQs52YzgrvoES/zkyNKZ3kM/rEVQD8Wdrh/kfYVzeVJvyDFcz5Eo0QXhG
         Cc25z/I3g+l6D2expqUK61OIFTqhI2ZjYHVrjfc4=
Date:   Wed, 5 Apr 2023 05:30:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [RESEND PATCH v4 03/21] staging: media: tegra-video: fix
 .vidioc_enum_fmt_vid_cap to return all formats
Message-ID: <20230405023048.GD9915@pendragon.ideasonboard.com>
References: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
 <20230309144320.2937553-4-luca.ceresoli@bootlin.com>
 <85268d69-3d3b-2c0f-ba26-073f09052362@xs4all.nl>
 <20230404161251.272cc78b@booty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404161251.272cc78b@booty>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, Apr 04, 2023 at 04:12:51PM +0200, Luca Ceresoli wrote:
> On Wed, 29 Mar 2023 13:16:22 +0200 Hans Verkuil wrote:
> 
> > Hi Luca,
> > 
> > I finally found the time to test this series. It looks OK, except for this patch.
> 
> Thank you very much for taking the time!
> 
> > The list of supported formats really has to be the intersection of what the tegra
> > supports and what the sensor supports.
> > 
> > Otherwise you would advertise pixelformats that cannot be used, and the application
> > would have no way of knowing that.
> 
> As far as I understand, I think we should rather make this driver fully
> behave as an MC-centric device. It is already using MC quite
> successfully after all.
> 
> Do you think this is correct?

Given the use cases for this driver, I agree.

> If you do, then I think the plan would be:
> 
>  - Add the V4L2_CAP_IO_MC flag
>  - As the mbus_code in get_format appropriately
>  - Leave the changes in this patch unmodified otherwise

-- 
Regards,

Laurent Pinchart
