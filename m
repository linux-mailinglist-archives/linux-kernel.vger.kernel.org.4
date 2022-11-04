Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627B6199A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiKDOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiKDOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:24:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD631F85
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:22:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so2595963pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJuNcXrLdCJM1KRVKwlMJhT9Ctl3812baupy3AQpKHQ=;
        b=NvxTKOjydC+TNUTauQOMqIoVQIhy8wyIsJQZgTbtv4gowJBgmNmHsQZ2uQT4jOpJpu
         cgOLSN/XknwgE8zS2VEZ6Xu/+QDoiwpwedkgzSP6I7VtqFN8rdxNtywdyqbQfWyTNp+E
         C5P0a/SDyqh4CoDhXiVBzpx0c2rYGpOCfTx2GN8h4yZSn0IraIJLVDAau3g1QCNC3HQ+
         uNZ4jeFwSaeob8aFCnBxhvSDhs3aTJo+G/CSqUNHIEj63GVy1z6xDDJEP5Gb3P80gd1r
         iccq3ssoZuxqPZKTFhBtHpU6nlFX8HZUt3vCeMd36Uv5yqXvQBwioLA3HdIbDntifi9Y
         6lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJuNcXrLdCJM1KRVKwlMJhT9Ctl3812baupy3AQpKHQ=;
        b=XEuXVVgJElxMYmMMy1H4FP6kYzYYojTXP3Mkn7/eT/qgTyqW3OBq88YuS1Wuft7+Gx
         DepQmK0OBknJz7U+wtAh0oxfTQ8KduDuHcNYQZJWi/kdkwS3U49UlbEppLvppyTjiKhC
         2vya/hsoISP9oPIcP/fAeVIp0bj+Z34WE53KeKFapcUG8PSThvSn41QZolG4R5StH54T
         w0r5UrTPrS6w0c3oYC1qpoU4Srs75JPioe/i9ViEI734XrcLl82Qhds9u7wY9hO64U/v
         SsbB0xZyyiBlL4WWJbj7y0AU/zEX0hGSOUxgi0edRmcgIqW/UWS7qZEgq/2McmpbEr5q
         b3rg==
X-Gm-Message-State: ACrzQf2J3LUhe2fEDLqbEiTv9YSP+Bx1QBr9qVGtNEEc0xhUnJMUwfC1
        4Zi81pgcxfgcbSY7eHHnj2kWtlsViWs=
X-Google-Smtp-Source: AMsMyM7APxzliBT+2nrygcTS7QRBB3ogpOju/PR6BNlZJYsbIaOBK5IhCO5PdyHqejsXaFp5Snjobz9INoI=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:45e5:86a8:76c:1f1c])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:22cf:b0:56d:1c55:45d0 with SMTP id
 f15-20020a056a0022cf00b0056d1c5545d0mr33328315pfj.54.1667571744258; Fri, 04
 Nov 2022 07:22:24 -0700 (PDT)
Date:   Fri,  4 Nov 2022 07:22:20 -0700
Message-Id: <20221104142220.469452-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH V2] KVM: SVM: Only dump VSMA to klog for debugging
From:   Peter Gonda <pgonda@google.com>
To:     jarkko@kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Harald Hoyer <harald@profian.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Explicitly print the VMSA dump at KERN_DEBUG log level, KERN_CONT uses
KERNEL_DEFAULT if the previous log line has a newline, i.e. if there's
nothing to continuing, and as a result the VMSA gets dumped when it
shouldn't.

The KERN_CONT documentation says it defaults back to KERNL_DEFAULT if the
previous log line has a newline. So switch from KERN_CONT to
print_hex_dump_debug().

Jarkko pointed this out in reference to the original patch. See:
https://lore.kernel.org/all/YuPMeWX4uuR1Tz3M@kernel.org/
print_hex_dump(KERN_DEBUG, ...) was pointed out there, but
print_hex_dump_debug() should similar.

Fixes: 6fac42f127b8 ("KVM: SVM: Dump Virtual Machine Save Area (VMSA) to klog")
Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Harald Hoyer <harald@profian.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c0c9ed5e279cb..9b8db157cf773 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -605,7 +605,7 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->dr6  = svm->vcpu.arch.dr6;
 
 	pr_debug("Virtual Machine Save Area (VMSA):\n");
-	print_hex_dump(KERN_CONT, "", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
 
 	return 0;
 }
-- 
2.38.1.431.g37b22c650d-goog

