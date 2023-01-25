Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97D67B5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjAYPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjAYPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:21:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68C18AA8;
        Wed, 25 Jan 2023 07:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674660113; x=1706196113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wK3p8oOR9HlAtXRXux6KGj539I6sXbcsgCvp9ZNibfE=;
  b=EQxme39ZAQy07Jr8nr1e3BuAh0m0vmWpSm9l3mptGDvW9DJYabb1AM6I
   kKe8br9qXIp9y+Kt0N6KETBEKKJsb4A9KvvetBrW301qgN3IexZT7eDWm
   m4wg90VhVvgF8zC3/CqxsRFuSGu02USMmhshdjS2UVs5KqzunGf0aCCHB
   yGls6pgYeutJLEsWYFcL2e4LejIi2yn9oA3v5Kw0utYU5fS8regpfvRGU
   uprYVLqs80Zw7OTixwJgUIhysulVFr9pY57fNaGlxcSwINyUf8mdsERyg
   C8AVbIAkOFlZIKCbcPHE1gX7EgEtnnv9nWvpZBWpgz3CIRVsOspqfbOQF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="412811035"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="412811035"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="612455983"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="612455983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 07:21:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKhau-00Eupa-2F;
        Wed, 25 Jan 2023 17:21:48 +0200
Date:   Wed, 25 Jan 2023 17:21:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 2/3] ACPI: utils: Add
 acpi_get_first_match_physical_node()
Message-ID: <Y9FJDFgdLYN2hpl4@smile.fi.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <20230123171006.58274-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171006.58274-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:10:05PM +0200, Andy Shevchenko wrote:
> There are drivers that are using a logic that is combined in the offered
> acpi_get_first_match_physical_node(). The rationale to have this helper
> not only redunction of the lines of code, but improving the robustness
> by properly handling the reference counters on the error paths.

After rebasing on top of the latest code base (with Hans' patches included) I
checked the users of similar code flow and found that there is no sense to
provide this helper now. It's only one user for this API as is, otherwise it
needs an access to struct acpi_device, which the proposed API doesn't provide.

Hence, self-NAK.

-- 
With Best Regards,
Andy Shevchenko


