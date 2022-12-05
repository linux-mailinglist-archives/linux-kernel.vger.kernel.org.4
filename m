Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C074E643714
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiLEVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLEVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090CA27DE2;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZETIdDmjfYeCy0D3lsONaap4DkGkoDJ9L7K3FVnWKA=;
        b=Ix6zovcmxiAi3jxnVFYmtLdH5vz6mwZUmDlpi/sFVmqhnqrqn9FjwBvgjvm1rSiJ4YQi22
        4m7W22/Tthk4YETRRoEcnO4rW+5an/DPzbX0APiabL6gDBVk6pnE0cZ1461Y3MlOX16vIR
        CnV3xL5REJLObw6NHyAg6XZJoPIWYL0KmfheKG/KlkOph+Y+cCR8xWNaPR/D9gvZRczoK1
        e2eUeFBGDTv3SIosj28iLs/hpp1fy+TApeV/OLHprqO5ZLeGXDLGdGD1cnjB+jc50NuR/A
        ePMy2VIO1fw/M+9IoF3HJDjvqdrAiBBBEy/Hr7LjPvDA/TNIqvnIUgDfFBKwmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZETIdDmjfYeCy0D3lsONaap4DkGkoDJ9L7K3FVnWKA=;
        b=OBe3Fv3HX1BQ4NRfCwkcJKlJTrr9Y6mfoS4Lln/byaPZuFpRDLcFtmqBx2xk0Q7l+4V7pS
        bbdT4zPALFAi1YCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide constants for PCI/IMS support
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.846169830@linutronix.de>
References: <20221124232326.846169830@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650717.4906.6017670287416779656.tip-bot2@tip-bot2>
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

Commit-ID:     e23d4192bf9b612bce5b24f22719fd3cc6edaa69
Gitweb:        https://git.kernel.org/tip/e23d4192bf9b612bce5b24f22719fd3cc6edaa69
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:34 +01:00

genirq/msi: Provide constants for PCI/IMS support

Provide the necessary constants for PCI/IMS support:

  - A new bus token for MSI irqdomain identification
  - A MSI feature flag for the MSI irqdomains to signal support
  - A secondary domain id

The latter expands the device internal domain pointer storage array from 1
to 2 entries. That extra pointer is mostly unused today, but the
alternative solutions would not be free either and would introduce more
complexity all over the place. Trade the 8bytes for simplicity.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.846169830@linutronix.de

---
 include/linux/irqdomain_defs.h | 1 +
 include/linux/msi.h            | 2 ++
 include/linux/msi_api.h        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 0b2d8a8..c29921f 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -25,6 +25,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
+	DOMAIN_BUS_PCI_DEVICE_IMS,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 3cb1586..a112b91 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -559,6 +559,8 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
+	/* Support for PCI/IMS */
+	MSI_FLAG_PCI_IMS		= (1 << 21),
 };
 
 /**
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 5ae72d1..391087a 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -15,6 +15,7 @@ struct device;
  */
 enum msi_domain_ids {
 	MSI_DEFAULT_DOMAIN,
+	MSI_SECONDARY_DOMAIN,
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
