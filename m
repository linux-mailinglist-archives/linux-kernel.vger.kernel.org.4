Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F86A3DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB0JHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0JGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:06:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179330C8;
        Mon, 27 Feb 2023 00:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29DC5B80CAE;
        Mon, 27 Feb 2023 08:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8899C433EF;
        Mon, 27 Feb 2023 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677488195;
        bh=hZFXPE1G1IOogWxssAFdNmsEjPCefrDxFpP6NdmV6Bs=;
        h=From:To:Cc:Subject:Date:From;
        b=OR0I7qX+Fp3CMPL4kNqPkMgb2XWqa2PhPO2ypF3yNw11COAb3YriGBaEOqf6XRYX2
         c+f8DfetqdyxBn50OA05mMF59vvsjAL1m7vSYE/UON40LaKlOFOAXCfby4DF6DmHK0
         ONH3od0HFZ2+eXh6x/WteokRFOhCsUVmRHfLF1BKgWAVTNGjUDrtL03/nOmb6TmfWi
         lPRbRC0s4x7ZsmhF0KWUoG/1rWP6ddd3AIi72G2Z/4z5r0l1Vtz2xggDpoyY3GGPbJ
         iFnsxzPw7pl9XleeBwhZauuSnBoaZtyX7Ri4W+lqv8oNl4ArYOmEUJ3o5HjxPCmCZU
         D87hW1pV7WgHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] zram: fix 32-bit atomic_long_t print
Date:   Mon, 27 Feb 2023 09:56:21 +0100
Message-Id: <20230227085629.2362316-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The type used to print &pool_stats.objs_moved is inconsistent with the
definition:

drivers/block/zram/zram_drv.c: In function 'mm_stat_show':
drivers/block/zram/zram_drv.c:1234:44: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]

Change the printing code to match.

Fixes: b7d89654a988 ("zram: show zsmalloc objs_moved stat in mm_stat")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3194e9254c6f..5c4ac0d3e850 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1231,7 +1231,7 @@ static ssize_t mm_stat_show(struct device *dev,
 			atomic_long_read(&pool_stats.pages_compacted),
 			(u64)atomic64_read(&zram->stats.huge_pages),
 			(u64)atomic64_read(&zram->stats.huge_pages_since),
-			(u64)atomic64_read(&pool_stats.objs_moved));
+			(u64)atomic_long_read(&pool_stats.objs_moved));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.39.2

