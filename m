Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597364DD38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLOPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLOPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:03:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694B2F65B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66A8EB81B51
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E355C433D2;
        Thu, 15 Dec 2022 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671116619;
        bh=in5CD1zMVADf1W0JGm7pLPBBonN1e05ohjCzNE+pQKY=;
        h=From:To:Cc:Subject:Date:From;
        b=N0gJMnnV22ePOdxgEKgpMWrhNDqEdffrWTnDAtsLLXSyRKLVMB9IHXaXxDCvLhUXp
         IhTok1aPSo6HRj795Dp2Y/SVaPbis8AEIXBOokvIEDmdIWE3jtgdaFAvx3BcCcOh7k
         w8XU/WwHtB7FMXKecAOOEkLyGKYn/Hb0ZYfq4tlrYxsCBK3GabxChEu/6gzD/zUYuZ
         fPaHGwSdOvgjGZHBNS4oVST/7muEs9pnlBvQ5mj5loK15I72joVcVcHNxvxmk4TJH8
         /x23FGAx/gbby3hq3J4TEcPyyhaHUnZx6xCWNupdiuNSkmJqeZ9CHY8AIfZROL7tb+
         06zcy6kXPw1bQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v2] f2fs: add missing doc for fault injection sysfs
Date:   Thu, 15 Dec 2022 23:03:30 +0800
Message-Id: <20221215150330.39240-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We supported configuring fault injection parameter via sysfs w/
below commits, however, we forgot to add doc entry, fix it.

commit 087968974fcd ("f2fs: add fault injection to sysfs")
/sys/fs/f2fs/fault_injection/fault_*

commit 1ecc0c5c50ce ("f2fs: support configuring fault injection per superblock")
/sys/fs/f2fs/<device>/fault_*

Cc: Sheng Yong <shengyong@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to handle merge conflict correctly.
 Documentation/ABI/testing/sysfs-fs-f2fs | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9e3756625a81..aaa379bb8a8f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -669,3 +669,42 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
 		the data blocks as warm. By default it was initialized as 2621440 blocks
 		(equals to 10GB).
+
+What:		/sys/fs/f2fs/<disk>/fault_rate
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong@oppo.com>
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Enable fault injection in all supported types with
+		specified injection rate.
+
+What:		/sys/fs/f2fs/<disk>/fault_type
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong@oppo.com>
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Support configuring fault injection type, should be
+		enabled with fault_injection option, fault type value
+		is shown below, it supports single or combined type.
+
+		===================      ===========
+		Type_Name                Type_Value
+		===================      ===========
+		FAULT_KMALLOC            0x000000001
+		FAULT_KVMALLOC           0x000000002
+		FAULT_PAGE_ALLOC         0x000000004
+		FAULT_PAGE_GET           0x000000008
+		FAULT_ALLOC_BIO          0x000000010 (obsolete)
+		FAULT_ALLOC_NID          0x000000020
+		FAULT_ORPHAN             0x000000040
+		FAULT_BLOCK              0x000000080
+		FAULT_DIR_DEPTH          0x000000100
+		FAULT_EVICT_INODE        0x000000200
+		FAULT_TRUNCATE           0x000000400
+		FAULT_READ_IO            0x000000800
+		FAULT_CHECKPOINT         0x000001000
+		FAULT_DISCARD            0x000002000
+		FAULT_WRITE_IO           0x000004000
+		FAULT_SLAB_ALLOC         0x000008000
+		FAULT_DQUOT_INIT         0x000010000
+		FAULT_LOCK_OP            0x000020000
+		FAULT_BLKADDR            0x000040000
+		===================      ===========
-- 
2.36.1

