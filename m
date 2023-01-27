Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C467ED85
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjA0S2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjA0S2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:28:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29E8660D;
        Fri, 27 Jan 2023 10:27:28 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K6jhIAiVGc51DkalpSpWKncAbZs2uGtkxWDUHxqyi58=;
        b=Fdy72VxklwHP60cD9VIHCWmoRzK7vIlE3E2oJXwBTD4GkV8RNpNRxTzZu5vsvNeWq88w7b
        mSRw9+vUUypkXN3rSqlo9HOg/Zn4sJLi04rs4P8qc/xbUkR3niukfzRVcs5YNpKlQYiXbQ
        AE9eJXi0MszFLsf3+9apEmed+wRMBxEnWvqo9CsJnNnYuTgcIPHefMuOS8XyR0e26F17+9
        tWL6xem0BnWh7SYy4yXpn2weHTIaPSnKxmqiRtz0HFbQziOMZsBWctXZ8mfIXKobbC4EpP
        l2K8eWyerG8sk6VkaMpc68NLjaxKpCleVCc4PsbkePyE0J7p85lLSlkCC7cM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K6jhIAiVGc51DkalpSpWKncAbZs2uGtkxWDUHxqyi58=;
        b=2eHuJm2zdOEjwPS6jibRTCdzkWJKklTdUky9PKmmKt3Wi5i6wQtKxQIB/eGfJ+vWadDD7C
        9gLpxxlmrD6pr1Cw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Disable NOTIFY_ENABLES
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401546.4906.1415806415892666642.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     8de62af018cc9262649d7688f7eb1409b2d8f594
Gitweb:        https://git.kernel.org/tip/8de62af018cc9262649d7688f7eb1409b2d8f594
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:59 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:46:05 -08:00

x86/tdx: Disable NOTIFY_ENABLES

== Background ==

There is a class of side-channel attacks against SGX enclaves called
"SGX Step"[1]. These attacks create lots of exceptions inside of
enclaves. Basically, run an in-enclave instruction, cause an exception.
Over and over.

There is a concern that a VMM could attack a TDX guest in the same way
by causing lots of #VE's. The TDX architecture includes new
countermeasures for these attacks. It basically counts the number of
exceptions and can send another *special* exception once the number of
VMM-induced #VE's hits a critical threshold[2].

== Problem ==

But, these special exceptions are independent of any action that the
guest takes. They can occur anywhere that the guest executes. This
includes sensitive areas like the entry code. The (non-paranoid) #VE
handler is incapable of handling exceptions in these areas.

== Solution ==

Fortunately, the special exceptions can be disabled by the guest via
write to NOTIFY_ENABLES TDCS field. NOTIFY_ENABLES is disabled by
default, but might be enabled by a bootloader, firmware or an earlier
kernel before the current kernel runs.

Disable NOTIFY_ENABLES feature explicitly and unconditionally. Any
NOTIFY_ENABLES-based #VE's that occur before this point will end up
in the early #VE exception handler and die due to unexpected exit
reason.

[1] https://github.com/jovanbulck/sgx-step
[2] https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html#safety-against-ve-in-kernel-code

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-8-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c4a1299..b593009 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -19,6 +19,10 @@
 #define TDX_GET_VEINFO			3
 #define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
+#define TDX_WR				8
+
+/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+#define TDCS_NOTIFY_ENABLES		0x9100000000000010
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
@@ -863,6 +867,9 @@ void __init tdx_early_init(void)
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
 	 * as flag, not as part of physical address.
