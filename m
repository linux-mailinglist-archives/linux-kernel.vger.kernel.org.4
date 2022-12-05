Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239AD64371A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiLEVm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiLEVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E92CDDC;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCizSNtz3J6srFQykIaE2yQnJ3kHOqzfzAO7gQwglzw=;
        b=fb7bsZLDs+6uz75c4FD+q+QEOUa6GuEk71WlkNkN8gRZeeavRysJfEtyzOXgbeYqPYYRk0
        fTFv2HEhDt2qTfb26qVF7E2COmqflnx3QFdoxQJT3+noGtRiCxc9J2TsNnBmknlmz2ltUb
        cQBXUE5oIim3KvHRdpCYdWHZVGuUhoruWi/9eR9+8myxO0z+IGF4tVlOBBBqIH/u2VPQ8J
        /hAW/vuVBAnaXzkgVDlmLw+YF+um9MYvz4PU2BSdA7//96gLJnLFn2PgO9/7q41vpiQAjU
        CG5aaymeq4fFlwyHLsNMZQTcmDKYautmkjbEClPgw/kWRwtSrmuA4IzRlFxmgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCizSNtz3J6srFQykIaE2yQnJ3kHOqzfzAO7gQwglzw=;
        b=fHt4r5J2T1HP+T8HTrDX96GnrSd0klG2kVQn1LhdacbYBfUI7cEuWXXDpcHjERxcYuTKx/
        QDWtK90f6pl1jVCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.558843119@linutronix.de>
References: <20221124232326.558843119@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650791.4906.1632858344427835014.tip-bot2@tip-bot2>
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

Commit-ID:     b834e3c08fc6c4460c2bce6575cba4705f6301e3
Gitweb:        https://git.kernel.org/tip/b834e3c08fc6c4460c2bce6575cba4705f6301e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:34 +01:00

genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN

Provide a new MSI feature flag in preparation for dynamic MSIX allocation
after the initial MSI-X enable has been done.

This needs to be an explicit MSI interrupt domain feature because quite
some implementations (both interrupt domains and legacy allocation mode)
have clear expectations that the allocation code is only invoked when MSI-X
is about to be enabled. They either talk to hypervisors or do some other
work and are not prepared to be invoked on an already MSI-X enabled device.

This is also explicit MSI-X only because rewriting the size of the MSI
entries is only possible when disabling MSI which in turn might cause lost
interrupts on the device.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.558843119@linutronix.de

---
 include/linux/msi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 00c5019..3cb1586 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -557,7 +557,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 18),
 	/* MSI-X entries must be contiguous */
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
-
+	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
+	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 };
 
 /**
