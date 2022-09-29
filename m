Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8EA5EEE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiI2HFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiI2HEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:04:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E02DFA4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:04:38 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdPQ41tcHzWgsy;
        Thu, 29 Sep 2022 15:00:28 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:04:35 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 15:04:35 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <lukas.bulwahn@gmail.com>, <bigeasy@linutronix.de>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH v2 -next] init/Kconfig: fix unmet direct dependencies
Date:   Thu, 29 Sep 2022 07:00:57 +0000
Message-ID: <20220929070057.59044-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
make config PROC_CHILDREN depend on PROC_FS.

When CONFIG_PROC_FS is not set and CONFIG_CHECKPOINT_RESTORE=y,
make menuconfig screams like this:

WARNING: unmet direct dependencies detected for PROC_CHILDREN
  Depends on [n]: PROC_FS [=n]
  Selected by [y]:
  - CHECKPOINT_RESTORE [=y]

CHECKPOINT_RESTORE would select PROC_CHILDREN which depends on PROC_FS,
so add depends on PROC_FS to CHECKPOINT_RESTORE to fix this.
Fixes: 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
Changes in v2:
	- change dependency of CHECKPOINT_RESTORE to depends on PROC_FS
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e11307310fc1..a19314933e54 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1273,6 +1273,7 @@ endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support"
+	depends on PROC_FS
 	select PROC_CHILDREN
 	select KCMP
 	default n
-- 
2.17.1

