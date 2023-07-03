Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC57745F77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGCPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:08:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDFBC;
        Mon,  3 Jul 2023 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688396918; x=1719932918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6iC3YuHe8rC5QwgP5+XpkMFQ2vyYYdvadondVp+quNw=;
  b=eAu9v1cxR3+EOtv1W7PXDc+txBXgde67b5iQCzvBc1bri9swGmDq7Tq+
   eSxNQxV1+xf00X9bTpd1ON13Z2nmVyRK0+DJ3ZXt+sdGl/SzhSWBOMmoA
   GXHx81acuWZdslQHMdbPBCv4RoWKzmWq/Q1dCQGp/LGBJeKQ4pPxANhip
   i2ER7aBOQBAlPZfXqf6BiNWbSKIT7iyGZNq9tBgENHJe/nzhGtWbY48FR
   N5oVKkaNxWEsKhPcZVZ61lAJHcDbEz//EctgNNoZgJWLJpTjoQxuDcQtl
   QUTSDSwWr4ub0irze+avalqpdXSqhGdDpy+LY5O3X+tpYl2LdVITluyyT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393645900"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393645900"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721809950"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721809950"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 08:08:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGLAH-001tW4-2e;
        Mon, 03 Jul 2023 18:08:33 +0300
Date:   Mon, 3 Jul 2023 18:08:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 1/2] docs: printk-formats: Fix hex printing of signed
 values
Message-ID: <ZKLkcWyY35OK/ZTw@smile.fi.intel.com>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:58:38PM +0300, Andy Shevchenko wrote:
> The commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]") obviously missed the point of sign
> promotion for the signed values lesser than int. In such case %x prints
> not the same as %h[h]x. Restore back those specifiers for the signed hex
> cases.

FWIW, currently we luckily have only one ABI case
drivers/power/supply/bq24190_charger.c:466
which luckily uses unsigned value for that specifier.

The rest is debug and error messages along with tracepoints.
The tracepoints might have an undesired, but not critical,
deviation. Nevertheless, promoting sign for hex values seems
to me the wrong suggestion.

-- 
With Best Regards,
Andy Shevchenko


