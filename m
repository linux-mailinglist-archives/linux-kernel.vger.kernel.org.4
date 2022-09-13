Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A005B6814
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIMGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiIMGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:42:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DFA58511
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663051353; x=1694587353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QwXKFHrSvUaOG3T1uuNRHZ6TdyYNDc9HukCFi5JLdbY=;
  b=coynnTmQsiFcQHaGz5BRqT66um3iZz+ooPHT5vT6e7HacSNaOVb2MdEG
   JwCPvAOeY66IxI1kwwZvPl0WsRpzFVjPLFRT+libIieD6Nw1rhVxTxjqg
   igj/EEdsyPQkLNxP/vWmp1Y5d/EIGMjdvBhU/6WWA+P4ZtLdJSYe/X6K6
   61MplDelMo+LwZWhEOvRWTU41vMDFand+bQut12gTTSlz0zKKpI5l6Bog
   r6vHGkNcnahN4vndGD3LCyl0S77/FWGHWVtaKA8akCPgjMh4Z1T4IRJGs
   1k+NA7RjNAR/2i4uzTdT7ZDDuckJeGu18tfQQBbRsdOC2A5x+hX/JngKL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384350393"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="384350393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678428674"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2022 23:41:43 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/3] Add tests trying to memblock_add() or memblock_reserve() 129th region
Date:   Tue, 13 Sep 2022 14:41:29 +0800
Message-Id: <20220913064138.407601-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

These tests is aimed for testing the memblock_double_array() can work normal. It
will using the dummy_physical_memory_init() to add the valid memory region into
the memblock.memory, and this memory region will be choosed when
memblock_double_array() to allocate the new memory region to double the regions.
Thus the new memory.regions or reserved.regions will occupy the valid memory
region, and the memory.max and reserved.max also being doubled. Check all of
these changed stuff, to make sure it actually success.

Changelog:
----------
v3:
  - Avoid to allocated multiple memory region from dummy_physical_memory_base(),
  split the memory into different part instead.
  - Some comments improvement.
v2:
  - Modify the get_memory_block_base() to dummy_physical_memory_base().
  - memory_add() the memory which is allocated from dummy_physical_memory_init()
  instead of some faked memory.
  - Add more comments to illustrate the test process.
  - Add a function dummy_physical_memory_cleanup_many() to free multiple memory
  which is allocated from dummy_physical_memory_init().

Shaoqin Huang (3):
  memblock test: Add test to memblock_add() 129th region
  memblock test: Add test to memblock_reserve() 129th region
  memblock test: Update TODO list

 tools/testing/memblock/TODO              |  11 +-
 tools/testing/memblock/tests/basic_api.c | 186 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |   7 +-
 tools/testing/memblock/tests/common.h    |   3 +
 4 files changed, 196 insertions(+), 11 deletions(-)

-- 
2.34.1

