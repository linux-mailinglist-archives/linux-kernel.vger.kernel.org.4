Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA46E3D73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDQC2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDQC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:28:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E061FEB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681698519; x=1713234519;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=k4gAZozd+Yrw3Ljl8MgCxDpqzd2X7xRSXq1bELURyF8=;
  b=TlXP7P0+/Ixh4KY0aYXJ9CnvJ4Zdy3V/BYA0n7OXzB2AInsImUN9SpSq
   7e3enYPyAgNAqYrmBocl1Im/l5PE4l7FYRR9EGY5rIpwiGjbi6w2qaDx4
   y2OiMJEmRpzP2hRZkxBwmhBGY8pHOiTAr8PM2jbvio5TDbTCksGHEQLJ1
   bK1Mvt6YTqlazcmpr6ztH24q3nsP1CKj+/sfGu5O3zRnFfa5SMpi7EoLk
   0OPflur2+cCzXeqmDFwCvhPzrjT5SgQqA5ZBbXDjkap91notr2EaKR5I/
   I6HxBop21GhiM2GD8p7+yQKexugLeDjCS/SiH4GKPqa7hRmhU/nrW2zX5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="431079190"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="431079190"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 19:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="667954169"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="667954169"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 19:28:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rename reclaim_pages() to reclaim_folios()
References: <20230415092716.61970-1-wangkefeng.wang@huawei.com>
        <ZDrK9R9wLlfrUWMZ@casper.infradead.org>
Date:   Mon, 17 Apr 2023 10:27:12 +0800
In-Reply-To: <ZDrK9R9wLlfrUWMZ@casper.infradead.org> (Matthew Wilcox's message
        of "Sat, 15 Apr 2023 17:04:05 +0100")
Message-ID: <87a5z7w8e7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Apr 15, 2023 at 05:27:16PM +0800, Kefeng Wang wrote:
>> As commit a83f0551f496 ("mm/vmscan: convert reclaim_pages() to use
>> a folio") changes the arg from page_list to folio_list, but not
>> the defination, let's correct it and rename it to reclaim_folios too.
>
> I didn't bother.  It's not inaccurate; we're reclaiming the pages
> in the folios.

What's the general rule about renaming "pages" to "folios" in function
names?  I am thinking whether it's necessary to rename migrate_pages()
to migrate_folios().  It's unnecessary?

Best Regards,
Huang, Ying
