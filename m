Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B3601795
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJQT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiJQT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54414D3F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666034757; x=1697570757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3+6DO9VeA7V5TPow8roEb4hbTgWNZlyynBDjtIDpAx4=;
  b=NjDIT2jjsmgl0S8NLBNKqwp7CfiZdnP2zXbMtV/EVBuE1FRwI6iyGOfE
   x804kHbj6cPARYtiigoABXLPRaNXjHRmV+kxMyxKc3QM3W46yhe3INUB/
   xc+BDFsMDcldD88rrUyNNs9cAzKSVXq2ImzSOEjHED5LpRy1jlN5QcPf4
   8VHkIMrxIFPmHI8Wf40yzGpE/hIaDnaRHSDeC06lMFAWZxn5kQ7g7noey
   CSbPGg3M/GkXp3qwEAhm+6IUqu1z99uze+MCG2KLPYamQaPVN0ShqWiPN
   PATXNXyJqCmNjyyLImUUFwsoMzwEnjxrcDp+r7d9jNSLf4KN9EPl2z0AU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285620003"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="285620003"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 12:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753747752"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="753747752"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 12:25:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okVjU-0090T2-1J;
        Mon, 17 Oct 2022 22:25:04 +0300
Date:   Mon, 17 Oct 2022 22:25:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y02sENwhtpsx5yhP@smile.fi.intel.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017191611.2577466-1-jane.chu@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:16:11PM -0600, Jane Chu wrote:
> While debugging a separate issue, it was found that an invalid string
> pointer could very well contain a non-canical address, such as
> 0x7665645f63616465. In that case, this line of defense isn't enough
> to protect the kernel from crashing due to general protection fault
> 
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                 return "(efault)";
> 
> So instead, use kern_addr_valid() to validate the string pointer.

How did you check that value of the (invalid string) pointer?


-- 
With Best Regards,
Andy Shevchenko


