Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701BB60385E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJSDGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJSDGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:06:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9080F7D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:06:10 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Msb911cYgzmVD6;
        Wed, 19 Oct 2022 11:01:25 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:06:08 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
Subject: [PATCH v6 0/2] squashfs: Add the mount parameter "threads="
Date:   Wed, 19 Oct 2022 11:09:28 +0800
Message-ID: <20221019030930.130456-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220930091406.50869-1-nixiaoming@huawei.com>
References: <20220930091406.50869-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

v6: fix opt->thread_ops unassigned if CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set.

v5: https://lore.kernel.org/lkml/20220930091406.50869-1-nixiaoming@huawei.com/
  fix a low-level mistake in patching:
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
*** BLURB HERE ***

Xiaoming Ni (2):
  squashfs: add the mount parameter theads=<single|multi|percpu>
  squashfs: Allows users to configure the number of decompression
    threads

 fs/squashfs/Kconfig                     | 51 +++++++++++--
 fs/squashfs/block.c                     |  2 +-
 fs/squashfs/decompressor.c              |  2 +-
 fs/squashfs/decompressor_multi.c        | 20 +++--
 fs/squashfs/decompressor_multi_percpu.c | 23 ++++--
 fs/squashfs/decompressor_single.c       | 15 +++-
 fs/squashfs/squashfs.h                  | 23 ++++--
 fs/squashfs/squashfs_fs_sb.h            |  4 +-
 fs/squashfs/super.c                     | 97 ++++++++++++++++++++++++-
 9 files changed, 203 insertions(+), 34 deletions(-)

-- 
2.27.0

