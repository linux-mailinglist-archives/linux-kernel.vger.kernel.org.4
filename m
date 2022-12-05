Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA79D64371C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiLEVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiLEVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8833825EBC;
        Mon,  5 Dec 2022 13:41:49 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMuezAP66rqkzuy2yUbyb2sa7AAjakuRuAw9B0xk+f8=;
        b=LagEQROHbBmPOhQQxiSnilsgweGrohP+zUdTsos4GHPbm+qUgznTewPQ1jmphu9OFHhHJD
        Le92uXHUu+dDMZWytA9DN6El7MClwsxl4guZKkyDxqimwd2rnPH2WyD0FGWRyfSQAaDb3X
        06cRsqydv9YjK5KqnBLJZrU+rQaVM3Ad/AVXN/faWhrDzZmO2zuskUu3K95x5Ax4XtNxfX
        ahMp3smKyRVcKyEmmK7kzdYiQG18p04DJl4fjLCdHxXrzEbUm6IEqwsToMZ6OMTIbSwHhT
        51D5nmYfNacX0QT5LrzVfMUR9UkNjfZSe0F/j9XnxIY5VPP+xoqJcLikH3MrXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMuezAP66rqkzuy2yUbyb2sa7AAjakuRuAw9B0xk+f8=;
        b=hRRhly/vPecrvLbCNQexOW0fzXebrsVHtFZNInL7k3jvwfwO+AWZ4Qp5kPmr7uV+6YIBiI
        aSV24vF5dVI7sPBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/msi: Enable PCI/IMS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232327.022658817@linutronix.de>
References: <20221124232327.022658817@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650685.4906.17177063208727382656.tip-bot2@tip-bot2>
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

Commit-ID:     6e24c887732901140f4e82ba2315c2e15f06f1d6
Gitweb:        https://git.kernel.org/tip/6e24c887732901140f4e82ba2315c2e15f06f1d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:35 +01:00

x86/apic/msi: Enable PCI/IMS

Enable IMS in the domain init and allocation mapping code, but do not
enable it on the vector domain as discussed in various threads on LKML.

The interrupt remap domains can expand this setting like they do with
PCI multi MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232327.022658817@linutronix.de

---
 arch/x86/kernel/apic/msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 682f51a..35d5b8f 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -184,6 +184,7 @@ static int x86_msi_prepare(struct irq_domain *domain, struct device *dev,
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		return 0;
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 		return 0;
 	default:
@@ -230,6 +231,10 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	case DOMAIN_BUS_PCI_DEVICE_MSI:
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 		break;
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
+		if (!(pops->supported_flags & MSI_FLAG_PCI_IMS))
+			return false;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
