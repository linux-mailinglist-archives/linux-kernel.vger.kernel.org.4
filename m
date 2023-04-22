Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2886EB886
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDVKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDVKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:17:43 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C41FC3;
        Sat, 22 Apr 2023 03:17:29 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=meetlpz@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33MAGTwg005986-33MAGTwh005986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 22 Apr 2023 18:16:37 +0800
From:   Peizhi Li <meetlpz@hust.edu.cn>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Peizhi Li <meetlpz@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: qedi_main.c: modify the code flow in 'qedi_alloc_global_queues'
Date:   Sat, 22 Apr 2023 18:16:26 +0800
Message-Id: <20230422101626.1722235-1-meetlpz@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: meetlpz@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When goto the mem_alloc_failure, it will result in a null pointer 
reference to variable 'gl' in function 'qedi_free_global_queues', 
due to the 'qedi->global_queues' not being allocated.

Fix this by returning -EINVAL directly.

Signed-off-by: Peizhi Li <meetlpz@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The issue is found by static analysis and remains untested. Meanwhile, 
this patches is similar with qedf which Jinhong Zhu fixed already. 

https://lore.kernel.org/all/20230417135518.184595-1-jinhongzhu@hust.edu.cn/
 drivers/scsi/qedi/qedi_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index f2ee49756df8..34f38e0f1c7d 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1637,8 +1637,7 @@ static int qedi_alloc_global_queues(struct qedi_ctx *qedi)
 	 * addresses of our queues
 	 */
 	if (!qedi->p_cpuq) {
-		status = -EINVAL;
-		goto mem_alloc_failure;
+		return -EINVAL;
 	}
 
 	qedi->global_queues = kzalloc((sizeof(struct global_queue *) *
-- 
2.25.1

