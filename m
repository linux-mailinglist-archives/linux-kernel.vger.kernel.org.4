Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47E5BF609
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIUGGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUGGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:06:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62A7B2AE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740411; x=1695276411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xsZ2Mvy4tpdwu8/Jy1B6jf7NAn4Nf2Vm//ir3UuH1OY=;
  b=Bx+p6cJEUbh1GAqiLszQQo6cf5mWArlFLBNaVqr3BA9iGJOvrqffT6W/
   8OHpaOLUmWitvLDZj0TLFLmCLmxHdutOgRG3jBk21HTaR6ag/cR3+x1fY
   1pmXBylszPtVJGBFyZNXwfSvMXALrg5yQJbxuneM1sg9oTKbUfLS6eyR1
   uefrJSgDYVZy+GIAS+6c+NQXiYuLoD2P3qZ76DuUu/IyVYTyfS4WIxzoW
   6/4EJChSkh5uHI6cnKY6Y89hABDBhxrf977tTG5D+QJ9aKtuweXsAjZns
   7zMlQguj/5TzRwk5LaUvWHIo835j89vUNjFXP4h8O0V5Y+kZ4plsp1BUC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284824"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913832"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:48 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 0/6] migrate_pages(): batch TLB flushing
Date:   Wed, 21 Sep 2022 14:06:10 +0800
Message-Id: <20220921060616.73086-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
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

From: "Huang, Ying" <ying.huang@intel.com>

Now, migrate_pages() migrate pages one by one, like the fake code as
follows,

  for each page
    unmap
    flush TLB
    copy
    restore map

If multiple pages are passed to migrate_pages(), there are
opportunities to batch the TLB flushing and copying.  That is, we can
change the code to something as follows,

  for each page
    unmap
  for each page
    flush TLB
  for each page
    copy
  for each page
    restore map

The total number of TLB flushing IPI can be reduced considerably.  And
we may use some hardware accelerator such as DSA to accelerate the
page copying.

So in this patch, we refactor the migrate_pages() implementation and
implement the TLB flushing batching.  Base on this, hardware
accelerated page copying can be implemented.

If too many pages are passed to migrate_pages(), in the naive batched
implementation, we may unmap too many pages at the same time.  The
possibility for a task to wait for the migrated pages to be mapped
again increases.  So the latency may be hurt.  To deal with this
issue, the max number of pages be unmapped in batch is restricted to
no more than HPAGE_PMD_NR.  That is, the influence is at the same
level of THP migration.

We use the following test to measure the performance impact of the
patchset,

On a 2-socket Intel server,

 - Run pmbench memory accessing benchmark

 - Run `migratepages` to migrate pages of pmbench between node 0 and
   node 1 back and forth.

With the patch, the TLB flushing IPI reduces 99.1% during the test and
the number of pages migrated successfully per second increases 291.7%.

This patchset is based on v6.0-rc5 and the following patchset,

[PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
https://lore.kernel.org/lkml/20220817081408.513338-1-ying.huang@intel.com/

The migrate_pages() related code is converting to folio now. So this
patchset cannot apply recent akpm/mm-unstable branch.  This patchset
is used to check the basic idea.  If it is OK, I will rebase the
patchset on top of folio changes.

Best Regards,
Huang, Ying
