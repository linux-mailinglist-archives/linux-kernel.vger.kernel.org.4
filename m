Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0773B6C45C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCVJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:08:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0D5CC12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:07:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so8247803plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679476069;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OUym5mR2BMTkr5dMZAiyWtrEULkoxuHuyPAHb5cL/yc=;
        b=6WTISs/T9RsY8/Bu3mDtU8yfUdtdENPdPhsDExlD61pY31Yxcs2eB9gyvSmawcYn+c
         YS5ZsepJYfsp9k0rFxFjxrVD0Lj3rrXAcgw/fAVbNar8JkXrj2EA0WFfAq8xJY0QWX78
         mtpuJirtvjZs2hT+3ORXt07Jjl3abRcGsuaeAu8TWj/slSWxnC6uPqoE2/zlYYQDKwNB
         zlioXgXC/qyGo3IdeCi75jZubWXL+sbPTfqRei4YEfYtI0nT/2/X9Cy+6ERCwW47y5+P
         IseISXJh+MpzxPe7YPFFqtuDMpzxwrrGEspIXXwtCygiWmU89zAsvtUs+93d34fFVnIb
         qOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476069;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUym5mR2BMTkr5dMZAiyWtrEULkoxuHuyPAHb5cL/yc=;
        b=1hAA2zvMIhy7NaKgqvxHjI4chFebFM7Tbcoomi6LUZsFIt7grXlKIssJurFUH/nQwY
         eleo1gpSNaImDwmKJQB98M39Hg/QMIriqrjt5QpxzZH14YFrxew0ZL+IsDh9YLcEw6qh
         PQtdOfBfcZBNaT10vPXoSk6lFpvlqy6uZqZzN3pliqERcTiRV0poTFwvP2nz32X0/dXE
         idYzbJU0K9h3BPWse6qBLpa3Bv6kanffn6PjDfWrPItzbYavgeToGgLZN2gelLMewGt0
         nNrwKjhFcnUPWWSchSSo5k/Eg1IxuiFGnNFCRj2dOwB1ptKGfF/NhA2rzBWTBI5lE6R3
         wpyQ==
X-Gm-Message-State: AO0yUKXA/qXK7UOdHXG+TwFbyxkayXzDNOmZXyCvWCG0pppC9pxy20xW
        wyaxh/UnCOhZzM9mBNBbRrSsxg==
X-Google-Smtp-Source: AK7set/Co1fFRC5QEGQCvwq/l/XilSzkUx9imltQ8lu0f1lMIJBdoIHjIx+50LcXrVYsmiqYlnUepw==
X-Received: by 2002:a05:6a20:6ca6:b0:da:1830:328a with SMTP id em38-20020a056a206ca600b000da1830328amr4498373pzb.44.1679476069314;
        Wed, 22 Mar 2023 02:07:49 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id q2-20020a63d602000000b00476dc914262sm9534815pgg.1.2023.03.22.02.07.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:07:48 -0700 (PDT)
Message-ID: <17c235f2fff960aefea33b50039e214f42164130.camel@areca.com.tw>
Subject: [PATCH 1/5] scsi: arcmsr: deprecated arcmsr_pci_unmap_dma() using
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 01:07:47 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch deprecate arcmsr_pci_unmap_dma(...) using by
direct calling to scsi_dma_unmap(...).

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 9d04cb6..e8c12dd 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1299,20 +1299,13 @@ static uint8_t arcmsr_abort_allcmd(struct AdapterControlBlock *acb)
 	return rtnval;
 }
 
-static void arcmsr_pci_unmap_dma(struct CommandControlBlock *ccb)
-{
-	struct scsi_cmnd *pcmd = ccb->pcmd;
-
-	scsi_dma_unmap(pcmd);
-}
-
 static void arcmsr_ccb_complete(struct CommandControlBlock *ccb)
 {
 	struct AdapterControlBlock *acb = ccb->acb;
 	struct scsi_cmnd *pcmd = ccb->pcmd;
 	unsigned long flags;
 	atomic_dec(&acb->ccboutstandingcount);
-	arcmsr_pci_unmap_dma(ccb);
+	scsi_dma_unmap(ccb->pcmd);
 	ccb->startdone = ARCMSR_CCB_DONE;
 	spin_lock_irqsave(&acb->ccblist_lock, flags);
 	list_add_tail(&ccb->list, &acb->ccb_free_list);
@@ -1596,7 +1589,7 @@ static void arcmsr_remove_scsi_devices(struct AdapterControlBlock *acb)
 		ccb = acb->pccb_pool[i];
 		if (ccb->startdone == ARCMSR_CCB_START) {
 			ccb->pcmd->result = DID_NO_CONNECT << 16;
-			arcmsr_pci_unmap_dma(ccb);
+			scsi_dma_unmap(ccb->pcmd);
 			scsi_done(ccb->pcmd);
 		}
 	}

