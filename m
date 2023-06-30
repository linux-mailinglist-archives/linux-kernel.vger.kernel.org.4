Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F257432DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3CsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjF3CsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:48:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4C535A7;
        Thu, 29 Jun 2023 19:48:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76714caf466so126204685a.1;
        Thu, 29 Jun 2023 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688093285; x=1690685285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ALnKxby19PRdzxTmTKNTGCytmjoLEZ1P5o67YM3y8=;
        b=XESjJS/WYUlwketPbHggw2mNZxEWqPMfUwldLsyUQzFIV4/AwstgqxiKth5pyXNlUw
         qAi33o9dYXWUI4MXFd3itlIi8TUrwd9S0AQzdyZrOpNXZPKP9l5eNcj4i3hi/o78KrBX
         KkK0G2ERgpK9MJaSg1FOlc/CTDGfteUVvFbR8oSjT0vJ3A7zdXttnNIHkM1vFmmR+oPW
         vEyzkWWVYpca86QuOLGHv6txTw4q38dsRAm/obAqnGMtELIjCSRn4BJ6j2p5v89CO9+1
         lBtCpi49x/ULmTtyNxdTs+Ogi6mAu4OzMwkz4F0/g4tMM6j8FFK0xGVhsaonDcbl+OJW
         TA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688093285; x=1690685285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4ALnKxby19PRdzxTmTKNTGCytmjoLEZ1P5o67YM3y8=;
        b=YTexsgWxkkBm7HzuuZq0J65kzHYLnNLF+mtnQ604amxn8s+twhg5N04MEV4LuwFBJY
         yWChPIS8dJbKUTPEMp8xDtAJs5RRPn3hsKzfM5WwGWDVLW/Cms+vtCy4y5eNRDHhJ7gu
         KVqc04bUny3UEn6eRhLpOdxWio4HAFVVMPcEyZPLlx4NNOj5ghM8EWW28NXzsUYDq/DU
         Wd3feLbxyvAMIY3k7S9N+DSIwyOv0yEgRPvPwHVkxuh5VUxg2ob0w3TgFgxmYYfGyYWj
         vbuhDByUm6SvTJLSS3IrElBSli0aqNcBOOdVCHBOmb5/AN/DpWHlMx8g7YqFLzcCzDR0
         Yv9A==
X-Gm-Message-State: AC+VfDylsbKClfpjJYI5IGJvh1V1zwDuu6sP7PgW/zpHdbpI8pPk+YGz
        REECMWGTGYmMCkPBidRyf4k=
X-Google-Smtp-Source: ACHHUZ7s7kalGiaALcvNXMQ8bFkk+F3F/a0hjtQhSfESqAy5yobugXLHDaNSPLiYa/X6zpKF/Sdw1Q==
X-Received: by 2002:a05:620a:424d:b0:765:8204:dd64 with SMTP id w13-20020a05620a424d00b007658204dd64mr1522149qko.7.1688093284787;
        Thu, 29 Jun 2023 19:48:04 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id p5-20020a63c145000000b00519c3475f21sm9600224pgi.46.2023.06.29.19.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:48:04 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date:   Fri, 30 Jun 2023 10:47:48 +0800
Message-Id: <20230630024748.1035993-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable phba->fcf.fcf_flag is often protected by the lock 
phba->hbalock() when is accessed. Here is an example in 
lpfc_unregister_fcf_rescan():

  spin_lock_irq(&phba->hbalock);
  phba->fcf.fcf_flag |= FCF_INIT_DISC;
  spin_unlock_irq(&phba->hbalock);

However, in the same function, phba->fcf.fcf_flag is assigned with 0 
without holding the lock, and thus can cause a data race:

  phba->fcf.fcf_flag = 0;

To fix this possible data race, a lock and unlock pair is added when 
accessing the variable phba->fcf.fcf_flag.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 5ba3a9ad9501..9d2feb69cae7 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6961,7 +6961,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
-- 
2.34.1

