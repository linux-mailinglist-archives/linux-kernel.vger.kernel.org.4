Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2567F535
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjA1Gco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA1Gcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:32:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D0D79630
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:32:41 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P3l1g3dWTzRrqN;
        Sat, 28 Jan 2023 14:30:31 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 14:32:37 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 0/4] Add overflow checks for several syscalls
Date:   Sat, 28 Jan 2023 14:32:25 +0800
Message-ID: <20230128063229.989058-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
The return value of mlock is zero. But nothing will be locked since the
len in do_mlock overflows to zero due to the following code in mlock:

  len = PAGE_ALIGN(len + (offset_in_page(start)));

The same problem happens in munlock.

Add new check and return -EINVAL to fix this overflowing scenarios since
they are absolutely wrong.

Similar logic is used to fix problems with multiple syscalls.

Changelog since v2[2]:
- modified the way of checking overflows based on Andrew's comments

Changelog since v1[1]:
- only check overflow rather than access_ok to keep backward-compatibility

[1]: https://lore.kernel.org/lkml/20221228141701.c64add46c4b09aa17f605baf@linux-foundation.org/T/
[2]: https://lore.kernel.org/linux-mm/20230116115813.2956935-5-mawupeng1@huawei.com/T/

Ma Wupeng (4):
  mm/mlock: return EINVAL if len overflows for mlock/munlock
  mm/mempolicy: return EINVAL for if len overflows for
    set_mempolicy_home_node
  mm/mempolicy: return EINVAL if len overflows for mbind
  mm/msync: return ENOMEM if len overflows for msync

 mm/mempolicy.c | 18 ++++++++++++------
 mm/mlock.c     | 14 ++++++++++++--
 mm/msync.c     |  9 ++++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.25.1

