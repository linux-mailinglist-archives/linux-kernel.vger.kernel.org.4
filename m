Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171FC62416F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKJLaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKJLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:30:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0F2B197
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668079821; x=1699615821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cUdFiGXF/+tjfUTHyRqfTqMCE7A8mkyb1UblyOGLEmQ=;
  b=YN3qzKWglhoHmPoiVno0tTuBqkCBMj4RJEmTiXgGVCkbTr92AydEpQSW
   qgUOVmjIHtYOwalQDZRyKlcEemhW3kC3SODM8b8i4R9zF3Iv/3OnP47Ye
   OzP+ZGcjvuFQN3E1lOxtS6eAuu8wMqKvzkwt0pZW7wXtttnG+lOXjCymn
   5TUfJBwaqyJROCjeA8EMBcXZrWaYtYblfC0kHaFbXupQI+xmLmMALkhn1
   FI6M4OTk74P7C4fuPoPyZ+CUutdpBxfo/EOQhhPIJu3edStlnRoX76Vbo
   G9L0cFtYz8jILLF9AJedBZsYV7mZrZErfzQrTldYuPUK30tS07KD7SoGV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="313059678"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="313059678"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:30:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631627136"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="631627136"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.22.77])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 03:30:17 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/3] Fix timeout handling when retiring requests
Date:   Thu, 10 Nov 2022 12:30:14 +0100
Message-ID: <1933631.usQuhbGJ8B@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
References: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 9 November 2022 20:09:34 CET Janusz Krzysztofik wrote:
> Fixes for issues discovered via code review while working on
> https://gitlab.freedesktop.org/drm/intel/issues/7349.
> 
> Janusz Krzysztofik (3):
>   drm/i915: Fix timeout handling when retiring requests
>   drm/i915: Fix unintended submission flush after retire times out
>   drm/i915: Fix 0 return value from DMA fence wait on i915 requests

Based on some comments received, I'm going to rework this series and resubmit.  
Please ignore this one.

Thanks,
Janusz

> 
>  drivers/gpu/drm/i915/gt/intel_gt_requests.c | 19 +++++++++++++++----
>  drivers/gpu/drm/i915/i915_request.c         |  2 +-
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> 




