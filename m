Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470A70B5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjEVHK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjEVHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768310C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739374; x=1716275374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=na5mcQ5pzQRlV4B5n8k09Kfb5lJnl8hyX0HKXBlJC28=;
  b=jjggRhZvuel/bIu8iH4107sFWndHjI7DrKXdDQM7LbLVo4WxTdamCfKq
   h7dm9XfC7QyhBJNbJZUCvbxMHwCX/bqCn63tXpnHP4eCL4O4PrYTpq63t
   i9WpeTMs7/ssliHEFp6OXdCLY3oQB3aXate28Hd9SR31OzPl5GrSc7omw
   XyzZCEScLbaO6dSiiu65/iIKtHO3HR9Xp7rCgzkg1Cf6M118D9hAmeLZh
   nS+t9BSBOzJHpPMcwmQ+e6Hs/P99fuUeKyp1sNP4fJhhqMF0tZh7n8Db0
   gWzEwO07ykaShA8+OIqtWjkcxLwIJoBKKmBHscThR8C66dNHkpvNeRscF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337436956"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337436956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212660"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212660"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:19 -0700
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
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH -V2 0/5] swap: cleanup get/put_swap_device() usage
Date:   Mon, 22 May 2023 15:09:00 +0800
Message-Id: <20230522070905.16773-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general rule to use a swap entry is as follows.

When we get a swap entry, if there isn't some other way to prevent
swapoff, such as page lock for swap cache, page table lock, etc., the
swap entry may become invalid because of swapoff.  Then, we need to
enclose all swap related functions with get_swap_device() and
put_swap_device(), unless the swap functions call
get/put_swap_device() by themselves.

Based on the above rule, all get/put_swap_device() usage are checked
and cleaned up if necessary.

Changelogs:

v2:

- Split patch per David's comments.  Thanks!

Best Regards,
Huang, Ying
