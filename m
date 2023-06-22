Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB272739A85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFVIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFVIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:46:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969A1FEE;
        Thu, 22 Jun 2023 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687423485; x=1718959485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVdMj2T2ArMG74E0IdAmn+b3fPmyAwDXe/tmL1jqLRk=;
  b=EGiTiEycKjHhTJ81eD0xk6caggZRWF5tIcqA77i8ZZm/1oLHOM4bN8tb
   Gy3ZPNCIvBKYSJEuNxeka5mrHEE4rRv4CmF4CxWZSDmZ3pbyKgHibvjWw
   7GqOfsrsiXy0+XlAUGlz4+esWTSoeGi2E7Nfet+5VCXZSL5pDFHyYV5SQ
   FzjNwD71EL0aG7iBbjrLGEkBLPsRrI10Z66ndY/576MRxwTO23E2bKPDy
   92Zs26nZgtt5PEerFUQZZ9pM3XIYuJSRUGwqS2H+8+xvQOoMULlll/Y8w
   dTnjAGJpthazyEMU8h+VHDJQxyJqXAWoaNPdDFUKH4pNVK7REnQYnwH8h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="345161486"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="345161486"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 01:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804701317"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="804701317"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 01:44:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCFvJ-005ixr-1D;
        Thu, 22 Jun 2023 11:44:13 +0300
Date:   Thu, 22 Jun 2023 11:44:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
Message-ID: <ZJQJ3cCaHiwu8rVX@smile.fi.intel.com>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:20:04PM +0200, Armin Wolf wrote:
> Am 21.06.23 um 17:11 schrieb Andy Shevchenko:

...

> > -		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
> 
> just an idea: how about printing an error/debug message in case of an
> malformed GUID?  This could be useful when searching for typos in GUIDs used
> by WMI drivers.

Commented on that separately.

...

> Works on my Dell Inspiron 3505, so for this patch:
> Tested-by: Armin Wolf <W_Armin@gmx.de>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko


