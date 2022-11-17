Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37AF62DF07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbiKQPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiKQPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:07:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A159876;
        Thu, 17 Nov 2022 07:07:56 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+p/3EF3ZPOVV5DsExwKrDuDyfRU/SzuktZL9Elkis0=;
        b=16v9QNJDOUHSl3FcAA0be2i4TRLW8uCJSvfpgOG4LNkll5wq76egyG/f0hZONc5zDsYjMM
        ZFHbdwy7bq6Y+GgbYy47pNoCw860QjIE7AtUgk5h8oVEwhQ0zfpg95wJx0gobpvrw798Y+
        iiMu2sl3DgCqIDRS5K9BUG3sPpICuF6Dl5oocIqIDNsK226uBJ98kEUUcplWPKCqkH1IXX
        rxrJDf8AG3vy3Tr2KZ0zXcZJUdeNEBrR4o1VY1RMHjNQxMOsfXImV1x6tSh5v4r1uLbddK
        f4KPlgAllKb++UjxNMm73fEjKENa8tmdbUoWZ66tSDTm0haIIItgqrN5Fyy7Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+p/3EF3ZPOVV5DsExwKrDuDyfRU/SzuktZL9Elkis0=;
        b=507iZZGOiQXlBE0wPou0HSprRM0m0l1BB3ehyiFxLVt1VuJPuoTRVKobMIQokEYW4jICVg
        uesZv1gfeKN8J8Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Validate MSI-X contiguous restriction early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.691357406@linutronix.de>
References: <20221111122015.691357406@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767404.4906.3594475439584777347.tip-bot2@tip-bot2>
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

Commit-ID:     4644d22eb673f173252610a93aaaba4c2bff7b41
Gitweb:        https://git.kernel.org/tip/4644d22eb673f173252610a93aaaba4c2bff7b41
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

PCI/MSI: Validate MSI-X contiguous restriction early

With interrupt domains the sanity check for MSI-X vector validation can be
done _before_ any allocation happens. The sanity check only applies to the
allocation functions which have an 'entries' array argument. The entries
array is filled by the caller with the requested MSI-X indices. Some drivers
have gaps in the index space which is not supported on all architectures.

The PCI/MSI irq domain has a 'feature' bit to enforce this validation late
during the allocation phase.

Just do it right away before doing any other work along with the other
sanity checks on that array.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.691357406@linutronix.de

---
 drivers/pci/msi/msi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 0740acd..b94f6da 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -725,13 +725,17 @@ out_disable:
 	return ret;
 }
 
-static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
+				      int nvec, int hwsize)
 {
+	bool nogap;
 	int i, j;
 
 	if (!entries)
 		return true;
 
+	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
+
 	for (i = 0; i < nvec; i++) {
 		/* Entry within hardware limit? */
 		if (entries[i].entry >= hwsize)
@@ -742,6 +746,9 @@ static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int 
 			if (entries[i].entry == entries[j].entry)
 				return false;
 		}
+		/* Check for unsupported gaps */
+		if (nogap && entries[i].entry != i)
+			return false;
 	}
 	return true;
 }
@@ -773,7 +780,7 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 	if (hwsize < 0)
 		return hwsize;
 
-	if (!pci_msix_validate_entries(entries, nvec, hwsize))
+	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
 		return -EINVAL;
 
 	/* PCI_IRQ_VIRTUAL is a horrible hack! */
