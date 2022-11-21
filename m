Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6359D632028
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKULQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKULQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:16:20 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BCC287E;
        Mon, 21 Nov 2022 03:11:35 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1669029064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/EgY2lXCAdAF7z2NAmaypvnrmSLjUVovTOiSsKJSrC4=;
        b=mrCHEs3LP4MiDp0HC7rR5o7PSz4Lyw/+K937QFY9hwoliOXZZU+B77+qFTxW/KOALmNICq
        HZrN9qokGljlUTPg6PfBqMxjQG5KflbSyKzvcz/8oS+G0Jg6sBb7s7vydcUKH27vIEOGWj
        QxGwY+0unt7q36VMC06COYt5syj09wU=
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc:     Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: 
Date:   Mon, 21 Nov 2022 14:11:04 +0300
Message-Id: <20221121111104.7186-1-arefev@swemel.ru>
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

Date: Mon, 21 Nov 2022 13:29:03 +0300
Subject: [PATCH] scsi:bfa: Eliminated buffer overflow

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

