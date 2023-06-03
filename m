Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF5721150
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFCRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F713E;
        Sat,  3 Jun 2023 09:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E591C61553;
        Sat,  3 Jun 2023 16:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79678C433D2;
        Sat,  3 Jun 2023 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685811596;
        bh=c4czb+/K444DuaOGCa6WiRR7Gt06zDGYJJlQOVMrtj0=;
        h=From:To:Cc:Subject:Date:From;
        b=tingSPCAip0+AxNhBChxvnymc77MW6Bc2NReshrMqgTphCGOavjHKmwJ/IpJc0eD/
         RYbad2PpnoZY5u8KnaeUe56kXlwWmXpZ2iHySQBSVRPVXPfE+ziYxpuzOJ8iVb365k
         cUj062Y8u2QPsBmkcZvwmLXWC33s10Gwxi+96IVWOvDAqEwxanhLQ/avLTZrcWWuZg
         w3OOXihZtP5JY12uOc1BllIIbhNRaI2ikCEX/nYIyCXDrG3rJ21u8Js9DK0i+y7BXt
         +FzNX8B128S/uV6ndcSJ+fgxK+PZIOdY42w9lkCjNwMLWebJem5ZXMrzIifzofn+FA
         aoYkIZGmbS42Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH] block/rnbd: fix mixed module-builtin object
Date:   Sun,  4 Jun 2023 01:59:49 +0900
Message-Id: <20230603165949.1753326-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_BLK_DEV_RNBD_CLIENT=m and CONFIG_BLK_DEV_RNBD_SERVER=y
(or vice versa), rnbd-common.o is linked to a module and also to
vmlinux even though CFLAGS are different between builtins and modules.

This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
Fixing mixed module-builtin objects").

Turn rnbd_access_mode_str() into an inline function.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/block/rnbd/Makefile      |  6 ++----
 drivers/block/rnbd/rnbd-common.c | 23 -----------------------
 drivers/block/rnbd/rnbd-proto.h  | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 28 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-common.c

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 40b31630822c..208e5f865497 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -3,13 +3,11 @@
 ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs
 
 rnbd-client-y := rnbd-clt.o \
-		  rnbd-clt-sysfs.o \
-		  rnbd-common.o
+		  rnbd-clt-sysfs.o
 
 CFLAGS_rnbd-srv-trace.o = -I$(src)
 
-rnbd-server-y := rnbd-common.o \
-		  rnbd-srv.o \
+rnbd-server-y := rnbd-srv.o \
 		  rnbd-srv-sysfs.o \
 		  rnbd-srv-trace.o
 
diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
deleted file mode 100644
index 596c3f732403..000000000000
--- a/drivers/block/rnbd/rnbd-common.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDMA Network Block Driver
- *
- * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
- * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
- * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
- */
-#include "rnbd-proto.h"
-
-const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
-{
-	switch (mode) {
-	case RNBD_ACCESS_RO:
-		return "ro";
-	case RNBD_ACCESS_RW:
-		return "rw";
-	case RNBD_ACCESS_MIGRATION:
-		return "migration";
-	default:
-		return "unknown";
-	}
-}
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index da1d0542d7e2..57afe9b07fda 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -300,6 +300,18 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	return rnbd_opf;
 }
 
-const char *rnbd_access_mode_str(enum rnbd_access_mode mode);
+static inline const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
+{
+	switch (mode) {
+	case RNBD_ACCESS_RO:
+		return "ro";
+	case RNBD_ACCESS_RW:
+		return "rw";
+	case RNBD_ACCESS_MIGRATION:
+		return "migration";
+	default:
+		return "unknown";
+	}
+}
 
 #endif /* RNBD_PROTO_H */
-- 
2.39.2

