Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F763AD97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiK1QXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiK1QWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:22:49 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C3ED2098B;
        Mon, 28 Nov 2022 08:22:35 -0800 (PST)
Received: from zju.edu.cn (unknown [10.12.77.33])
        by mail-app2 (Coremail) with SMTP id by_KCgB3J2go4IRjlapJCA--.26077S4;
        Tue, 29 Nov 2022 00:22:00 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>,
        syzbot+fce48a3dd3368645bd6c@syzkaller.appspotmail.com
Subject: [PATCH v0] media: dvbdev: fix refcnt bug
Date:   Tue, 29 Nov 2022 00:21:59 +0800
Message-Id: <20221128162159.16901-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgB3J2go4IRjlapJCA--.26077S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45KFyrCw4rKFyfuF43trb_yoW5JFy8pa
        yUGFyYkrW8Kr1xJr4UAw1UJr15Jw4vyFy8Jry7Xr1DtF17Gw1UJr1jyrWUAryDJrs7Zr17
        tr1UWwn2vr4DWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
        xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
        kI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE
        74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit initialize the dvbdev->ref before the template copy,
which will overwrite the reference and cause refcnt bug.

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc6-next-20221128-syzkaller #0
...
RIP: 0010:refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
RSP: 0000:ffffc900000678d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88813ff58000 RSI: ffffffff81660e7c RDI: fffff5200000cf0c
RBP: ffff888022a45010 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000c48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 kref_get include/linux/kref.h:45 [inline]
 dvb_device_get drivers/media/dvb-core/dvbdev.c:585 [inline]
 dvb_register_device+0xe83/0x16e0 drivers/media/dvb-core/dvbdev.c:517
...

Just place the kref_init at correct position.

Reported-by: syzbot+fce48a3dd3368645bd6c@syzkaller.appspotmail.com
Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d45673cb3..2a857cf70 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -482,8 +482,8 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		return -ENOMEM;
 	}
 
-	kref_init(&dvbdev->ref);
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
+	kref_init(&dvbdev->ref);
 	dvbdev->type = type;
 	dvbdev->id = id;
 	dvbdev->adapter = adap;
-- 
2.38.1

