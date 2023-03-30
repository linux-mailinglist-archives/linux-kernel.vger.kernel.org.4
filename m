Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FDB6CFD37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC3Hpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC3Hpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:45:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE411721
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:45:41 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnFmt2LgdzrZDC;
        Thu, 30 Mar 2023 15:44:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 15:45:39 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH 0/2] mm: ksm: support hwpoison for ksm page
Date:   Thu, 30 Mar 2023 15:44:59 +0800
Message-ID: <20230330074501.205092-1-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

