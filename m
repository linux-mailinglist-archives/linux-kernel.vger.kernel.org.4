Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8E64DC71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLONtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLONtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:49:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C227938
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3175B81AAC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFC0C433D2;
        Thu, 15 Dec 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671112139;
        bh=/LcZa3XGVGnIrqoF1A3pJ0bE+VqGjwDs1whEMu0i64Y=;
        h=From:To:Cc:Subject:Date:From;
        b=acBSqVup6NokugHXtLPlDHayWNBLdqiPzMlnOWLWoOFrPXxJkMlH08NeJU9l+G47X
         6s45Zi5GW6+hbqvH67Tn4BE8YqizV6YgPPoKyO5foGcjqbxzVO5+hx2vKiBHNgHi4L
         UyZ+maCTqw7i69WqC0dXS8dINTSo691WwYQu2iVMUcr6ve4clXDYndiE9wmD8uMg8Q
         Wf5+asAgHsDjwiuuqeUY3BYrPj0CfhB3JxkOmy599mf5iCVQGbPWyuSySqrFjQlGdi
         iLzEhdmwVNF/d9Z5yfcH02xBvj5UhZdxSl4rar/ZpwgMJlshuVC9L58i7twR5nlmdu
         fQseVvmsFzTZQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH] f2fs: add missing doc for fault injection sysfs
Date:   Thu, 15 Dec 2022 21:48:44 +0800
Message-Id: <20221215134844.12951-1-chao@kernel.org>
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
 Documentation/ABI/testing/sysfs-fs-f2fs | 63 +++++++++++++++----------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9e3756625a81..3ce58d0c4f2e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -642,30 +642,41 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Show the accumulated total revoked atomic write block count after boot.
 		If you write "0" here, you can initialize to "0".
 
-What:		/sys/fs/f2fs/<disk>/gc_mode
-Date:		October 2022
-Contact:	"Yangtao Li" <frank.li@vivo.com>
-Description:	Show the current gc_mode as a string.
-		This is a read-only entry.
+What:		/sys/fs/f2fs/<disk>/fault_rate
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong@oppo.com>
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Enable fault injection in all supported types with
+		specified injection rate.
 
-What:		/sys/fs/f2fs/<disk>/discard_urgent_util
-Date:		November 2022
-Contact:	"Yangtao Li" <frank.li@vivo.com>
-Description:	When space utilization exceeds this, do background DISCARD aggressively.
-		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
-		of discards is not 0 and set discard granularity to 1.
-		Default: 80
-
-What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
-Date:		November 2022
-Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
-Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
-		the data blocks as hot. By default it was initialized as 262144 blocks
-		(equals to 1GB).
-
-What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
-Date:		November 2022
-Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
-Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
-		the data blocks as warm. By default it was initialized as 2621440 blocks
-		(equals to 10GB).
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

