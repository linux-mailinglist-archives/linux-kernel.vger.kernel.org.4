Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59976482FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLINxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLINxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:53:35 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4597285B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:53:34 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so8186163pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuRW8bb+Xuc5Kw9Ss68gOSGDX5ftSELw7fxSLgdhk9o=;
        b=HAcVaLxMpMOnLw4dVXy71oo9WD/KStFSbTUbMtFL4GLK34QrJi7aurdZTEWEO/AlmI
         kKXmheNN8ZD7PdIBIu6XsHweyCBv5lDauGTLQ0mTTsiaYR5Wd4gi7lOZTrZUpz0oPm3U
         fQaEXxfQxm/E34yBjhQIe20n4zvouBFfHFtuFcTcRQQKfpaM0dKhx/ZXfYeyf5GP/zqA
         SV/T6QTzChFVSzWtKhaimH7sog5wOtxnPtN3zt9Zd9qtMQB6+RSVLj89mYmASYqiCmUi
         BWjJuwoGrGFAxG1Mrm5JZodFpjvnOvDz7wgXLoSnYjRYbGfdZhAOAR7o3Z3CrLINOfVW
         5AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuRW8bb+Xuc5Kw9Ss68gOSGDX5ftSELw7fxSLgdhk9o=;
        b=cMrFko6yzPPzU3U4WSaGUYgkwtEcrzkPVNZ+jCEbyHHccs10zvhI3W3iT8y0WmkMIl
         mJPTXKybEQCVxV5hpmC7ws7unbnc/VMRH6hyQpwrw81AejXqoZJ97Sufc84nWmWlpv/I
         DsrEGdP/H2UHdTQxYxVfKmG9Xl6sjlYBN4y08bOvziN3iT7rNpAXmLNdK+FHR9z3/a/W
         iEIm0WxXHrU4YmW9S9TQK7CsV5+AlZn0AHRYsaLChTEDXM11oNUbngzC2gukZcdD82E4
         dlWVrFBnR2hPP0raFjR4Vrd5OzXiqdQylM9R9ZIU2/N+sah2iyS72NOL3KMaZN3NEHiW
         FWfA==
X-Gm-Message-State: ANoB5pltTGQFkKmHqKb1M0yhpV3290Xh+ZyVpi3+Lp+thqsYCAw12d7f
        CWUDBWyRhaQ3lPk3A99zf+4=
X-Google-Smtp-Source: AA0mqf4u2zsNVxEGPtQEj4/7+yH9TnLkzbjepukOASwxQwvyAAgAATrE0ly7dOFwNJc8GPhhl6RerA==
X-Received: by 2002:a17:902:eb52:b0:189:c253:3625 with SMTP id i18-20020a170902eb5200b00189c2533625mr5870441pli.11.1670594013936;
        Fri, 09 Dec 2022 05:53:33 -0800 (PST)
Received: from junjun.localdomain ([113.140.249.126])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b00186ff402508sm1356489plf.281.2022.12.09.05.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:53:32 -0800 (PST)
From:   Harry Song <jundongsong1@gmail.com>
To:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com
Cc:     jundongsong1@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Fix incorrect description of DMB instruction
Date:   Fri,  9 Dec 2022 21:53:04 +0800
Message-Id: <20221209135304.3306-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current comment is a description of the DSB instruction:
previous commit [1].

In the ARM architecture manual, DSB and DMB instructions
are described as follows:

DMB: The DMB instruction does not ensure the completion of
any of the memory accesses for which it ensures relative order.i

DSB: A DSB instruction is a memory barrier that ensures that
memory accesses that occur before the DSB instruction have
completed before the completion of the DSB instruction.

So after dsb is replaced with dmb, the description here is not correct.
DMB instructions do not ensure that memory access has been completed,
but rather ensure the order of instructions.

  a76a37777f2c ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer") [1]

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d5df91c5..fb229c0ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -139,8 +139,8 @@ static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 prod)
 static void queue_sync_cons_out(struct arm_smmu_queue *q)
 {
 	/*
-	 * Ensure that all CPU accesses (reads and writes) to the queue
-	 * are complete before we update the cons pointer.
+	 * Ensure the relative order of cpu accesses (reads and writes)
+	 * to the queue before update the cons pointer.
 	 */
 	__iomb();
 	writel_relaxed(q->llq.cons, q->cons_reg);
-- 
2.25.1

