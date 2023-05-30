Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85917716A79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjE3RKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjE3RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:10:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797AB0;
        Tue, 30 May 2023 10:10:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685466599;
        bh=peTYqiDIJwMTxZXYjxcESzL+meJW7xb6TLmkgWy1rDc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MmjqZ4Bwp3Be9YZkCiQrCu81B7RID2MZyRYNDKbotmDWxShteyHcm1yIXpHbWaMMz
         ixOQuE0fZAoVnWX0HxLiz+EoZ2ijRs8ub7JyJRcOojiVC5rIp49fVbWYZswP3IwpnH
         WijGAA3AtwxEYEWjAsuf2R+b8xhgzBN1F2G5BHkY=
Date:   Tue, 30 May 2023 19:09:59 +0200
Subject: [PATCH v3 3/4] block: constify struct part_attr_group
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v3-3-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685466599; l=600;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=peTYqiDIJwMTxZXYjxcESzL+meJW7xb6TLmkgWy1rDc=;
 b=+Z0u8TxxAEUMeMtX7vnTcg9bBfSWnxQKVHdDaMkRx8ThH4UBGbG+XxJDmSna8Y+jVPy8qvJa3
 vMWFel4P/ptBSHvxB1hRLoMenbH1i+utkQEHWKC7N7gBxWKydnFQlN0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct is never modified so it can be const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 2bc21063edef..d5f5633bf725 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -228,7 +228,7 @@ static struct attribute *part_attrs[] = {
 	NULL
 };
 
-static struct attribute_group part_attr_group = {
+static const struct attribute_group part_attr_group = {
 	.attrs = part_attrs,
 };
 

-- 
2.40.1

