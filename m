Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF26DF4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjDLMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDLMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:05:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA2B7;
        Wed, 12 Apr 2023 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681301152; x=1712837152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iNHXn7Y7088Jm9D91nEHAacZ/cTLuLTbGyvLMhXVDd0=;
  b=Pg51DmKrMgfwrXEjW2J+YpMIuyRdcDrshQegXcKPhWpF9djpNw4oD+8f
   LZ2HexohPA2o8AfF9zPhs+2qTqVLDXub3DKUnaYhgKBNK7BKmhhMDspA4
   Vo0vP3lZ+iF3RNt1QOZKlK0qw9l1miEtsnhoNyoCbyBSME2X1FzO5QXpj
   VtTx9tFNHZS7/k4UY7659pUbrq8NUSqbggye3otkC4MV8hEWXIi1eW1z8
   ODlhvrN8rnp/SGATLEPax9tnHilJGv4se4DAutdFHdb3tR9W62j8/mycc
   J0uGM4de9G807Y3qB09pkYC3U3TCUjvTFoLQfMo82UnKmSX2CuCswYd2w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="332568301"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332568301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="800290120"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800290120"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:05:49 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 5FBC1120D2E;
        Wed, 12 Apr 2023 15:05:46 +0300 (EEST)
Date:   Wed, 12 Apr 2023 15:05:46 +0300
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
Message-ID: <ZDaemghP0HQSw3Fo@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
 <8fe5c9c5-6eb0-86ae-9e5d-fbaa72be25fe@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe5c9c5-6eb0-86ae-9e5d-fbaa72be25fe@wolfvision.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Apr 12, 2023 at 01:57:36PM +0200, Michael Riesch wrote:
> Hi Sakari,
> 
> On 4/12/23 13:50, Sakari Ailus wrote:
> > Hi Michael,
> > 
> > On Wed, Apr 12, 2023 at 10:00:26AM +0200, Michael Riesch wrote:
> >>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
> >>    then what happens if the application performs a
> >>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
> >>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
> >>    the application's point of view.
> > 
> > Would there be a reason to implement both of these controls in a single
> > driver? AFAIU, the relative one should be used if there absolute value
> > isn't known to the driver.
> 
> Probably not, but on the other hand there is nothing the prevents a
> driver developer from doing so, right? Point is that should there be a
> driver which does implement both controls, we are in trouble AFAIU.

I think the documentation should be improved in this regard.

Also cc Hans.

-- 
Regards,

Sakari Ailus
