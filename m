Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637CF6E7A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjDSNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjDSNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:23:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3A83F7;
        Wed, 19 Apr 2023 06:22:57 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681910575;
        bh=F1Xh/pDNAlchgFKirA0vgid7PL0x67US+gdddb/wlr4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VNIRAemzz0YzaaaYfycLL5n96oMcnfjzaSn+rSAqGd5jKy3U+Lcnygbi4iJbVWwcO
         iq2n6Ry4eGkUuI7mNVkZjgy4QOFGROvd2j0tsXElI93P3VtTBcuxvzzoi2yRCcoFyB
         nvDTZASfh42ptV99LsX2cV6gNT1lfBpMQv0lNxvc=
Date:   Wed, 19 Apr 2023 15:22:53 +0200
Subject: [PATCH v2 1/4] block: constify partition prober array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v2-1-817b58f85cd1@weissschuh.net>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
In-Reply-To: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681910574; l=828;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=F1Xh/pDNAlchgFKirA0vgid7PL0x67US+gdddb/wlr4=;
 b=VuyLji4uA3RU0pCdR8qOs9X6x53gpMW01ICgxehm6k/R3hR/2nK1o5yq5lHod71uW2GsxbcWr
 7ZS+XtaJqhWDXmBVHPvQz6uVBwUMCKoIac5GOj8V8uRDAwcyZoEj5fJ
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

The array is never modified so it can be const.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304191640.SkNk7kVN-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7b8ef6296abd..890072ae5c7c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -12,7 +12,7 @@
 #include <linux/raid/detect.h>
 #include "check.h"
 
-static int (*check_part[])(struct parsed_partitions *) = {
+static int (*const check_part[])(struct parsed_partitions *) = {
 	/*
 	 * Probe partition formats with tables at disk address 0
 	 * that also have an ADFS boot block at 0xdc0.

-- 
2.40.0

