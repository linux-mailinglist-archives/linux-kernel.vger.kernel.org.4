Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43B5F0755
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiI3JOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiI3JON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725C12F772
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:14:12 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf4DK3YcrzHtsT;
        Fri, 30 Sep 2022 17:09:21 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:14:10 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
Subject: [PATCH v5 0/2] squashfs: Add the mount parameter "threads="
Date:   Fri, 30 Sep 2022 17:14:04 +0800
Message-ID: <20220930091406.50869-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220916083604.33408-1-nixiaoming@huawei.com>
References: <20220916083604.33408-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Squashfs supports multiple decompressor parallel modes. However, this
mode can be configured only during kernel building and does not support flexible
selection during runtime.

In the current patch set, the mount parameter "threads=" is added to allow users
to select the parallel decompressor mode and configure the number of decompressors
when mounting a file system.

"threads=<single|multi|percpu|1|2|3|...>"
The upper limit is num_online_cpus() * 2.

v5: fix a low-level mistake in patching:
  fs/squashfs/super.c:492:7: warning: "CONFIG_SQUASHFS_DECOMP_MULTI" is 
  not defined, evaluates to 0 [-Wundef]

v4: https://lore.kernel.org/lkml/20220916083604.33408-1-nixiaoming@huawei.com/
 Based on Philip Lougher's suggestion, make the following updates:
 1. Use static modifiers to avoid changing symbol names.
 2. Fixed some formatting issues

v3: https://lore.kernel.org/lkml/20220902094855.22666-1-nixiaoming@huawei.com/
  Based on Philip Lougher's suggestion, make the following updates:
  1. The default configuration is the same as that before the patch installation.
  2. Compile the three decompression modes when the new configuration is enabled.
  3. "threads=1" supports only the SQUASHFS_DECOMP_SINGLE mode.

v2: https://lore.kernel.org/lkml/20220816010052.15764-1-nixiaoming@huawei.com/
  fix warning: sparse: incorrect type in initializer (different address spaces)
  Reported-by: kernel test robot <lkp@intel.com>

v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/

Xiaoming Ni (2):
  squashfs: add the mount parameter theads=<single|multi|percpu>
  squashfs: Allows users to configure the number of  decompression
    threads

 fs/squashfs/Kconfig                     | 51 ++++++++++++++++--
 fs/squashfs/block.c                     |  2 +-
 fs/squashfs/decompressor.c              |  2 +-
 fs/squashfs/decompressor_multi.c        | 20 ++++---
 fs/squashfs/decompressor_multi_percpu.c | 23 +++++---
 fs/squashfs/decompressor_single.c       | 15 ++++--
 fs/squashfs/squashfs.h                  | 23 ++++++--
 fs/squashfs/squashfs_fs_sb.h            |  4 +-
 fs/squashfs/super.c                     | 93 +++++++++++++++++++++++++++++++--
 9 files changed, 199 insertions(+), 34 deletions(-)

-- 
2.12.3

