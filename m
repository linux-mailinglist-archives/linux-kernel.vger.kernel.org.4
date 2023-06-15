Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A919731C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbjFOPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbjFOO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:59:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2AE295C;
        Thu, 15 Jun 2023 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686841196; x=1718377196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VVBSBvMBZGW873x3/L4ZC2+Q3Ba2pg7UCxEhgZGxqRY=;
  b=SmBADmU6KPajTO/u1p9JNhEKM3Gb1q+Dvi9hd6OQnVbCfUrDyuNS/RmL
   e2eylmHcMguTg+bPxMpqy/m+TRsyxbc4oGrSG7ljJ8DChVsDqJbiBsZf9
   GeTnJoAmcaD56n9uQ5okG37mIEO6i/GTooct8G9sbJZvRnop8DUnWpccJ
   Y7NfieGmLCWOhXvoAtJ6OmIGvftwe2I4Ic2WavITvbEMAjsi0kXQ0rOUA
   qbAunC6nHqowWQfRlxxhRCmgsbr3Xy+xu68BEgtawdVfSdsWFcd3Mud9L
   EPf7AxWtZ/fAT292yUQtYxA3U3friX5MXdkPCf6jvVc8HG8L7J+1coLJG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357811937"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="357811937"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:59:56 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745591843"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745591843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 07:59:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9oS0-003y45-1l;
        Thu, 15 Jun 2023 17:59:52 +0300
Date:   Thu, 15 Jun 2023 17:59:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 05:52:43PM +0300, Andy Shevchenko wrote:
> Insulate of_device_alloc() and of_amba_device_create() from possible
> changes to fwnode_handle implementation by using device_set_node()
> instead of open-coding dev->dev.fwnode assignments.

Side note. When I preparing this change I have noticed a lot of

	dev_set_name(... dev_name())

in the code which seems to me problematic in two ways:
1) (minor) the dev_set_name() may fail, no checks are there;
2) (major?) the above construction leaks memory.

Is it on purpose (esp. second point)? If no, can it be fixed?
Note, I'm not familiar with OF platform code, so I would help
reviewing the change, but that's it.

-- 
With Best Regards,
Andy Shevchenko


