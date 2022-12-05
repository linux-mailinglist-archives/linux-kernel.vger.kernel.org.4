Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A01643024
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiLES1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D0720F4A;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WM8EONqxHEtDCDP/wm7zqqT1HHSVasmF5/3zb4tuqgg=;
        b=uImeh7S7NUE0PTs4Aa+TkjcmrHwg4hwwGECVZSk9kbXZky7BqjTixN0ObmJ5rcaifFMnNk
        fXHEcCzh5CXHVrb3dQnd/jbEYpxVQcnpoVmO4wJ4r1/uBiAYvYbaKxVHShpnkZ7ChkdQqL
        L/N3SIWDEWWx/6M8XnZiAdBplhqdA0CHjMGsFVPCg4S36nq4+2UkNYfv+/d420GgEJoQ9t
        Thj/DnbTz6eiMI4og2rIOLw+D/NHJ8OMir2pdzPXNZMzkmBoVLoFbdYexPywtoqNYK5jah
        0pMfJygPSMAy0AkKKdPnc6qmbnamtTiX3PnJvkiQgwqRD2sM//c+7W7KztNRGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WM8EONqxHEtDCDP/wm7zqqT1HHSVasmF5/3zb4tuqgg=;
        b=KEUDvDH9OT0UxgMTGYRoBfcEkmMwW9BqjSg065NO7GiMhhobnWzVtKUKqjGWVq58pd56N+
        ukeev37gLxMrilDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Add irq_domain:: Dev for per device
 MSI domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.618807601@linutronix.de>
References: <20221124232325.618807601@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471595.4906.7972815409340483633.tip-bot2@tip-bot2>
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

Commit-ID:     4443664f298d1a2cba25a2e48d53b78f4138209b
Gitweb:        https://git.kernel.org/tip/4443664f298d1a2cba25a2e48d53b78f4138209b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/irqdomain: Add irq_domain:: Dev for per device MSI domains

Per device domains require the device pointer of the device which
instantiated the domain for some purposes. Add the pointer to struct
irq_domain. It will be used in the next step which provides the
infrastructure to create per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.618807601@linutronix.de

---
 include/linux/irqdomain.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a668cc0..a372086 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -132,6 +132,9 @@ struct irq_domain_chip_generic;
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
+ * @dev:	Pointer to the device which instantiated the irqdomain
+ *		With per device irq domains this is not necessarily the same
+ *		as @pm_dev.
  * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
@@ -155,6 +158,7 @@ struct irq_domain {
 	struct fwnode_handle		*fwnode;
 	enum irq_domain_bus_token	bus_token;
 	struct irq_domain_chip_generic	*gc;
+	struct device			*dev;
 	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
