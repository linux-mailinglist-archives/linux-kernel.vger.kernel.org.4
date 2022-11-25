Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AE638DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKYPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKYPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:53:40 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AC1E4AF04;
        Fri, 25 Nov 2022 07:53:29 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgCXK97s5IBjv2N5CA--.23174S3;
        Fri, 25 Nov 2022 23:53:26 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 1/4] elevator: print none at first in elv_iosched_show even if the queue has a scheduler
Date:   Fri, 25 Nov 2022 23:53:11 +0800
Message-Id: <b613ad2a94ff552937672d70a5f2e43068e42bb2.1669391142.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669391142.git.nickyc975@zju.edu.cn>
References: <cover.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCXK97s5IBjv2N5CA--.23174S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWfuFy7Kry7CryfAw4rGrg_yoWDAFXEqF
        ZYq3Z7Jw45J34UCF4jyF1xtFWFvws3XF15Kwsrtr97Ja15Ka4jyr1xuFs8J34DGFWUua43
        A3srZ3s7AwnFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUQZ23UUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgEDB1ZdtcjbFAAHs5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the printing order of the io schedulers consistent, and removes
a redundant q->elevator check.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 599413620558..308bee253564 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -767,10 +767,12 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	if (!elv_support_iosched(q))
 		return sprintf(name, "none\n");
 
-	if (!q->elevator)
+	if (!q->elevator) {
 		len += sprintf(name+len, "[none] ");
-	else
+	} else {
+		len += sprintf(name+len, "none ");
 		cur = eq->type;
+	}
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(e, &elv_list, list) {
@@ -783,9 +785,6 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	}
 	spin_unlock(&elv_list_lock);
 
-	if (q->elevator)
-		len += sprintf(name+len, "none");
-
 	len += sprintf(len+name, "\n");
 	return len;
 }
-- 
2.34.1

