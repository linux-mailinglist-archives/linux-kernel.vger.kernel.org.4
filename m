Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA074622556
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKII15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKII1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5E13D52;
        Wed,  9 Nov 2022 00:27:50 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N6dLR2gyvzJnRL;
        Wed,  9 Nov 2022 16:24:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:48 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH 00/13] leds: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:01 +0800
Message-ID: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fault-inject tests reports this issue:

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 2 PID: 52 at kernel/locking/mutex.c:582 __mutex_lock+0x1366/0x15b0
Call Trace:
 <TASK>
   cr0014114_set_sync+0x2d/0x80 [leds_cr0014114 dbd1de3fefae3e163bcc08f4eeaa6d1b243203a9]
   set_brightness_delayed+0xc2/0x140
   process_one_work+0x651/0xc30
   worker_thread+0x30b/0x820
   kthread+0x1a0/0x1e0
   ret_from_fork+0x1f/0x30
 </TASK>

The issue occurs in the following scenarios:

.probe()
  mutex_init()
  led->brightness_set_blocking = callback  <-- e.g. cr0014114_set_sync()
  devm_led_classdev_register_ext()
  <-- dr->node.release = devm_led_classdev_release()
...

.remove()
  mutex_destroy(lock)         <-- lock destroy

worker_thread()
  set_brightness_work
    set_brightness_delayed()
      __led_set_brightness_blocking()
        led_cdev->brightness_set_blocking()
        <-- callback, e.g. cr0014114_set_sync()
          mutex_lock(lock)              <-- lock is used after destroy

.release()
  devm_led_classdev_release()
    led_classdev_unregister()
      <-- flush set_brightness_work

When non-devm resources are allocated they mustn't be followed by devm
allocations, otherwise it will break the tear down ordering and might
lead to crashes or other bugs during ->remove() stage. Fix this by
wrapping mutex_destroy() call with devm_add_action_or_reset().

Wang Yufen (13):
  leds: cr0014114: Fix devm vs. non-devm ordering
  leds: el15203000: Fix devm vs. non-devm ordering
  leds: lm3532: Fix devm vs. non-devm ordering
  leds: lm3692x: Fix devm vs. non-devm ordering
  leds: lm3697: Fix devm vs. non-devm ordering
  leds: lp50xx: Fix devm vs. non-devm ordering
  leds: lp8860: Fix devm vs. non-devm ordering
  leds: mlxreg: Fix devm vs. non-devm ordering
  leds: mt6323: Fix devm vs. non-devm ordering
  leds: powernv: Fix devm vs. non-devm ordering
  leds: sc27xx: Fix devm vs. non-devm ordering
  leds: spi-byte: Fix devm vs. non-devm ordering
  leds: rt8515: Fix devm vs. non-devm ordering

 drivers/leds/flash/leds-rt8515.c | 11 +++++++++--
 drivers/leds/leds-cr0014114.c    | 11 ++++++++++-
 drivers/leds/leds-el15203000.c   | 18 +++++++++++-------
 drivers/leds/leds-lm3532.c       | 10 ++++++++++
 drivers/leds/leds-lm3692x.c      | 11 ++++++++++-
 drivers/leds/leds-lm3697.c       | 13 ++++++++++---
 drivers/leds/leds-lp50xx.c       | 12 ++++++++++--
 drivers/leds/leds-lp8860.c       | 11 +++++++++--
 drivers/leds/leds-mlxreg.c       | 20 ++++++++++----------
 drivers/leds/leds-mt6323.c       | 11 +++++++++--
 drivers/leds/leds-powernv.c      | 12 +++++++++---
 drivers/leds/leds-sc27xx-bltc.c  | 27 +++++++++++----------------
 drivers/leds/leds-spi-byte.c     | 21 ++++++++++-----------
 13 files changed, 128 insertions(+), 60 deletions(-)

-- 
1.8.3.1

