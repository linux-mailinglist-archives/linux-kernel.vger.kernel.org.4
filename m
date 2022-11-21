Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC070632C84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKUTBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:58 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794DD0DDA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:00:54 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B44275FD02;
        Mon, 21 Nov 2022 22:00:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669057251;
        bh=94J4V6Ls316AqryyMZmBCDT4NIvXDUVp2JtOV9OlzRc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=aYIyuMIboz0W6DJ6i8lYtxkJL5XEoZPiVXv6TDGwRe7BzvLhJnaPeVxSrAxpc+MIk
         HzSAFVWWLMqmJaPRxAIeiW3PHoB3vDtsT5/8wukhP9lgr+avn50xU61LvkAMUs+QSE
         4QhQF0B4RYPFY7Y2zL+eQHwC6j/2wrRHrJ86WXODWvYxvRQOWqbOcKSFvvU9JdoF2q
         SAcemz3So2nX20e61dSmi78IdOxrdP74YiFXvEGSKec/5GyHXNNq51cmkUrRu151Zd
         Cd2Qcm15t/QPFRqwTIDI0K2eGRt/5Hg8iLjlSYwSj6NSQ1neryIKjwGHNexl6llh9L
         o6ze4UScdUArA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 22:00:49 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <ddrokosov@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Date:   Mon, 21 Nov 2022 22:00:16 +0300
Message-ID: <20221121190020.66548-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
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

Hello!

This RFC series adds feature which allows merge identical
compressed pages into a single one. The main idea is that
zram only stores object references, which store the compressed
content of the pages. Thus, the contents of the zsmalloc objects
don't change in any way.

For simplicity, let's imagine that 3 pages with the same content
got into zram:

+----------------+   +----------------+   +----------------+
|zram_table_entry|   |zram_table_entry|   |zram_table_entry|
+-------+--------+   +-------+--------+   +--------+-------+
        |                    |                     |
        | handle (1)         | handle (2)          | handle (3)
+-------v--------+   +-------v---------+  +--------v-------+
|zsmalloc  object|   |zsmalloc  object |  |zsmalloc  object|
++--------------++   +-+-------------+-+  ++--------------++
 +--------------+      +-------------+     +--------------+
 | buffer: "abc"|      |buffer: "abc"|     | buffer: "abc"|
 +--------------+      +-------------+     +--------------+

As you can see, the data is duplicated. Merge mechanism saves
(after scanning objects) only one zsmalloc object. Here's
what happens ater the scan and merge:

+----------------+   +----------------+   +----------------+
|zram_table_entry|   |zram_table_entry|   |zram_tabl _entry|
+-------+--------+   +-------+--------+   +--------+-------+
        |                    |                     |
        | handle (1)         | handle (1)          | handle (1)
        |           +--------v---------+           |
        +-----------> zsmalloc  object <-----------+
                    +--+-------------+-+
                       +-------------+
                       |buffer: "abc"|
                       +-------------+

Thus, we reduced the amount of memory occupied by 3 times.

This mechanism doesn't affect the perf of the zram itself in
any way (maybe just a little bit on the zram_free_page function).
In order to describe each such identical object, we (constantly)
need sizeof(zram_rbtree_node) bytes. So, for example, if the system
has 20 identical buffers with a size of 1024, the memory gain will be
(20 * 1024) - (1 * 1024 + sizeof(zram_rbtree_node)) = 19456 -
sizeof(zram_rbtree_node) bytes. But, it should be understood, these are
counts without zsmalloc data structures overhead.

Testing on my system (8GB ram + 1 gb zram swap) showed that at high 
loads, on average, when calling the merge mechanism, we can save 
up to 15-20% of the memory usage.

This patch serices adds a new sysfs node (trigger merging) and new 
field in mm_stat (how many pages are merged in zram at the moment):

  $ cat /sys/block/zram/mm_stat
    431452160 332984392 339894272 0 339894272 282 0 51374 51374 0

  $ echo 1 > /sys/block/zram/merge

  $ cat /sys/block/zram/mm_stat
    431452160 270376848 287301504 0 339894272 282 0 51374 51374 6593

Alexey Romanov (4):
  zram: introduce merge identical pages mechanism
  zram: add merge sysfs knob
  zram: add pages_merged counter to mm_stat
  zram: recompression: add ZRAM_MERGED check

 Documentation/admin-guide/blockdev/zram.rst |   2 +
 drivers/block/zram/zram_drv.c               | 315 +++++++++++++++++++-
 drivers/block/zram/zram_drv.h               |   7 +
 3 files changed, 320 insertions(+), 4 deletions(-)

-- 
2.25.1

