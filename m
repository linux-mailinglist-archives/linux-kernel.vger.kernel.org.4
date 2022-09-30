Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40C5F01E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiI3Au2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiI3AuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D094491D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64BA9621F7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C86C433B5;
        Fri, 30 Sep 2022 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499020;
        bh=NwDUjrU4LjI2WMT3IqrYZyXMmFV1TWVsRQF3T99VRtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdaj/SQvQN18WwRjZJizOlwuhVjsmSAOdzAIyeXyBSOaWet4IJaM2d1DwdJp1Ym4S
         I9T2YOCTXtKAwwG0CmrS21hgIoBS6k0OC6ZY8e/pv6UdbJ8CcbbF68B6zqjIQE0yHX
         D5IxVPdjQ0fvPYgkoBubfmRQ5mvuf/XsRFrfvvG4ZtJuMNijb36NSJwdSen45FXdh2
         oFGqGlwmKK+Hq4obvhhNUJ/+W5ONG76Q7Q/ZLDD/fG31LZ8fVKfy7TKSTtePAqhOIl
         dkvkOlB++OC/W1Y6RAJjhteV25ci0kquwdbx3u99j3+Vy0sZ4OVVgZZDesC9bWUOIC
         Xj1m4hlmH3sZA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 3/9] spmi: pmic-arb: handle spurious interrupt
Date:   Thu, 29 Sep 2022 17:50:12 -0700
Message-Id: <20220930005019.2663064-4-sboyd@kernel.org>
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

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Call handle_bad_irq() when the summary interrupt is fired spuriously.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/1655004286-11493-3-git-send-email-quic_fenglinw@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5a99723b3f32..719bd73e5153 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -605,10 +605,11 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 				irq_mask, ppid);
 }
 
-static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
+static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 {
 	unsigned int irq;
 	u32 status, id;
+	int handled = 0;
 	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
 	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
 
@@ -623,7 +624,10 @@ static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 			continue;
 		}
 		generic_handle_irq(irq);
+		handled++;
 	}
+
+	return handled;
 }
 
 static void pmic_arb_chained_irq(struct irq_desc *desc)
@@ -634,7 +638,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	int first = pmic_arb->min_apid >> 5;
 	int last = pmic_arb->max_apid >> 5;
 	u8 ee = pmic_arb->ee;
-	u32 status, enable;
+	u32 status, enable, handled = 0;
 	int i, id, apid;
 
 	chained_irq_enter(chip, desc);
@@ -649,10 +653,14 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 			enable = readl_relaxed(
 					ver_ops->acc_enable(pmic_arb, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-				periph_interrupt(pmic_arb, apid);
+				if (periph_interrupt(pmic_arb, apid) != 0)
+					handled++;
 		}
 	}
 
+	if (handled == 0)
+		handle_bad_irq(desc);
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

