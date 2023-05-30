Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246C715B28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjE3KMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjE3KLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58FF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:11:42 -0700 (PDT)
Date:   Tue, 30 May 2023 10:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685441500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Kgox1DACm+wImb37rOPJ3ZxaCjPRS4PC+RXndEqMgYI=;
        b=0yABhfWbjUr5GEpV4YxmFDoNSsXdV+/sj0sAUW+sEyxaxywok/pllZGcNbAUYX2NColHwa
        AS/yS/DEAzQR8iz8SMMFRe4mddbqp5Qr3/+PIigctY/9/6YmFRng+BOXyJMHDDeVLn9c9j
        /pu8N8ZAkjuOfBL3U2ftHtEGZVzwe5XC732bF7gk89mE83Ppwt22wmXapIcVlkhvKFuVYo
        cdy2pUzldCGPKoPVbe4a+IeZVT0Vwpwo2MhhulbTVZpbdy5L/LSrl5xXK/tAOViNPFmCDQ
        XhkGmeIAZVdnylsoqylkjHZ5KQTPSk3Sh7CenrioGm33glY/jDpl0qHuBw4D7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685441500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Kgox1DACm+wImb37rOPJ3ZxaCjPRS4PC+RXndEqMgYI=;
        b=di5ajOfwLx+9lu6pIZ8FeqhR9ovUes6m/1dXIdl13QM8QojyV3Y16mrdbHRZmbC2pJBFsd
        Q+jcx1DjV+lttkDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic: Correctly validate OF quirk
 descriptors
Cc:     Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <168544149933.404.717399647227994720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     91539341a3b6e9c868024a4292455dae36e6f58c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/91539341a3b6e9c868024a4292455dae36e6f58c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 30 May 2023 11:01:22 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 30 May 2023 11:01:22 +01:00

irqchip/gic: Correctly validate OF quirk descriptors

When checking for OF quirks, make sure either 'compatible' or 'property'
is set, and give up otherwise.

This avoids non-OF quirks being randomly applied as they don't have any
of the OF data that need checking.

Cc: Douglas Anderson <dianders@chromium.org>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index de47b51..afd6a18 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -16,6 +16,8 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
+		if (!quirks->compatible && !quirks->property)
+			continue;
 		if (quirks->compatible &&
 		    !of_device_is_compatible(np, quirks->compatible))
 			continue;
