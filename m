Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53978674870
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjATBA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjATBAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:00:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A7A1028;
        Thu, 19 Jan 2023 17:00:53 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09667514;
        Fri, 20 Jan 2023 02:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674176451;
        bh=tUHR1lm0/GiTPaTojG05os0odntRdSE/TwVOXS1mhn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF+3LpDxK/DyIVL3yWXfMQDpoa2AGbvzYy3oWKEbDRjx+Y2RXq5r9DCxSIu+68QTh
         2Vlseywog6UJIKMSkZlADSlYg8pEQu0HIHMV4tKpdmN/ETM1zlH1oKzD63h5pTYBqF
         VZOt9sWYmFMWVtyLwPO9h24f+2zUmQThHtR12qz0=
Date:   Fri, 20 Jan 2023 03:00:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Message-ID: <Y8nnwIqah3O9QfIU@pendragon.ideasonboard.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
 <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com>
 <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
 <Y8lS5eBliYw5EHBb@kadam>
 <CAMEGJJ2b1KFQY1m1eTcvf8_kGBBTjzrBD2i_M2uR+6v4gEcbVQ@mail.gmail.com>
 <Y8lVvHMIYeSOLM5q@kadam>
 <Y8nl++1Mjd7xLqZe@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8nl++1Mjd7xLqZe@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 02:53:17AM +0200, Laurent Pinchart wrote:
> On Thu, Jan 19, 2023 at 05:37:48PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 19, 2023 at 02:31:50PM +0000, Phil Elwell wrote:
> > > On Thu, 19 Jan 2023 at 14:25, Dan Carpenter wrote:
> > > > On Thu, Jan 19, 2023 at 01:47:44PM +0000, Phil Elwell wrote:
> > > > > > > I understand the desire to remove the custom logging. I don't welcome
> > > > > > > the loss of flexibility that comes with such a strategy
> > > > > >
> > > > > > What "loss of flexibility"?  You now have access to the full dynamic
> > > > > > debugging facilities that all of the rest of the kernel has.  What is
> > > > > > lacking?
> > > > >
> > > > > Perhaps I've missed something, either in this patch set or the kernel
> > > > > as a whole, but how is one supposed to set different logging levels on
> > > > > different facilities within a driver/module, or even for the module as
> > > > > a whole?
> > > >
> > > > Yeah.  You will be still able to do that and more besides after the
> > > > transition.  Cleaning this up makes the code better in every way.
> > > >
> > > > Documentation/admin-guide/dynamic-debug-howto.rst
> > > 
> > > Are you saying this patch set gets us to that point?
> > 
> > Yes.  The patch has some issues, but yes.
> 
> I think I'm missing something too then. Dynamic debug provides the
> ability to easily switch dev_dbg() messages on and off at runtime, but
> it doesn't provide, as far as I'm aware, log levels or log categories.
> 
> Log levels are currently used by the vchiq code to suppress messages
> below a certain level. Kernel log levels are not an exact replacement,
> as the messages still end up in the kernel log (except for debug
> messages).
> 
> Log categories are used to group messages in categories and control
> their log level per category. As far as I know, dynamic debug doesn't
> provide any such feature.

After a bit more research (which I should have done before replying,
sorry), it looks like dynamic debug has support for classes, which are
used by, for instance, the DRM logging infrastructure (see
include/drm/drm_print.h). I don't see that being wired up to dev_*()
print macros though, am I missing something, or would vchiq need to keep
using custom logging macros (with dynamic debug used as a backend,
replacing the current custom implementation) to make use of this feature
?

-- 
Regards,

Laurent Pinchart
