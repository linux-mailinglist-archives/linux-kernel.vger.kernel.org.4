Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A05F20B3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJBAT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJBATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:19:54 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A309DD81
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:19:50 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.190.65.158])
        by mail-app4 (Coremail) with SMTP id cS_KCgAXjk3_2DhjIc_GBg--.24421S2;
        Sun, 02 Oct 2022 08:19:20 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, james.smart@broadcom.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by nvme_fc_rcv_ls_req
Date:   Sun,  2 Oct 2022 08:19:09 +0800
Message-Id: <20221002001909.20070-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAXjk3_2DhjIc_GBg--.24421S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UArWrKw13GFW8WF4Durg_yoW8Jw15pa
        95WF9YkF17CF1jyasrGF4FvrWrZ3Z2gayUG3ZFq3y3uwnYqryFyrZ0ka4FvFWDuF97WFyr
        XFy8Xw1UGF1DAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIKAVZdtbvX2gBDsA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function lpfc_poll_timeout() is a timer handler that runs in an
atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
As a result, the sleep-in-atomic-context bug will happen. The processes
is shown below:

lpfc_poll_timeout()
 lpfc_sli_handle_fast_ring_event()
  lpfc_sli_process_unsol_iocb()
   lpfc_complete_unsol_iocb()
    lpfc_nvme_unsol_ls_handler()
     lpfc_nvme_handle_lsreq()
      nvme_fc_rcv_ls_req()
       kzalloc(sizeof(.., GFP_KERNEL) //may sleep

This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
GFP_ATOMIC in order to mitigate the bug.

Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5..36698dfc8b3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	lsop = kzalloc(sizeof(*lsop) +
 			sizeof(union nvmefc_ls_requests) +
 			sizeof(union nvmefc_ls_responses),
-			GFP_KERNEL);
+			GFP_ATOMIC);
 	if (!lsop) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: No memory\n",
-- 
2.17.1

