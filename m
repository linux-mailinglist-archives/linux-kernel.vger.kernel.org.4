Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2864E66676C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjALAKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjALAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:10:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D36217
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673482251; x=1705018251;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=B8OHqQ46jqRFh4OZ3XyIpP2Or7E8kRK1cFUxRIB4a/M=;
  b=RFOeb6HgIjo55rbGrW7SlWf+y0fnKjTHji+D9//8+ru39bLrYfxZ5YUE
   rf5erOAHO0n+QZiCZLBmZoABUlc4B9MX4B0FBfv62H2uSXtBzOo+gJCah
   fbBWWrzO4TU8sav5OLSrkG28wuoZRdpJS0Yc2yrG0t14svSs/5D7DfXsj
   z9TTc7jYZup+7Fo1Ei6snCWLRHYIwttRrI3fIXwNkFTW7mXa1a1RFbDCn
   Nq95wl2R31LMm6CKR6N1flQsxa0aGmsEk2k+UrZt6TTbEVl4CYp4IbQ40
   ju18Vx7JIqVxhSzUtc5ZNCgCu4MSwEZa2ExssBJff2yysuKZtGJlLdlkY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307094911"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307094911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:10:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="688135417"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="688135417"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:10:45 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
References: <20230110075327.590514-1-ying.huang@intel.com>
        <Y74WsWCFGh2wFGji@monkey> <Y782h7t10uRVW0RC@monkey>
Date:   Thu, 12 Jan 2023 08:09:42 +0800
In-Reply-To: <Y782h7t10uRVW0RC@monkey> (Mike Kravetz's message of "Wed, 11 Jan
        2023 14:21:59 -0800")
Message-ID: <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 01/10/23 17:53, Mike Kravetz wrote:
>> Just saw the following easily reproducible issue on next-20230110.  Have not
>> verified it is related to/caused by this series, but it looks suspicious.
>
> Verified this is caused by the series,
>
> 734cbddcfe72 migrate_pages: organize stats with struct migrate_pages_stats
> to
> 323b933ba062 migrate_pages: batch flushing TLB
>
> in linux-next.

Thanks for reporting.

I tried this yesterday (next-20230111), but failed to reproduce it.  Can
you share your kernel config?  Is there any other setup needed?

BTW: can you bisect to one specific commit which causes the bug in the
series?

Best Regards,
Huang, Ying
