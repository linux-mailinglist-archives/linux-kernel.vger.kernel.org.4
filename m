Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8176C08FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCTCrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCTCrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:47:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749EB2068C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:47:46 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pfzfh69GQz9v37;
        Mon, 20 Mar 2023 10:47:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:47:43 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>, <david@redhat.com>
Subject: [PATCH v4 0/4] Add overflow checks for several syscalls
Date:   Mon, 20 Mar 2023 10:47:35 +0800
Message-ID: <20230320024739.224850-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Changelog since v3[3]:
- rebase to the latest master
- add simple testcases

Changelog since v2[2]:
- modified the way of checking overflows based on Andrew's comments

Changelog since v1[1]:
- only check overflow rather than access_ok to keep backward-compatibility

[1]: https://lore.kernel.org/lkml/20221228141701.c64add46c4b09aa17f605baf@linux-foundation.org/T/
[2]: https://lore.kernel.org/linux-mm/20230116115813.2956935-5-mawupeng1@huawei.com/T/
[3]: https://lore.kernel.org/linux-mm/de4149c7-0e6e-2035-3fb8-2f9da9633704@huawei.com/T/

Ma Wupeng (4):
  mm/mlock: return EINVAL if len overflows for mlock/munlock
  mm/mempolicy: return EINVAL for if len overflows for
    set_mempolicy_home_node
  mm/mempolicy: return EINVAL if len overflows for mbind
  mm/msync: return ENOMEM if len overflows for msync

 mm/mempolicy.c | 6 ++++--
 mm/mlock.c     | 8 ++++++++
 mm/msync.c     | 3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1

