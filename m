Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547BC6A394C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjB0DKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB0DKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:10:36 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573CCEC4A;
        Sun, 26 Feb 2023 19:10:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ky4so5333849plb.3;
        Sun, 26 Feb 2023 19:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+L49kKjVGMIflTo4gi5GnHRy5nclrp50XkY2Jw83y4=;
        b=hgSt6v6G9VDAbJqgK7g9QfroWxBrNOV2r1Ld5MVmnUKzQ0OcPsLieSZr9/2emBH7Pa
         MdBQ5IJkP8tshfHVGnXQgNfyu0dZNxv+3vcSGZPlsQQ8Km3vm718XBfaMuoLDASYlvli
         hqPPIEPDnlcyi8zzhgIv0VF+zG/9nZGlIyeFPvS5iQ3LTbVP5RtZHkc/qRWhZ3W+lDsw
         8bILxN223uH4eaaVGZYN+gWvdFY9SKlJRyfpi9ynbwaOG8koC7ESj8968WEtB/cTjFGx
         DIpjkmYmcslEyXMtjx9pRgwXrSjVxpXwuKIqucdkD2iEMCjThalWm7y16sMCc8JKmC7q
         V9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+L49kKjVGMIflTo4gi5GnHRy5nclrp50XkY2Jw83y4=;
        b=1mqJ59VzvbLsiJr7E76AZwFWeGGXAOiV3gbeCZiRkidP12UBeBo2yAuBmS9mzQwB1y
         XpAmielKiSvvnv6YZu38zNfwdyM7rxy+9Xf/uam0eqIyw3pxoDEiEP8lcK4zfIQmktji
         ZBjLctC3hsn0ePTLiXnhwhWPBKSerPrzkp0GEytTHPbApwQ77yhsjRvyY1vB1bA+Fcta
         KwfAq26oHJ6zlkH39OdR1Qk3xv5/MybRi6QH0WUBvffpON7URbgBW0z5Dm733rTNK1WW
         0IWNP3TruGR6/g/3JUlM7/9RvSGAB7ceNcnkRq++B38umpolQeEQ/PuJ29NVDM3LYgww
         qyBA==
X-Gm-Message-State: AO0yUKWxCOEzSkpAbEABY7D9JNBFdjAlPqeTSy4P1b59YFjH7VPY/W6d
        2jeLwx9faROmVxqXrWMTrhA=
X-Google-Smtp-Source: AK7set+vghs+qHTn5OT71t1bQa0u4ftTPxr7Mtq40zyzDydbd1l4PYbPaGoxH7qXRt/kAdkMvm3QwA==
X-Received: by 2002:a17:903:1205:b0:19c:36c9:2449 with SMTP id l5-20020a170903120500b0019c36c92449mr29523026plh.17.1677467434876;
        Sun, 26 Feb 2023 19:10:34 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b0019cbb055a95sm3336562plb.94.2023.02.26.19.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 19:10:34 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     chenxiang66@hisilicon.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH] scsi: hisi_sas: add a check of devm_add_action
Date:   Mon, 27 Feb 2023 11:10:30 +0800
Message-Id: <20230227031030.893324-1-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

devm_add_action may fails, check it in the caller of
interrupt_preinit_v3_hw

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0c3fcb807..a63279f55 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2495,8 +2495,7 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
 	shost->nr_hw_queues = hisi_hba->cq_nvecs;
 
-	devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
-	return 0;
+	return devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
 }
 
 static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
-- 
2.34.1

