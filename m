Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4295F3F96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJDJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJDJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C70318F;
        Tue,  4 Oct 2022 02:27:10 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tr1Jdmoz9hOBx8+3qnWQjg+m6tHY0hJi361zyWHO32w=;
        b=TdwqJB4qa5461WEArDEcIocailklbROCAufuFQvUsQ6v9DdVIk3aGAvMzev9YE41LL7Ef5
        LzSSLKLwkkyoe7NNaOzR880JxtyOPVKpUgqzxpcfvLXFN7rPiiXOAbbchPUxCWEY9LDUQD
        j5rgTwqDdS0UwMbDDyl8tK4k6HrvbJESuhRG2Tlvpsi82qQiKsqxBzuqvPFLcZ9piUF7Ey
        zmQZoEqZjoXa+fSmeZQxUDaF7u+8c8rsh46I6RdU1G0sLOSqk0LS3HtTGw9wxeMCd1cV+U
        +bdg8Xi+guJPy3LHE8fGXIS5U4skRJ3KS77DXnxh9vN5PdVNVehIi1gzbFDhTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tr1Jdmoz9hOBx8+3qnWQjg+m6tHY0hJi361zyWHO32w=;
        b=ij253lDa7xYjPSpsjTo5jH8wc6/TCMKLc5LFIn2B6OZSbu3XWUd2eOk7HAd+7J/+drR1OH
        FbUIrldLi0t9Z3AA==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-sysctr: handle
 nxp,no-divider property
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902111207.2902493-3-peng.fan@oss.nxp.com>
References: <20220902111207.2902493-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <166487562691.401.3433013681547293513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     27b30995b75d1e79360c164ba179bca86ab76ba6
Gitweb:        https://git.kernel.org/tip/27b30995b75d1e79360c164ba179bca86ab76ba6
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Fri, 02 Sep 2022 19:12:07 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:46 +02:00

clocksource/drivers/imx-sysctr: handle nxp,no-divider property

The previous hardware design embedds a internal divider for base clock.
New design not has that divider, so check the nxp,no-divider property,
if true, directly use base clock input, otherwise divide by 3 as before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20220902111207.2902493-3-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 523e376..5a7a951 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -134,8 +134,10 @@ static int __init sysctr_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	/* system counter clock is divided by 3 internally */
-	to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+	if (!of_property_read_bool(np, "nxp,no-divider")) {
+		/* system counter clock is divided by 3 internally */
+		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+	}
 
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
