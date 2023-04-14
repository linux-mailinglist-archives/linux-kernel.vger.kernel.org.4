Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CA6E1A16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDNCSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:18:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25430D5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:18:30 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PyKl901X5zSs8R;
        Fri, 14 Apr 2023 10:14:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:18:27 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH v2 0/2] mm: ksm: support hwpoison for ksm page
Date:   Fri, 14 Apr 2023 10:17:39 +0800
Message-ID: <20230414021741.2597273-1-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ksm does not support hwpoison. As ksm is being used more widely
for deduplication at the system level, container level, and process level, 
supporting hwpoison for ksm has become increasingly important. However, ksm
pages were not processed by hwpoison in 2009 [1].

The main method of implementation:
1. Refactor add_to_kill() and add new add_to_kill_*() to better accommodate
the handling of different types of pages.
2. Add collect_procs_ksm() to collect processes when the error hit an ksm 
page.
3. Add task_in_to_kill_list() to avoid duplicate addition of tsk to the 
to_kill list. 
4. Try_to_unmap ksm page (already supported).
5. Handle related processes such as sending SIGBUS.

Tested with poisoning to ksm page from
1) different process
2) one process

and with/without memory_failure_early_kill set, the processes
are killed as expected with the patchset. 

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
commit/?h=01e00f880ca700376e1845cf7a2524ebe68e47d6

v2:
- Rename the "addr" argument to "ksm_addr" in both the 
"__add__add_to_kill()" and "add_to_kill_ksm()"
- Collect RB/TB

Longlong Xia (2):
  mm: memory-failure: Refactor add_to_kill()
  mm: ksm: Support hwpoison for ksm page

 include/linux/ksm.h | 11 ++++++++
 include/linux/mm.h  |  7 +++++
 mm/ksm.c            | 45 ++++++++++++++++++++++++++++++++
 mm/memory-failure.c | 63 +++++++++++++++++++++++++++++++++------------
 4 files changed, 109 insertions(+), 17 deletions(-)

-- 
2.25.1

