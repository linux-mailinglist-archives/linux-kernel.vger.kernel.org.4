Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3986C463A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCVJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjCVJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:21:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CA5F50F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:20:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so18706697ple.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679476837;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gk7upXiG6tQnjmAbZAy+2hfQqQURaFjrDuWcXF2d57c=;
        b=bwVOwT65dBMPO57hdlbzNA8a+HC+4eI5z+X3CqQNXfyDMQqvecrsm/6Ll4T8b4NLzb
         PFE2sSJh4UwLSnRabI1Nuj4ZPOcBtg6K7RLRZ3/EqCLDKELF+sLmz+5xjNPtijnPs56x
         4cg0RtbFmfo36Qt7KICrkga4NXCFUN3A5bXnkiRBWeT/hcMZ/tbRt56E8HrCcPYJ6iE2
         lPX5e27oCLNLo95+pfV9wS6+800zaRVlYo9iRFfXm63v+4yjcdWtIN2EoyGFJZsmRTXP
         q9mMmwN7mBe3CCR/Qf8Qjqs8wGBldD8F0Z2IDPiSU097+/b+kSyjB4nLyRpyXhphCvwL
         tTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476837;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk7upXiG6tQnjmAbZAy+2hfQqQURaFjrDuWcXF2d57c=;
        b=X0ELyHV3kfYdSsZb+/gwPClSdNa9B9f5Bf1G+g7s2zoKfbJPMBHr8Ks7dbGMPV98T4
         f/i4IJ216x1G4UELVbr8ZLpKw2Xo8SXtHm7gL7kPZG5w5OdC6vpg3/VfpwPujlTJtPf7
         c6MYMjw18pOhvL/Ff39+dpMuoDVDASz62ovInHpVtb2uC4ZeMartAMHlfqUjdtbpriLP
         sjepwWyc/lfaLcSXxyjINQEt/5kl9Rtfr61Oox4syK8h9FF8yT8xvxmdyOveNlNB5blb
         7N8ZR/5HjCGYcU2ygDoWpsgZ+grSDvEWOWzt/sgLOOxM5xRobq75wk1Wh7MbB/R0lXI/
         dfsA==
X-Gm-Message-State: AO0yUKWsxa+9EY0F76OAeXIltJmTylXCXHH3LfaEtTTMq7UWMHgFQPGg
        BIC16jf/5+DTCW4U/qrJfVzjcw==
X-Google-Smtp-Source: AK7set9MFydPJqupCVJggyqn3s+4qT8rXRYcfEljHNZyGCEqVhJz/knR7egq9Ufkj8oItyOEMpbNfQ==
X-Received: by 2002:a17:90b:3852:b0:23d:449a:db70 with SMTP id nl18-20020a17090b385200b0023d449adb70mr2992722pjb.28.1679476836770;
        Wed, 22 Mar 2023 02:20:36 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id cv18-20020a17090afd1200b0022335f1dae2sm9279596pjb.22.2023.03.22.02.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:20:36 -0700 (PDT)
Message-ID: <4aec4385abc6eab10b575c28130ec615a144492d.camel@areca.com.tw>
Subject: [PATCH 3/5] scsi: arcmsr: fixed reading buffer empty length error
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 01:20:35 +0800
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

This patch fixed reading buffer empty length error
which cause areca CLI app command timeout.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index d387a38..587332e 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2254,8 +2254,11 @@ static void arcmsr_iop2drv_data_wrote_handle(struct AdapterControlBlock *acb)
 
 	spin_lock_irqsave(&acb->rqbuffer_lock, flags);
 	prbuffer = arcmsr_get_iop_rqbuffer(acb);
-	buf_empty_len = (acb->rqbuf_putIndex - acb->rqbuf_getIndex - 1) &
-		(ARCMSR_MAX_QBUFFER - 1);
+	if (acb->rqbuf_putIndex >= acb->rqbuf_getIndex) {
+		buf_empty_len = (ARCMSR_MAX_QBUFFER - 1) -
+		(acb->rqbuf_putIndex - acb->rqbuf_getIndex);
+	} else
+		buf_empty_len = acb->rqbuf_getIndex - acb->rqbuf_putIndex - 1;
 	if (buf_empty_len >= readl(&prbuffer->data_len)) {
 		if (arcmsr_Read_iop_rqbuffer_data(acb, prbuffer) == 0)
 			acb->acb_flags |= ACB_F_IOPDATA_OVERFLOW;

