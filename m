Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D350972F49D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjFNGTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbjFNGTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:19:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA191BE3;
        Tue, 13 Jun 2023 23:19:07 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qgw9W1MSgzqTcl;
        Wed, 14 Jun 2023 14:14:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 14:19:04 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH stable 5.10 0/1] Fix memleak during hotremove memory
Date:   Wed, 14 Jun 2023 14:18:59 +0800
Message-ID: <20230614061900.3296725-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Hi maintainers:

Our test find a memleak in init_memory_block, it is clear that mem is never
been released due to wrong refcount. Commit 08b3acd7a68f ("mm/memory_hotplug:
Introduce offline_and_remove_memory()") failed to dec refcount after
find_memory_block which fail to dec refcount to zero in remove memory
causing the leak.

Commit 8dc4bb58a146 ("mm/memory_hotplug: extend offline_and_remove_memory()
to handle more than one memory block") introduce walk_memory_blocks to
replace find_memory_block which dec refcount by calling put_device after
find_memory_block_by_id. In the way, the memleak is fixed.

Here is the simplified calltrace:

  kmem_cache_alloc_trace+0x664/0xed0
  init_memory_block+0x8c/0x170
  create_memory_block_devices+0xa4/0x150
  add_memory_resource+0x188/0x530
  __add_memory+0x78/0x104
  add_memory+0x6c/0xb0

David Hildenbrand (1):
  mm/memory_hotplug: extend offline_and_remove_memory() to handle more
    than one memory block

 mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 16 deletions(-)

-- 
2.25.1

