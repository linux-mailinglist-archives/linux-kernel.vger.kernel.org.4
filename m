Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1196B6B68
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjCLUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:47:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C12D4D;
        Sun, 12 Mar 2023 13:47:38 -0700 (PDT)
Date:   Sun, 12 Mar 2023 20:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678654056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmDYs33+VDMIv1F2Mo+7be4m4EhaoKcu+WQiAIsIjEQ=;
        b=SdCOnOhqbgIqbng3JzNS3oilYUS3u+szQG3od6asYq3RLQGdPIxJqzqDyL1Uz1vuB6GTwN
        PebQnfLISjOcSUjyZ9sS6biohn2+Sbq/ycWkchwEMU4UPIVGSyoP7W4WZJYm8/NDtwnD1j
        dDwqgTlEj8Oac+xEgSCSfySXrGRu/X0ndwkX1gDu0c7AuWxm5ohFntt9F5+xiWLxJnHbEs
        A9ChplF6n9HIoAca+li9WRjBmLsEaCFffyL6yCJd6P4OGQwkE4ElnLOvZeztmJwN/XJr+b
        vMzdCYUDpxpz89weR5mtrcdJ1Rt+dc1UA+HNA4sraa88HZLGrn9xD0SvKkXFNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678654056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmDYs33+VDMIv1F2Mo+7be4m4EhaoKcu+WQiAIsIjEQ=;
        b=7NwMpEXknhVoKmKYkmBpgAdbPe36ronJY1PGWneUq9aKO43ZTu/zcMrpEIdlSAbul1h589
        7zSxbL2BlA3qmxBg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Do not taint when late loading on AMD
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230303114649.18552-1-bp@alien8.de>
References: <20230303114649.18552-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167865405614.5837.13144930108431641081.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     09b951476df9eadf15f2acba7568fa35e4b2313b
Gitweb:        https://git.kernel.org/tip/09b951476df9eadf15f2acba7568fa35e4b2313b
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Mar 2023 12:46:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 12 Mar 2023 21:32:51 +01:00

x86/microcode: Do not taint when late loading on AMD

Describe why the concurrency issues which late loading poses are not
affecting AMD hardware, after discussing it with hw folks. Thus, do not
taint when late loading on it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230303114649.18552-1-bp@alien8.de
---
 Documentation/x86/microcode.rst      | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index b627c6f..15b52e2 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -208,6 +208,16 @@ Basically there is no way to declare a new microcode update suitable
 for late-loading. This is another one of the problems that caused late
 loading to be not enabled by default.
 
+AMD
+---
+
+Late loading on AMD does not have the concurrency issues described
+above: when loading is attempted on T0, the T1 is quiesced and does not
+execute instructions. Therefore, even if a higher priority interrupt or
+a fault happens, the whole core will see it either before the microcode
+patch has been applied or after. In either case, T0 and T1 will have the
+same microcode revision and nothing intermediate.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e5..779f705 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -498,7 +498,8 @@ put:
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 
 	return ret;
 }
