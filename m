Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CA7012C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbjELXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjELXwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:52:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C80E71A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24deb9c5f8dso5541484a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935462; x=1686527462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eQC1WP9HfF32PBCDofAFgKjIRQz/i/Wsm+dGz45S7kY=;
        b=0z9ywKuRxK/XqqugSVuMPGre0/Po8fyCsSxJiFCIhtwbRrMCZJEhaBiGdn9Ds0ST1y
         aVSU/Gps3Oa+n6S6RXWn7V0u/AKgfEFdrOeLnrL60X6DkCPMxBOsXPOGC5b5S6FJnu4o
         UpOvqw1yFgIghLp5GskLHwrmqX0dEXdc0T/iIlFiFhCtSr6FGp+7TmLU9Kymq8+pD3J5
         mSlnN8TBlcRMsE38W3JUIuDvWUOHVdUD3B51yV90RNZz0clUKn+1xhb8u6vb1/9theYc
         Ew069Rnx5yUTW3ew+psj0mH+WQVv1UFjm98Qw4Hb/oA/wF0+qdH+j+WgUgzlqHlUroHs
         +qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935462; x=1686527462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQC1WP9HfF32PBCDofAFgKjIRQz/i/Wsm+dGz45S7kY=;
        b=lWfQX9kPW18/A3VX4eYz9vMPrhbL2YeCDe7CLxaCsYQUn0UpPA8TBHzY+0KraVVI5t
         50DoELXN2qF3ZYUIrypj85QTOcvv4ksRND7JohQvz+EUaeSWtbmb+4WGwMCKf2M6F5wO
         OF6phzR5ZI5MixDcnEUeTfp89sui4WEqToAQyBqZRr9BsKslVJsuVMoA1enVyNmRMDXi
         njHBn4t8N6GANLUGYCk+q0HgZesBqtMWFjtfegsNX4UnfvWgCjJ3eP6XtpnjzHSo2lAk
         GdnrYetOitVt341f2QxJLsckKB4jLUEBUvzHquU6tIHmq66SRYFrtdw5PCZunqz5dkZy
         7jfw==
X-Gm-Message-State: AC+VfDyrXY+s9Uxb/LQ2DWyrgG3P3s3wTkwC9M+QG7HkZraAfb76dZOe
        vzmmesOIK07rQAuu4W5QieDZTfTGuws=
X-Google-Smtp-Source: ACHHUZ6Q5iYycxspH41azVUGb++smRyiNiIV0FKdKVgCrDxd4yD3BHLvKT9503TqoBtF75L7PEML+Y9aIJY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:148:b0:246:f99b:fd65 with SMTP id
 em8-20020a17090b014800b00246f99bfd65mr8097081pjb.5.1683935462688; Fri, 12 May
 2023 16:51:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:26 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-19-seanjc@google.com>
Subject: [PATCH v3 18/18] KVM: SVM: Use "standard" stgi() helper when
 disabling SVM
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/kvm/svm/svm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d00da133b14f..d94132898431 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -594,17 +594,10 @@ static inline void kvm_cpu_svm_disable(void)
 	rdmsrl(MSR_EFER, efer);
 	if (efer & EFER_SVME) {
 		/*
-		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
-		 * aren't blocked, e.g. if a fatal error occurred between CLGI
-		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
-		 * context between reading EFER and executing STGI.  In that
-		 * case, GIF must already be set, otherwise the NMI would have
-		 * been blocked, so just eat the fault.
+		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
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
2.40.1.606.ga4b1b128d6-goog

