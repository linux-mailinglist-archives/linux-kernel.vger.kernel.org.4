Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F462B379
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKPGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKPGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:49:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9D624F;
        Tue, 15 Nov 2022 22:49:09 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBtpR5zL9zqST6;
        Wed, 16 Nov 2022 14:45:19 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:49:07 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:49:05 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <gregkh@suse.de>, <marcel@holtmann.org>, <jkosina@suse.cz>,
        <rdunlap@infradead.org>, <jirislaby@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        <syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com>
Subject: [PATCH] HID: core: fix shift-out-of-bounds in hid_report_raw_event
Date:   Wed, 16 Nov 2022 07:14:28 +0000
Message-ID: <20221116071428.191437-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Syzbot reported shift-out-of-bounds in hid_report_raw_event.

microsoft 0003:045E:07DA.0001: hid_field_extract() called with n (128) >
32! (swapper/0)
======================================================================
UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:1323:20
shift exponent 127 is too large for 32-bit type 'int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.1.0-rc4-syzkaller-00159-g4bbf3422df78 #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS
Google 10/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3a6/0x420 lib/ubsan.c:322
 snto32 drivers/hid/hid-core.c:1323 [inline]
 hid_input_fetch_field drivers/hid/hid-core.c:1572 [inline]
 hid_process_report drivers/hid/hid-core.c:1665 [inline]
 hid_report_raw_event+0xd56/0x18b0 drivers/hid/hid-core.c:1998
 hid_input_report+0x408/0x4f0 drivers/hid/hid-core.c:2066
 hid_irq_in+0x459/0x690 drivers/hid/usbhid/hid-core.c:284
 __usb_hcd_giveback_urb+0x369/0x530 drivers/usb/core/hcd.c:1671
 dummy_timer+0x86b/0x3110 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0xf5/0x210 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers+0x76a/0x980 kernel/time/timer.c:1790
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1803
 __do_softirq+0x277/0x75b kernel/softirq.c:571
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1107
======================================================================

If the size of the integer (unsigned n) is bigger than 32 in snto32(),
shift exponent will be too large for 32-bit type 'int', resulting in a
shift-out-of-bounds bug.
Fix this by adding a check on the size of the integer (unsigned n) in
snto32(). To add support for n greater than 32 bits, set n to 32, if n
is greater than 32.

Reported-by: syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com
Fixes: dde5845a529f ("[PATCH] Generic HID layer - code split")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9c1d31f63f85..bd47628da6be 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1315,6 +1315,9 @@ static s32 snto32(__u32 value, unsigned n)
 	if (!value || !n)
 		return 0;
 
+	if (n > 32)
+		n = 32;
+
 	switch (n) {
 	case 8:  return ((__s8)value);
 	case 16: return ((__s16)value);
-- 
2.25.1

