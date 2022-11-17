Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB262DF57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiKQPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiKQPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:10:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13D490A8;
        Thu, 17 Nov 2022 07:08:36 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ7IDcdz2kRDkskmrnjbIaNuMerZZbNgSVXrJHNie9c=;
        b=0rLvmMViNOyrgq/Vc7scjasIA23f6t6RydNWBE0rnR/MnN2DniesKApXXfPWMtRcdfPfCJ
        PAW7Qrnb6sraWnemVHSuv8uOW3c58IAd79oY+beRSMqhy1l8/4czz+kf3jjaSQ5+NaZgZp
        7sQMJ0AtRUCdmF/mjdWc/TZoZzYumQwAFu3wkyA0BrtuzPM3oLj1janYTUUwlaHghNQzXq
        C7eWiwmkjT4yaQzs3N6mXrcon3Z7I/D54cfoVtMfHxzinkoMGMgPq+HmdnSchd8Fs/jOU7
        7AG9/J5rfV+yIUgOAy57y2EvHU5VaQbUishwlMX9EFJO20QFm19re2iofsPB9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ7IDcdz2kRDkskmrnjbIaNuMerZZbNgSVXrJHNie9c=;
        b=sgZ0hV2GQjRUnYJ9p7mCVjLbERGcGMzTFBQAJsOQdGmTLigQheFbm7AgH2KNZx8sEvzOCU
        hxq76jT0GY6d4tCg==
From:   "tip-bot2 for Angus Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove unused argument force of
 irq_set_affinity_deactivated()
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221007103236.599-1-angus.chen@jaguarmicro.com>
References: <20221007103236.599-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Message-ID: <166869771390.4906.10407501709343037583.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fd19ce77993a49f3afc56bb4cae7eafb1ec69e0c
Gitweb:        https://git.kernel.org/tip/fd19ce77993a49f3afc56bb4cae7eafb1ec69e0c
Author:        Angus Chen <angus.chen@jaguarmicro.com>
AuthorDate:    Fri, 07 Oct 2022 18:32:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 14:00:55 +01:00

genirq: Remove unused argument force of irq_set_affinity_deactivated()

The force parameter in irq_set_affinity_deactivated() is not used,
get rid of it.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221007103236.599-1-angus.chen@jaguarmicro.com
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe780..5b7cf28 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -321,7 +321,7 @@ static int irq_try_set_affinity(struct irq_data *data,
 }
 
 static bool irq_set_affinity_deactivated(struct irq_data *data,
-					 const struct cpumask *mask, bool force)
+					 const struct cpumask *mask)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
@@ -354,7 +354,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_set_affinity_deactivated(data, mask, force))
+	if (irq_set_affinity_deactivated(data, mask))
 		return 0;
 
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
