Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9145FE144
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiJMSbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJMSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:31:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A901793B0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:26:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so5675713ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oow4Z/54Ywu9hc74bLjW+CtYs8QrvcOSZ9QuyKFYcEc=;
        b=ED9AlBSj+HB3AoaKj7DQ6M9wpZ6f6w4GodqNMB1xfK/zk6oF6HLxanhqwuG7Fd6R3S
         Na43xZWDhuMEVhpRgGli0KufczMvg+iDIQia5e4MkKK7NnuzBjYr9uWV/zTXJ2FFJ9mQ
         CDyD4aWS4JrSGufnnIK1XfXmJDZocqpnWKg50JoUJhnQJlrDPJUjqGK+uFLhPwnvQaLm
         DgG4sQ4tmE0ckxaWchNtaudUhH51Q6d4aBK2QPPGJznLm1RAeOMbO6udAqa5gRk6vBbw
         nvOjXEF3+QAHeLVvYUsrPzaVR7kXWBH6YABlCbDTIH1fcLYhwp2wbMHea3TwU0W1rPJk
         mbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oow4Z/54Ywu9hc74bLjW+CtYs8QrvcOSZ9QuyKFYcEc=;
        b=f5TJjc+WBDwxq3ACzbaqxu0128WRVwpsOCQR1xcITr95hNT5qTk4no9FDyI/K5pB8f
         dqb1aFWo4/0zsCj2k3PG0riBejSIGUHzjxsLSwcaFPTXSTbLJaO+w/ZmwV6piTmcXCpx
         6JUnQccaN4ebmjkBrnS09IUdFpBMBF3aIXlInreXC54kLuUAADq/LLGdkKd1uvilJK0z
         MsgIfBOBposElPEiXvJ+MR1fHIxAYw592PpOaNpKBQSP8K13KLvtg8L7i8lG0R6vLNZJ
         xLZfNZptjAHwTYOZSrF1oCHnNGgFzsDuXChpks9MocsEmJ+2/EYO10sJmJv1Cnemn2MT
         RfqA==
X-Gm-Message-State: ACrzQf1Exbj6vU2UuPQvtfoQJu0CxpgcJ7/nCM1HCgjBoHyDjoiRF7Mk
        L3QwuImiji8BUayQkEHJmGYtR/fHJChUhX2k
X-Google-Smtp-Source: AMsMyM7zbaKTyyrnltI3FlR5A/IP6LXwZcu3J1BPdc+HmT8j7TiQ8hkdI+Pf+LW56SPwakrGxverFA==
X-Received: by 2002:a17:906:3fd2:b0:78d:b793:5ef9 with SMTP id k18-20020a1709063fd200b0078db7935ef9mr730855ejj.496.1665684767259;
        Thu, 13 Oct 2022 11:12:47 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:46 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/5] iommu/sun50i: Consider all fault sources for reset
Date:   Thu, 13 Oct 2022 20:12:17 +0200
Message-Id: <20221013181221.3247429-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
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

We have to reset masters for all faults - permissions, L1 fault or L2
fault. Currently it's done only for permissions. If other type of fault
happens, master is in locked up state. Fix that by really considering
all fault sources.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c777882d0ec2..38d1069cf383 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -869,8 +869,8 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 
 static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 {
+	u32 status, l1_status, l2_status, resets;
 	struct sun50i_iommu *iommu = dev_id;
-	u32 status;
 
 	spin_lock(&iommu->iommu_lock);
 
@@ -880,6 +880,9 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	l1_status = iommu_read(iommu, IOMMU_L1PG_INT_REG);
+	l2_status = iommu_read(iommu, IOMMU_L2PG_INT_REG);
+
 	if (status & IOMMU_INT_INVALID_L2PG)
 		sun50i_iommu_handle_pt_irq(iommu,
 					    IOMMU_INT_ERR_ADDR_L2_REG,
@@ -893,7 +896,8 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
-	iommu_write(iommu, IOMMU_RESET_REG, ~status);
+	resets = (status | l1_status | l2_status) & IOMMU_INT_MASTER_MASK;
+	iommu_write(iommu, IOMMU_RESET_REG, ~resets);
 	iommu_write(iommu, IOMMU_RESET_REG, IOMMU_RESET_RELEASE_ALL);
 
 	spin_unlock(&iommu->iommu_lock);
-- 
2.38.0

