Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026345B77FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiIMRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiIMRaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:30:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697A5E66D;
        Tue, 13 Sep 2022 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663085948; x=1694621948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fDsTr/VS50WDRqnrfx9yjLzSOH6gbA7stGJu/++JKx8=;
  b=Dh+5un702XtY/RRgRItjl19L7fFUc+rUDaFTK8CQIxQEACVfYAE5pDxH
   y8l5qYSaIvHIqpryyg8NScCNamqDUZhBC1I3uoBkS6HhzKwAetXugBCZf
   KQ8D3JJ4SlV7NYJNOhCPmpT9K+vncYuiyyrKOqaZpEH9HBEdP9Xh1658n
   wY+3JBDdT5tKEaK9Dr0+hcjFofDxR6YPUqIJbUSD58juSUjdUJsrKPyVa
   VEPNgnGHgQYCSuqRVJBmnDQHFCt/pkfdCR3/hOTmIf13Rc/Qp46aT3vV5
   1A5XYzzHxBOPDh+6InssbViS0028EUO3Ux2koQFCj+k0duknkBpa3nyDG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285204175"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="285204175"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:19:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="618976598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:19:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oY8cp-001pvQ-2I;
        Tue, 13 Sep 2022 19:19:03 +0300
Date:   Tue, 13 Sep 2022 19:19:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] gpio: 104-idio-16: Utilize the idio-16 GPIO library
Message-ID: <YyCtdw14JijxsEQ4@smile.fi.intel.com>
References: <cover.1662927941.git.william.gray@linaro.org>
 <6f8b7d379a83e1509ec790bbaf0a9e15fdf26180.1662927941.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8b7d379a83e1509ec790bbaf0a9e15fdf26180.1662927941.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 04:34:39PM -0400, William Breathitt Gray wrote:
> The ACCES 104-IDIO-16 device is part of the ACCES IDIO-16 family, so the
> idio-16 GPIO library module is selected and utilized to consolidate
> code.

> +	/* Reading output signals is not supported */
> +	if (offset < IDIO_16_NOUT)
>  		return -EINVAL;

I see it's in the original code, but isn't it possible to cache and return
cached value in such cases?

-- 
With Best Regards,
Andy Shevchenko


