Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307876B02B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCHJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCHJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:21:09 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80995BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1678267264; x=1709803264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y+qjIHWzcca+yd9j/kP72fFl8+TP5V5KFgYwtZbFabI=;
  b=fN2mZzSDjExTM8cM6p0PCQCeoM8k1SP1hvkwVBq0/lYlRolz4A+jZuv/
   IjxsHnMVg6qhDCF3HmPQTf96+jXm4JO8WTYumwvPeJv8q/+Mwo7MBpdTs
   ZEK3p3Xd5YyC5o+d5PsHQSxcvElYj5gynvV26+Lsh1oej+WBVl6f73Oeo
   Y=;
X-IronPort-AV: E=Sophos;i="5.98,243,1673913600"; 
   d="scan'208";a="300733479"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 09:20:55 +0000
Received: from EX19D020EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id D51B0C185B;
        Wed,  8 Mar 2023 09:20:53 +0000 (UTC)
Received: from EX19D030EUC001.ant.amazon.com (10.252.61.228) by
 EX19D020EUA002.ant.amazon.com (10.252.50.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Wed, 8 Mar 2023 09:20:52 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D030EUC001.ant.amazon.com (10.252.61.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Wed, 8 Mar 2023 09:20:51 +0000
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com
 (10.13.225.85) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server (TLS) id 15.0.1497.45 via Frontend Transport; Wed, 8 Mar 2023 09:20:49
 +0000
From:   Tomas Krcka <krckatom@amazon.de>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Tomas Krcka <krckatom@amazon.de>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow acknowledgment
Date:   Wed, 8 Mar 2023 09:20:47 +0000
Message-ID: <20230308092048.71390-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an overflow occurs in the event queue, the SMMU toggles overflow
flag OVFLG in the PROD register.
The evtq thread is supposed to acknowledge the overflow flag by toggling
flag OVACKFLG in the CONS register, otherwise the overflow condition is
still active (OVFLG != OVACKFLG).

Currently the acknowledge register is toggled after clearing the event
queue but is never propagated to the hardware. It would be done next
time when executing evtq thread.

The SMMU still adds elements to the queue when the overflow condition is
active but any subsequent overflow information after clearing the event
queue will be lost.

This change keeps the SMMU in sync as it's expected by design.

Signed-off-by: Tomas Krcka <krckatom@amazon.de>
Suggested-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..acc1ff5ff69b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1579,6 +1579,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	/* Sync our overflow flag, as we believe we're up to speed */
 	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
 		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
 	return IRQ_HANDLED;
 }
 
-- 
2.39.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



