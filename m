Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE59722D33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjFERCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjFERBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:01:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4C9219C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:01:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0349BD75;
        Mon,  5 Jun 2023 10:02:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C09C3F587;
        Mon,  5 Jun 2023 10:01:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 2/4] ACPI/APMT: Don't register invalid resource
Date:   Mon,  5 Jun 2023 18:01:32 +0100
Message-Id: <63b34656e1f7b41bcb458fb6d7496e04db757e0d.1685983270.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1685983270.git.robin.murphy@arm.com>
References: <cover.1685983270.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't register a resource for the second page unless the dual-page
extension flag is actually present to say it's valid.

CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/apmt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index 8cab69fa5d59..aa7d5c3c0dd8 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -35,11 +35,13 @@ static int __init apmt_init_resources(struct resource *res,
 
 	num_res++;
 
-	res[num_res].start = node->base_address1;
-	res[num_res].end = node->base_address1 + SZ_4K - 1;
-	res[num_res].flags = IORESOURCE_MEM;
+	if (node->flags & ACPI_APMT_FLAGS_DUAL_PAGE) {
+		res[num_res].start = node->base_address1;
+		res[num_res].end = node->base_address1 + SZ_4K - 1;
+		res[num_res].flags = IORESOURCE_MEM;
 
-	num_res++;
+		num_res++;
+	}
 
 	if (node->ovflw_irq != 0) {
 		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
-- 
2.39.2.101.g768bb238c484.dirty

