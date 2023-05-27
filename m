Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A67134C2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjE0MgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjE0MgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:36:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2FB135
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:35:49 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QT1SR3mYTzLm9y;
        Sat, 27 May 2023 20:34:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 0/6] kexec: enable kexec_crash_size to support two crash kernel regions
Date:   Sat, 27 May 2023 20:34:33 +0800
Message-ID: <20230527123439.772-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When crashkernel=X fails to reserve region under 4G, it will fall back to
reserve region above 4G and a region of the default size will also be reserved
under 4G. Unfortunately, /sys/kernel/kexec_crash_size only supports one crash
kernel region now, the user cannot sense the low memory reserved by reading
/sys/kernel/kexec_crash_size. Also, low memory cannot be freed by writing this
file.

For example:
resource_size(crashk_res) = 512M
resource_size(crashk_low_res) = 256M

The result of 'cat /sys/kernel/kexec_crash_size' is 512M, but it should be 768M.
When we execute 'echo 0 > /sys/kernel/kexec_crash_size', the size of crashk_res
becomes 0 and resource_size(crashk_low_res) is still 256 MB, which is incorrect.

Since crashk_res manages the memory with high address and crashk_low_res manages
the memory with low address, crashk_low_res is shrunken only when all crashk_res
is shrunken. And because when there is only one crash kernel region, crashk_res
is always used. Therefore, if all crashk_res is shrunken and crashk_low_res still
exists, swap them.


Zhen Lei (6):
  kexec: fix a memory leak in crash_shrink_memory()
  kexec: delete a useless check in crash_shrink_memory()
  kexec: clear crashk_res if all its memory has been released
  kexec: improve the readability of crash_shrink_memory()
  kexec: add helper __crash_shrink_memory()
  kexec: enable kexec_crash_size to support two crash kernel regions

 kernel/kexec_core.c | 92 +++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 28 deletions(-)

-- 
2.25.1

