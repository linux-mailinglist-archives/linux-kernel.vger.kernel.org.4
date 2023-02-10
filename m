Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3C691C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjBJJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjBJJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:58:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0F76D26
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:58:31 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PCpzf1KG6zHwFm;
        Fri, 10 Feb 2023 17:56:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 17:58:28 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <chenwandun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>, <xialonglong1@huawei.com>
Subject: [PATCH -next v2 0/3] cleanup of devtmpfs_*_node()
Date:   Fri, 10 Feb 2023 09:54:41 +0000
Message-ID: <20230210095444.4067307-1-xialonglong1@huawei.com>
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

In one test, when modprobe zram, no zram device was found in the /dev. 
But don't see any errors printed in jouranls/dmesg. Later we found out 
that the reason was that device_add() did not check its return value when
calling devtmpfs_create_node().

The test steps:
1. Set the SElinux label of /dev to user_home_t 
2. modprobe zram num_devices=1000

v1 -> v2:
- New patch 1 to add error handling for devtmpfs_create_node().
- use dev_err() to replace pr_err_ratelimited in [2].
- only remove return value of devtmpfs_delete_node() in [3].

Longlong Xia (3):
  driver core: add error handling for devtmpfs_create_node()
  devtmpfs: add debug info to handle()
  devtmpfs: remove return value of devtmpfs_delete_node()

 drivers/base/base.h     |  4 ++--
 drivers/base/core.c     |  6 +++++-
 drivers/base/devtmpfs.c | 20 ++++++++++++++------
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

