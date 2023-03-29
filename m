Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB26CD964
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjC2Mek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjC2Meh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:34:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747349C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:34:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so6219682wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680093275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7k3Pknpt+FEvPFnkTWZnOtAOiCcWdoby7FCUyoCPirk=;
        b=eSTGarnH/zmuvSNqMiK+j3gUub4rdGlUmgMXGMZSB22aaAjp3aVRN/rirW64CE1pw7
         LmSkOZTkhgJ8KuBU4Q55udhOd6+/1Ifum5Z8t+uFsbHueg5TsR9ggN30Bl4DdelXSpZA
         LfKP/JNmNGkLwOokH+4tvwlvCXd6kVjDaVTBfJ+8FA2FjVZrclXbUVSFxmvkui2fZ5lT
         EI2iefa6zWJbr3TgvdTOT5U/bVnmAnNFE4VvD7YOPsiAMnjvN2tGweJnxGVPD2XJ5qxj
         rVonai3gldWgqeFtq3fbqj8AYIg8uiMtokiW7E/Y4QR6hmS9yaZTkGlZu1ZT6TkhGbcX
         Fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680093275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k3Pknpt+FEvPFnkTWZnOtAOiCcWdoby7FCUyoCPirk=;
        b=JaAdqZ3UMeKS4SwW2R9WhrjdTlZOM/fLaza+o49dVzmkz87VwRI40v3/4Zd/6mIVzG
         tIdvYd+qWEoShw/0J2SKhTl6OxJ/WP9+6znoDgQjV4UpBk7GHjYP4bXL0e42QRmgFD3F
         LRXOJ9x1NNQZa3psfwXdpAQi+v/ztKC10e1u4zOOziDzYwSXxnb8JJC3C4xoM3yakOf/
         lDkUDOENbFdmJiB/UqzDbpRBR2gsYkb2OTRl4u2kbMfKYMkg6DqoE8xb0Epc9iOwzh5Q
         dEiNpQWghiDfHrnv18ki3D8VNKBxdnoxeen5XQCnjo7FkMvT+Y5JVIiaxKORCGVnSXQ5
         LbZg==
X-Gm-Message-State: AO0yUKX8JbrKs/TrdmFl13p3vXbn3vhSaZxFmIt5KxH8g/xir3PPdETj
        viRF92OEWMH5BvUqyNllFkA=
X-Google-Smtp-Source: AK7set9CwcmF1pMBPEcBJD7EKQVp+E6VRC0xGZObxJ2FH27ScUsoi1HLiTGPjJXd0Fet7MkW06Qd1Q==
X-Received: by 2002:a05:600c:21d8:b0:3ed:2b49:eefc with SMTP id x24-20020a05600c21d800b003ed2b49eefcmr15666798wmj.3.1680093274790;
        Wed, 29 Mar 2023 05:34:34 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id b39-20020a05600c4aa700b003ed29189777sm2167726wmp.47.2023.03.29.05.34.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2023 05:34:34 -0700 (PDT)
From:   tomas.krcka@gmail.com
To:     will@kernel.org
Cc:     Tomas Krcka <krckatom@amazon.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any
Date:   Wed, 29 Mar 2023 12:34:19 +0000
Message-Id: <20230329123420.34641-1-tomas.krcka@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Krcka <krckatom@amazon.de>

When an overflow occurs in the PRI queue, the SMMU toggles the overflow
flag in the PROD register. To exit the overflow condition, the PRI thread
is supposed to acknowledge it by toggling this flag in the CONS register.
Unacknowledged overflow causes the queue to stop adding anything new.

Currently, the priq thread always writes the CONS register back to the
SMMU after clearing the queue.

The writeback is not necessary if the OVFLG in the PROD register has not
been changed, no overflow has occured.

This commit checks the difference of the overflow flag between CONS and
PROD register. If it's different, toggles the OVACKFLG flag in the CONS
register and write it to the SMMU.

The situation is similar for the event queue.
The acknowledge register is also toggled after clearing the event
queue but never propagated to the hardware. This would only be done the
next time when executing evtq thread.

Unacknowledged event queue overflow doesn't affect the event
queue, because the SMMU still adds elements to that queue when the
overflow condition is active.
But it feel nicer to keep SMMU in sync when possible, so use the same
way here as well.

Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..7614739ea2c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -152,6 +152,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
+static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
+{
+	struct arm_smmu_ll_queue *llq = &q->llq;
+
+	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
+		return;
+
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		      Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
+}
+
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
 {
 	u32 prod;
@@ -1577,8 +1589,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
@@ -1636,9 +1647,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
-	queue_sync_cons_out(q);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2

