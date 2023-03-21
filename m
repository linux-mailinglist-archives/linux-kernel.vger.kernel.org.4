Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9476C2B85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUHlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCUHk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A493B231
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:40:42 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pgk5S0b6tzrVn1;
        Tue, 21 Mar 2023 15:39:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 15:40:39 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 0/4] Add overflow checks for several syscalls
Date:   Tue, 21 Mar 2023 15:40:31 +0800
Message-ID: <20230321074035.1526157-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Here is the testcases:

  #include <stdio.h>
  #define _GNU_SOURCE
  #include <sys/mman.h>
  #include <fcntl.h>
  #include <errno.h>
  #include <unistd.h>
  #include <string.h>
  #include <limits.h>
  #include <numaif.h>
  
  extern int errno;
  int main(void)
  {
      int fd;
      int ret;
      void *addr;
      int size = getpagesize();
  
      fd = open("/tmp/testfile", O_RDWR | O_CREAT);
      if (fd < 0) {
          printf("open file error! errno: %d\n", errno);
          return -1;
      }
      printf("open success\n");
      addr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      if (addr == MAP_FAILED) {
          printf("open file error! errno: %d\n", errno);
          close(fd);
          return -1;
      }
      printf("mmap success\n");
      memset(addr, 0, size);
  
      printf("==== mlock ====\n");
      ret = mlock(addr, ULONG_MAX);
      if (ret == -1 && errno == EINVAL)
          printf("mlock test passed\n");
      else
          printf("mlock test failed, ret: %d, errno: %d\n", ret, errno);
  
      printf("==== set_mempolicy_home_node ====\n");
      ret = syscall(450, addr, ULONG_MAX, 0, 0);
      if (ret == -1 && errno == EINVAL)
          printf("set_mempolicy_home_node test passed\n");
      else
          printf("set_mempolicy_home_node test failed, ret: %d, errno: %d\n", ret, errno);
  
      printf("==== mbind ====\n");
      unsigned long nodemask = 1Ul << 0;
      long max_node = 8 * sizeof(nodemask);
      ret = mbind(addr, ULONG_MAX, MPOL_BIND, &nodemask, max_node, MPOL_MF_MOVE_ALL);
      if (ret == -1 && errno == EINVAL)
          printf("mbind test passed\n");
      else
          printf("mbind test failed, ret: %d, errno: %d\n", ret, errno);
  
      printf("==== msync ====\n");
      ret = msync(addr, ULONG_MAX, MS_ASYNC);
      if (ret == -1 && errno == ENOMEM)
          printf("mbind test passed\n");
      else
          printf("mbind test failed, ret: %d, errno: %d\n", ret, errno);
  
      munmap(mmap, size);
  
      return 0;
  }

Changelog since V4:
- send the right version of this patchset

Changelog since v3[3]:
- rebase to the latest master
- add simple testcases

Changelog since v2[2]:
- modified the way of checking overflows based on Andrew's comments

Changelog since v1[1]:
- only check overflow rather than access_ok to keep backward-compatibility

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

