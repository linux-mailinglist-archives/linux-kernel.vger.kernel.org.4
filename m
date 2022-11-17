Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACC862DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiKQPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiKQPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:07:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C814E74AA4;
        Thu, 17 Nov 2022 07:07:57 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqSrWor0W3gt7s1Oft9gM5a9a3arhJ6cJus3p2ui2qI=;
        b=SkpTF0wJhT3WzN7CQiW/AndPqPQxGMStYzurk/jwu44MtE0Ak986n9lGmfkNx7zuy9motk
        eWGIkhmYmuWZ6DiM6+eGn2KxBCelaZy9GUJ38sbaLQ4LRJJKjdyc6ge1XJvm6ewFVZfF2/
        VFI9mCPasrQ0hJoH4xoQ6LzRvIKL5pOpc3t+5Zf8ZcjTEqg8K3T8W/AvFFR1Z8ENTq+TA0
        lQ8DxoXTEpN5XPr6ushEer9clkQhL7wYJRWgWm6yWD/x2s6HP+Sdp49ToBaEpXyEImKzcO
        5Rmj1Xe7JtutC1BBYaOyipwa/FY4lQWtj9er7j0bCcnQpYZX3iYozulPliBu2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqSrWor0W3gt7s1Oft9gM5a9a3arhJ6cJus3p2ui2qI=;
        b=v2tP2c+yKFFBoZHxB4tTlOU76e4i6RnbArV8LRKeR8na/IyWBstTo2ERiexFijTdGdqvWt
        PAV7YJYNm8G7pIAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Reject MSI-X early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.631728309@linutronix.de>
References: <20221111122015.631728309@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767519.4906.15352965310185673367.tip-bot2@tip-bot2>
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

Commit-ID:     99f3d279765725920aa5924fa445537a20129a6f
Gitweb:        https://git.kernel.org/tip/99f3d279765725920aa5924fa445537a20129a6f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

PCI/MSI: Reject MSI-X early

Similar to PCI multi-MSI reject MSI-X enablement when a irq domain is
attached to the device which does not support MSI-X.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.631728309@linutronix.de

---
 drivers/pci/msi/msi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index bc84647..0740acd 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -762,6 +762,10 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
+	/* Check MSI-X early on irq domain enabled architectures */
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY))
+		return -ENOTSUPP;
+
 	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
