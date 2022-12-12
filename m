Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25A64A74D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiLLShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiLLSh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:37:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D212AFD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q93-20020a17090a1b6600b0021311ab9082so364295pjq.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+njGW4VjenMTQbJUIuskcZhM7dDdCQXICJE3uEmTc98=;
        b=ZQ9u9x0jc+g6g3SLO/fDBuNnJLbyN8v5Mp4f9IqdWtSZYz3Oe8f/FTKp97SJBnZITU
         dspnGUAZFMMqDM0mPUPfWxExkLUru43PkNik6taHARntQDAtf+hiNPKOYn1sojBxrvt8
         laDXCBRbfO2vqge8JNDgZEJErg2ix1RCQUvmlVCbOZgnIH48kO6K8nBbqfp6c2H+0lB9
         cN6+V4Edi+CZutedirUU7HemunrZWSy4D+4LBZTi4MpXq5CgEc1u4t/3qcI0hZplrkkl
         vdiLp1qBn2tPZNwOBySx9BH3Ye8jaQTBK7fxuaNhMT7nowS6MCCTRCwA922gFO84Q4Y7
         bknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+njGW4VjenMTQbJUIuskcZhM7dDdCQXICJE3uEmTc98=;
        b=Gbuh40vS5YZ+W+PqVdF9CEjqZE6YVEtvalEw/RGXBaMrVbySAYbFtifx3NWIE9k9Bf
         H6l7ISUTBOZmsjK77q2LFhSFuW19yiC8i5+dIrPCiwPolxYCiEFRZAYyRggzTZaCmkko
         1JauaDJcZcXg7IceiyUFDAcbXRwHKUEW/CAuKmHTssZq1bGrPLfJch9v/1wbOe3oDdVH
         3WNuMjxpanjyBn3EN5fEs8Nm9AT6FuZOrWDA1OEruZ4IuSmr3TgCsefgPgztPdyly25k
         d44OG2NDNwV5chUTZy4m7PuDKItok2L+1TMbBAEyp3TjNF+ypXYCw0ha4Jcnx+lgIn0M
         1znQ==
X-Gm-Message-State: ANoB5pkN/WhmK4VVptP02lNJPwuDBPY8QQzCj42l5oiY4jDOV3aTPBZt
        Cw4CvsAdzwWOGwEPU1SrQWiCRN1oG2Pd
X-Google-Smtp-Source: AA0mqf5KMkc5/651W+5Uzzagtvk/Z1Zi+Z5SO9fqVmCF1GEn68XFI1Bq4ItaaOGSW2cUNLhAMdZrF8Ndntt8
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:bd92:b0:219:861b:b108 with SMTP id
 z18-20020a17090abd9200b00219861bb108mr541pjr.121.1670870244693; Mon, 12 Dec
 2022 10:37:24 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:37:08 -0800
In-Reply-To: <20221212183720.4062037-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221212183720.4062037-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212183720.4062037-2-vipinsh@google.com>
Subject: [Patch v4 01/13] x86/hyperv: Add HV_EXPOSE_INVARIANT_TSC define
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Avoid open coding BIT(0) of HV_X64_MSR_TSC_INVARIANT_CONTROL by adding
a dedicated define. While there's only one user at this moment, the
upcoming KVM implementation of Hyper-V Invariant TSC feature will need
to use it as well.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e3efaf6e6b62..617332dd64ac 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -255,6 +255,9 @@ enum hv_isolation_type {
 /* TSC invariant control */
 #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
 
+/* HV_X64_MSR_TSC_INVARIANT_CONTROL bits */
+#define HV_EXPOSE_INVARIANT_TSC		BIT_ULL(0)
+
 /* Register name aliases for temporary compatibility */
 #define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
 #define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..e402923800d7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -388,7 +388,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * setting of this MSR bit should happen before init_intel()
 		 * is called.
 		 */
-		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
+		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	}
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

