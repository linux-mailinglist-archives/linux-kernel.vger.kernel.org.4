Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28370D6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjEWIIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjEWIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:08:18 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB1110C3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:07:50 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [218.12.19.251])
        by mail-app2 (Coremail) with SMTP id by_KCgDX_n1Ccmxk1PiyAw--.43277S2;
        Tue, 23 May 2023 15:59:07 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] dm crypt: fix sleep-in-atomic-context bug in kcryptd_crypt_tasklet
Date:   Tue, 23 May 2023 15:58:57 +0800
Message-Id: <20230523075857.76520-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDX_n1Ccmxk1PiyAw--.43277S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18ur45Ww47Wr1kXFyrWFg_yoW8Xw47pF
        WruF95CFy8Gr4Ygw1DKF18tFy5Gw4kGFW3GFW8Wa43AF15Xr1vvFy2krWUtr4UZF95ZFy7
        ZFWkAay5WF1qy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU52NtUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQEAWRrhN4LtgAxsb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve the IO performance of the dm-crypt
implementation, the commit 39d42fa96ba1 ("dm crypt:
add flags to optionally bypass kcryptd workqueues")
adds tasklet to do the crypto operations.

The tasklet callback function kcryptd_crypt_tasklet()
calls kcryptd_crypt() which is an original workqueue
callback function that may sleep. As a result, the
sleep-in-atomic-context bug may happen. The process
is shown below.

   (atomic context)
kcryptd_crypt_tasklet()
  kcryptd_crypt()
    kcryptd_crypt_write_convert()
      wait_for_completion() //may sleep

The wait_for_completion() is a function that may sleep.
In order to mitigate the bug, this patch changes
wait_for_completion() to try_wait_for_completion().

Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/md/dm-crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8b47b913ee8..5e2b2463d87 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2085,7 +2085,8 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	crypt_finished = atomic_dec_and_test(&ctx->cc_pending);
 	if (!crypt_finished && kcryptd_crypt_write_inline(cc, ctx)) {
 		/* Wait for completion signaled by kcryptd_async_done() */
-		wait_for_completion(&ctx->restart);
+		while (!try_wait_for_completion(&ctx->restart))
+			;
 		crypt_finished = 1;
 	}
 
-- 
2.17.1

