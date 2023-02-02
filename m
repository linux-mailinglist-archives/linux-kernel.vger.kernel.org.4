Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA36873D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjBBDce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjBBDca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:32:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307C35BF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:32:28 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P6knW5PFwz16Mnv;
        Thu,  2 Feb 2023 11:30:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 11:32:26 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH -next 0/3] cleanup of devtmpfs_*_node()
Date:   Thu, 2 Feb 2023 03:32:00 +0000
Message-ID: <20230202033203.1239239-1-xialonglong1@huawei.com>
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
calling devtmpfs_create_node(). So we hope to turn devtmpfs_*_node() & 
devtmpfs_submit_req() into a function with no return value, and add some
debug info in the handle() that actually processes the request to let the
user know why the creation was not successful.

Patch [1] devtmpfs: convert to pr_fmt. 
Patch [2] devtmpfs: add debug info to handle().
Patch [3] devtmpfs: Remove return value of devtmpfs_*_node() & 
devtmpfs_submit_req().

Longlong Xia (3):
  devtmpfs: convert to pr_fmt
  devtmpfs: add debug info to handle()
  devtmpfs: remove return value of devtmpfs_*_node() &
    devtmpfs_submit_req()

 drivers/base/base.h     |  8 +++----
 drivers/base/devtmpfs.c | 48 +++++++++++++++++++++++------------------
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.25.1

