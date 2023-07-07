Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAE74AC71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjGGIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjGGIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:03:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C64171D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688717019; x=1720253019;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=zeZySM/P+hW8gCRTMIgHwOEaGeKA9fS+25kTtwVY72I=;
  b=On/TLSeISB6HYNRY+ayDvvRHmodI6OYmC/iZzrpMexgcVYjWAaWqMXyF
   byDGTTCtQ20maieLF605oB04T6sI8lvOb6n0GV0JG+PUcqxcsPruEDyg/
   GBRwFVJa6IM3aYkDmPmeM4nWFuic24I2BF7UN9vO9kc4QcMyl+A9N3CSq
   Xvl92phyRhMAXaZY2fcPPx4OH3ZTGsJudeGHcOJmTJMZk5Y6hHaUvA5VS
   jt+uDEUhrqpytK7R2r3gU5OxRQkJd6BvF/VxYoVbCwoT7OX6Jy503GZEf
   LxSkITpnoUakU+fiU0vj8oyS/OcdPKE6DiS8xzg4OEC/10aYRNgMnL+S+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362700206"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="362700206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="966555855"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="966555855"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:03:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
        <20230703135330.1865927-5-ryan.roberts@arm.com>
Date:   Fri, 07 Jul 2023 16:01:45 +0800
In-Reply-To: <20230703135330.1865927-5-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Mon, 3 Jul 2023 14:53:29 +0100")
Message-ID: <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> allocated in large folios of a specified order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.

I likes the idea to share as much code as possible between large
(anonymous) folio and THP.  Finally, THP becomes just a special kind of
large folio.

Although we can use smaller page order for FLEXIBLE_THP, it's hard to
avoid internal fragmentation completely.  So, I think that finally we
will need to provide a mechanism for the users to opt out, e.g.,
something like "always madvise never" via
/sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
a good idea to reuse the existing interface of THP.

Best Regards,
Huang, Ying
