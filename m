Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF0716FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjE3V3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjE3V3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E968C7;
        Tue, 30 May 2023 14:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFCB662F3A;
        Tue, 30 May 2023 21:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FF0C433EF;
        Tue, 30 May 2023 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685482169;
        bh=GLu5O3LRK+uO/mUwyhrjlKostu2tteVX5Bk4Ufg7ekc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZNQPtKFdt5D+x3VhvyKmUos4cGo3u6phr45fOBLBoMRuPKE7fdH8G8pMi346ZzBBY
         mhK8Dz5AzQ4T0CJ36AlrlvO1syDAE8qb2tZ/gou9OJeW5yru/5SI0KLTHGjYKPwn42
         XtxYYduapa1Z8trkQLBBuE5HC/+kxbdm9twKTe0/iX+JdFpo4fEioJmTtNpszyvoTd
         fTMn8yT3wl/G26qYclsyYVotsP6DeAR4tgW5kChJEPEeco45QA33ZzcIEPTQTLD5dq
         osA99hB+fW5P+RWmtgA+rdLREk5oxm8PQ/Cyssv9eJMYH/NXdXxjtSrpKwRdGwRYbb
         lYCvJBoSDjzFQ==
Date:   Tue, 30 May 2023 15:30:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Message-ID: <ZHZq7AV9Q2WG1xRB@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid confusing the compiler about possible negative sizes.
Use size_t instead of int for variables size and copied.

Address the following warning found with GCC-13:
In function ‘lpfc_debugfs_ras_log_data’,
    inlined from ‘lpfc_debugfs_ras_log_open’ at drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’ specified bound between 18446744071562067968 and 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
 2210 |                         memcpy(buffer + copied, dmabuf->virt,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2211 |                                size - copied - 1);
      |                                ~~~~~~~~~~~~~~~~~~

Link: https://github.com/KSPP/linux/issues/305
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index bdf34af4ef36..493729e74abe 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2189,9 +2189,9 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 #endif
 
 static int lpfc_debugfs_ras_log_data(struct lpfc_hba *phba,
-				     char *buffer, int size)
+				     char *buffer, size_t size)
 {
-	int copied = 0;
+	size_t copied = 0;
 	struct lpfc_dmabuf *dmabuf, *next;
 
 	memset(buffer, 0, size);
@@ -2249,7 +2249,7 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
 {
 	struct lpfc_hba *phba = inode->i_private;
 	struct lpfc_debug *debug;
-	int size;
+	size_t size;
 	int rc = -ENOMEM;
 
 	spin_lock_irq(&phba->hbalock);
-- 
2.34.1

