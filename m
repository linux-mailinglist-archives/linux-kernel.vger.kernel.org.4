Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F05F0C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiI3Nle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI3Nla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:41:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE01311D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664545289; x=1696081289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bumirpj6GVJkj3t2hFSzwj6RxfG0Tjmrh1oye2eeS9s=;
  b=fQ2EIiiB4mdJDVcWa+PGBJYiqJ0vWHJwt3f3na85bE7Wg+dDu4mG+7rM
   +h1OLtZu5P5uJi0em0Qc7a2T6rz+9mHChDg82YF8psxJDwXBmuFMDl7En
   iFPZBQJIa8YUTlz58foLfTt8T9H4BiHK/VpyMstfLalogwnbwrMEnxBaE
   vgDfHW6GbEfgJtzENqzXKjoEhuwvIwtUtbyioV+W1RvRLbo9hVTrZolbB
   Xo+sjsu8fukQg5daNfwb4NLd/kwrZ3Pb0I6yZkGEUNPglV6giU9nMNbFu
   3yHSZxTFrOMsx147ZpF8FNR5K64Cavqu3bztQSnC0i/rZNRZpvtRR+n6x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="303103138"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303103138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 06:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="765133454"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="765133454"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2022 06:41:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oeGGb-000WmK-0P;
        Fri, 30 Sep 2022 16:41:25 +0300
Date:   Fri, 30 Sep 2022 16:41:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <YzbyBA9uJUL/a32P@smile.fi.intel.com>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:10:50PM +0200, Uwe Kleine-König wrote:
> For code that emits a string representing a usual return value it's
> convenient to have a 0 result in a string representation of success
> instead of "00000000".

This is a controversial change. For APIs that comes to my mind it means
"OPTIONAL resource NOT FOUND, while no error happened". Doe it mean success?
I don't think so.

> A usecase is tracing where the return value of a callback is emitted,
> see
> https://lore.kernel.org/linux-pwm/20220916151506.298488-2-u.kleine-koenig@pengutronix.de
> for an example.

-- 
With Best Regards,
Andy Shevchenko


