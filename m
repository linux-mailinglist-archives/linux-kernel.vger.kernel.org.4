Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444D60C711
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiJYI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:58:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F73F6179;
        Tue, 25 Oct 2022 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666688325; x=1698224325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wobCzPymTGLVzVS8xvZoimtbG8thJgFTUNq5m2nYbf8=;
  b=DX0A2hmbJd6Y0GVRp/YAmFAWb9SBxsVoummfNRHb5sW8OhuiSHlL3uot
   tdzhk13bzIPOY907arjmmKrmjYega+BUwIEhOX8HHpM43VTYmSd+9HxLk
   xdHIeKilpplajrBkbFFKDtld3JymtVOGJk8aD5NZzfT9LZR/+y2yDVMps
   8r74ExbmHkkhxr7NCZpUooawI98aHPomtaDJHDnsy3GtyZn9WW6o1T3i5
   x17c+HrzdJRGX4MlQuWubHFcCKspyDniuCkrYWPClN52w9VkTNAY2dA9E
   kHQBAuCWdj2tbG8COvqUOtD5wYxjNhJosnpBOIdpAwb64t7YMuoybtytI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393941983"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="393941983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582704669"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="582704669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 01:58:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1onFld-001udB-05;
        Tue, 25 Oct 2022 11:58:37 +0300
Date:   Tue, 25 Oct 2022 11:58:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: Use flex_cpy() to check extent copying
Message-ID: <Y1elPIWqgyQIHz4n@smile.fi.intel.com>
References: <20221024171848.never.522-kees@kernel.org>
 <20221024172058.534477-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024172058.534477-2-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:20:58AM -0700, Kees Cook wrote:
> Use flex_cpy() instead of memcpy() to copy the bui_fmt flexible array
> structure, which will perform bounds checking internally. Avoids the
> false positive warning seen under FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 48) of single field "dst_bui_fmt" at fs/xfs/xfs_bmap_item.c:628 (size 16)

...

>  #include "xfs_error.h"
>  #include "xfs_log_priv.h"
>  #include "xfs_log_recover.h"

> +#include <linux/flex_array.h>

Wouldn't it be better to include it before any "local" headers?

-- 
With Best Regards,
Andy Shevchenko


