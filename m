Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054AE619ED9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKDRfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiKDRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:35:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674B4199B;
        Fri,  4 Nov 2022 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667583310; x=1699119310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uP1tPIt8qHBfLh5QZxt54aNl5/XGep4lzBteyD9eTF0=;
  b=gaX6MQlFKeg0rutqUde/MxtU/fULJcDpc4hPcQzg1L3mOdXCQI2PtIHC
   G9RaM6k8zKuk5YJVMjmh4sfm/xp1n4rqFMM/kxDWMKDHiq7yYgBV3SdbJ
   dTS5Ehqxek48BZgoaRwCIsKHzQsa2UExq8+5WWixNWfv4+GyzPzhKF3Lj
   mEL1xQmHGr1L21liQNcvlX2upxPwy66hCrWn35W73NDrksrbAfj1L5m8g
   5CiO+g4mQ//iJ0ZwnFxYuTEeAFbNF0N1kILaA9RbnbB3RV0sYvVcbQ3jU
   YKk8SomE3s8B6i8G52umabMxXmmZ/2wAFpEtrErn/aN5Zqqj4or1vIvD+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="308735762"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="308735762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="586256983"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="586256983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2022 10:35:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or0aw-007TBI-06;
        Fri, 04 Nov 2022 19:35:06 +0200
Date:   Fri, 4 Nov 2022 19:35:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] device property: Get rid of
 __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Message-ID: <Y2VNSXKPLYvaGkp3@smile.fi.intel.com>
References: <20221104154849.35177-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104154849.35177-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 05:48:48PM +0200, Andy Shevchenko wrote:
> First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
> Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
> to the data layout. It's more understandable when the data structure
> is placed explicitly. That said, get rid of those macros by replacing
> them with the existing helper and explicit data structure layout.

...

> +(struct property_entry) {						\
> +	.name = _name_,							\
> +	.length = (_len_) * sizeof(struct software_node_ref_args),	\
> +	.type = DEV_PROP_##_Type_,					\

> +	.pointer = _val_,						\

While waiting for the comments, I have noticed missed {} here. I haven't
checked if gcc 5.1 still requires that, but in any case that should be matter
of a separate patch (to drop {} for anonymous union members initialization).

That said, v2 will occur if no serious objection is provided.

> +}

-- 
With Best Regards,
Andy Shevchenko


