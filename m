Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9F6DF437
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDLLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDLLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:50:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1949C7;
        Wed, 12 Apr 2023 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681300228; x=1712836228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJguQgfPrCzOL1UinkrZOLLmdKnj7zrU8lo6WlYHIEs=;
  b=ANyWOjNCdnyJh+m6m4GZn/dwv2tyfTMODVhLp3P5R/CdNweR4tU4NpVI
   i/ecFSPonXbnKAM1jLIxyunUYwRYXTLrqiFR6DK/QDobfcm7W6p44a2nx
   exg1Tp9qJnIEi2NPv6Zw9GEVfxh1Cs9sml89T59EKqqKCsFw6YDLoj93Z
   1rBQD2YvWEbnMSskt+ho04reZ0nC+ivzTp6xXVWHROOUPr9QKhWGUflvX
   IPpvSUz2HuienR2JVjwLl++DtRdaRqOr/L16W2DE10VsmZx9vGeN2LpQp
   JjwXYjdFXUz9ne24zly79GfuaJXke8nW7YRaHgm3A+R/5M30Y8nUCPhJd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341362754"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="341362754"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="758207430"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758207430"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:50:20 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 06736120D2E;
        Wed, 12 Apr 2023 14:50:18 +0300 (EEST)
Date:   Wed, 12 Apr 2023 14:50:18 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Message-ID: <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Apr 12, 2023 at 10:00:26AM +0200, Michael Riesch wrote:
>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
>    then what happens if the application performs a
>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
>    the application's point of view.

Would there be a reason to implement both of these controls in a single
driver? AFAIU, the relative one should be used if there absolute value
isn't known to the driver.

-- 
Kind regards,

Sakari Ailus
