Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1963E593
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiK3XhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiK3Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:36:57 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E571128
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 145-20020a621497000000b00574fab7294dso227737pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KY6cgH0FoQgBjJK6cWHlNWc/cuNwA3rTkcmq/FIE/W0=;
        b=O5Kmt+7v3RpSCb0+VWEK9EqPSVW4nD/fCUmVYybP1v3f7uc0CVBZQJ6Mp82SSuZjF7
         zmqc3E+bxzy+4Uq3+UDL+eohoq6ah6TrTNoVMvZHg4n+blU3QqemmrwiIawxne5qaD2T
         UConf3WriIgOVVFc0wl6okzHI4t82xGt4irFaBr3xR+F+tKQt3rl2uMUicSZ4RLGB9mZ
         L4lQxltIQF790VaPnhEgv3TVdq11vbEFZWepOygqrqfyQCJT5q3mxBQgc0290BBpcxCj
         r6Ta1DMsMNlerxvpH+yMMUmLS6f5AjQRavMBZ2mZ/a/ok3WETdkul8QghZxRpHT3AW/f
         vCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY6cgH0FoQgBjJK6cWHlNWc/cuNwA3rTkcmq/FIE/W0=;
        b=kJpX0xRPYYtITTix7Ybn79Zji4JU7QkVIEmQXhWUb739+X0QFIHJFiOQaHF4BQneRW
         8uDV0Dxv4eg5oF51n2JBISyyMYYSgk5YqYD9XyRiEoYzMrxkmxn6q2mLiMW7mqRx+K+D
         mxy2DsbZMLzB5L9rNmqjpr26ShWvMG/ocFBET3WKaYGvFG5O8o+x2SujnuE/GjFm25a1
         7KUgyE9FVOZptQ56RWj/R3GbtgFRETHmBQ2fTmtb1aOXLlc9vOX5Wz6FWfxPuixMKumb
         9PuNWzoPONl1Mv3sfc8psahckh3f/evLnLvA8dC0kXuarxFa8SxxlgZgval0Y/qHa8Sb
         SlaQ==
X-Gm-Message-State: ANoB5pnfTIVD2OF5jQEYy6YrTKJawWRNqiREYkrg/UU5aSFVB8IWWGya
        zWyBiAYpXALSbXD5GNunnaW1lcvmJto=
X-Google-Smtp-Source: AA0mqf4eLRzKyfTQoTVAS0rlYdPo2PtSyno6QQQW3xQ9gUaSf2mV1RYEc8CRKCvPiAwwGbpbgWj5zcIKORc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1206:b0:186:a2ef:7a74 with SMTP id
 l6-20020a170903120600b00186a2ef7a74mr48409099plh.148.1669851416008; Wed, 30
 Nov 2022 15:36:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:36:48 +0000
In-Reply-To: <20221130233650.1404148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130233650.1404148-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130233650.1404148-3-seanjc@google.com>
Subject: [PATCH v4 2/4] x86/virt: Force GIF=1 prior to disabling SVM (for
 reboot flows)
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
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

Set GIF=1 prior to disabling SVM to ensure that INIT is recognized if the
kernel is disabling SVM in an emergency, e.g. if the kernel is about to
jump into a crash kernel or may reboot without doing a full CPU RESET.
If GIF is left cleared, the new kernel (or firmware) will be unabled to
awaken APs.  Eat faults on STGI (due to EFER.SVME=0) as it's possible
that SVM could be disabled via NMI shootdown between reading EFER.SVME
and executing STGI.

Link: https://lore.kernel.org/all/cbcb6f35-e5d7-c1c9-4db9-fe5cc4de579a@amd.com
Cc: stable@vger.kernel.org
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 8757078d4442..0acb14806a74 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -126,7 +126,18 @@ static inline void cpu_svm_disable(void)
 
 	wrmsrl(MSR_VM_HSAVE_PA, 0);
 	rdmsrl(MSR_EFER, efer);
-	wrmsrl(MSR_EFER, efer & ~EFER_SVME);
+	if (efer & EFER_SVME) {
+		/*
+		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
+		 * NMI aren't blocked.  Eat faults on STGI, as it #UDs if SVM
+		 * isn't enabled and SVM can be disabled by an NMI callback.
+		 */
+		asm_volatile_goto("1: stgi\n\t"
+				  _ASM_EXTABLE(1b, %l[fault])
+				  ::: "memory" : fault);
+fault:
+		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
+	}
 }
 
 /** Makes sure SVM is disabled, if it is supported on the CPU
-- 
2.38.1.584.g0f3c55d4c2-goog

