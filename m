Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2718B6E2F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDOIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:00:14 -0400
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24B949D9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:00:11 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [106.117.97.24])
        by mail-app4 (Coremail) with SMTP id cS_KCgC3vAl_WTpk_1oQAA--.8648S2;
        Sat, 15 Apr 2023 16:00:09 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH RESEND] media: usb: siano: Fix warning due to null work_func_t function pointer
Date:   Sat, 15 Apr 2023 15:59:59 +0800
Message-Id: <20230415075959.5429-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgC3vAl_WTpk_1oQAA--.8648S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8JFyDtFyDXrW5uFWxZwb_yoW5CFW3pw
        18XrWjkFW8JF1Yyrn8Ar1UG3W5J3WxZa48GrW7Wr1rWF1rG3W7Xa48KFWjkryUtr4UZrya
        yF90q34xtr1jgaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU04E_DUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIGAWQ5a9oSIAAqsy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit ebad8e731c1c ("media: usb: siano: Fix use after
free bugs caused by do_submit_urb") adds cancel_work_sync() in
smsusb_stop_streaming(). But smsusb_stop_streaming() may be called,
even if the work_struct surb->wq has not been initialized. As a result,
the warning will occur. One of the processes that could lead to warning
is shown below:

smsusb_probe()
  smsusb_init_device()
    if (!dev->in_ep || !dev->out_ep || align < 0) {
         smsusb_term_device(intf);
           smsusb_stop_streaming()
             cancel_work_sync(&dev->surbs[i].wq);
               __cancel_work_timer()
                 __flush_work()
                   if (WARN_ON(!work->func)) // work->func is null

The log reported by syzbot is shown below:

WARNING: CPU: 0 PID: 897 at kernel/workqueue.c:3066 __flush_work+0x798/0xa80 kernel/workqueue.c:3063
Modules linked in:
CPU: 0 PID: 897 Comm: kworker/0:2 Not tainted 6.2.0-rc1-syzkaller #0
RIP: 0010:__flush_work+0x798/0xa80 kernel/workqueue.c:3066
...
RSP: 0018:ffffc9000464ebf8 EFLAGS: 00010246
RAX: 1ffff11002dbb420 RBX: 0000000000000021 RCX: 1ffffffff204fa4e
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffff888016dda0e8
RBP: ffffc9000464ed98 R08: 0000000000000001 R09: ffffffff90253b2f
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888016dda0e8
R13: ffff888016dda0e8 R14: ffff888016dda100 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd4331efe8 CR3: 000000000b48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_timer+0x315/0x460 kernel/workqueue.c:3160
 smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:182 [inline]
 smsusb_term_device+0xda/0x2d0 drivers/media/usb/siano/smsusb.c:344
 smsusb_init_device+0x400/0x9ce drivers/media/usb/siano/smsusb.c:419
 smsusb_probe+0xbbd/0xc55 drivers/media/usb/siano/smsusb.c:567
...

This patch adds check before cancel_work_sync(). If surb->wq has not
been initialized, the cancel_work_sync() will not be executed.

Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/media/usb/siano/smsusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 6f443c542c6..640737d3b8a 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -179,7 +179,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
-- 
2.17.1

