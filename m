Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D45BBD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIRLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiIRLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BF2529A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A2ABB80ECD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46695C433D6;
        Sun, 18 Sep 2022 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501045;
        bh=XWLe4fY6Thsb7bb130/4zOFqppPdJiIjx28e0jGdVCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4qBPa74j9/0vh5MVe4K5tCaMzlGFKVBsQgU0ixqCNBcytK3VnJH3R1TBRiurlRzr
         zZNdsLChwJoo/XRAyCacbQyJCOJJac/XZs0+ikk8ogH44WnB7DXCsHWNmKwW2Idk8B
         AK/Obz9Or38lIiLjS/0HI8Q4PJ8FoxSvNJx7qBLFZDD3jhhrPiBJUtf0IpnWb1mAa1
         UJPZ1YU1I3CKwfePuatc/vOQzCqAX13wo5nzFzVUpMJLhkyC9AAP3RkZ6VevTSUn8Y
         28g+IR9KPsY1yG0fDpJ4rj0wPc7JMf593HcuQGfF2HEaWKehXqP/RLbgm8A7Q6EChX
         urxtcXjj3EgbA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/7] habanalabs/gaudi2: get f/w reset status register dynamically
Date:   Sun, 18 Sep 2022 14:37:13 +0300
Message-Id: <20220918113717.2637094-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Get the firmware reset status address from the dynamic registers
we read from the firmware instead of using a define.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c             | 5 ++++-
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 6ed9b3ce16dd..b95eab4c237c 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -5439,7 +5439,10 @@ static void gaudi2_execute_soft_reset(struct hl_device *hdev, u32 reset_sleep_ms
 
 	if (!driver_performs_reset) {
 		/* set SP to indicate reset request sent to FW */
-		WREG32(mmCPU_RST_STATUS_TO_HOST, CPU_RST_STATUS_NA);
+		if (dyn_regs->cpu_rst_status)
+			WREG32(le32_to_cpu(dyn_regs->cpu_rst_status), CPU_RST_STATUS_NA);
+		else
+			WREG32(mmCPU_RST_STATUS_TO_HOST, CPU_RST_STATUS_NA);
 
 		WREG32(le32_to_cpu(dyn_regs->gic_host_soft_rst_irq),
 			gaudi2_irq_map_table[GAUDI2_EVENT_CPU_SOFT_RESET].cpu_id);
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 2e45be5de4fe..e0ea51cc7475 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -431,7 +431,9 @@ struct cpu_dyn_regs {
 	__le32 gic_host_ints_irq;
 	__le32 gic_host_soft_rst_irq;
 	__le32 gic_rot_qm_irq_ctrl;
-	__le32 reserved1[22];		/* reserve for future use */
+	__le32 cpu_rst_status;
+	__le32 eng_arc_irq_ctrl;
+	__le32 reserved1[20];		/* reserve for future use */
 };
 
 /* TODO: remove the desc magic after the code is updated to use message */
-- 
2.25.1

