Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD038639628
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKZNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKZNef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728119039
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:35 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bzeurKs43bdeMtLCP7XNpz7DjxYDtCiG6Qg2Pn3fZ0=;
        b=bgFZ4NMsZouF3z70TBNriLdDNSYDggJflWNRas0DtK5Rrx7EavTY6DiO+u9D3NmY3f0289
        3j/A9OOZeSWz020q7lX07yJX7EjD0UUz8XnPS3WbaqmSFjE4F8PN36yRJikJG49nhzyo2u
        5b4+cKhtxUAgh9tYynJ/epoFW9tl99VxUsM3h2DwSUYZOuVis0aWsrnJNdZikf9cdfnPww
        tirDYfFTeNPsgEq7ME068cQzcApRY+ZsuoEYi7VqTI40v1yF9zxNA1n8wLH38HmKod7BH0
        jZXRLhouklysFUG70fVcBMeydamyaVJg1L3Erl6+UTziSPnbp11NDOWfz818Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bzeurKs43bdeMtLCP7XNpz7DjxYDtCiG6Qg2Pn3fZ0=;
        b=/V2uCyUubcRM6Y3JB7jcAgUl6PJXf3ifCuPWYbVKLGzGEJ6/Wtxp+8n5VCshCVAJw0H0rv
        s2+dWJ76o7TamzCg==
From:   "irqchip-bot for Shang XiaoJing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: gic-pm: Use
 pm_runtime_resume_and_get() in gic_probe()
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221124065150.22809-1-shangxiaojing@huawei.com>
References: <20221124065150.22809-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Message-ID: <166946967257.4906.15241711598038467524.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f9ee20c85b3a3ba0afd3672630ec4f93d339f015
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f9ee20c85b3a3ba0afd3672630ec4f93d339f015
Author:        Shang XiaoJing <shangxiaojing@huawei.com>
AuthorDate:    Thu, 24 Nov 2022 14:51:50 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:42 

irqchip: gic-pm: Use pm_runtime_resume_and_get() in gic_probe()

gic_probe() calls pm_runtime_get_sync() and added fail path as
rpm_put to put usage_counter. However, pm_runtime_get_sync()
will increment usage_counter even it failed. Fix it by replacing it with
pm_runtime_resume_and_get() to keep usage counter balanced.

Fixes: 9c8edddfc992 ("irqchip/gic: Add platform driver for non-root GICs that require RPM")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124065150.22809-1-shangxiaojing@huawei.com
---
 drivers/irqchip/irq-gic-pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index b60e185..3989d16 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -102,7 +102,7 @@ static int gic_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		goto rpm_disable;
 
