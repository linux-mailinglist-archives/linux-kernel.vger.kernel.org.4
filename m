Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B21637FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKXTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKXTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:36:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CA82235
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669318574; x=1700854574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C8l6VkDUAjQEQdg9zyM7mPOQgK66sCV8qL/BSSTOXpQ=;
  b=QgclNOMnbzqCzXTqAVEUWzZIgp5WVgD6FK25nNleq3INaJWCuPHo5Fq7
   T2/QMbULybAGUA4OxvnXJSAhymKC4swwurT8fxQ0bx0W/cBOxR/9w24Wz
   2wEgRP5tqHJBNUbtjRUbLjKCZbhOlJP7Wm4f8O4mq63swQ0StQryolnYd
   z60MzDVlF/d2IvMWzgpn91d4maIyxbQSY/0kPPLaDE/7pMbKAJU3zJ/Dt
   vN+lULeY4gcoxWjvPmxjUlmLVSOjgJVh2Buc/JoQtvPIboMh7Vxgd3o6o
   bZ/m99uLC6YgGJympDL9ryVgkGi3nwPFa3RjicBaZdbnWGSY5pNtKtfhx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="301920621"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="301920621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 11:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="673330855"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="673330855"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 24 Nov 2022 11:36:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyI13-00GvS6-2B;
        Thu, 24 Nov 2022 21:36:09 +0200
Date:   Thu, 24 Nov 2022 21:36:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kirill@shutemov.name, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        martin.petersen@oracle.com, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/mm: Fix sparse warnings in untagged_ptr()
Message-ID: <Y3/HqcdjLI2QQMTC@smile.fi.intel.com>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
 <20221116004353.15052-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116004353.15052-3-kirill.shutemov@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:43:53AM +0300, Kirill A. Shutemov wrote:
> Linear Address Masking patchset triggered a lot of sparse warnings.
> 
> The root cause is that casting pointer to '__typeof__(*(ptr)) *' will
> strip all sparse tags. The type has to be defined based on the pointer
> type, not based on what the pointer points to.
> 
> Fix cast in untagged_ptr() and avoid __typeof__() usage in
> get/put_user().

Without this patch we have

drivers/auxdisplay/charlcd.c:482:21: warning: incorrect type in assignment (different address spaces)
drivers/auxdisplay/charlcd.c:482:21:    expected char const [noderef] __user *__ptr_clean
drivers/auxdisplay/charlcd.c:482:21:    got char const *

So,

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can we have this series applied, please?

-- 
With Best Regards,
Andy Shevchenko


