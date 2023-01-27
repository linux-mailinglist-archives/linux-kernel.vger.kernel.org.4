Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB567DFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjA0JQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjA0JQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:16:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354B1E5C7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674810981; x=1706346981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZvGD9jJs3AQxKwOXh5YNYV0CIuV12BOFWOtoN/4oNE=;
  b=LpaLWd2jsPYrv4NIahuhp6d12v/zPRC3tWJ4OhoD2QlWO7eEm8jFebjd
   iuQFcQXyZzm0BJkcjvO9eD5WqI/VhVGkrvKv7OSHIqTiFlZjaQttKhsnL
   gS61MZqTL+S2SyEWxZiMG7lDhIOs8lia0G0HX1Phw61Je6GLLAHyEilcI
   gIHXuA7NhDsTIJU8kG/SwF5bEIeUM1RBoYh8FeV14Gdgz+COgbYHu3lR/
   SrwvWRhp2bEn7KeNBnYJBVoRcPCb19siK5WWZrhmm1H1og8mN0RQXHYLj
   h/OTnFU4IZvp0U9x17IDuxQVXiGJG+K2yBvgW17GGJKgzg9kcMlwqY0dy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391600468"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="391600468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:16:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751927452"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="751927452"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:16:18 -0800
Date:   Fri, 27 Jan 2023 10:16:16 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] accep/ivpu: PM: remove broken ivpu_dbg() statements
Message-ID: <20230127091616.GA837200@linux.intel.com>
References: <20230126163804.3648051-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126163804.3648051-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:37:54PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PM is disabled, the driver fails to build:
> 
> drivers/accel/ivpu/ivpu_pm.c: In function 'ivpu_rpm_get':
> drivers/accel/ivpu/ivpu_pm.c:240:84: error: 'struct dev_pm_info' has no member named 'usage_count'
>   240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
>       |                                                                                    ^
> include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
>   272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
>       |         ^~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
>   155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~
> drivers/accel/ivpu/ivpu_drv.h:65:17: note: in expansion of macro 'dev_dbg'
>    65 |                 dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
>       |                 ^~~~~~~
> drivers/accel/ivpu/ivpu_pm.c:240:9: note: in expansion of macro 'ivpu_dbg'
>   240 |         ivpu_dbg(vdev, RPM, "rpm_get count %d\n", atomic_read(&vdev->drm.dev->power.usage_count));
>       |         ^~~~~~~~
> 
> It would be possible to rework these statements to only conditionally print
> the reference counter, or to make the driver depend on CONFIG_PM, but my
> impression is that these are not actually needed at all if the driver generally
> works, or they could be put back when required. Just remove all four of these
> to make the driver build in all configurations.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
