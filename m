Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C356F91F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEFMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:22:36 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412114921;
        Sat,  6 May 2023 05:22:33 -0700 (PDT)
Received: from joe-virtual-machine.localdomain ([10.12.176.104])
        (user=U201911841@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 346CLPj1014147-346CLPj2014147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 May 2023 20:21:31 +0800
From:   Zhong Yong <U201911841@hust.edu.cn>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Zhong Yong <U201911841@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: Fix missing unwind goto in mpt3sas_config_update_driver_trigger_pg3()
Date:   Sat,  6 May 2023 20:20:30 +0800
Message-Id: <20230506122032.2090153-1-U201911841@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: U201911841@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:
drivers/scsi/mpt3sas/mpt3sas_config.c:2478
mpt3sas_config_update_driver_trigger_pg3() warn: missing unwind goto?

Fix this by assigning '-EFAULT' to 'rc' and
changing the direct return to a goto 'out'.

Fixes: 2a5c3a35c156 ("scsi: mpt3sas: Add persistent SCSI sense trigger page")
Signed-off-by: Zhong Yong <U201911841@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and the patch remains untested.
---
 drivers/scsi/mpt3sas/mpt3sas_config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index d114ef381c44..a426d086044a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -2475,7 +2475,8 @@ mpt3sas_config_update_driver_trigger_pg3(struct MPT3SAS_ADAPTER *ioc,
 		    ioc_err(ioc,
 		    "%s: Failed to get trigger pg3, ioc_status(0x%04x)\n",
 		    __func__, ioc_status));
-		return -EFAULT;
+		rc = -EFAULT;
+		goto out;
 	}
 
 	if (set) {
-- 
2.34.1

