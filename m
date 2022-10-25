Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF760CC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiJYMr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiJYMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:47:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354533E14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:45:25 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxWmq4Ww6zJn7S;
        Tue, 25 Oct 2022 20:42:35 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 20:45:21 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 20:45:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v9 0/3] crypto: hisilicon - supports device isolation feature
Date:   Tue, 25 Oct 2022 12:39:28 +0000
Message-ID: <20221025123931.42161-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the uacce hardware error isolation interface. Supports
  configures the hardware error isolation frequency.
2.Defining the isolation strategy for ACC by uacce sysfs node. If the
  number of hardware errors in a per hour exceeds the configured value,
  the device will not be available in user space. The VF device use the
  PF device isolation strategy.

changes v1->v2:
        - deleted dev_to_uacce api.
        - add vfs node doc.
        - move uacce->ref to driver.
changes v2->v3:
        - deleted some redundant code.
        - use qm state instead of reference count.
        - add null pointer check.
        - isolate_strategy_read() instead of a copy.
changes v3->v4:
        - modify a comment
changes v4->v5:
        - use bool instead of atomic.
        - isolation frequency instead of isolation command.
changes v5->v6:
        - add is_visible in uacce.
        - add the description of the isolation strategy file node.
changes v6->v7
        - add an example for isolate_strategy in Documentation.
changes v7->v8
        - update the correct date.
changes v8->v9
        - move isolation strategy from qm to uacce.

Kai Ye (3):
  uacce: supports device isolation feature
  Documentation: add a isolation strategy sysfs node for uacce
  crypto: hisilicon/qm - add the device isolation feature for acc

 Documentation/ABI/testing/sysfs-driver-uacce |  27 ++++
 drivers/crypto/hisilicon/qm.c                |  66 +++++++--
 drivers/misc/uacce/uacce.c                   | 145 +++++++++++++++++++
 include/linux/uacce.h                        |  43 +++++-
 4 files changed, 271 insertions(+), 10 deletions(-)

-- 
2.17.1

