Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE8666071
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjAKQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjAKQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:28:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC71C422;
        Wed, 11 Jan 2023 08:26:51 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC5884DD;
        Wed, 11 Jan 2023 17:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673454409;
        bh=XcChrOCe2/CPzRm4LhKPTJOLcZhk/V1PHjwC3XbavZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W39L8WLLnnWyqGIk0zc+ZGVYnUCgVZ1pDnf7y7QPKzzGbHP9Jebduh2+CTlMWhveV
         B9Ny/ZlOxV4tLfy8E/9zbvDWPAUrK2abv/wgKw83Qe6KShBM3C2gysnVtve2cTIEd6
         Z5nVNYxgdQTLM9pr/5hB7VktuEAwuZstHbKZeuOo=
Date:   Wed, 11 Jan 2023 18:26:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v3 0/7] staging: vc04_services: Remove custom return
 values
Message-ID: <Y77jR5i+q9Flu0si@pendragon.ideasonboard.com>
References: <20221223122404.170585-1-umang.jain@ideasonboard.com>
 <ba52e6b4-33ec-622e-00b6-1b098f529a90@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba52e6b4-33ec-622e-00b6-1b098f529a90@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

On Wed, Jan 11, 2023 at 02:32:17PM +0530, Umang Jain wrote:
> Hi all,
> 
> Gentle ping for review, If it's needs more iterations or ready to be 
> accepted...

I see that Stefan has tested the whole series. Florian is listed as the
maintainer for vc04_services. Florian, do you want to review this series
further, or can we merge it in v6.3 ?

> On 12/23/22 5:53 PM, Umang Jain wrote:
> > The series removes the custom return values from functions
> > and replaces them with linux error codes. This address the TODO
> >   vchiq interface:
> > * Get rid of custom function return values
> >
> > Changes in v3:
> > - Drop fixes tag for 5/7 as suggested in review
> > - Add Tested-by: by Stefan Wahren to the series
> >
> > Changes in V2:
> > - Patch 3/7 now reports for specific errors like -ENOMEM, -EHOSTDOWN
> > - Patch 5/7 reports -ENOTCONN instead of -EINVAL and adds a "Fixes" tag
> >
> > Umang Jain (7):
> >    staging: vc04_services: Replace vchiq_status return type to int
> >    staging: vc04_services: Drop VCHIQ_SUCCESS usage
> >    staging: vc04_services: Drop VCHIQ_ERROR usage
> >    staging: vc04_services: Drop VCHIQ_RETRY usage
> >    vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on disconnect
> >    staging: vc04_services: Drop enum vchiq_status remnants
> >    staging: vc04_services: vchiq: Drop custom return values from TODO
> >
> >   .../bcm2835-audio/bcm2835-vchiq.c             |  12 +-
> >   .../include/linux/raspberrypi/vchiq.h         |  65 +++---
> >   drivers/staging/vc04_services/interface/TODO  |   5 -
> >   .../interface/vchiq_arm/vchiq_arm.c           | 124 +++++-----
> >   .../interface/vchiq_arm/vchiq_arm.h           |  12 +-
> >   .../interface/vchiq_arm/vchiq_core.c          | 216 +++++++++---------
> >   .../interface/vchiq_arm/vchiq_core.h          |  18 +-
> >   .../interface/vchiq_arm/vchiq_dev.c           |  36 +--
> >   .../interface/vchiq_arm/vchiq_ioctl.h         |   8 +-
> >   .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  11 +-
> >   10 files changed, 246 insertions(+), 261 deletions(-)

-- 
Regards,

Laurent Pinchart
