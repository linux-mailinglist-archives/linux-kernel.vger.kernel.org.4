Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14786350B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiKWGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiKWGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:55:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1087A48
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:55:22 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NHBd04943zJns6;
        Wed, 23 Nov 2022 14:52:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:55:19 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <ccaulfie@redhat.com>, <teigland@redhat.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH -next] fs: dlm: Fix build error without DEBUG_LOCK_ALLOC
Date:   Wed, 23 Nov 2022 06:53:19 +0000
Message-ID: <20221123065319.56756-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DLM is y, DEBUG_LOCK_ALLOC is n, building fails:

fs/dlm/lowcomms.o: In function `lowcomms_queue_rwork':
lowcomms.c:(.text+0x2ac): undefined reference to `lockdep_is_held'
lowcomms.c:(.text+0x308): undefined reference to `lockdep_is_held'
fs/dlm/lowcomms.o: In function `lowcomms_queue_swork':
lowcomms.c:(.text+0x3e0): undefined reference to `lockdep_is_held'
fs/dlm/lowcomms.o: In function `restore_callbacks':
lowcomms.c:(.text+0xd8c): undefined reference to `lockdep_is_held'
lowcomms.c:(.text+0xdcc): undefined reference to `lockdep_is_held'

Make DLM select DEBUG_LOCK_ALLOC to fix this.

Fixes: dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/dlm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index 1105ce3c80cb..90a0861e7a29 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -5,6 +5,7 @@ menuconfig DLM
 	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
 	select IP_SCTP
 	select SRCU
+	select DEBUG_LOCK_ALLOC
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
--
2.17.1

