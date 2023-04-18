Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F36E5961
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjDRGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDRGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:18 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2D10F5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:15 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7493D5FD02;
        Tue, 18 Apr 2023 09:25:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799112;
        bh=Fse+MPOrkQw272jW64QlMpSMJAmRuGF8pomAFgTEHuE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=hZA5i7iCjFc/tKT3rPkI4USwY//pOo/cnffBym9jGgM50MwyUjdHPt3CKY+nkdck7
         18Q/R6NVSISemgJNhsRPONl0XlRFTYa0gERJxmvDBRNqpjtXR/899VJNg0Qr/WG2kg
         t5NB83Ioh5dzeCdWIPEZEjEzjTEXmNtkQmf3PaRGOltOxke0zECiwvryQkKsvE7WnO
         VgiBLmR+AGTedzfEcCgIXibEZ5F0neD/819/sHGew355vgmqf0EpI3uZZhg6wtHgpJ
         SjmvMJFTAhZEOXX8FqLEsccEWCnQcs8NgPv+VLzTBfK6FzcLdSMwnrN2TCBTxZyyr2
         YGMFbWI1OU3Mw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:10 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 0/5] Introduce objects folding mechanism
Date:   Tue, 18 Apr 2023 09:24:58 +0300
Message-ID: <20230418062503.62121-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 02:02:00 #21122658
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This RFC series adds feature which allows fold identical
zsmalloc objects into a single one.

Based on ZRAM version:
https://lore.kernel.org/lkml/Y3w8%2Fq%2FHoSbqamoD@google.com/t/

Let's imagine that 3 objects with the same content got into zsmalloc:

+----------------+   +----------------+   +----------------+
|    handle 1    |   |    handle 2    |   |    handle 3    |
+-------+--------+   +-------+--------+   +--------+-------+
        |                    |                     |
        |                    |                     |
+-------v--------+   +-------v---------+  +--------v-------+
|zsmalloc  object|   |zsmalloc  object |  |zsmalloc  object|
++--------------++   +-+-------------+-+  ++--------------++
 +--------------+      +-------------+     +--------------+
 | buffer: "abc"|      |buffer: "abc"|     | buffer: "abc"|
 +--------------+      +-------------+     +--------------+

As you can see, the data is duplicated. Fold mechanism saves
(after scanning objects) only one zsmalloc object. Here's
what happens after the scan and fold:

+----------------+   +----------------+   +----------------+
|    handle 1    |   |    handle 2    |   |    handle 3    |
+-------+--------+   +-------+--------+   +--------+-------+
        |                    |                     |
        |                    |                     |
        |           +--------v---------+           |
        +-----------> zsmalloc  object <-----------+
                    +--+-------------+-+
                       +-------------+
                       |buffer: "abc"|
                       +-------------+

Thus, we reduced the amount of memory occupied by 3 times.

This mechanism doesn't affect the perf of the zsmalloc itself in
any way (maybe just a little bit on the zs_free() function).
In order to describe each such identical object, we (constantly)
need sizeof(fold_rbtree_node) bytes. Also, all struct size_class now
have new field struct rb_root fold_rbtree.

Testing on my system (8GB RAM + 1Gb ZRAM SWAP) showed that at high
loads, on average, when calling the fold mechanism, we can save
up to 15-20% of the memory usage.

This patch series adds a new sysfs node into ZRAM - trigger folding
and provides new field in mm_stat. This field shows how many pages
freed during folding:

  $ cat /sys/block/zram0/mm_stat
    431452160 332984392 339894272 0 339894272 282 0 51374 51374 0

  $ echo 1 > /sys/block/zram0/fold

  $ cat /sys/block/zram/mm_stat
    431452160 270376848 287301504 0 339894272 282 0 51374 51374 6593

Alexey Romanov (5):
  mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
  mm/zsmalloc: get rid of PAGE_MASK
  mm/zsmalloc: introduce objects folding mechanism
  zram: add fold sysfs knob
  zram: add pages_folded to stats

 Documentation/admin-guide/blockdev/zram.rst |   2 +
 drivers/block/zram/zram_drv.c               |  30 +-
 include/linux/zsmalloc.h                    |   4 +
 mm/Kconfig                                  |   9 +
 mm/zsmalloc.c                               | 484 +++++++++++++++++++-
 5 files changed, 513 insertions(+), 16 deletions(-)

-- 
2.38.1

