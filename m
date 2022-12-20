Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF60651A98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLTGUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLTGUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:20:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A591054D;
        Mon, 19 Dec 2022 22:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671517221; x=1703053221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lty/LQWZY8a0ZJJO2Q3wb0rYMLNUUXK5pjrli1f2HuA=;
  b=I4IUit2UsHgXT9V/baLuSu6OOFD4XqgiO1zJXRU/jsGqhagBkOl2nuQL
   WY1DdBVKmCu80mxbpVXrMUiW4HVstRoK06si0e5ka6vMvJNuQT6iTj6QI
   RYeKCQ9WlR+TB2O6LqcZLn2oXKi6IYMDkowanKPxL3WG+ELZ8dfxzN/7M
   bDL3JCSe6+2+02Chko+6KoYxX/Xg0FwPyIP09h4WhnDi4fbXjIz/YrO8i
   S/KVX8EaM+2Fk69oBXnsjIhcZXzmHp92+dV3S1kDhAipAVGvtq4+LQilu
   yRdJ5CbwKaol9PT72Y9kfdAlPH+ck8v66NYcw3jfVRnPj+zu833Mk0S18
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="381763497"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="381763497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 22:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="681511635"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="681511635"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 22:20:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EBF28F7; Tue, 20 Dec 2022 08:20:31 +0200 (EET)
Date:   Tue, 20 Dec 2022 08:20:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/8] pinctrl: Introduce struct pinfunction and
 PINCTRL_PINFUNCTION() macro
Message-ID: <Y6FULyRF4IxdtGoG@black.fi.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
 <Y6B4YZZW0GS/2kDV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6B4YZZW0GS/2kDV@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:42:41PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 02:42:33PM +0200, Andy Shevchenko wrote:
> > There are many pin control drivers define their own data type for
> > pin function representation which is the same or embed the same data
> > as newly introduced one. Provide the data type and convenient macro
> > for all pin control drivers.
> 
> The stats for the entire series:
> 
> drivers/pinctrl/intel/pinctrl-baytrail.c   | 10 +++++-----
> drivers/pinctrl/intel/pinctrl-cherryview.c |  6 +++---
> drivers/pinctrl/intel/pinctrl-intel.c      |  6 +++---
> drivers/pinctrl/intel/pinctrl-intel.h      | 16 +++++-----------
> drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  8 ++++----
> drivers/pinctrl/intel/pinctrl-merrifield.c |  6 +++---
> drivers/pinctrl/intel/pinctrl-moorefield.c |  6 +++---
> include/linux/pinctrl/pinctrl.h            | 20 ++++++++++++++++++++
> 8 files changed, 46 insertions(+), 32 deletions(-)

Thanks!

For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
