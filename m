Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE606ED5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjDXT5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXT5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:57:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C214211;
        Mon, 24 Apr 2023 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682366231; x=1713902231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+deS8h8FoffVbs4vbkzCb9zdDbBYPFKIFtYSNJTiYo=;
  b=ShIeLLtrRlWN/qCvsGu2fpIdhfWufmfpHEXwuJ2MXI9ZJUjjmOEJVbNk
   NqWgXlFMHgDIyoqTWv+5hJm8EebXFHDylrpGOahUOWRNHOBsfgrWVBXsr
   iCbrMgx8HaPD+zJ4B4gzp95sSU2ZNrnWT+u5V4fGWK3vuERb+xoOSgsFs
   5GSoMzVn6DITUV/ZIM1D3MUhRz0cqt8IIQTD/PVnmkl3oorAiPN+DMUt1
   zCLnWDM5eq6niZMXPACwIz4vufRR9RqXPeQW3csWuL5adcTMUlCphXgJn
   uGpXYJYUSqGYY21jgFlMEIEptIX8yEVSKscp7lS0xV+TxyDXtN/H1f32C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326156760"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326156760"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939463928"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="939463928"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:57:07 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6433911FAD0;
        Mon, 24 Apr 2023 22:57:04 +0300 (EEST)
Date:   Mon, 24 Apr 2023 22:57:04 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Brotzge <Alexander.Brotzge@wolfvision.net>,
        Dieter Mathis <Dieter.Mathis@wolfvision.net>
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Message-ID: <ZEbfEPeNCS9hBBnP@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
 <ZDbKU5kwcb7RGeCo@kekkonen.localdomain>
 <ccae3994-3b1b-4050-ea34-98f97cf886e0@wolfvision.net>
 <ZD+t5QYH20Y8+8MV@kekkonen.localdomain>
 <45fea085-54c3-157e-6459-adaaf1edebf5@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45fea085-54c3-157e-6459-adaaf1edebf5@wolfvision.net>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Apr 19, 2023 at 01:24:58PM +0200, Michael Riesch wrote:
> Hi Sakari,
> 
> On 4/19/23 11:01, Sakari Ailus wrote:
> > Hi Michael,
> > 
> > On Mon, Apr 17, 2023 at 02:38:20PM +0200, Michael Riesch wrote:
> >> Hi Sakari,
> >>
> >> On 4/12/23 17:12, Sakari Ailus wrote:
> >>> Hi Dave, Michael,
> >>>
> >>> On Wed, Apr 12, 2023 at 02:55:56PM +0100, Dave Stevenson wrote:
> >>>>>> If the ranges aren't updated, where should that out-of-range lens
> >>>>>> movement leave the lens?
> >>>>>
> >>>>> This is up to the hardware controller, but I would guess it typically
> >>>>> stops one step before disaster. Wherever that may be, the error
> >>>>> condition and the current position can be read out via this new STATUS
> >>>>> control.
> >>>>>
> >>>>> Does this sound good so far?
> >>>>
> >>>> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
> >>>> Laurent), and I'm just expressing my views based on the lenses I've
> >>>> encountered.
> >>>> All of my lenses have a single drive for focus, a single drive for
> >>>> zoom, and where there are multiple elements they are all connected
> >>>> mechanically. Your setup sounds far more complex and is likely to need
> >>>> a more extensive driver, but it'd be nice to not unnecessarily
> >>>> overcomplicate the interface.
> >>>
> >>> Could we also have a driver that uses these new controls?
> >>
> >> If you are referring to the driver for our custom lens controller, then
> >> I have to say that it is under development and simply not ready for
> >> release yet. Also, the decision has not yet been made whether or not
> >> this will be an open-source driver.
> >>
> >> A different approach could be the adaptation of the vimc-lens driver,
> >> which currently only supports FOCUS_ABSOLUTE. But this would raise
> >> several implementation questions and at least for me this would be a
> >> nontrivial task.
> >>
> >> Is it required to have a driver for this interface (in the sense that
> >> the patches cannot be accepted otherwise)?
> > 
> > That has been traditionally required, and a virtual driver isn't usually
> > considered enough. There are at least two reasons for this. The first one
> > being that if the driver isn't reviewable and targetting upstream it may be
> > difficult to figure out whether the interface changes are the right ones
> > for that driver. This is perhaps a lesser concern here. Secondly, there is
> > also unwillingness to add interface elements that might never be supported
> > by the kernel itself --- this is effectively just dead code.
> > 
> > Also cc Hans and Laurent.
> 
> I understand your concerns. Cc: Alexander and Dieter
> 
> We aim to be an open-source friendly company. If you are OK with us
> submitting a driver that targets very custom hardware that is only
> available in integrated form in our products (and not, for instance,
> available for sale as a standalone device), then we are prepared to
> submit the driver sources for consideration for inclusion in mainline
> Linux. Would this be acceptable?

How easily can you run your own kernel on this thing?

A somewhat close comparison point to this would be mobile phones that come
with raw camera sensors that often are found nowhere else except on that
very phone model. These are not always very easy to use actually. It is
also true that these sensors _could_ be found elsewhere and sometimes are.

I wonder what others think.

> 
> As I already stated above, it will take us some time to prepare
> everything in a form that is suitable for submission. Now should I
> submit the next iteration(s) of the series at hand as RFC or as regular
> patch series?

RFC perhaps, unless it comes with a driver? It doesn't necessarily matter
much in the end. Sometimes what was labelled as RFC gets merged as-is, at
other times there are 20 versions of what was labelled as PATCH to begin
with.

> 
> >>> The controls themselves appear reasonable to me as well. I guess there are
> >>> changes to be made based on the discussion?
> >>
> >> I'd summarize that whether or not the status controls are compound
> >> controls of the type V4L2_CTRL_TYPE_LENS_STATUS is the open question.
> >>
> >> As a potential follow-up question I recently asked myself if the struct
> >> v4l2_ctrl_lens_status should contain trailing reserved bytes for future
> >> extension (no idea, though, what this could be).
> >>
> >> Alternatively, we could come up with "V4L2_CID_FOCUS_CURRENT (integer)"
> >> for the current position and "V4L2_CID_FOCUS_STATUS (bitmask)" (and add
> >> further controls when they are needed. Here, we lose atomicity but maybe
> >> this can be ignored. One could assume that all relevant controls are
> >> read out with a single ioctl which provides at least some level of
> >> atomicity.
> > 
> > There might be something that could be done in the control framework to
> > address this. But it's not something that can be expected to happen soon.
> > 
> > I'd perhaps keep them separate, not to make it a compound control just for
> > the access reason. But I certainly don't have a strong opinion about it.
> 
> After some further considerations, and following Dave's and your
> comments, I'll keep them separate.
> 
> Discussion to be continued with v2.

-- 
Lomd regards,

Sakari Ailus
