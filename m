Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334363FC0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiLAX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLAX2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:28:48 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10F10B5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so3450153pje.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=e1NugFnVCB110oXGMzrxJ93wD+BGdk2//9yqV+Q+IFc=;
        b=AMe6PZQjL+GG9iGCzR8Y1kDAWFNDPhfhQ+A1ONMZtd40MzMjOdxdVkLPy+o4zaOX0k
         EapYcGzlaA1WBqr4QlwRfZ/UOs5nydC4Z1Q/Gf0DfQdR3+VxXzQfOWCYeJSuLnkwtnNB
         L7Vajcoe+gve+aTRDGu6MsW0HaBmVK74RQOdCPb2q3azcTPtng2zprtO4MceWEGmlla3
         f3hiYd9MJ2N+xVUOXVq+DxA3f9DleU3IbHw/BTopzy8ZL9QIuIC8mpHHUKu8syJvajlJ
         alNgTMKhLluW+5etzrvrxstnTPTvrN0Wrp8jdMFi222FhOv00hZ6Xw+CcRQjc1UzjctI
         O/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1NugFnVCB110oXGMzrxJ93wD+BGdk2//9yqV+Q+IFc=;
        b=ZIpYLEqi7+sRlH7tQUJAJ0Y/bOlOAfUaMEIgAhdj9eFUEOdrSarwHpPFlT+7UgiD+3
         ZYC/lC2TGx8Yb6Cnlnr27RTjhqHRMDvt/ZWROVz2Z3HhqCfPSTcIir9GFHHaVu752qFs
         uIm7aIxHoGutq0xqWL3+vlM+TdfO7OVUFcoCqth0IHLx9F+9xVYQ9QcTIuEeDrb5r6hw
         ao6/CjwLN5Va85XCDlzpUj/x9VwcS6+Q9DeEDwCknFjFo4Yasu87WpV8vS5vXIogPY0M
         Rb1bXpzW6F6r0wvzW7CVw2YyhpKZrT6ymF4+3siUvN54qMbtXkjBi2AiH7LNHd4XaaLA
         X6UA==
X-Gm-Message-State: ANoB5plmLUBLHwafFSWjL5N3QaXVFrD9NrFDDLgrFUIi7/xJMhE6Zuji
        /4Ozpx/z1QI6z7N+M56MBI8/IETmWXY=
X-Google-Smtp-Source: AA0mqf5ZwcIe+YY0pzfxIbAo3lP4N19HMp0HJsnVajNzyxLAxNKYPCVLQTfGvi94v6IjIRWdxVfh94oDZbo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6904:b0:188:fd9b:479d with SMTP id
 j4-20020a170902690400b00188fd9b479dmr53509373plk.93.1669937248948; Thu, 01
 Dec 2022 15:27:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:55 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-17-seanjc@google.com>
Subject: [PATCH 16/16] KVM: SVM: Use "standard" stgi() helper when disabling SVM
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

Now that kvm_rebooting is guaranteed to be true prior to disabling SVM
in an emergency, use the existing stgi() helper instead of open coding
STGI.  In effect, eat faults on STGI if and only if kvm_rebooting==true.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 08ed4679903a..72899a61f708 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -579,13 +579,9 @@ static inline void kvm_cpu_svm_disable(void)
 	if (efer & EFER_SVME) {
 		/*
 		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
-		 * NMI aren't blocked.  Eat faults on STGI, as it #UDs if SVM
-		 * isn't enabled and SVM can be disabled by an NMI callback.
+		 * NMI aren't blocked.
 		 */
-		asm_volatile_goto("1: stgi\n\t"
-				  _ASM_EXTABLE(1b, %l[fault])
-				  ::: "memory" : fault);
-fault:
+		stgi();
 		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
 	}
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

