Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B91674858
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjATAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATAxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:53:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAE9AAB9;
        Thu, 19 Jan 2023 16:53:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17ABE514;
        Fri, 20 Jan 2023 01:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674175998;
        bh=leFNSZshv+kpPN94K/far0pL9B7KIYKntxiaXNDjR4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXRMl3TludEwKOM8ACTPCGPZ4KXVAtKd4a3LEYyl3mTLrxbLqBhtSIZedlnTVXzYI
         R06RARw7I8Ajys8fEhQgvNMUnJWIqimdY5Ofi+CJS0/nTh7lw9mAiUKA8SrYT2UjgC
         x0wHKgEKCMqDg4UzmmyfJqIsRFssMHj5XFC41gI8=
Date:   Fri, 20 Jan 2023 02:53:15 +0200
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
Message-ID: <Y8nl++1Mjd7xLqZe@pendragon.ideasonboard.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
 <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com>
 <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
 <Y8lS5eBliYw5EHBb@kadam>
 <CAMEGJJ2b1KFQY1m1eTcvf8_kGBBTjzrBD2i_M2uR+6v4gEcbVQ@mail.gmail.com>
 <Y8lVvHMIYeSOLM5q@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8lVvHMIYeSOLM5q@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:37:48PM +0300, Dan Carpenter wrote:
> On Thu, Jan 19, 2023 at 02:31:50PM +0000, Phil Elwell wrote:
> > On Thu, 19 Jan 2023 at 14:25, Dan Carpenter wrote:
> > > On Thu, Jan 19, 2023 at 01:47:44PM +0000, Phil Elwell wrote:
> > > > > > I understand the desire to remove the custom logging. I don't welcome
> > > > > > the loss of flexibility that comes with such a strategy
> > > > >
> > > > > What "loss of flexibility"?  You now have access to the full dynamic
> > > > > debugging facilities that all of the rest of the kernel has.  What is
> > > > > lacking?
> > > >
> > > > Perhaps I've missed something, either in this patch set or the kernel
> > > > as a whole, but how is one supposed to set different logging levels on
> > > > different facilities within a driver/module, or even for the module as
> > > > a whole?
> > >
> > > Yeah.  You will be still able to do that and more besides after the
> > > transition.  Cleaning this up makes the code better in every way.
> > >
> > > Documentation/admin-guide/dynamic-debug-howto.rst
> > 
> > Are you saying this patch set gets us to that point?
> 
> Yes.  The patch has some issues, but yes.

I think I'm missing something too then. Dynamic debug provides the
ability to easily switch dev_dbg() messages on and off at runtime, but
it doesn't provide, as far as I'm aware, log levels or log categories.

Log levels are currently used by the vchiq code to suppress messages
below a certain level. Kernel log levels are not an exact replacement,
as the messages still end up in the kernel log (except for debug
messages).

Log categories are used to group messages in categories and control
their log level per category. As far as I know, dynamic debug doesn't
provide any such feature.

-- 
Regards,

Laurent Pinchart
