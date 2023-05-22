Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909170C19A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjEVO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjEVO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:57:25 -0400
X-Greylist: delayed 2984 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 07:57:19 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694A133
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:57:18 -0700 (PDT)
X-ASG-Debug-ID: 1684764420-1cf43912154487a0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id sFbFNjxpWl4KZr3q; Mon, 22 May 2023 10:07:00 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=4E6O0lAp7AWjLeYBN4LPsbrcKqkqgWhw9cCQDP1+2Jg=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=Cf8Js0wNTqS4JiDyRot5
        UWCtaPLqG3Obt4CZ6gaKHSYqSKk0gjnX11/A+IyaYsnIc8EohHBizyr9XWGvfKwEBF2pAY7iD/ELj
        X9ZKhV3N7nSfIlDA/zGDu/elSNnWwRJPILVQ+3Vzs+kPtyzKG4KfuqyO75/whyOYq5q1uKQUw0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12632356; Mon, 22 May 2023 10:07:00 -0400
Message-ID: <3a2c6e29-15bc-c519-573c-c08e5c042868@cybernetics.com>
Date:   Mon, 22 May 2023 10:07:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v2 RESEND] x86/cpu: fix SME test in stop_this_cpu()
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v2 RESEND] x86/cpu: fix SME test in stop_this_cpu()
From:   Tony Battersby <tonyb@cybernetics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com> <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <90428c6d-97f6-794f-8cfd-5b30dd5ed140@cybernetics.com>
In-Reply-To: <90428c6d-97f6-794f-8cfd-5b30dd5ed140@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1684764420
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original thread title: "x86/cpu: fix intermittent lockup on poweroff"

I think we all agreed that my small patch below was correct.  tglx also
had an additional patch to fix the underlying race condition, but the
thread seems to have died out.  Can I get my patch applied at least?

Thanks,
Tony Battersby
Cybernetics

---

Check that the CPU supports the desired CPUID leaf before attempting to
read it.  On Intel, querying an invalid extended CPUID leaf returns the
values of the maximum basic CPUID leaf.  Depending on the CPU, this
could cause the SME test to incorrectly evaluate to true, causing
native_wbinvd() to be executed when it should have been skipped (seen on
a Supermicro X8DTH-6F board with Intel Xeon X5650).

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Cc: <stable@vger.kernel.org> # 5.18+
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Changes since v1: updated title and description.

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
-- 2.25.1

