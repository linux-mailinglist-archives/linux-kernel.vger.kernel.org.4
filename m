Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEE643046
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiLES1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6720BE8;
        Mon,  5 Dec 2022 10:25:19 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4TmGrr6CqhWXhuVum4g3dKhcRpAc3swOSW11IndD9w=;
        b=nsENywLdenZpIIBqQPqpPxX6Ytw7FDCni4TStFqcJZtyNyyVjg4elopXSfnn4QEy+3D9YB
        4WhuNycxVoLGUYivl4IlCDprKk2Ruho0YStL/u1IaddTmee+SgVyzV+EJrw/tEm+PmjvIz
        5qFzYLeaFpFaLm9hcdaXVrfBR3p2VhkARKQaZeuqORvNnU2+ygIl0npxgj9tls3cOhS87P
        QJvyv5Ysaosi9px5bzTc62mxNgnPOeyp6qzxo3wTr9DrQ8iFXUbRKXC4m8r1U2DH8tm+ed
        3GozSUjFTNZ1L0IUjHm3WkjvSjk83thX6t3Y9vc4M6NdCWV8dTggsFby3BPCwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4TmGrr6CqhWXhuVum4g3dKhcRpAc3swOSW11IndD9w=;
        b=8A+Za5ELO2b5OS8ISPl81XN65cJvd6CBgq8rPvxOYmJROnnZbnuVX3A0PrEbhOwB/vnxJ5
        lbG+rvKS7HNUZeDw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] platform-msi: Switch to the domain id aware MSI interfaces
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.513924920@linutronix.de>
References: <20221124230314.513924920@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471810.4906.10493249948096555909.tip-bot2@tip-bot2>
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

Commit-ID:     b330ff9f0b03d6107ee941240ef63cc95374ff3d
Gitweb:        https://git.kernel.org/tip/b330ff9f0b03d6107ee941240ef63cc95374ff3d
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

platform-msi: Switch to the domain id aware MSI interfaces

Switch to the new domain id aware interfaces to phase out the previous
ones. No functional change.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.513924920@linutronix.de

---
 drivers/base/platform-msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index dddafa1..5883e76 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -213,7 +213,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		return err;
 
-	err = msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
+	err = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
 	if (err)
 		platform_msi_free_priv_data(dev);
 
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	msi_domain_free_irqs(dev->msi.domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
