Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B763C50F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiK2QYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiK2QYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:24:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE85F85C;
        Tue, 29 Nov 2022 08:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739071; x=1701275071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5q6aJCFVWUP0NkYQCOW+dWlUYCqc3lUwB5q4NpyiI3A=;
  b=gyWKpXq3suxabw+XePH6LJ6Nx6z73AyYqK/nGtTCIDn31ANXfUuUb5ak
   cEEXT/qJ6BdagyTGQ3MB+HJMHK3Q7fbCoZSpYERNonej5u/yCqsic6NlR
   d58lVh27yXKnmBTicGt2EmH+7++7TzU8bSdPF+k58EkXnMJkaXKkWxPdh
   Eo5GXqdVMkfyU9udTHAkEcgnoI/4HipsfoqeMF0zsyPvy9M4pnAoiT1LY
   9sKq0YL0S0nm+DrGsBK8fGKB5Fta0Za3QlQYqYS4Rpueci1vacZvbkIA6
   Xxc2fEkpLfKm6rZ3GusyHj+yG6CtnUpdAZYMG2qBcoll02u9uxrRk/kBb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="313853657"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="313853657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818271271"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="818271271"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2022 08:24:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03PG-001mbK-03;
        Tue, 29 Nov 2022 18:24:26 +0200
Date:   Tue, 29 Nov 2022 18:24:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ads7846: always set last command to PWRDOWN
Message-ID: <Y4YyOUsnFWzk//Dl@smile.fi.intel.com>
References: <20221129151959.26052-1-l.ellero@asem.it>
 <20221129151959.26052-3-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129151959.26052-3-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:19:58PM +0100, Luca Ellero wrote:
> Controllers that report pressure (e.g. ADS7846) use 5 commands and the
> correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.
> 
> Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
> commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
> the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.

Besides the same comments as per patch 1...

> This patch fixes it.

"Fix this by..." (finish this with the correct wording).


-- 
With Best Regards,
Andy Shevchenko


