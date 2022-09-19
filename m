Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7770D5BC184
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiISCtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiISCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:49:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E563A19C25
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663555753; x=1695091753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TpLKzHcoPWVF/VzhAYmzp5p7rI6irdkZ0/MM0DfUOUY=;
  b=nOHxQaoIUNtVKzmi3HtQpVmAMtXUfMPpgxrNwc38KiMGWH1EDoWOFP15
   /Ita435TilJUYd86JRAJZSvraRTdY3a1hDqoyZ2xTmdisn2nvuGRyHakk
   J9WFKP+MPL8EKYzN+1AxOx30Uq6sMAMlrlXpjpG7U9n8KFbsAzD782p85
   i0PWkZhh/MXYIrNBCoW6HXchLsWQtQcK25kWag7Z2CAtxoypT/6WmyybI
   HueJJt5lYM6lIetL8/rGJNuiOZE8KEI7lLa6UWL+KGOYZAWykJQFSUZI0
   tP5llP2fxirgYXrsy8uQwMeOnXFJK0Qi8O6KVQtIpscnW5Qo56lqqBCny
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="299283404"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="299283404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 19:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="947035156"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2022 19:49:05 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 0/3] Add tests trying to memblock_add() or memblock_reserve() 129th region
Date:   Mon, 19 Sep 2022 10:47:36 +0800
Message-Id: <20220919024745.153395-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v4:
  - Increase the MEM_SIZE to SZ_32K. And makes the calculation process in
  memblock_add_many_check() more simpler.
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
 tools/testing/memblock/tests/basic_api.c | 184 +++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |   7 +-
 tools/testing/memblock/tests/common.h    |   6 +-
 4 files changed, 196 insertions(+), 12 deletions(-)

-- 
2.34.1

