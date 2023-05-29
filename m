Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0EC7143F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE2GOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjE2GOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD7B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340855; x=1716876855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lZvg1L57BcoSEw3CqHyDTtH9MeFq1P/MjhjyoIG9cOk=;
  b=a2TAUepaXSB/fUm74HgmOqxRji0GG/eqXp4N7Z05TEgTg/r4NWk+UQnN
   sxZ5JMrjPYndaU2lLBwgr4K+wOtY1i8+URqfzj91LMOc+0DFprwRqvwZL
   worAsq9F85nrieVk4MrOiXmhVXLwt/ww5OHRg/bf1Gdjuoivm0SzHaK3P
   KJ1tmoORBuL5sg97/qpml70D8llJBicVbhz9yFiXbPzke8DbxRAng3/r3
   4CB80VVOvSUzWLjHzr4pJe+ds7x1jITW8RQMIdqW68/MWpCTRYBNADTn3
   YAeoYQYxjstIyz8DdjScxSD6nNegmF+Cu65M2wGe2TsRFC+U0jugMzbCC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881762"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036079969"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036079969"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:11 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH -V3 0/5] swap: cleanup get/put_swap_device() usage
Date:   Mon, 29 May 2023 14:13:50 +0800
Message-Id: <20230529061355.125791-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general rule to use a swap entry is as follows.

When we get a swap entry, if there aren't some other ways to prevent
swapoff, such as the folio in swap cache is locked, page table lock is
held, etc., the swap entry may become invalid because of swapoff.
Then, we need to enclose all swap related functions with
get_swap_device() and put_swap_device(), unless the swap functions
call get/put_swap_device() by themselves.

Based on the above rule, all get/put_swap_device() usage are checked
and cleaned up if necessary.

Changelogs:

V3:

- Fix build error in [2/5], Thanks David!

- Fix comments and patch description about the folio in swap cache, Thanks David!

- Collected reviewed-by.

V2:

- Split patch per David's comments.  Thanks!

Best Regards,
Huang, Ying
