Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78AA5E6BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiIVTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiIVTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:46:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9310BB1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663876012; x=1695412012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CRIm3bvGTl6E2GyZwdHdv1SQnq73SIXScDS+be11evo=;
  b=A4jQ+mllCZVaCerEmk2yaAfumKKPvSRHGffKmsJN9mfiu2fxuP9siZ5H
   EZCFmyMFz5As9wNWoePKlF3kaRp/cWM+EZ3yUbQnHGHW2wsy6+K2uTaCi
   BhVwYUj1yZ33Gnb5UH2yTgkrb6OtfVPhIwEz9q3geC9maE5X75YxLnE6T
   TLL06ds3JlrD5D5AWxhFCV/yfe6/elsfLkSMmCW+h7o8kzYTkgIzk1Ia1
   Fvxl1X1I3e23NTHiHfB9XkAXr1EMLiqxRgnMFRqfeY+Zy2zvOfzfvs3Yc
   5Wgz78N5VHGzDhPJheoNWeFzy9A2DxCLO34U99dFf9vOBu4R/sk1Use1t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283501319"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283501319"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688450399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 12:46:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obS9p-006BDJ-0m;
        Thu, 22 Sep 2022 22:46:49 +0300
Date:   Thu, 22 Sep 2022 22:46:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v1 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Message-ID: <Yyy7qPXmIrL2TraY@smile.fi.intel.com>
References: <20220922193447.88123-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922193447.88123-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:34:47PM +0300, Andy Shevchenko wrote:
> Currently the approximation is used which wastes the more memory
> the more CPUs are present on the system. Proposed change calculates
> the exact maximum needed in the worst case:
> 
>   NR_CPUS	old		new
>   -------	---		---
>   1 .. 1860	4096		4096
>   ...		...		...
>   2*4096	28672		19925
>   4*4096	57344		43597
>   8*4096	114688		92749
>   16*4096	229376		191053
>   32*4096	458752		403197
>   64*4096	917504		861949
>   128*4096	1835008		1779453
>   256*4096	3670016		3670016
> 
> Under the hood the reccurent formula is being used:
>   (5 - 0) * 2 +
>     (50 - 5) * 3 +
>       (500 - 50) * 4 +
>         (5000 - 500) * 5 +
>           ...
>             (X[i] - X[i-1]) * i
> 
> which allows to count the exact maximum length in the worst case,
> i.e. when each second CPU is being listed. For less than 1861 and
> more than 1 million CPUs the old is being used.

Scratch this because for the range 1171..1860 the new is better,
I'll update commit message and comment in v2 sending soon.

-- 
With Best Regards,
Andy Shevchenko


