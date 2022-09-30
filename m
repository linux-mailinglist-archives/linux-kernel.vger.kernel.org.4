Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEB5F01E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiI3Aud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiI3AuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F1564C3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C2C621F5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48575C43470;
        Fri, 30 Sep 2022 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499021;
        bh=zB8G1Z7pEhfGomLi8IipgwDv6tydTM4idiFu0sDQK/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfDM6tRDl9nDSLXTYnWKvRI8R5FbmaW+PCjml/5KwCOvwhkyiQPOIyRVQ3GPFgTDq
         zA4N8cH7SUHToIId7ZoWcStOqluA4g8BbeONFtEdC0ImgxY9YMS8XWg1cgOiRGVU97
         SoZdLPGTZjfR32/pgM2f28KdI6uK0B+rkNJsYlqtIBiWzHzgyCYyGTAtcAcrunJop4
         m2XLqfmhQ/jI+smB8XolxljyUGviVXifVgSwXJhovCJwuQt3ByY5US6j0v8g3gPIsg
         mHTwPO7K5ftXeZcEo0Qoty+mZPqBjhuGw/L9RQFMrwCvoixAQZ4Byp0VeJue5A7MCe
         dSizEtBsLpgPg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: [PATCH 5/9] spmi: pmic-arb: check apid against limits before calling irq handler
Date:   Thu, 29 Sep 2022 17:50:14 -0700
Message-Id: <20220930005019.2663064-6-sboyd@kernel.org>
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

From: David Collins <collinsd@codeaurora.org>

Check that the apid for an SPMI interrupt falls between the
min_apid and max_apid that can be handled by the APPS processor
before invoking the per-apid interrupt handler:
periph_interrupt().

This avoids an access violation in rare cases where the status
bit is set for an interrupt that is not owned by the APPS
processor.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/1655004286-11493-5-git-send-email-quic_fenglinw@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2bc3b88f35c9..e19eaec30aa5 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -625,21 +625,26 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	struct spmi_pmic_arb *pmic_arb = irq_desc_get_handler_data(desc);
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int first = pmic_arb->min_apid >> 5;
-	int last = pmic_arb->max_apid >> 5;
+	int first = pmic_arb->min_apid;
+	int last = pmic_arb->max_apid;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
 
 	chained_irq_enter(chip, desc);
 
-	for (i = first; i <= last; ++i) {
+	for (i = first >> 5; i <= last >> 5; ++i) {
 		status = readl_relaxed(
 				ver_ops->owner_acc_status(pmic_arb, ee, i));
 		while (status) {
 			id = ffs(status) - 1;
 			status &= ~BIT(id);
 			apid = id + i * 32;
+			if (apid < first || apid > last) {
+				WARN_ONCE(true, "spurious spmi irq received for apid=%d\n",
+					apid);
+				continue;
+			}
 			enable = readl_relaxed(
 					ver_ops->acc_enable(pmic_arb, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

