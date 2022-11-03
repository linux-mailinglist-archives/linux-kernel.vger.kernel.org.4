Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C17618A26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiKCVEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:04:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0F6475
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:04:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e13-20020a17090301cd00b001871e6f8714so2028761plh.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1MqUUYTBqZBuLSU6Stq6+emUDWkFLI+9b+J7NXsYFdg=;
        b=M75acoPPp8sxUkaoycxX9GC5fTgwvRvyoYqiAaCc8zdoEcqEcIyRy8QsFv0nmD6c5c
         Y5oOMdtaC5bcq0dP7PeKtfxaQm9xK2ST+/pWQA6NCEQoJ2XWbffTRR9kdJZLHq4iZ4WX
         +YToRzOLZ55t2I7mDYu0Ths/zoFcNKwnmuh/tlB9n8w5BRkBrExwS3Z6FEETINHROuwz
         iUHMEeFgR2cwGtd5YeSEyqZTq8p9KpDOvqc0OZYk+rZLg593zS4ekA45q1K9S++z6Ezb
         Xn9nkpyr4Dtx/NG9goxj/hSJdpr0hOINoKqTcQiGX0wOkIwaXrRO5v0A5iDzo5DA2Tr8
         DNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MqUUYTBqZBuLSU6Stq6+emUDWkFLI+9b+J7NXsYFdg=;
        b=ukUf+v4hYsQ/CRTJWRxoX0MrybDgcr0BZ8Wmv6ylQSMvagZgrdb1v1+4W4JUH0yRw3
         yaiGdjnZ+GJXwUqF1AhGqQ2gE90/J2SMMt+RGMxndH9FBDF6vTMZx9rmGMeD5n2ntSB3
         wLq8bTUBJxN3CqQ6N4uvtEaKR4YsnOuyaYqn2PC9UPvvKkqKbg8Dn+HeYv+Aoyvt3L2h
         wlg2Epx3felMDBMudPJucphi65RSwgKqQK5npzrA6Sn8JO4BDUlH/5/b8OvxwxfQzopY
         rZ1eg5WSLNY7aYI/7NDiIU65BFqxNSW0SVBtuz3C8jU+brcCozGg/ZQw+fzPrb5S/Y5r
         ZXcA==
X-Gm-Message-State: ACrzQf1Q/b1my1WHOryqCtVcsqRRoDDR//ypZnx9g+DEiZB+XMZzUlLJ
        JvKyoqbQW73H1Y+SB42jp19NBvlJ+Ns=
X-Google-Smtp-Source: AMsMyM4uNOQp7t/ugUfcgUXPUj6YPppbO5PfbKqoSPM6udmXloKtVq+/LCEM/c1ZkcDhWBrNcr3gFi3gScY=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:45e5:86a8:76c:1f1c])
 (user=pgonda job=sendgmr) by 2002:a63:5d12:0:b0:46e:cd38:3f76 with SMTP id
 r18-20020a635d12000000b0046ecd383f76mr26972646pgb.64.1667509464485; Thu, 03
 Nov 2022 14:04:24 -0700 (PDT)
Date:   Thu,  3 Nov 2022 14:04:21 -0700
Message-Id: <20221103210421.359837-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH] KVM: SVM: Only dump VSMA to klog for debugging
From:   Peter Gonda <pgonda@google.com>
To:     jarkko@kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Harald Hoyer <harald@profian.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

The KERN_CONT documentation says it defaults back to KERNL_DEFAULT if the
previous log line has a newline. So switch from KERN_CONT to
print_hex_dump_debug().

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Harald Hoyer <harald@profian.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>

Fixes: 6fac42f127b8 ("KVM: SVM: Dump Virtual Machine Save Area (VMSA) to klog")
---

Tested before without DEBUG or CONFIG_DYNAMIC_DEBUG I would see the VMSA
raw hex bytes spew on dmesg. After change no such spew.

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

