Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB05F01EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiI3Aul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiI3Au1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAB5AA0D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E31B826C9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F24C433C1;
        Fri, 30 Sep 2022 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499020;
        bh=1iKgq57jI+UOl7K/jTlEvdXh17z6ctGT+qZUxoeVpCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKf3xd2w/P/LVo7L9VmrzjR/2bRsBRK7UnDSKPe0DFKelXF48aoVFfbtakbChcB2F
         iOyxwhUd38n+DYMBUucONFy3PO0tGLEzcdyaCjIhtcPBPy4MvL+3QiEWUdKR+4CCQA
         nZMftVHc5+QXyEBY0ctX7sggU9qzkvyqdYQ6cezjS/E0KUFqbJ7c+PZs6XbnZIgucR
         89lcLJ42cTplQFCwldpxhWMXBdZwAIGs83PspsiPgIktEHVC+Ek9L08czn+LlkHE+P
         +BBmbviUJtyWw9yJ18YMJBJ77GeEFjUZUrTOSvKuTPnW+b8DCh8hm8TzgDGJBZrS3Y
         8m7TUwmveqNeQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        David Collins <collinsd@codeaurora.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: [PATCH 2/9] spmi: pmic-arb: add a print in cleanup_irq
Date:   Thu, 29 Sep 2022 17:50:11 -0700
Message-Id: <20220930005019.2663064-3-sboyd@kernel.org>
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

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

The cleanup_irq() was meant to clear and mask interrupts that were
left enabled in the hardware but there was no interrupt handler
registered for it. Add an error print when it gets invoked.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/1655004286-11493-2-git-send-email-quic_fenglinw@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 2113be40b5a9..5a99723b3f32 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -590,6 +590,8 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 	u8 per = ppid & 0xFF;
 	u8 irq_mask = BIT(id);
 
+	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
+			__func__, apid, sid, per, id);
 	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
 
 	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

