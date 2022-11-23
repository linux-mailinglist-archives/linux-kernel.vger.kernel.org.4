Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247AE63513E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiKWHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiKWHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:45:51 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C78F8849;
        Tue, 22 Nov 2022 23:45:49 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1669189547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NyGQuAK8qaIoADlkM2cY8C4CbAnRMBfaC7DAeE7V5QM=;
        b=NstPDabF4kgRZAUFh1fBWd3+20zAEWf32RVcthDIrI5oC3RwwwmDUQW+OkEYahOm5b9YBt
        R/AuEBRng0GSouJ7Xm44jU5UyW7tWpHs+12e1XLlt+tglhwEecp7JwwhKJtZz1WxoQuB9m
        UVWko0D7OA9wXv0fyhbZvtgt175wcQU=
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc:     Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] scsi: bfa: Eliminated buffer overflow
Date:   Wed, 23 Nov 2022 10:45:46 +0300
Message-Id: <20221123074546.30340-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer 'cmd->adapter_hwpath' of size 32 accessed at
bfad_bsg.c:101:103 can overflow, since its index 'i'
can have value 32 that is out of range.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/scsi/bfa/bfad_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index be8dfbe13e90..78615ffc62ef 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -98,9 +98,9 @@ bfad_iocmd_ioc_get_info(struct bfad_s *bfad, void *cmd)
 
 	/* set adapter hw path */
 	strcpy(iocmd->adapter_hwpath, bfad->pci_name);
-	for (i = 0; iocmd->adapter_hwpath[i] != ':' && i < BFA_STRING_32; i++)
+	for (i = 0; iocmd->adapter_hwpath[i] != ':' && i < BFA_STRING_32-2; i++)
 		;
-	for (; iocmd->adapter_hwpath[++i] != ':' && i < BFA_STRING_32; )
+	for (; iocmd->adapter_hwpath[++i] != ':' && i < BFA_STRING_32-1; )
 		;
 	iocmd->adapter_hwpath[i] = '\0';
 	iocmd->status = BFA_STATUS_OK;
-- 
2.25.1

