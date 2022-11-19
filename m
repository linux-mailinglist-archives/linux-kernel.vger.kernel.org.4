Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4345630D15
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiKSHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKSHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:54:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACC24F36;
        Fri, 18 Nov 2022 23:54:31 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDmBK5NhRzmV5w;
        Sat, 19 Nov 2022 15:54:01 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:54:27 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 15:54:27 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH v10 0/3] crypto: hisilicon - supports device isolation feature
Date:   Sat, 19 Nov 2022 07:48:14 +0000
Message-ID: <20221119074817.12063-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1、Add the uacce hardware error isolation interface. Hardware error 
   thresholds can be configured by sysfs node. User can get the hardware
   isolated state by sysfs node.
2、Defining the isolation strategy for uacce device by uacce sysfs node. 
   If the number of hardware errors exceeds the configured value, the 
   uacce device will not be available in user space.
3、The ACC VF device use the PF device isolation strategy.
   
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
changes v9->v10
	- Go back to the v8 version of the solution.
	- Modify some code according to suggestions.

Kai Ye (3):
  uacce: supports device isolation feature
  Documentation: add the device isolation feature sysfs nodes for uacce
  crypto: hisilicon/qm - define the device isolation strategy

 Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
 drivers/crypto/hisilicon/qm.c                | 169 +++++++++++++++++--
 drivers/misc/uacce/uacce.c                   |  50 ++++++
 include/linux/hisi_acc_qm.h                  |  15 ++
 include/linux/uacce.h                        |  12 ++
 5 files changed, 249 insertions(+), 15 deletions(-)

-- 
2.17.1

