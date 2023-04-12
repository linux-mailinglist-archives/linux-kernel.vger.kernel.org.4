Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDE6DF968
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjDLPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:12:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29A59F3;
        Wed, 12 Apr 2023 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681312345; x=1712848345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ritMmFWx/EQv07wbQLyVpyzAhqQ3TR59ZTTAlw28V1U=;
  b=HpX3rBGFBZegClLCDiVFZ0SxwbHIqBtl54RkivxGdnG7yWna0jVF4lCk
   Nl3jY+7tsxUPatN6erCIvJt0UGw0lHtgeC9vCk7zEsZdiUBUPCA8bqg6/
   bB9/h8qRFMhGdCFj1agufCimDjPsmNaFtKa4GuJbkdRynWrKm4d5nzqEa
   puDQXQtprt2AklENjigoYgEv1gwQIED/6Djv2wWmyN8lVQMIF01BrAI+i
   gXkqYhkX6WP+I/gXDs89g8YUkq5aXYwV52KKdlY0SVx0D35XBymKczF3B
   xrXEBHxvjVpiBuBtciezH7LLQ7e1Bgy0ZTNW5j8B8SDL4C1ONgoM7xGBz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="341419660"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="341419660"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682501553"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682501553"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:12:22 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D0A5611F78C;
        Wed, 12 Apr 2023 18:12:19 +0300 (EEST)
Date:   Wed, 12 Apr 2023 18:12:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Message-ID: <ZDbKU5kwcb7RGeCo@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Michael,

On Wed, Apr 12, 2023 at 02:55:56PM +0100, Dave Stevenson wrote:
> > > If the ranges aren't updated, where should that out-of-range lens
> > > movement leave the lens?
> >
> > This is up to the hardware controller, but I would guess it typically
> > stops one step before disaster. Wherever that may be, the error
> > condition and the current position can be read out via this new STATUS
> > control.
> >
> > Does this sound good so far?
> 
> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
> Laurent), and I'm just expressing my views based on the lenses I've
> encountered.
> All of my lenses have a single drive for focus, a single drive for
> zoom, and where there are multiple elements they are all connected
> mechanically. Your setup sounds far more complex and is likely to need
> a more extensive driver, but it'd be nice to not unnecessarily
> overcomplicate the interface.

Could we also have a driver that uses these new controls?

The controls themselves appear reasonable to me as well. I guess there are
changes to be made based on the discussion?

-- 
Regards,

Sakari Ailus
