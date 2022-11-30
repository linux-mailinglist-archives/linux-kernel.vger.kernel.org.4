Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C163E483
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK3XK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiK3XKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:10:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4701975F8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:09:49 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s15-20020a170902ea0f00b0018970bb67bfso15430011plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g1stMgF+unVz+1wniuTG4sBb8H6V2BLTtzNNraJ+L2g=;
        b=Qu2Gj2AQMSdn5ynZ5uRxUGFqbeHyl2Ed5IXeJ2cS9b8RyxUmxP+UPpwD4AXe0Ud2wQ
         GLE5fpqUn5yzNfMmkf1QqZp6YlOWxyIHZvzY2PTHyliCph5U92Ri7VRil5QNW2hbhlro
         eqLV3fzPciK364AgPpAWure/pils1YFI032lNHB5vYzqLYNGO/HTaCFu4SnHfGbx0IJL
         YzVxc9OdZl6JuUto8jah8ZZUeY5Nlgmu8NeURLW2FfXGR4hkpIETaC3DDgh3Y+VWw9aT
         wnj+XTBDiyARsefNZ1R+h94oYnfXDMDFEaIxFxgvi52xPOyDG50iBdiNI6MjV0enlZkj
         ltag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1stMgF+unVz+1wniuTG4sBb8H6V2BLTtzNNraJ+L2g=;
        b=QM4ccFKlu9iuNgXKIPobC3F6ql5qpGAQGCYGOMJ9r2mctdPp/NtvcDrEEd5cQdMi7j
         uD59kFMrTXwI4q4GqADDvNqk/8N5h6wn93Z2DNJCVksVtJin3jlf2p3l8aAqNelLLVyI
         KUZQTswXliZnKxnyyKX8Y6i+zMAhWLg10XDMM6tbqkx97SM3vuulspu/yqQAyZobO9t5
         sd3fQZFW16vDJbiJQPc0N/SWD/Fw4SspQLo8ThG/1PFURSwUTrfZ3wsAGwJeHLvX9DoZ
         iM+Ku58EZ7/zKnf3oOyGZ1o8B14xQXT6M9giHkpDN5Hzy6ssJKC927F5vv0+gHeM4f3l
         7Zxw==
X-Gm-Message-State: ANoB5pkO8CQ7B2wEpuZwz2gFc2JzCgPNngnegvIW68JY/RaQnGjZ6RRH
        /tgZTDoQsiNnfcxHNJF0DNA6zpD47U4=
X-Google-Smtp-Source: AA0mqf66P6cZGe+dew2XFgeia1skilH4V8u9knhT3C8CLrninF2nDNQmOIJQuI+E9fZev+1MNEWaGc+MIJs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9a47:b0:189:acf9:87af with SMTP id
 x7-20020a1709029a4700b00189acf987afmr3514511plv.160.1669849789646; Wed, 30
 Nov 2022 15:09:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:51 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-8-seanjc@google.com>
Subject: [PATCH v2 07/50] KVM: x86: Do timer initialization after XCR0 configuration
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

Move kvm_arch_init()'s call to kvm_timer_init() down a few lines below
the XCR0 configuration code.  A future patch will move hardware setup
into kvm_arch_init() and slot in vendor hardware setup before the call
to kvm_timer_init() so that timer initialization (among other stuff)
doesn't need to be unwound if vendor setup fails.  XCR0 setup on the
other hand needs to happen before vendor hardware setup.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f18f579ebde8..a873618564cd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9326,13 +9326,13 @@ int kvm_arch_init(void *opaque)
 	if (r)
 		goto out_free_percpu;
 
-	kvm_timer_init();
-
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
 	}
 
+	kvm_timer_init();
+
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
 #ifdef CONFIG_X86_64
-- 
2.38.1.584.g0f3c55d4c2-goog

