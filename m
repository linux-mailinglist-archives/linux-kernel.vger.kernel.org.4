Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827D63FBF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiLAX1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLAX1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:27:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA088C9366
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-39afd53dcdbso31374777b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gWsZ8OEnLV5ymKaFcFmcePQ3bdY8nApK/KZQmQFCIA8=;
        b=KN+kBu6bWD02SccUwaKTReovA9KttAHlSNVjQiYSWj29bw0KOiCRw/sKqjr/lVMsDF
         Fs7Tr5euBCRY2XuQF6p7OubZFH+0hwCZaHv6tJRF7NnLpHO6x0G76cQZ+teH+Sqyatke
         QvK9E0JqQyweeu9vSF3H9lSs4o0oy7nK4o7cGI5MwRQ3LILlUaCVzkwKXXJ4MJxzkYwP
         4b+8FdEFgNCMr9gBAWReY4t8hXIKJoDbkTk8M+cpJule4aX29nrdLG+4QNAWps/F6asm
         XgfYfXc5EIaFHcCMD9VChTb9l77gn/d1UI6XkXoW5ETAbItWPe5FSl2x6tF/ZsgsrOrY
         qgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWsZ8OEnLV5ymKaFcFmcePQ3bdY8nApK/KZQmQFCIA8=;
        b=X2rqvtGVrcEumMZwjQZO1EVstJny4xBtp8Il5I5Onr6G8hdRelHogRJnUuf9XpWL+7
         V36POqzBOZdGlCVckDLcnKn4u4GGAFqmVBLyZ760cfbQiwGOW8obgQcU5CaYboXa8idD
         XH+r9pddPq3dtukQp3IM9za8CxifitMIvUHTZ9Fh/Y9MMttvx/IeS3MRwbmpYHjWTDbV
         5UbDLPna5SgJDAzPxr66QicgVTp6V8YQgwFxBX6IWgAREyx55k1gvpW5rcLO9i6JX8c5
         cHOT+Ch3tU63jYHhiefUlI35GxPScCNb8YGmcX3gxnHbWbtntSZAkSsyJPYSe+8n5uFk
         RnIg==
X-Gm-Message-State: ANoB5pmjYJUdKNOVSCGIely5HwL7IQme6tgbf+c/eg40IpRvPrf6yNP+
        o1Fyg9gEQ1UlDEGsbe9t/p31yf+Um10=
X-Google-Smtp-Source: AA0mqf5maF4Vu0S4xUlcIY8YFxf8gDoFMgorwDnnuu84ndnWGBO3blG1tL2RQ1OFKekagbDVnUSGdnXjp3c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:af04:0:b0:6de:9623:a2ec with SMTP id
 a4-20020a25af04000000b006de9623a2ecmr46844162ybh.496.1669937228986; Thu, 01
 Dec 2022 15:27:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:43 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-5-seanjc@google.com>
Subject: [PATCH 04/16] x86/reboot: Assert that IRQs are disabled when turning
 off virtualization
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that IRQs are disabled when turning off virtualization in an
emergency.  KVM enables hardware via on_each_cpu(), i.e. could re-enable
hardware if a pending IPI were delivered after disabling virtualization.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 78182b2969db..40ea16ecb3b8 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -838,6 +838,8 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
+	lockdep_assert_irqs_disabled();
+
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	cpu_crash_vmclear_loaded_vmcss();
 #endif
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

