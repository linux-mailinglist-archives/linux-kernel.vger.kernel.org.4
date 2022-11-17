Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4FC62D12D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiKQCh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKQChX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:37:23 -0500
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6A232EF3A;
        Wed, 16 Nov 2022 18:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=woxW9
        qfXbc/Rwz9N9Bvo3L2Mqtqice/69vnimc6ZZQE=; b=DXN4c8Re1I9FWGAJNfBoI
        gzgkljQk3IX2xcw/yYf9j9YOU/sr9XZQzPBIkUHlAU4B3TqCO4naHzYdqH9Lrji+
        92MgcyQxNC4zt+gokAMV/PG8vOGowA4XSJbh+R4+WAvSwGfJnSxxMzkV9IRrL1SS
        qU6556GEMYO6CvHbXm6NXs=
Received: from localhost.localdomain (unknown [36.112.3.106])
        by smtp4 (Coremail) with SMTP id HNxpCgDXv5kmnnVjtcyRsg--.7212S4;
        Thu, 17 Nov 2022 10:36:46 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei@gmail.com>,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: lpfc: Fix potential memory leak in lpfcdiag_sli3_loop_post_rxbufs()
Date:   Thu, 17 Nov 2022 10:36:19 +0800
Message-Id: <20221117023619.9565-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDXv5kmnnVjtcyRsg--.7212S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jr18ZFyrAF4kXw13XF13Arb_yoW8Jry8pF
        WfKa47ur95tF1IgrnxG3W5XFnYqa9Yg34jkFs29ws8Wa4xuFyFgF47CryrWry8AF1xAry8
        WrZ7KF95WFW7XwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziJ3vUUUUUU=
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFR68jF5mNZwQXgAAsk
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianglei Nie <niejianglei@gmail.com>

lpfcdiag_sli3_loop_post_rxbufs() allocates a memory chunk from "rxbuffer"
with diag_cmd_data_alloc(). The "rxbuffer" should be freed when gets some
error. But when the function gets some error and jump to
"err_post_rxbufs_exit",The "rxbuffer" is not released, which will lead to
a memory leak.

We should free the "rxbuffer" with diag_cmd_data_free() in
"err_post_rxbufs_exit" when the "rxbuffer" is not NULL.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Jianglei Nie <niejianglei@gmail.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 852b025e2fec..2693def758b7 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2989,8 +2989,11 @@ static int lpfcdiag_sli3_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 err_post_rxbufs_exit:
 
 	if (rxbmp) {
-		if (rxbmp->virt)
+		if (rxbmp->virt) {
+			if (rxbuffer != NULL)
+				diag_cmd_data_free(phba, rxbuffer);
 			lpfc_mbuf_free(phba, rxbmp->virt, rxbmp->phys);
+		}
 		kfree(rxbmp);
 	}
 
-- 
2.25.1

