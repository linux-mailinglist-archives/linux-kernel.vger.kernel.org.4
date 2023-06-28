Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89937414FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF1Pae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF1PaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:30:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED6268F;
        Wed, 28 Jun 2023 08:30:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686a05bc66so3927525b3a.1;
        Wed, 28 Jun 2023 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687966224; x=1690558224;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eipvAP8cAn3qf+QI5BYy9KRsjhBE5RJHKH6KbEsvKw=;
        b=DLCSvvkoZyzg/8xfkZLY7hLnKpqO2AfmVDGH7CazwOeuORTBSh9pLzonCgs9+rnW3/
         Sr9lLBKxsdz9sfw5eF2BON0DHIIxyzQF3xcBHGmtsg3CQujkcFNeAIsnUmgtDSBF8LsL
         azvmmJdr7NC9Fu2D/kYwY3FGgBR9xzYnGG90bV4/KYtLPY4xiPIS1DC4CDyUSYajy11f
         Ejj1pVfGKdEQ4to387hki+9rpeKnzwOk/qavvLU0T9t7KDD8jnXRv2w/hD2jbe6Mpahc
         w8Hb3mNRMk9y1w66tPY0Ni+R8JEPRd2rhjH+Yyg3KoDTUPtZog8l68srdcZHUKlx+BBH
         kmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966224; x=1690558224;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eipvAP8cAn3qf+QI5BYy9KRsjhBE5RJHKH6KbEsvKw=;
        b=lHhXrskL3WtdqfodlTS72YlAM2i3xTf3PS5ro/m8LwlpIgWEgFrOvaGLSedxE5fVVr
         HUFNWRKlhbP2EHoTZVbtMbPhUb5BBsJSrbLdVdYlowwEOEiQNP0EcaoWFyoyR4GcLjU+
         RAxPFJNvjpNcQavM1vpptuHTcsxRqRlJIw/+tfIXSCiNPOUhTs9icwRwAT6NfYwjJY34
         xrQvJxDLkPM+cwYRony2+KcKtK1Uxt6ZGQsuA4Ma6JGS0oMSZtfFQ2cY4XVV4vlfL14p
         1vcnyYo2tWFc7tuywbKTkNFdzxNiulm3FRkN8pYDjxz4A6FHadw85Mwvcu0NiiSGJhEU
         HfYw==
X-Gm-Message-State: AC+VfDy2uGpSYKDio8h+Y4PRosNR2KVSXvuChVnib6F4zxoCJlhinw3a
        TrjQDf2+REaXrGKzuVHDXeAFJRTs1aoZDA==
X-Google-Smtp-Source: ACHHUZ6ZbMYzkEt6o8nH76d/fZa9ZfWMAZIv91i5uWcQmfW2Hn824BfpaqeSWGgqIwgLiWqNP/CVgA==
X-Received: by 2002:a05:6a20:938b:b0:e9:5b0a:deff with SMTP id x11-20020a056a20938b00b000e95b0adeffmr33939956pzh.22.1687966223619;
        Wed, 28 Jun 2023 08:30:23 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001b3fb1119fdsm1750669plb.297.2023.06.28.08.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:30:23 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     chenxiang66@hisilicon.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: hisi_sas: Fix potential deadlock on &hisi_hba->lock
Date:   Wed, 28 Jun 2023 15:30:10 +0000
Message-Id: <20230628153010.57705-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &hisi_hba->lock is acquired by hard irq int_abnormal_v1_hw(),
other acquisition of the same lock under process context should
disable irq, otherwise deadlock could happen if the
irq preempt the execution while the lock is held in process context
on the same CPU.

[Interrupt]: int_abnormal_v1_hw()
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1447
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:2050
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1079
    -->spin_lock_irqsave(&hisi_hba->lock, flags);

[Process Context]: hisi_sas_clear_nexus_ha()
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1932
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1135
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1116
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1105
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:166
    -->spin_lock(&hisi_hba->lock);

[Process Context]: hisi_sas_dev_found()
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:665
    -->spin_lock(&hisi_hba->lock);

[Process Context]: hisi_sas_queue_command()
    -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:188
    -->spin_lock(&hisi_hba->lock);

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock, which reported the above
warning when analyzing the linux kernel 6.4-rc7 release.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 412431c901a7..47c5062a732e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -161,11 +161,12 @@ static void hisi_sas_slot_index_clear(struct hisi_hba *hisi_hba, int slot_idx)
 
 static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 {
+	unsigned long flags;
 	if (hisi_hba->hw->slot_index_alloc ||
 	    slot_idx < HISI_SAS_RESERVED_IPTT) {
-		spin_lock(&hisi_hba->lock);
+		spin_lock_irqsave(&hisi_hba->lock, flags);
 		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
-		spin_unlock(&hisi_hba->lock);
+		spin_unlock_irqrestore(&hisi_hba->lock, flags);
 	}
 }
 
@@ -181,11 +182,12 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 {
 	int index;
 	void *bitmap = hisi_hba->slot_index_tags;
+	unsigned long flags;
 
 	if (rq)
 		return rq->tag + HISI_SAS_RESERVED_IPTT;
 
-	spin_lock(&hisi_hba->lock);
+	spin_lock_irqsave(&hisi_hba->lock, flags);
 	index = find_next_zero_bit(bitmap, HISI_SAS_RESERVED_IPTT,
 				   hisi_hba->last_slot_index + 1);
 	if (index >= HISI_SAS_RESERVED_IPTT) {
@@ -193,13 +195,13 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 				HISI_SAS_RESERVED_IPTT,
 				0);
 		if (index >= HISI_SAS_RESERVED_IPTT) {
-			spin_unlock(&hisi_hba->lock);
+			spin_unlock_irqrestore(&hisi_hba->lock, flags);
 			return -SAS_QUEUE_FULL;
 		}
 	}
 	hisi_sas_slot_index_set(hisi_hba, index);
 	hisi_hba->last_slot_index = index;
-	spin_unlock(&hisi_hba->lock);
+	spin_unlock_irqrestore(&hisi_hba->lock, flags);
 
 	return index;
 }
@@ -658,11 +660,12 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct hisi_sas_device *sas_dev = NULL;
+	unsigned long flags;
 	int last = hisi_hba->last_dev_id;
 	int first = (hisi_hba->last_dev_id + 1) % HISI_SAS_MAX_DEVICES;
 	int i;
 
-	spin_lock(&hisi_hba->lock);
+	spin_lock_irqsave(&hisi_hba->lock, flags);
 	for (i = first; i != last; i %= HISI_SAS_MAX_DEVICES) {
 		if (hisi_hba->devices[i].dev_type == SAS_PHY_UNUSED) {
 			int queue = i % hisi_hba->queue_count;
@@ -682,7 +685,7 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 		i++;
 	}
 	hisi_hba->last_dev_id = i;
-	spin_unlock(&hisi_hba->lock);
+	spin_unlock_irqrestore(&hisi_hba->lock, flags);
 
 	return sas_dev;
 }
-- 
2.17.1

