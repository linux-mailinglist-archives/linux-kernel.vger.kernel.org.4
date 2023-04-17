Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358206E4A64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDQN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDQN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:56:51 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9C546BF;
        Mon, 17 Apr 2023 06:56:49 -0700 (PDT)
Received: from user-virtual-machine.. ([10.12.182.5])
        (user=jinhongzhu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33HDtc6o016109-33HDtc6p016109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Apr 2023 21:55:43 +0800
From:   Jinhong Zhu <jinhongzhu@hust.edu.cn>
To:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinhong Zhu <jinhongzhu@hust.edu.cn>
Cc:     Dan Carpenter <error27@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qedf: Fix NULL dereference in error handling
Date:   Mon, 17 Apr 2023 21:55:18 +0800
Message-Id: <20230417135518.184595-1-jinhongzhu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: jinhongzhu@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reported:

drivers/scsi/qedf/qedf_main.c:3056 qedf_alloc_global_queues()
warn: missing unwind goto?

At this point in the function, nothing has been allocated so we can
return directly. In particular the "qedf->global_queues" have not been
allocated so calling qedf_free_global_queues() will lead to a NULL
dereference when we check if (!gl[i]) and "gl" is NULL.

Fixes: 09e062ce83cb ("qedf: Fix NULL dereference in error handling")
Signed-off-by: Jinhong Zhu <jinhongzhu@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
---
 drivers/scsi/qedf/qedf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 35e16600fc63..f2c7dd4db9c6 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3043,9 +3043,8 @@ static int qedf_alloc_global_queues(struct qedf_ctx *qedf)
 	 * addresses of our queues
 	 */
 	if (!qedf->p_cpuq) {
-		status = -EINVAL;
 		QEDF_ERR(&qedf->dbg_ctx, "p_cpuq is NULL.\n");
-		goto mem_alloc_failure;
+		return -EINVAL;
 	}
 
 	qedf->global_queues = kzalloc((sizeof(struct global_queue *)
-- 
2.34.1

