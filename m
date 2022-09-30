Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E775F01EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiI3Auw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiI3Au2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ACC5A8B5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15E0EB824C2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F822C43141;
        Fri, 30 Sep 2022 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499021;
        bh=h409O7MuFLd1R61Cty/K7nU8QRAFuS/SVZNLRXmCENc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAk6c6zc1p79t1K11l/7dq2q4WAISTuoGI6iVo6I/QPLVZjJ6qQNXsclw2B7oac5D
         gnyKhhL2rANgr15f1hGG31cR2o2/Lzt0HRP1/UKeVq7sPpNC4Fr03d2y/mMYljlqpj
         VSFOq0yOOVsOado9BtDJTss34j3/25KqDbSn10fnEEUtFf+R2Icw6wOnbCQA7930e+
         kzO3bUEi5UU1W4nOyxVACFzLVfycLPQUAYV48CLsmi+XMUdDpN4ni9CU66yh3a89Vn
         jdjLqwsPFHlMWJk5plJvzeJzKlP2s81+S/rlK3O+MnvZVTSJuGmcsmAKQD7WebQmkq
         wuTMxWsZMYFPw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ashay Jaiswal <ashayj@codeaurora.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        David Collins <collinsd@codeaurora.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: [PATCH 6/9] spmi: pmic-arb: add support to dispatch interrupt based on IRQ status
Date:   Thu, 29 Sep 2022 17:50:15 -0700
Message-Id: <20220930005019.2663064-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930005019.2663064-1-sboyd@kernel.org>
References: <20220930005019.2663064-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashay Jaiswal <ashayj@codeaurora.org>

Current implementation of SPMI arbiter dispatches interrupt based on the
Arbiter's accumulator status, in some cases the accumulator status may
remain zero and the interrupt remains un-handled. Add logic to dispatch
interrupts based Arbiter's IRQ status if the accumulator status is zero.

Signed-off-by: Ashay Jaiswal <ashayj@codeaurora.org>
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/1655004286-11493-6-git-send-email-quic_fenglinw@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index e19eaec30aa5..56f22941d570 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -630,12 +630,18 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
+	/* status based dispatch */
+	bool acc_valid = false;
+	u32 irq_status = 0;
 
 	chained_irq_enter(chip, desc);
 
 	for (i = first >> 5; i <= last >> 5; ++i) {
 		status = readl_relaxed(
 				ver_ops->owner_acc_status(pmic_arb, ee, i));
+		if (status)
+			acc_valid = true;
+
 		while (status) {
 			id = ffs(status) - 1;
 			status &= ~BIT(id);
@@ -653,6 +659,29 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 		}
 	}
 
+	/* ACC_STATUS is empty but IRQ fired check IRQ_STATUS */
+	if (!acc_valid) {
+		for (i = first; i <= last; i++) {
+			/* skip if APPS is not irq owner */
+			if (pmic_arb->apid_data[i].irq_ee != pmic_arb->ee)
+				continue;
+
+			irq_status = readl_relaxed(
+					     ver_ops->irq_status(pmic_arb, i));
+			if (irq_status) {
+				enable = readl_relaxed(
+					     ver_ops->acc_enable(pmic_arb, i));
+				if (enable & SPMI_PIC_ACC_ENABLE_BIT) {
+					dev_dbg(&pmic_arb->spmic->dev,
+						"Dispatching IRQ for apid=%d status=%x\n",
+						i, irq_status);
+					if (periph_interrupt(pmic_arb, i) != 0)
+						handled++;
+				}
+			}
+		}
+	}
+
 	if (handled == 0)
 		handle_bad_irq(desc);
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

