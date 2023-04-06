Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EAA6D9F86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjDFSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFSJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:09:10 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD12D7F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=m8j3+11mjWqUYKGWjM37PJj3N8NR05QL+S5Ug4QfIns=; b=mP
        P+3p3Hfy6yCIzaY9bvaTXU4v/XsSgSwcLB6scpju5pF2eecRvhgQm+73uQXINJopyxIE3jzimgw/w
        AuzYkrZRWUdM0I5HcQ1Tb0tSwfxlxQrQGfXSHH2ykZde4GOQ3X3sKtuedyKeHPeKhkLRB0LjiJ7zR
        slJCnKlTBc3wHEXoOFX86U0L+YCDxfW8Fm+G7246QBP5Uknv1nXjDvquMslMSFMEuLmSpX907aIVZ
        /SCQq1bI+RLaaHpFR/PMC4SdIlGwyDDdz/4DUMIsnVqEslB+RwMYtvj+vBZj81D2H0npbw5cwFLER
        lJ0wJHMtNgV9NUROseY3uCyQQjPWJR1w==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pkU2h-00053p-II;
        Thu, 06 Apr 2023 19:09:04 +0100
From:   John Keeping <john@metanate.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Keeping <john@metanate.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: update affinity of secondary threads
Date:   Thu,  6 Apr 2023 19:08:57 +0100
Message-Id: <20230406180857.588682-1-john@metanate.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For interrupts with secondary threads, the affinity is applied when the
thread is created but if the interrupts affinity is changed later only
the primary thread is updated.

Update the secondary thread's affinity as well to keep all the
interrupt's activity on the assigned CPUs.

Signed-off-by: John Keeping <john@metanate.com>
---
 kernel/irq/manage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8ce75495e04f..4f76eb8b7fcf 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -189,9 +189,13 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
-	for_each_action_of_desc(desc, action)
+	for_each_action_of_desc(desc, action) {
 		if (action->thread)
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		if (action->secondary && action->secondary->thread)
+			set_bit(IRQTF_AFFINITY,
+				&action->secondary->thread_flags);
+	}
 }
 
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-- 
2.40.0

