Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104D724723
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjFFPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjFFPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:00:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5254F199A;
        Tue,  6 Jun 2023 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063632; x=1717599632;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=Wlt2kIy2P85sLJKYJcYLugIw7E4/N60edZHtxt3m85U=;
  b=GRl5JEmaL42TojDnT2ogGotMuBqFe2i+QXkA5R9q2NaqeVo2eLzKrx/w
   WLr6dr2+veTEFt/AdiAfJypKIaw0yOIaJ6Uk6uIw5vRnE4HKgdZO21fxx
   nOKg91idLQ8Jh2s/sLRTbrEyWRlB1z5wd1nfiQq1Rqd+ym+vfal0e8EfB
   2LyNEJt+iUD/JKzznCqUidNs/jv2zsQSRxKE5iZOAVaWi7gJSWOl2C8yR
   ja08Qabfk3HjLeuyCB5BJ0WjdYA9Efzgt+6p8u07urMAzV5YxWTN4c0IT
   IyiY64WMD2oOC6DfuqMbUjeNonhYQfAaqrLd7EcdHVxKLtHMLBbffiPDp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337052481"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337052481"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955791278"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955791278"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2023 07:58:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y8q-001gP3-1g;
        Tue, 06 Jun 2023 17:58:36 +0300
Date:   Tue, 6 Jun 2023 17:58:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] pktdvd: Clean up the driver
Message-ID: <ZH9JnPAL8x2GPSV3@smile.fi.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 06:45:40PM +0200, Andy Shevchenko wrote:
> Some cleanups to the recently resurrected driver.

Anybody to pick this up, please?

> v2:
> - added tags (Greg)
> 
> Andy Shevchenko (9):
>   pktcdvd: Get rid of custom printing macros
>   pktcdvd: replace sscanf() by kstrtoul()
>   pktcdvd: use sysfs_emit() to instead of scnprintf()
>   pktcdvd: Get rid of pkt_seq_show() forward declaration
>   pktcdvd: Drop redundant castings for sector_t
>   pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
>   pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
>   pktcdvd: Get rid of redundant 'else'
>   pktcdvd: Sort headers
> 
>  drivers/block/pktcdvd.c      | 525 +++++++++++++++++------------------
>  include/linux/pktcdvd.h      |   1 -
>  include/uapi/linux/pktcdvd.h |   1 +
>  3 files changed, 257 insertions(+), 270 deletions(-)
> 
> -- 
> 2.39.1
> 

-- 
With Best Regards,
Andy Shevchenko


