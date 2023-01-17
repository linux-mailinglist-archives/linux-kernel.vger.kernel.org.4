Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAED66E448
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAQRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAQRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:00:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268D39BA3;
        Tue, 17 Jan 2023 09:00:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E91F61265;
        Tue, 17 Jan 2023 17:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AD1C433D2;
        Tue, 17 Jan 2023 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974834;
        bh=QNh3TQFYT4vMIEZ85frVh2PselKngIOifHgEhRG2e2g=;
        h=From:To:Cc:Subject:Date:From;
        b=LshBPt+3eewDOD7tj/cucbMXW6k1B8XFb+oCnEqLFpvmE1yH9w2RNJnKY+1VFBYpo
         xbENILpXu9oRXczijjo7D2QE6shiBcY4Np9QJZWM30C/dS2Erg2ADSW1YoUK2al/SU
         3Mz+fRPFgFsRaxyN2LPVv8ZDkAuBIYpFIVGIuTqmZpF1T3opvPFnShmflH3tK0K723
         JDH8TVHw36EpBKXfraEBSqcWp+kBVslAPY7t/ho2TaoA4farpBXCrJ2wjL7KmlNFOL
         9Uqentqldnz+onLbGiCkbpuvM89TdUF1AkSN49hZkzf2bnjQLorSLy8ogGFp9TGk46
         Kzd6N6KBKbC+A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qla2xxx: fix printk format string
Date:   Tue, 17 Jan 2023 18:00:15 +0100
Message-Id: <20230117170029.2387516-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Printing a size_t value that is the result of the sizeof() operator requires
using the %z format string modifier to avoid a warning on 32-bit architectures:

drivers/scsi/qla2xxx/qla_mid.c: In function 'qla_create_buf_pool':
drivers/scsi/qla2xxx/qla_mid.c:1094:51: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
 1094 |                     "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
      |                                                 ~~^       ~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                   |          |
      |                                                   long int   unsigned int
      |                                                 %d

Fixes: 82d8dfd2a238 ("scsi: qla2xxx: edif: Fix performance dip due to lock contention")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qla2xxx/qla_mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index c6ca39b8e23d..1483f6258f92 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -1091,7 +1091,7 @@ int qla_create_buf_pool(struct scsi_qla_host *vha, struct qla_qpair *qp)
 	qp->buf_pool.buf_map   = kcalloc(sz, sizeof(long), GFP_KERNEL);
 	if (!qp->buf_pool.buf_map) {
 		ql_log(ql_log_warn, vha, 0x0186,
-		    "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
+		    "Failed to allocate buf_map(%zd).\n", sz * sizeof(unsigned long));
 		return -ENOMEM;
 	}
 	sz = qp->req->length * sizeof(void *);
-- 
2.39.0

