Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67400716A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjE3RKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjE3RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:10:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A30C9;
        Tue, 30 May 2023 10:10:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685466599;
        bh=apIFDLHl3uyZ3nUh5SjhWlSyk5P+UTn/1j0vvZ5474M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oPF56zRQrlugpPXKlPAegMLvT8bylBT6l6eq0rW00XU8jltV+SONKMfkNdeHt0FgC
         A1+k39drMfa3hR/yGkObcA8Bp3nMK5SugOSAEWJndacstmFZSRj/HkMJnIgDFQfUNr
         rerf/z8GpUbUmTsAddDPa3IcV6M+oa4ep+KXfDy4=
Date:   Tue, 30 May 2023 19:09:57 +0200
Subject: [PATCH v3 1/4] block: constify partition prober array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v3-1-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685466599; l=830;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=apIFDLHl3uyZ3nUh5SjhWlSyk5P+UTn/1j0vvZ5474M=;
 b=IFJ0t3Kix1Cs0Berp2pyXH7ZCfDifLrNQG5HeDr/OAwefjYUQYpW5RGF+nbqHWjQzd7iKD9eR
 U+Y+YkpnlSIACPpgz2RrEK20+BHx3DDi8ktcWcGrALyEfNvDHNqGilY
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
Closes: https://lore.kernel.org/oe-kbuild-all/202304191640.SkNk7kVN-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..650603dbe557 100644
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
2.40.1

