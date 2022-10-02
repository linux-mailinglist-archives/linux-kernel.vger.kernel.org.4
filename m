Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B15F2141
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 06:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJBEH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiJBEHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 00:07:25 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE354220E9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 21:07:22 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.190.65.158])
        by mail-app2 (Coremail) with SMTP id by_KCgB3fvZuDjljRyqBBg--.23164S2;
        Sun, 02 Oct 2022 12:07:17 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send
Date:   Sun,  2 Oct 2022 12:07:09 +0800
Message-Id: <20221002040709.27849-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgB3fvZuDjljRyqBBg--.23164S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF17WFWktr1xCrW3Xr1fWFg_yoWkArg_Ca
        1xJ3ZxCrn29ry7uwn8trs09rWYyF4UZ3WvkFsagrWaq398Jr18X3s7Zrnruw1fWrWfCr13
        CrW3Aw1rA3W7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIKAVZdtbvX2gBLsI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gsm_dlci_t1() is a timer handler that runs in an
atomic context, but it calls "kzalloc(..., GFP_KERNEL)" that
may sleep. As a result, the sleep-in-atomic-context bug will
happen. The process is shown below:

gsm_dlci_t1()
 gsm_dlci_open()
  gsm_modem_update()
   gsm_modem_upd_via_msc()
    gsm_control_send()
     kzalloc(sizeof(.., GFP_KERNEL) //may sleep

This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
GFP_ATOMIC in order to mitigate the bug.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 01c112e2e21..2a0de70e0be 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1670,7 +1670,7 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 		unsigned int command, u8 *data, int clen)
 {
 	struct gsm_control *ctrl = kzalloc(sizeof(struct gsm_control),
-						GFP_KERNEL);
+						GFP_ATOMIC);
 	unsigned long flags;
 	if (ctrl == NULL)
 		return NULL;
-- 
2.17.1

