Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D16A8F99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCCDC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCCDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:02:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A485848B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677812541; x=1709348541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G3zRk1EKAJOu7vQd/yH73yVtZIFRGseFJ2N2fMBTDwk=;
  b=eWWOkUbd9fYAe+UzxGzhqTwexWZ03Cl+2dufO3fQzC1r3D4LZMSjEu94
   MeUYuQe09ctihaqawsXOEXT2EEYoMjL6QcSPKqBC9uSQugNrptExMjvPC
   v67Fzbm3+KCX3wU3Cwejj9YVcthlUAqJbrn9d1ispWvM4bhhBQ3mWHr6J
   0JhWiRveO5oIk5iBjedgcvkPFm9R1g4nvZFL9DAsJA7Tmd0Eliq69XBB0
   xAH4CCJELUD+EHE7556a9rk5xTsi/sOyTXapT5wYTvFUyyea9nOdop/cJ
   FPm/nbdhUWdBI8DClJp/3jqDquZnVgvY7ht7aET+ZMnKkqhrj6xgjF+4P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421207080"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="421207080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 19:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668497679"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="668497679"
Received: from xinyumao-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 19:02:17 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH -V2 0/3] migrate_pages: fix deadlock in batched synchronous migration
Date:   Fri,  3 Mar 2023 11:01:52 +0800
Message-Id: <20230303030155.160983-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two deadlock bugs were reported for the migrate_pages() batching
series.  Thanks Hugh and Pengfei.  Analysis shows that if we have
locked some other folios except the one we are migrating, it's not
safe in general to wait synchronously, for example, to wait the
writeback to complete or wait to lock the buffer head.

So 1/3 fixes the deadlock in a simple way, where the batching support
for the synchronous migration is disabled.  The change is
straightforward and easy to be understood.  While 3/3 re-introduce the
batching for synchronous migration via trying to migrate
asynchronously in batch optimistically, then fall back to migrate
synchronously one by one for fail-to-migrate folios.  Test shows that
this can restore the TLB flushing batching performance for synchronous
migration effectively.

Changelogs:

v2:

- Rebased on latest upstream.

- Restore the total retry number of synchronous migrations and removed
  "force" logic from migrate_folio_unmap().  Thanks Hugh!

- Revised some comments per Baolin's comment.  Thanks!

- Collected reviewed-by and tested-by.

Best Regards,
Huang, Ying
