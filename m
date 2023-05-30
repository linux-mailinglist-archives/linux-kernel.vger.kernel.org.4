Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85755716FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjE3VkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjE3VkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:40:13 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2111C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685482808; x=1717018808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0lAuoGk56JFzvUQpYQHSf87YsEVvoUcUI9dkbr4Ucg0=;
  b=rGgQWThtEoTsvcIi2kGPoAMR8vnSdKGvnwjrIXoL1E14TxDFlLRLDtgC
   htx6uQJzJycrhGkBOa7BkYhO80ssaWc/OtIDXmQMmaYGfrOhvAVeiyiUu
   8WH7lb1qXOcT8T/KcWckh7MCP8saBXQtX56B5HlneU8EdRMoCuGvQAnnp
   A=;
X-IronPort-AV: E=Sophos;i="6.00,205,1681171200"; 
   d="scan'208";a="6913183"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:40:06 +0000
Received: from EX19D014EUC004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id BA4F1805EA;
        Tue, 30 May 2023 21:40:05 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.226) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 21:40:01 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
        Marc Zyngier <maz@kernel.org>,
        Liao Chang <liaochang1@huawei.com>
Subject: [PATCH 1/2] genirq: Expand doc for PENDING and REPLAY flags
Date:   Tue, 30 May 2023 23:38:47 +0200
Message-ID: <20230530213848.3273006-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.226]
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

