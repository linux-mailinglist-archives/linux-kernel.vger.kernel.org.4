Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93568A812
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBDEGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBDEGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:06:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F993E3C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675483606; x=1707019606;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+XXStKh3j+XHfCAm1vQfzdlmrIlu0fkTxoAosQ00C2s=;
  b=P+68azm8QrAovfYeAui+9uH3SrzdjVKpGse6UL8qduNS85UytM9qmqAn
   xmRm17JkugZ1ovhu4taZX99k6Fzeh/1G393bcjgtg5FgqfpCmCTCiyTMl
   uryCFuGZp8WdafIRz0youZyPipDSjLVtQEzI06hUmlGHrsQ0/WoxllbZt
   6RSldGw0WhBKTSd5eDtwNu0wF/ZiG+WkVvvrcBDIs2qmAPq9kDE36A4wQ
   f4UteBnmjLPmmHJ7ZqCTcxfd+vo8k/Wi3I2zW6nJvbc6Vk+hU84or6v74
   kggKSwLYuHKvL1KutuXdeAkHaQ0k/k3ws/gcl/foc0OL4J2vgl+zQDyRA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391309346"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391309346"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734573702"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734573702"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.125.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:06:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/4] Remove get_kernel_pages()
Date:   Fri, 03 Feb 2023 20:06:32 -0800
Message-Id: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjZ3WMC/x3NQQqDMBCF4atI1o0ko1jSVe9RRGI66tA0SmJtR
 bx7R5f/g8e3iYSRMIlbtomICyUaAwdcMuEGG3qU9OQWoKBQoArZ49y8MAb0zWR7TFIbU5TgutZe
 jeBbaxPKNtrgBj6Gj/c8ThE7+p3Oo+YeKM1jXE920cd6CKAVGyxBlZuyqkBJLSna/IsU1juFGX3
 uxreo933/A2bOhwi7AAAA
To:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-mm@kvack.org, Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675483603; l=2450;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+XXStKh3j+XHfCAm1vQfzdlmrIlu0fkTxoAosQ00C2s=;
 b=uiELKqKl1rb6sOhVOwgs8nj+yDmsZW7IRkTZMpss2wfMavp/n/GthM90M7+cawX38rpd3SUdvp0L
 wLgrsliCCT3ru9EaQmYslPppourPJuwwOdkdT5W6ixQ1/ZhM1zLM
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit,

I did not see a follow up on this series per your last email.[1]  I'd like to
move forward with getting rid of kmap_to_page().  So Hopefully this can land
and you can build on this rather than the other way around?

All,

Al Viro found[2] that kmap_to_page() is broken.  But not only is it broken, it
presents confusion over how highmem should be used because kmap() and friends
should not be used for 'long term' mappings.

get_kernel_pages() is a caller of kmap_to_page().  It only has one caller
[shm_get_kernel_pages()] which does not need the functionality.

Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
does not have any need to support vmalloc'ed addresses either.  Remove that
functionality to clean up the logic.

This series also fixes is_kmap_addr() and uses it to ensure no kmap addresses
slip in later.

[1] https://lore.kernel.org/all/CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XXAUpqdaW53w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3@ZenIV

To: Sumit Garg <sumit.garg@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christoph Hellwig" <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: op-tee@lists.trustedfirmware.org
Cc: linux-mm@kvack.org
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes in v2:
- Al Viro: Avoid allocating the kiov.
- Sumit: Update cover letter to clarify the motivation behind removing
  get_kernel_pages()
- Link to v1: https://lore.kernel.org/r/20221002002326.946620-1-ira.weiny@intel.com

---
Ira Weiny (4):
      highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
      tee: Remove vmalloc page support
      tee: Remove call to get_kernel_pages()
      mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
 include/linux/highmem-internal.h |  5 ++++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 ------------------------------
 4 files changed, 14 insertions(+), 60 deletions(-)
---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230203-get_kernel_pages-199342cfba79

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
