Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0F6DA844
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjDGEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDGEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:32:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD68684;
        Thu,  6 Apr 2023 21:32:21 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D806D8A4;
        Fri,  7 Apr 2023 06:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680841940;
        bh=DLRyYL7JJWMS2lVd7UMcnWaWD08oLNGHSYb1rviAAL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmo6g0rQO3zngyyDEwS7w93QKDXHOqOQdVRItWUzeLvQRXJgEyK2Cw0xGundBT0pd
         Uz6Pe049SwNVTMTQdFnGEABxOv2vkoCVS0egAnekVnAO1rdTDKnbn5c5kCeO4ty8cM
         Vha69I3z9nCEd0sEL52vXJQ6UGDpS/c6Ns6A2t04=
Date:   Fri, 7 Apr 2023 07:32:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, mchehab@kernel.org,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
Message-ID: <20230407043227.GI31272@pendragon.ideasonboard.com>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-2-martin.kepplinger@puri.sm>
 <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
 <20230406013338.GK9915@pendragon.ideasonboard.com>
 <ZC7K2ZdrxR8w7T5r@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC7K2ZdrxR8w7T5r@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Apr 06, 2023 at 04:36:25PM +0300, Sakari Ailus wrote:
> On Thu, Apr 06, 2023 at 04:33:38AM +0300, Laurent Pinchart wrote:
> > On Wed, Apr 05, 2023 at 03:52:52PM +0300, Sakari Ailus wrote:
> > > On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> > > > pm_runtime_get_if_in_use() does not only return nonzero values when
> > > > the device is in use, it can return a negative errno too.
> > > > 
> > > > And especially during resuming from system suspend, when runtime pm
> > > > is not yet up again, this can very well happen. And in such a case
> > > > the subsequent pm_runtime_put() call would result in a refcount underflow!
> > > 
> > > I think this issue should have a more generic solution, it's very difficult
> > > to address this in drivers only with the current APIs.
> > > 
> > > pm_runtime_get_if_in_use() will also return an error if runtime PM is
> > > disabled, so this patch will break the driver for that configuration.
> > 
> > I'm increasingly inclined to depend on CONFIG_PM for all camera sensor
> > drivers.
> 
> For what reason? This is the smallest of all problems related to power
> management. Also runtime PM has no-op functions for just this purpose.

Because it creates a myriad of sleep (or bigger) issues like this one,
and more seem to be popping up (or coming to my attention at least) over
time.

> (Frankly it'd be great if we could make CONFIG_PM go away. So perhaps
> requiring it everywhere is one feasible approach to do that.)

I'm all for it :-) For camera sensor drivers, are you aware of use
cases where !CONFIG_PM would be desired ?

-- 
Regards,

Laurent Pinchart
