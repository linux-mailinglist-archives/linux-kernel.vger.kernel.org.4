Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7362DF51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiKQPLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiKQPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B64490A3;
        Thu, 17 Nov 2022 07:08:32 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIMxsWhit/bKrkNB4DwbGVSCH0N9PgJ8XEbGje/u/dA=;
        b=D148dV3YjkC6rpOPdrv83RI1qrun22QpeAHCXbOqu/LkOtfYUPxHg6XgQ5y7Gxl6mC8aRF
        6/YNzV5BHqtGoeWoj/1ktX2Y2cOgxL+OyT94WqACeu7By7RVlQbolAgU3L1eheqzHJZI3F
        N/nHA/bdw3UbgfVbuWRlPEWLiiwOGmnXv3NqL9IgjovG1mndIg3VM4Q+2K4AuBC7VJHKlC
        zi+EcgWLt3igZpKQI4oRlcq+zYjHH6WmUc4Pd7H3rfq16knJSftDUSqrecd20PW4X0g1K2
        rAmt7FfTIRZd7hnA7cQi099usEEi9GJtZkbnzNyNhKWhyp/vlCqFKM8JRxatIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIMxsWhit/bKrkNB4DwbGVSCH0N9PgJ8XEbGje/u/dA=;
        b=bFb+45K3VZDwbuRv6JdF4Zld79QojZhe424EPnt4dkRC1SrNBZQPlSFZ8aFanY0U5VTHd3
        vobl5LWFeQxw1+BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Use MSI_DESC_ALL in msi_add_simple_msi_descs()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.831151822@linutronix.de>
References: <20221111122013.831151822@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770955.4906.17167965142739919126.tip-bot2@tip-bot2>
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

Commit-ID:     befd780253e774ea9388dd8dfad7c627a0aa7e02
Gitweb:        https://git.kernel.org/tip/befd780253e774ea9388dd8dfad7c627a0aa7e02
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

genirq/msi: Use MSI_DESC_ALL in msi_add_simple_msi_descs()

There are no associated MSI descriptors in the requested range when the MSI
descriptor allocation fails. Use MSI_DESC_ALL as the filter which prepares
the next step to get rid of the filter for freeing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122013.831151822@linutronix.de

---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a9ee535..bba6359 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,7 +120,7 @@ static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsi
 fail_mem:
 	ret = -ENOMEM;
 fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, last);
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, index, last);
 	return ret;
 }
 
