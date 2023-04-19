Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B46E7461
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjDSHvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjDSHuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6AC661;
        Wed, 19 Apr 2023 00:50:09 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681890606;
        bh=+BWDSAdjFIxcN4cSYW2nKSzd7xdEBdtngZoCQpaUs9w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NyyuVOq0wU0MqJDnYPJa5VSqrfwPaWKLJpYHbP92zONHYlxLMpK1CBm2WXHkx5H7F
         Jlyp6HyboCrYmp238RVTZTIqD3mrPefNIEvw1GlIOlwGLC/DI5zLjyGG7uDBwG0FRU
         sUDOKZd0HT5Mh0QrwY5ynKcDxIVJMes1ZGlN6ZYU=
Date:   Wed, 19 Apr 2023 09:50:03 +0200
Subject: [PATCH 3/4] block: constify struct part_attr_group
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v1-3-2d66f2d83873@weissschuh.net>
References: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
In-Reply-To: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681890605; l=600;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+BWDSAdjFIxcN4cSYW2nKSzd7xdEBdtngZoCQpaUs9w=;
 b=s7SU+6Q3vLf9/5zFRUxMbk2GkvuT/h+4uDo7UJ/0fT30OjxJdFEV0JZkGR8VXzZScEVeCnbi8
 7Q2n3iAfQX4BuRsBtnY97fCWHLSAJOJmWKzAfFgWcd+YIqLuMvAV11y
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
index 812407ea38e9..032e415618cb 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -236,7 +236,7 @@ static struct attribute *part_attrs[] = {
 	NULL
 };
 
-static struct attribute_group part_attr_group = {
+static const struct attribute_group part_attr_group = {
 	.attrs = part_attrs,
 };
 

-- 
2.40.0

