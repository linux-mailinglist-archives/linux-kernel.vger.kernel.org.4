Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E4722865
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjFEOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjFEOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC2118;
        Mon,  5 Jun 2023 07:08:19 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbncYe5bJfQl9Kaut5W1J4D/EgNC3+gf86CUeN1lbFA=;
        b=sEX9RonhP2krlur3O4PmtZYJ/+fUbttNmpgkAGBNEUF3tjEM3NkSZ0Sz5pNAc7ObcmtHZh
        FL4cHIKufDMYyJHiLuu3Ttav9t7lSr2Z1ehuCM0PvglphTo4ZiJB4Vs4GWY3ctFhITviu8
        h2c/sWO/ckuxwPBky/DJTJ8VkFhxItLNQ8dZM6GjYKmopBZ/yoo1UjrE0kI6bdi0Wy9E2z
        BpW+SIZzUmEWqves6CsalzYMGzRg7/8+D6w9+tgD8K2lvmhMNAjWV7r+pkBpns6IDrQZbm
        qLeVKyXq3/eVFMAem845I/Xpfb2uJPmsMQcqqSbuWqzlAqdRAgJlXLb/R2C7mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbncYe5bJfQl9Kaut5W1J4D/EgNC3+gf86CUeN1lbFA=;
        b=mpa0RJe/5uUr/7CyxetWM6fdtv1GWZ4AWcwC7d/ZX2fQsGPfAv+BhsJJU7hwvD2CHbT8gJ
        VglakVU19Opqy2Cw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/hyperv: Set MTRR state when running as SEV-SNP
 Hyper-V guest
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-5-jgross@suse.com>
References: <20230502120931.20719-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409682.404.2522096676257055244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     c957f1f3c498bcce85c04e92e60afbae1fd10cde
Gitweb:        https://git.kernel.org/tip/c957f1f3c498bcce85c04e92e60afbae1fd10cde
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:19 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:32 +02:00

x86/hyperv: Set MTRR state when running as SEV-SNP Hyper-V guest

In order to avoid mappings using the UC- cache attribute, set the
MTRR state to use WB caching as the default.

This is needed in order to cope with the fact that PAT is enabled,
while MTRRs are not supported by the hypervisor.

Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-5-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/hyperv/ivm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cc92388..6f7c1b5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -17,6 +17,7 @@
 #include <asm/mem_encrypt.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/mtrr.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
@@ -372,6 +373,9 @@ void __init hv_vtom_init(void)
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
+
+	/* Set WB as the default cache mode. */
+	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
