Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66A643727
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiLEVnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiLEVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCA2CDDD;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoOu6qLojYFUZbCcsdiLeS1LpsKLhL+iTJw++hZkR+Y=;
        b=Zh4BKbQOlsFtoHRfzazIxMbPnMG2qehssEInaEhbSoT4whuw6Gdtopq83SFb9SLqGpgQvc
        dPGoUY+P/Im8eHskUE3+SK0qopJZiVhIn9fM1B52A75X8Dpcnd5nldkDm2l45ej5PUZ7JD
        tEB4SZG0wFDuibG+pSTTqmauV8y5HEmdsrCIZrCCKiqy7inoiCpP5vLi/ppNdwtYUILeNf
        ugzJIEhYgz0af0F9I4JLsuQL5KB508Qrn0OMTKjV2mPGjT3Z5/7UY+HnZYj/i27U0a9fz0
        vnfsCCARDd7M2x57h5yfsAPPNRF5dM7DvZrZkebuudZSti78gVg9p7Vv/X1++g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoOu6qLojYFUZbCcsdiLeS1LpsKLhL+iTJw++hZkR+Y=;
        b=Yu0W54ywy5hDZnG0TyF2DanMpUu7m7r/Gk5L/2roMfPymDt+ygKkZw9aMr4rKYzvYy+B3B
        sfffmirbZne+/hCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide struct msi_map
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.326410494@linutronix.de>
References: <20221124232326.326410494@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650855.4906.16905481322264960950.tip-bot2@tip-bot2>
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

Commit-ID:     06bff9e347271566e8dd79e7c3eb971660209a00
Gitweb:        https://git.kernel.org/tip/06bff9e347271566e8dd79e7c3eb971660209a00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

genirq/msi: Provide struct msi_map

A simple struct to hold a MSI index / Linux interrupt number pair. It will
be returned from the dynamic vector allocation function and handed back to
the corresponding free() function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.326410494@linutronix.de

---
 include/linux/msi_api.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 8640171..4cb7f4c 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -18,6 +18,19 @@ enum msi_domain_ids {
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
+/**
+ * msi_map - Mapping between MSI index and Linux interrupt number
+ * @index:	The MSI index, e.g. slot in the MSI-X table or
+ *		a software managed index if >= 0. If negative
+ *		the allocation function failed and it contains
+ *		the error code.
+ * @virq:	The associated Linux interrupt number
+ */
+struct msi_map {
+	int	index;
+	int	virq;
+};
+
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
 
 /**
