Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C1E6EC342
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDXARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDXARL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:17:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE9E7C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682295430; x=1713831430;
  h=from:to:cc:subject:date:message-id;
  bh=IJLvmjBgE8lNBogKeKIxw1MUQdoweA4rG/DsHNcpD/o=;
  b=XQuvm0fjHWCG5aiiKsTSt7KSh9no5HtY/zdiYrk5g5xF8vXMTnMt4ZQa
   K+LdRhCdoVuHwN2LCbd5aL9+Y8Em5adnx5RlSzLU7dBdIxB5qaImEwtRe
   zNXvL9NOAunz6aMvkm3CCV1S+UG7khVuKTyqmJ7QPxgxupe6lnAbXk/5n
   68QDHJx7KyBh6VjsoMYOXjyuqydYG/12MzM4+eA4DZNMNFJ80M10zh88k
   rm0xQs/GfXKfO0Pl3spYK7Uc/EzM6MCrNKHUSl+5jcGhQ+vuZGHQ5S0tQ
   ydRH5XbPao6mz747nKpgJKcuGOLXD9Q6mMy9N6lz3e6I6id8hN7yLHwp7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="411605275"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="411605275"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 17:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="1022502116"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="1022502116"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2023 17:17:09 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2 0/2] x86/cacheinfo: Set the number of leaves per CPU
Date:   Sun, 23 Apr 2023 17:19:54 -0700
Message-Id: <20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This v2 of now a patchset to set the number of cache leaves independently
for each CPU. v1 can be found here [1].

These are the changes since v2:
  * Dave Hansen, suggested to use the existing per-CPU ci_cpu_cacheinfo
    variable. Now the global variable num_cache_leaves became useless.
  * While here, I noticed that init_cache_level() also became useless:
    x86 does not need ci_cpu_cacheinfo::num_levels.

These patches apply cleanly on top of the master branch of the tip tree.

Thanks and BR,
Ricardo


[1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/


Ricardo Neri (2):
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 50 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

-- 
2.25.1

