Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F586A69E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCAJiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:38:53 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1E12C2412B;
        Wed,  1 Mar 2023 01:38:51 -0800 (PST)
Received: from ubuntu.localdomain (unknown [106.117.98.179])
        by mail-app3 (Coremail) with SMTP id cC_KCgCHCLVWGP9jxVKcDQ--.89S2;
        Wed, 01 Mar 2023 17:18:25 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] media: usb: siano: Fix warning due to null work_func_t function pointer
Date:   Wed,  1 Mar 2023 17:18:13 +0800
Message-Id: <20230301091813.82543-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgCHCLVWGP9jxVKcDQ--.89S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8JFyDtFyDXrW5uFWxZwb_yoW5CFW3pw
        18XrWjkFW8JF1Yyrn8Ar1UG3W5J3WxZa48GrW7Wr1rWF1rG3W7Xa48KFWjkryUtr4UZrya
        yF90q34xtr1jgaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUIhFcUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgsBAVZdtd2CmAAIs4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

