Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03E5F20F6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJBBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJBBlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 21:41:13 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44ABC564FF;
        Sat,  1 Oct 2022 18:41:10 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.190.65.158])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXaLQg7DhjDY5WBw--.53562S2;
        Sun, 02 Oct 2022 09:41:00 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, kuba@kernel.org, davem@davemloft.net,
        andrii@kernel.org, gregkh@linuxfoundation.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] scsi: target: iscsi: cxgbit: fix sleep-in-atomic-context bug in cxgbit_abort_conn
Date:   Sun,  2 Oct 2022 09:40:47 +0800
Message-Id: <20221002014047.23066-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgAXaLQg7DhjDY5WBw--.53562S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykKF18trW7uw43Aw1fZwb_yoW8XrW5pF
        4v9348AF4kG3y5WF48AF40kr4Sv3W5JFy3Ga47uws8Zws0vr98KrsYya4xZay5WFykWF47
        XF4ruw1UGF4qyrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIKAVZdtbvX2gBFsG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function iscsit_handle_time2retain_timeout() is a timer handler that
runs in an atomic context, but it calls "alloc_skb(0, GFP_KERNEL | ...)"
that may sleep. As a result, the sleep-in-atomic-context bug will happen.
The process is shown below:

iscsit_handle_time2retain_timeout()
 iscsit_close_session()
  iscsit_free_connection_recovery_entries()
   iscsit_free_cmd()
    __iscsit_free_cmd()
     cxgbit_unmap_cmd()
      cxgbit_abort_conn()
       alloc_skb(0, GFP_KERNEL | ...) //may sleep

This patch changes the gfp_t parameter of alloc_skb() from GFP_KERNEL to
GFP_ATOMIC in order to mitigate the bug.

Fixes: 1ae01724ae92 ("cxgbit: Abort the TCP connection in case of data out timeout")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 3336d2b78bf..eb3da6d2c62 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -697,7 +697,7 @@ __cxgbit_abort_conn(struct cxgbit_sock *csk, struct sk_buff *skb)
 
 void cxgbit_abort_conn(struct cxgbit_sock *csk)
 {
-	struct sk_buff *skb = alloc_skb(0, GFP_KERNEL | __GFP_NOFAIL);
+	struct sk_buff *skb = alloc_skb(0, GFP_ATOMIC | __GFP_NOFAIL);
 
 	cxgbit_get_csk(csk);
 	cxgbit_init_wr_wait(&csk->com.wr_wait);
-- 
2.17.1

