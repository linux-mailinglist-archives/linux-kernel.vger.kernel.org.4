Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188A6EE8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjDYT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjDYT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:57:14 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 12:57:12 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25C19A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:57:12 -0700 (PDT)
X-ASG-Debug-ID: 1682450813-1cf4391215313690001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id UJmp3BejnK1cjIIr; Tue, 25 Apr 2023 15:26:53 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=NKoTw0X5ggn4GP4rCHMZBRbxnmfIguEqeaihKcA5REk=;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
        MIME-Version:Date:Message-ID; b=XjJvQNfRCimTBY0NYTJiqaV9m5jO6rqZsItwTv2jCDwOE
        avvzTgWVFYvLTXnDb4GXZREDk1+OzndudyR/3Q9FlskrpRtPaFaczQNSQ12HBhOF1DvPeBiMCO0zE
        njol8uefnZ/keDtObWbQu/fhnYfYYmZHFqIc9bRsxOj06gv4o=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12590162; Tue, 25 Apr 2023 15:26:53 -0400
Message-ID: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
Date:   Tue, 25 Apr 2023 15:26:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1682450813
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stop_this_cpu(), make sure the CPUID leaf exists before accessing the
leaf.  This fixes a lockup on poweroff 50% of the time due to the wrong
branch being taken randomly on some CPUs (seen on Supermicro X8DTH-6F
with Intel Xeon X5650).

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Cc: <stable@vger.kernel.org> # 5.18+
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

NOTE: I don't have any AMD CPUs to test, so I was unable to fully test
this patch.  Could someone with an AMD CPU that supports SME please test
this and make sure it calls native_wbinvd()?


 arch/x86/kernel/process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b650cde3f64d..26aa32e8f636 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -754,13 +754,15 @@ bool xen_set_default_idle(void)
 
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
+
 	local_irq_disable();
 	/*
 	 * Remove this CPU:
 	 */
 	set_cpu_online(smp_processor_id(), false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -774,7 +776,8 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f &&
+	    (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
 	for (;;) {
 		/*
-- 
2.25.1

