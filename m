Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA5727F95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjFHMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjFHMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:02:49 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B583210B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686225770; x=1717761770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lAuoGk56JFzvUQpYQHSf87YsEVvoUcUI9dkbr4Ucg0=;
  b=J+nm46Mob4/x/UF02E9UISjlpnr6m7tg47WQhfk8qw1Z0m7p22ECIG5z
   AfBAvmUldQwiT6NXLyNlQk1Hx/JgBji/UlKM5aKa/iK+8DxbX5b0byHQ6
   wKatf3jUVYx0RuPj72Qp0ckOf//LsTtarIEBUPBY3Ds7Rcwhxj5LXQDwm
   w=;
X-IronPort-AV: E=Sophos;i="6.00,226,1681171200"; 
   d="scan'208";a="332957334"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:02:45 +0000
Received: from EX19D014EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id F403365A01;
        Thu,  8 Jun 2023 12:02:43 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.221) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 12:02:39 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>, <liaochang1@huawei.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>
Subject: [PATCH 1/3] genirq: Expand doc for PENDING and REPLAY flags
Date:   Thu, 8 Jun 2023 14:00:19 +0200
Message-ID: <20230608120021.3273400-2-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608120021.3273400-1-jgowans@amazon.com>
References: <20230608120021.3273400-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.221]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a bit more info about what the flags are used for may help future
code readers.

Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Liao Chang <liaochang1@huawei.com>
---
 kernel/irq/internals.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b557579..c443a0ddc07e 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -47,9 +47,12 @@ enum {
  *				  detection
  * IRQS_POLL_INPROGRESS		- polling in progress
  * IRQS_ONESHOT			- irq is not unmasked in primary handler
- * IRQS_REPLAY			- irq is replayed
+ * IRQS_REPLAY			- irq has been resent and will not be resent
+ * 				  again until the handler has run and cleared
+ * 				  this flag.
  * IRQS_WAITING			- irq is waiting
- * IRQS_PENDING			- irq is pending and replayed later
+ * IRQS_PENDING			- irq needs to be resent and should be resent
+ * 				  at the next available opportunity.
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
-- 
2.25.1

