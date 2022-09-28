Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45B5EDF05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiI1OnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiI1OnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8EAED91;
        Wed, 28 Sep 2022 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664376193; x=1695912193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XzQ8pnmeP2qSNXN417/XXU2Y2eIwv3syoJcPNFYPRxI=;
  b=Sjw05Y6gog7U/Wa4zsZPePOl+AsjaZpCU0r0m5E3AfSwz816YD5bcE9p
   tio0WMJYWPPBSlr0A0dS7ipdF69cdK0a2QCUcbU3569LFetV88fw1CAx8
   auKBSnXutBljkMGNb4TlZU8gncF+ihC/HB0/gQaJVosFQYpnE4okZBgFt
   Q4PhkvQ+11z8BKDOdgF/F4D4jKxzYDif5eMXb39nhOub89xGbsT6ctC2j
   iV4/tC6Cbsu44aStzlev5F77PWO10QVOVFGkYQFKJfgdCiFPZmRMPSGKm
   ieGW7LeL+L9gsL1p7NlrbxKb4Qb1S2VaMSV0PKXx4yYvNlE5vWbe9YPJy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="365665188"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="365665188"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="747452867"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="747452867"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2022 07:43:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odYHE-008yAq-0Q;
        Wed, 28 Sep 2022 17:43:08 +0300
Date:   Wed, 28 Sep 2022 17:43:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] pwm: lpss: Make use of bits.h macros for all masks
Message-ID: <YzRde5PuFnL5KbrC@smile.fi.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
 <20220927162421.11052-7-andriy.shevchenko@linux.intel.com>
 <YzRYPvzWFBXijIBQ@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRYPvzWFBXijIBQ@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:20:46PM +0200, Thierry Reding wrote:
> On Tue, Sep 27, 2022 at 07:24:20PM +0300, Andy Shevchenko wrote:
> > Make use of the GENMASK() (far less error-prone, far more concise).
> 
> Very subjective.

See an example why not: 0a90ed8d0cfa ("platform/x86: pmc_atom: Fix SLP_TYPx
bitfield mask").

-- 
With Best Regards,
Andy Shevchenko


