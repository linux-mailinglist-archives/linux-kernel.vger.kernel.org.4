Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671F6292E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiKOIEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiKOIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:04:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB4B1F3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:04:51 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBJXG4fSJzqSS7;
        Tue, 15 Nov 2022 16:01:02 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 16:04:46 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yusongping@huawei.com>,
        <hucool.lihua@huawei.com>
Subject: [PATCH] ubifs: Fix build errors as symbol undefined
Date:   Tue, 15 Nov 2022 16:33:35 +0800
Message-ID: <20221115083335.21211-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_UBIFS_FS is enable but CONFIG_UBIFS_FS_AUTHENTICATION is not set:
    ERROR: modpost: "ubifs_bad_hash" [fs/ubifs/ubifs.ko] undefined!

Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
 fs/ubifs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 45d3d207fb99..93bda1057fdc 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -13,6 +13,7 @@ config UBIFS_FS
 	select CRYPTO_HASH_INFO
 	select UBIFS_FS_XATTR if FS_ENCRYPTION
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	select UBIFS_FS_AUTHENTICATION
 	depends on MTD_UBI
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
@@ -91,6 +92,7 @@ config UBIFS_FS_AUTHENTICATION
 	select KEYS
 	select CRYPTO_HMAC
 	select SYSTEM_DATA_VERIFICATION
+	select SYSTEM_TRUSTED_KEYRING
 	help
 	  Enable authentication support for UBIFS. This feature offers protection
 	  against offline changes for both data and metadata of the filesystem.
-- 
2.17.1

