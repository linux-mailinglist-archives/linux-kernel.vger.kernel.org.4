Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3670CEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjEWAI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjEVXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 19:25:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E110D3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684797353; x=1716333353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/gNqy37Kwj4nw9l2Tmp4gwPRJoz64UYV1IsBGKEssM=;
  b=FZrQ+6ozi1xmWyjIK4jRg/9fWk1EUrApx5W8Rb0OxVk5gEzhPtMXe3qI
   D5Hjy3mX7bUneBFlNle6lGi2XxQtu+RmVR8btif9yw49y+O/GlR8H9waf
   I+B4HsYDt+tPgGhmZ+9Yy12PgE/DqYRRJgbEZ5QmyYL6hLpTaBX6ERVvw
   b90vJYuD1OynvjJnQHnCb9iBE5LZxn8kAowx8WvWUKvpwRus7XgfwAgEj
   QJFGDoZFljrXohY0ZGMb5NKoUjBheY0uVSTQuehMmx3vMdDw+DWUcOaCT
   BYlbtB/lsxseaJzH9afTI+Qb9HGVlz12LfsMt5kK9/VdskKMRVBeWbM0z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="416533121"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416533121"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 16:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="815868153"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="815868153"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2023 16:15:52 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/urgent for 6.4-rc4
Date:   Mon, 22 May 2023 16:15:48 -0700
Message-Id: <20230522231548.1511061-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a single x86/urgent change for 6.4-rc4.  This works around
and issue where the INVLPG instruction may miss invalidating kernel
TLB entries.  I do expect an eventual microcode fix for this.  When
the microcode version numbers are known, we can circle back around and
add them the model table to disable this workaround.

--

The following changes since commit 7d8accfaa0ab65e4282c8e58950f7d688342cd86:

  hwmon: (k10temp) Add PCI ID for family 19, model 78h (2023-05-08 11:36:19 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_6.4-rc4

for you to fetch changes up to ce0b15d11ad837fbacc5356941712218e38a0a83:

  x86/mm: Avoid incomplete Global INVLPG flushes (2023-05-17 08:55:02 -0700)

----------------------------------------------------------------
Work around a TLB invalidation issue in recent hybrid CPUs

----------------------------------------------------------------
Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

 arch/x86/mm/init.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
