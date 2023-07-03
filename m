Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD8745A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGCKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGCKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:51:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D9B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688381463; x=1719917463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BadCQA6HO8laQVNoZwiU3/nTxzC9qflmlgQcwaZtETA=;
  b=HxqdE4B3KjUHccP/jfqljpQZ6FvO/UAV4jEOvKQZTpBtIgwWkkwVkRIG
   5TAzIOceOS8lehg+0FkDjE+g44dSa4iVAuXwdzMjeqiDokrO71nkslaYK
   MM9wpJJ+O3Xhvxnr4qynnJceKyps7jy59E1HnVFM0JAsYcD4+jZerwdRP
   SIsx0ZIzQOOal4LE/NJPSqypYG5yVDJYT2KZtRNJmGgFd7fQgGw13BbBe
   O/5XhTOwzCbnySM7Y4xxHVnTi+Dk/LlWWiUYN85/JX7QRwAhG7Cpvnn9L
   EydKLo46dVLkpBzHinUbeM8YMjmXHzu3izp3SA1+6f2s1EjvLnr5vaOlY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366335268"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366335268"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="808529347"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="808529347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 03:51:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGH90-001qCc-2e;
        Mon, 03 Jul 2023 13:50:58 +0300
Date:   Mon, 3 Jul 2023 13:50:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Message-ID: <ZKKoEv9V6bTJQy7u@smile.fi.intel.com>
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:33:42PM +0300, Andy Shevchenko wrote:
> We don't need to traverse over the entire string and replace
> occurrences of a character with '\0'. The first match will
> suffice. Hence, replace strreplace() with strchrnul().

Not that it's a hot path, the bloat-o-meter shows +6 bytes on x86_64,
the change seems has no added value, self-rejected.

-- 
With Best Regards,
Andy Shevchenko


