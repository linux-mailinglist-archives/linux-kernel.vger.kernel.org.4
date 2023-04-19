Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441B6E7A99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjDSNXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjDSNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:23:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F2146E4;
        Wed, 19 Apr 2023 06:22:57 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681910575;
        bh=kF2K3Rlh4UxwVdG+nyD6f0YN/COQ4qVDn3yxp2SKVxc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YFcCgHB8hGVlTs6lQ4T9459c4/d4RD3GEKKZ6KWt41n4/reI6B9YihsWBxTuhXcGe
         ZJ2q4Lm8Q1519saGzleo4rXllH3ATrhOp+8odSpXU2VUCGYNS47aTycBDc5SLXGlPk
         txYPxfm5rUXQ8DsBx0VWYqP4eurgBl6AngEUgVnE=
Date:   Wed, 19 Apr 2023 15:22:55 +0200
Subject: [PATCH v2 3/4] block: constify struct part_attr_group
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v2-3-817b58f85cd1@weissschuh.net>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
In-Reply-To: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681910574; l=600;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kF2K3Rlh4UxwVdG+nyD6f0YN/COQ4qVDn3yxp2SKVxc=;
 b=hGep4w3kBAcn2BOjS1uLDC86/cXeBxeh1sDHAoHUGWD8Pzz7IlRumdd7npMtycAN4auCvh7xQ
 P701kG2CAYvBm+/VUjf4ZtHX2qeArE5wFJh037KFpKqwZ10UILi7IMP
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
index 43bde8118a78..cb37ac71868e 100644
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

