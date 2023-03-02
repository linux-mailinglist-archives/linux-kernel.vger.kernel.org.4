Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F896A8982
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCBTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCBTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:34:51 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F4D1B542
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:34:51 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6EF0920B9C3D;
        Thu,  2 Mar 2023 11:34:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EF0920B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677785690;
        bh=6Tvtuiro6Rs44YifCyzt6GKgNmrargfr4Wcp7VYJ/Rw=;
        h=From:To:Subject:Date:From;
        b=dm4J+fjRRLotjP7dvmezTypnoJLOxIvEVLDJq9AoVZ+cNBO4FhmFp5ZYrBi6hLEys
         zDH8HgC0bm+0LgUJM6YwI+LMSbVvz5BQKwDQkS9RlImGnLjzmew1WcLDmTR/Pld7Dx
         RV65/T76wxnm/wVu3o4K+QTTPmrAJlVq8fzIQ3s0=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ioapic: Don't return 0 as valid virq
Date:   Thu,  2 Mar 2023 11:34:46 -0800
Message-Id: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero is invalid virq and should't be returned as a valid value for
lower irq bound. If IO-APIC and gsi_top are not initialized return
the 'from' value as virq.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/kernel/apic/io_apic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a868b76cd3d4..000cc6159b8b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2483,9 +2483,11 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
+	 *
+	 * Incase gsi_top is also not initialized return @from.
 	 */
 	if (!ioapic_initialized)
-		return gsi_top;
+		return gsi_top ? : from;
 	/*
 	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
 	 * updated. So simply return @from if ioapic_dynirq_base == 0.
-- 
2.34.1

