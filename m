Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A696AFCD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCHCVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHCVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:21:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C4A6499
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:21:06 -0800 (PST)
X-UUID: ddc234eabd5711eda06fc9ecc4dadd91-20230308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=13Wy0Ed++1zXh0KzmnLa4BZ0fSU9hMpfdWuFisECxUA=;
        b=p9xVSjlu85X97VqmsUP1EoW0h7c+G3qBfxHAdOFe7FoOdXDWNvMtir6WIiFA4FeWwqVhTDZInK7b4JglgZ2KQS7y55qmgjH9csmxPv6Lr6skGBBAzAKXdxGs/no91MmloS0gswgAerheuZ5/vspbbNKSEgeCM94nELVWv8V6bu4=;
X-CID-CACHE: Type:Local,Time:202303081011+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:52d32188-1362-4898-a3a5-ebd9b2f65e21,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:57e616f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: ddc234eabd5711eda06fc9ecc4dadd91-20230308
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1123491311; Wed, 08 Mar 2023 10:20:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 8 Mar 2023 10:20:59 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 8 Mar 2023 10:20:58 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>,
        <haibo.li@mediatek.com>
Subject: [PATCH] kcsan:fix alignment_fault when read unaligned instrumented memory
Date:   Wed, 8 Mar 2023 10:20:57 +0800
Message-ID: <20230308022057.151078-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enable kcsan on arm64+linux-5.15,it reports alignment_fault
when access unaligned address.
Here is the oops log:
"
Trying to unpack rootfs image as initramfs.....
Unable to handle kernel paging request at virtual address
  ffffff802a0d8d7171
Mem abort info:o:
  ESR = 0x9600002121
  EC = 0x25: DABT (current EL), IL = 32 bitsts
  SET = 0, FnV = 0 0
  EA = 0, S1PTW = 0 0
  FSC = 0x21: alignment fault
Data abort info:o:
  ISV = 0, ISS = 0x0000002121
  CM = 0, WnR = 0 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000002835200000
[ffffff802a0d8d71] pgd=180000005fbf9003, p4d=180000005fbf9003,
pud=180000005fbf9003, pmd=180000005fbe8003, pte=006800002a0d8707
Internal error: Oops: 96000021 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 45 Comm: kworker/u8:2 Not tainted
  5.15.78-android13-8-g63561175bbda-dirty #1
...
pc : kcsan_setup_watchpoint+0x26c/0x6bc
lr : kcsan_setup_watchpoint+0x88/0x6bc
sp : ffffffc00ab4b7f0
x29: ffffffc00ab4b800 x28: ffffff80294fe588 x27: 0000000000000001
x26: 0000000000000019 x25: 0000000000000001 x24: ffffff80294fdb80
x23: 0000000000000000 x22: ffffffc00a70fb68 x21: ffffff802a0d8d71
x20: 0000000000000002 x19: 0000000000000000 x18: ffffffc00a9bd060
x17: 0000000000000001 x16: 0000000000000000 x15: ffffffc00a59f000
x14: 0000000000000001 x13: 0000000000000000 x12: ffffffc00a70faa0
x11: 00000000aaaaaaab x10: 0000000000000054 x9 : ffffffc00839adf8
x8 : ffffffc009b4cf00 x7 : 0000000000000000 x6 : 0000000000000007
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc00a70fb70
x2 : 0005ff802a0d8d71 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 kcsan_setup_watchpoint+0x26c/0x6bc
 __tsan_read2+0x1f0/0x234
 inflate_fast+0x498/0x750
 zlib_inflate+0x1304/0x2384
 __gunzip+0x3a0/0x45c
 gunzip+0x20/0x30
 unpack_to_rootfs+0x2a8/0x3fc
 do_populate_rootfs+0xe8/0x11c
 async_run_entry_fn+0x58/0x1bc
 process_one_work+0x3ec/0x738
 worker_thread+0x4c4/0x838
 kthread+0x20c/0x258
 ret_from_fork+0x10/0x20
Code: b8bfc2a8 2a0803f7 14000007 d503249f (78bfc2a8) )
---[ end trace 613a943cb0a572b6 ]-----
"

After checking linux 6.3-rc1 on QEMU arm64,it still has the possibility
to read unaligned address in read_instrumented_memory(qemu can not
emulate alignment fault)

To fix alignment fault and read the value of instrumented memory
more effective,bypass the unaligned access in read_instrumented_memory.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 kernel/kcsan/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 54d077e1a2dc..88e75d7d85d2 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -337,6 +337,11 @@ static void delay_access(int type)
  */
 static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
 {
+	bool aligned_read = (size == 1) || IS_ALIGNED((unsigned long)ptr, size);
+
+	if (!aligned_read)
+		return 0;
+
 	switch (size) {
 	case 1:  return READ_ONCE(*(const u8 *)ptr);
 	case 2:  return READ_ONCE(*(const u16 *)ptr);
-- 
2.25.1

