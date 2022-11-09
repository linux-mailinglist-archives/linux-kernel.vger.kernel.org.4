Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C162214D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKIBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:24:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65E5E9ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667957041; x=1699493041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0TMMNcHvMTwfWl9Wm/AU82DRQX/a8ASBVMfhyIlRsiA=;
  b=hCekdBABpYTTwvfS0uZPF3cycWm+pduTy6Onj89hEgPjfciE/1ae6Zpx
   LSQ8l8tU+PHhA32kd769o/dIV3eeTUkjwr4VY3f92hwbYEDgjNnH1uo63
   cxhyMmbuUUkHASu9bSYhCjg8SPtulDnQOz4dGZ/R08WFwytvjw+QYv37T
   as/jihhBg82H7EheK67t8t3Zy2SYKa7LnA5Q0W7rRpchhENsrLEO6PgbZ
   W/5Q+QcGzc05GKPkVlkzs5ubffKYe1CcntK2eAM0YnIf2eHid9cxRQE0B
   Z5pnVmY8v7mLYo4jdkus68z2Aw68qvlN3ztLe+ahgdK7vd0yFXpvNsXxO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298374454"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298374454"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:23:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881731712"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="881731712"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:23:55 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH -V2 0/2] migrate: convert migrate_pages()/unmap_and_move() to use folios
Date:   Wed,  9 Nov 2022 09:23:46 +0800
Message-Id: <20221109012348.93849-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is quite straightforward, just replace the page API to
the corresponding folio API.  migrate_pages() and unmap_and_move()
mostly work with folios (head pages) only.

Changelog:

v1 -> v2:

- Rebased on mm-unstable.

- Added reviewed-by.

rfc -> v1:

- Change API to test transhuge and hugetlb, per Matthew and Zi's comments.

- Make THP related statistics for THP only, per Matthew's comments.

Best Regards,
Huang, Ying
