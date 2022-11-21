Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58859632C85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiKUTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKUTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:58 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDACCFE80
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:00:56 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6BD2B5FD0D;
        Mon, 21 Nov 2022 22:00:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669057254;
        bh=tTM44IR5Faf10C/P1nfxsNgdug0WyLlkFkfRmk6dQz8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ZgPZzRvJE29M4MUwixqY94klL086904XptaKyfBbZ2r0zNobazayO2F7pRoP9kY3F
         5FUTHdEF2kVnf8QEJvqFG9CdwFShkARs239S88MgZl6Gucbb+ftJwCwrqHOkkTtBkG
         BPorMZxxQ4qQ3EQ3/Mz4jPfoTgpr0qQqUEUJf5M945USJXQ4EhhM0WHj7GvHweyxRa
         O/9jKeTOYMJLmAJSObuZn6LFGSL9oyx5LeBV/+ovuM/PhSF5x0i6QYWJskM2bnaw1U
         HMHzlu+XismWsdQN/V45vD5LFfjERfrHkLz/a6jT6n1ykjM8Zhu/AgwVmU+yEZwF3s
         JWihXUjKj9KJw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 22:00:54 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <ddrokosov@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 4/4] zram: recompression: add ZRAM_MERGED check
Date:   Mon, 21 Nov 2022 22:00:20 +0300
Message-ID: <20221121190020.66548-5-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221121190020.66548-1-avromanov@sberdevices.ru>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/21 16:41:00 #20594217
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to recompress merged pages in the current
implementation. Although, in the future it is possible to add
support for recompression of merged pages.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7a267b37e5db..07661283ea15 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2211,7 +2211,8 @@ static ssize_t recompress_store(struct device *dev,
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
 		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
 		    zram_test_flag(zram, index, ZRAM_SAME) ||
-		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE) ||
+		    zram_test_flag(zram, index, ZRAM_MERGED))
 			goto next;
 
 		err = zram_recompress(zram, index, page, threshold,
-- 
2.25.1

