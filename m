Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC463FC08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiLAX2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiLAX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:28:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC63CE41E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f71-20020a25384a000000b006dd7876e98eso3289312yba.15
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xKO5gDHH6l2BFGRx+bAr/R/X/txGS/YMP3y88vo/DQs=;
        b=O6HXE5mlRidl0Q4rg3rTusA/uGWWbvzYZixtwdz2MUbik0b8Z6ICCGGqeQiqEoime7
         L2AfiIVKS9WasGmJLtrCfdVsyTFPf0YlWz56R1E38/8w0f500LJAenTrT3AVUQu+q1dz
         2wgGdMjtPJrgnEFXMeWyb+VyPnSBwX0LdNfpokDzQ8gCS38+Sb4zbTS066WOEl+djFle
         9Kskm+wQwxdJNVTFMHKMxzvNjt37+Rt2yBgO4kuYpsqiKNSZWiIQbn1Z9p3I6T2vOnBX
         PFfgGe2Oj+l8DFaSFI4MgLtP9BvgCA6CYt8cSln717GUjOaqIuI2yds0V00PifmVFZQU
         EfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKO5gDHH6l2BFGRx+bAr/R/X/txGS/YMP3y88vo/DQs=;
        b=Ts50H8020oU9WL4U2VNovfiYgWZA6f/J+VxXBkd0Y9Y6cTEMYgTun49RB7U/XTHclg
         i2QdcCeOwk/JLIvt190mMN7WXd9MBh46cizjtSvrRc3AvYz9SACU2EWgB7XSgP6lgeuC
         Xb5lcnZllvNZdgoKfTdv18ySmMesHIOAng8gAVI9FyKcaIR/tugLYDxyBh72Hvme2k70
         wynKj/AO569nkLfjur5XQ+85gH9jOI55/hiF09XEDVH5Q1+BzkAbU6GUoHKM2q/mc38y
         dADIODZ+BmyqPq+6YTqsTNN/CNXmnySRuziT1q8uJG6MgZAK/8Jagf64N1IvjMK/23k9
         3jLg==
X-Gm-Message-State: ANoB5pm4OkVnJSp3z52oqJACSzk0TnfQiQw+pCk0YU7apB9BdF8n+zto
        0C17Nff3sDaJTfNyyBRATwG57WpGu4E=
X-Google-Smtp-Source: AA0mqf6r5wVfKxGEDpenXvu+3yNlydRMkzdX022siAktDieu8OZ+F1d0HzAQPOqn6tZJ1GsC0NgzArz2qEQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6c44:0:b0:6e9:b6ea:fc86 with SMTP id
 h65-20020a256c44000000b006e9b6eafc86mr47631850ybc.183.1669937242341; Thu, 01
 Dec 2022 15:27:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:51 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-13-seanjc@google.com>
Subject: [PATCH 12/16] x86/virt: Drop unnecessary check on extended CPUID
 level in cpu_has_svm()
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the explicit check on the extended CPUID level in cpu_has_svm(), the
kernel's cached CPUID info will leave the entire SVM leaf unset if said
leaf is not supported by hardware.  Prior to using cached information,
the check was needed to avoid false positives due to Intel's rather crazy
CPUID behavior of returning the values of the maximum supported leaf if
the specified leaf is unsupported.

Fixes: 682a8108872f ("x86/kvm/svm: Simplify cpu_has_svm()")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0b373543514f..eddc0eeb836f 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -39,12 +39,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

