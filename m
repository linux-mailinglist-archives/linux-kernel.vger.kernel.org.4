Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC996DF8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjDLOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjDLOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:39:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8C59775;
        Wed, 12 Apr 2023 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681310349; x=1712846349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZ+4bqcOwGArNUff5c6q4WqLlSztJS1TSKOKE8pP2P4=;
  b=NFbU0lN+kFFYJzZWK1MCEbKb2no7YqwKEIWRwS7KDi53b2LPGdu8FctW
   l2xKHCT5iidqRjo9WKgGC1iRerBI2hx50nUVC/HTDH1Rg+/IziP8dfnBN
   A+ZqsSWKbmlZuWkup7Tm677S8V0+fL1dH3tt6fZdSRKLpAkgyAM8An4CI
   fBfLoZbm0VaGoqfhMvKz445dxpuxiJuhV5Hmh7TYCcX6bHh8uL23sXDQd
   DM7VuRZOl7XH+AYTb2MEBe+YEVtwDYcbTNLGKJOvaOmiMqQ5ukl5n2V//
   TAwm50863EWsDVxRa6ikkYhTdiLpKc+QjWcvTq3Bymj+Y+2snqeitP0L8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324277258"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324277258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639258064"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639258064"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:39:05 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 7EF49120D2E;
        Wed, 12 Apr 2023 17:39:02 +0300 (EEST)
Date:   Wed, 12 Apr 2023 17:39:02 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Message-ID: <ZDbChgZJHVaaX3/x@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
 <8fe5c9c5-6eb0-86ae-9e5d-fbaa72be25fe@wolfvision.net>
 <ZDaemghP0HQSw3Fo@kekkonen.localdomain>
 <77d91964-de0a-8bd4-12d9-bc16110cfa7c@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d91964-de0a-8bd4-12d9-bc16110cfa7c@wolfvision.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Apr 12, 2023 at 03:43:26PM +0200, Michael Riesch wrote:
> Hi Sakari,
> 
> On 4/12/23 14:05, Sakari Ailus wrote:
> > Hi Michael,
> > 
> > On Wed, Apr 12, 2023 at 01:57:36PM +0200, Michael Riesch wrote:
> >> Hi Sakari,
> >>
> >> On 4/12/23 13:50, Sakari Ailus wrote:
> >>> Hi Michael,
> >>>
> >>> On Wed, Apr 12, 2023 at 10:00:26AM +0200, Michael Riesch wrote:
> >>>>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
> >>>>    then what happens if the application performs a
> >>>>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
> >>>>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
> >>>>    the application's point of view.
> >>>
> >>> Would there be a reason to implement both of these controls in a single
> >>> driver? AFAIU, the relative one should be used if there absolute value
> >>> isn't known to the driver.
> >>
> >> Probably not, but on the other hand there is nothing the prevents a
> >> driver developer from doing so, right? Point is that should there be a
> >> driver which does implement both controls, we are in trouble AFAIU.
> > 
> > I think the documentation should be improved in this regard.
> 
> The documentation of which control exactly? And what items should be added?

Both V4L2_CID_FOCUS_ABSOLUTE and V4L2_CID_FOCUS_RELATIVE. For the former,
the sentence "Positive values set the focus closer to the camera, negative
values towards infinity." doesn't make much sense in the context. For the
latter, what I mentioned earlier, i.e. this should be only implemented if
the absolute value isn't known. It's not a driver's job to do simple
arithmetics for the user space.

In fact, it appears that no driver is using V4L2_CID_FOCUS_RELATIVE at the
moment. So we could as well deprecate it (or remove from documentation
altogether).

-- 
Kind regards,

Sakari Ailus
