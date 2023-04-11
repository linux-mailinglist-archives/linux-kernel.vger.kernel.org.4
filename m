Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2E6DDB26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDKMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDKMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:48:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5E3596;
        Tue, 11 Apr 2023 05:48:38 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DB711EC0102;
        Tue, 11 Apr 2023 14:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681217317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2AX/Yk1SUY0S02ZvQVZW8ykeMgzMpqSJymlGaALSeJg=;
        b=dDuNxWii94DD61uuwWojjkDopP+gurSLtAONy3q2JEf3VAz+X2bREGTQH9y38vnp7+PTQf
        /B+1FbXWAdtQyGOHu0+XCEOOBRDtlIqnQF6kP6ZlIGzqwL874k1+r+Fk/6yIetEq6Ssv3Y
        SHiLi7Uk1H/7ohbu6Mwk5WVnfuWehlk=
Date:   Tue, 11 Apr 2023 14:48:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/microcode] x86/microcode: Do not taint when late
 loading on AMD
Message-ID: <20230411124832.GAZDVXIFR3BiExtXba@fat_crate.local>
References: <20230303114649.18552-1-bp@alien8.de>
 <167865405614.5837.13144930108431641081.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167865405614.5837.13144930108431641081.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 08:47:36PM -0000, tip-bot2 for Borislav Petkov (AMD) wrote:
> The following commit has been merged into the x86/microcode branch of tip:
> 
> Commit-ID:     09b951476df9eadf15f2acba7568fa35e4b2313b
> Gitweb:        https://git.kernel.org/tip/09b951476df9eadf15f2acba7568fa35e4b2313b
> Author:        Borislav Petkov (AMD) <bp@alien8.de>
> AuthorDate:    Fri, 03 Mar 2023 12:46:49 +01:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Sun, 12 Mar 2023 21:32:51 +01:00
> 
> x86/microcode: Do not taint when late loading on AMD
> 
> Describe why the concurrency issues which late loading poses are not
> affecting AMD hardware, after discussing it with hw folks. Thus, do not
> taint when late loading on it.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230303114649.18552-1-bp@alien8.de

Forgot to adjust the error message too. Updated patch coming up.

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 779f70547fb7..22cf57c899b6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -440,9 +440,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -498,8 +495,11 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("Late microcode loading is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading if possible.\n");
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 
 	return ret;
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
