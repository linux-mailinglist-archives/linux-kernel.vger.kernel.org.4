Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACD7452F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGBW2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGBW2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:28:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3FCE48;
        Sun,  2 Jul 2023 15:28:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-160-45-219.reb.o2.cz [85.160.45.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E252A6DE;
        Mon,  3 Jul 2023 00:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688336840;
        bh=XkF0zOHhROpAoFlaqmgLQgzZVdldtalFw4OSvXP0aN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUj6tKE2Gjdwo+OIwF6bQ1z30sDPB8Em+YpmNP2RWdeacN6uGeCpsD9ps7UF5774g
         u+dD78HhOMaRjjoTVtxxOLSx8bnybning+dFX5gWQyb+Pi+32cqf833QF5/4MwJPQO
         5J3rO7JURTZxleXoSfFIaGE+ssletB8gUNcN6BlU=
Date:   Mon, 3 Jul 2023 01:28:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
Message-ID: <20230702222803.GF9285@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <YhihbncnSlmvrn/D@valkosipuli.retiisi.eu>
 <20230702152356.GA16995@pendragon.ideasonboard.com>
 <ZKG/bej80eL13Qqp@valkosipuli.retiisi.eu>
 <20230702214505.GB16995@pendragon.ideasonboard.com>
 <20230702214711.GC16995@pendragon.ideasonboard.com>
 <ZKHye/4kARSHqsIJ@valkosipuli.retiisi.eu>
 <20230702220138.GE9285@pendragon.ideasonboard.com>
 <ZKH4LXKHX8G1WK7a@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKH4LXKHX8G1WK7a@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:20:29PM +0000, Sakari Ailus wrote:
> On Mon, Jul 03, 2023 at 01:01:38AM +0300, Laurent Pinchart wrote:
> > > > > > > > If the hardware doesn't support lane remapping for CCP2, then that should
> > > > > > > > be reflected in DT bindings, i.e. data-lanes isn't relevant. There's no
> > > > > > > > need to check that here.
> > > > > > > 
> > > > > > > Should the above check for CSI-2 be dropped as well then ?
> > > > > > 
> > > > > > Same for CSI-2, too: if there's nothing to configure there (lane remapping)
> > > > > > there's no need to validate that part of the DT either.
> > > > > 
> > > > > OK, I'll drop that.
> > > > 
> > > > Actually, I'm wondering if it would make sense to tell the parsing
> > > > functions whether lane reordering is supported or not. The checks could
> > > > then be moved to the framework. What do you think ?
> > > 
> > > I'm not sure how useful this check would be in the first place: if you have
> > > hardware that can reorder the lanes, the framework doesn't know what to
> > > check there (if anything) and otherwise there's little point in the
> > > entire check.
> > 
> > Isn't it good to tell users that something is wrong instead of accepting
> > the invalid configuration and let them wonder why the device isn't
> > working ? Users in this case would be system integrators, not end
> > users, but we have lots of debugging information in the kernel aimed for
> > them already.
> 
> In which of the two cases above the framework could do something useful
> there? For devices where you can reorder the lanes or for those where you
> can't?

For devices where you can't, to detect DT that reorders lanes.

-- 
Regards,

Laurent Pinchart
