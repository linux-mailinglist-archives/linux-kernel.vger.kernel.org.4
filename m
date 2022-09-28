Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4765ED573
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiI1GzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiI1Gym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:54:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE52409B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:53:13 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4McnCC3KCjz1P6vq;
        Wed, 28 Sep 2022 14:48:55 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:53:11 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 14:53:11 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <akpm@linux-foundation.org>, <ndesaulniers@google.com>,
        <nathan@kernel.org>, <vbabka@suse.cz>, <masahiroy@kernel.org>,
        <arnd@arndb.de>, <bigeasy@linutronix.de>, <seanjc@google.com>,
        <hannes@cmpxchg.org>, <ojeda@kernel.org>, <mhiramat@kernel.org>,
        <dmitry.torokhov@gmail.com>, <atomlin@redhat.com>, <ddiss@suse.de>,
        <christophe.leroy@csgroup.eu>, <lukas.bulwahn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] init/Kconfig: fix unmet direct dependencies
Date:   Wed, 28 Sep 2022 06:49:34 +0000
Message-ID: <20220928064934.70867-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

So add PROC_FS to dependencies to fix this.
Fixes: 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e11307310fc1..fc32b28fe93e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1273,6 +1273,7 @@ endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support"
+	select PROC_FS
 	select PROC_CHILDREN
 	select KCMP
 	default n
-- 
2.17.1

