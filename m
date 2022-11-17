Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577BF62DF53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiKQPLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiKQPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:10:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2549096;
        Thu, 17 Nov 2022 07:08:35 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DCbvnZREnzUo5fScMcpxybop5Pr0Jy09VR2REXWdbc=;
        b=U4XzJlJIL65+kjKWGCcPixK7NgrFc0oGJ7CfUVPrcU1g9Im2Kn5IBBAR2H2wSvq6NgcIdu
        bYfvBaY/4X6kLBmTqX9R3Rg8qqSVKPerKU9QGz74mFPhirT4ePzbowKp+2Ksv/H1zqnIci
        xYmzWQU4ok3e5KdQzsXW+EF/AnFvOHRN3nXlADjX/FAFeKPeQrXtwOWheOuIVuidSqGP8s
        +5+tfLKahOpEpz/INmy6RIFdss8q+bnsaNa8k7ZT+eEHWwDGgyPlbdlYnIw2snT2D0/zPd
        8kSXD5u97AxjA8GKQZrTg07ABaHDyO/m21fWBnFXSeDL64E7EISEs2NZbHsAlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DCbvnZREnzUo5fScMcpxybop5Pr0Jy09VR2REXWdbc=;
        b=bHeBn8aShG3UR6zp42vSuQbGpSe49fXxY/wmUFHu6p45KekABUlBKd24bC9rc8wLKxfHqW
        BqspOES0kLnwstCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Check for MSI enabled in __pci_msix_enable()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.653556720@linutronix.de>
References: <20221111122013.653556720@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869771276.4906.11341244525719942741.tip-bot2@tip-bot2>
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

Commit-ID:     fe97f59a78fefda6c4a8c8ee6a070b1f769fc801
Gitweb:        https://git.kernel.org/tip/fe97f59a78fefda6c4a8c8ee6a070b1f769fc801
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

PCI/MSI: Check for MSI enabled in __pci_msix_enable()

PCI/MSI and PCI/MSI-X are mutually exclusive, but the MSI-X enable code
lacks a check for already enabled MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122013.653556720@linutronix.de

---
 drivers/pci/msi/msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fdd2ec0..160af9f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -935,6 +935,11 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (dev->msi_enabled) {
+		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
+		return -EINVAL;
+	}
+
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
