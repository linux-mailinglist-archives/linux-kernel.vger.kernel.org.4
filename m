Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1F63E54B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiK3XRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiK3XQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:16:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEA90745
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:11:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o137-20020a25418f000000b006f8cd26bfcfso2218520yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8x0ZXn3EDc/IXE10wWIHQ6grwXVgVE97mHwl4hbdeQk=;
        b=svX1/fceR089wUbhSQhk/jDIM6Hb1O6OQ2qpyY/bxODwo2l21O/+lF2M/oWYVFopBL
         9iVSjpUD4ByvxHNMTLm2+Aqi3jkHju8zeyRE0QQ4MXEVtGJlbaZInZtfd0vZlRTxGrzq
         JsifAxPm+HxofD/VWF9T5VpkTs3QrcfDSrRCCx24sbFpCjTOTpcatd79jNfZI53OekTV
         PFymG/ZoNTP1yqeAIkXfkfQrmLz6NqML76C7vkqujoT5hbToc0RUrI+jh/dGR+3upHWw
         Pv5WHPynR7w4dPeVQ7wg5KdVd27yXGQS19WxO6GBAvU3VTI/56EGnkKmcDKvptaKWmKb
         82JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x0ZXn3EDc/IXE10wWIHQ6grwXVgVE97mHwl4hbdeQk=;
        b=bDUNSA74T1bJ8kD4yHlw+Rv0EJZummKqBg9VKimpG7lCuDZ37KZ0zwmG6o+19bqjVk
         8wgp8708P8V+V/rWRqhVd1N8Wh4s2AiRnw4uYEfwVbMcrFXFDWTAK27lmeSQBBSAkpDV
         te8Opp/Vm6SReT24D8fEo3BwHj8w5ST4em4lm2E5ppijwA6uOpZDsIOwHG3mU+z8IwS/
         PIYsrQCbqmvzM1F3wC0LobkVHfhSlWoX4EQmLYvq51MK+rzC70Y63ry68e4pRrft6iRe
         aN4vMwDGiwD87bLWNa0YlY1u3i7EN7tGYCXLSZGAgiIHqizB1jKURBppyBcHKy8S3lrK
         UT/A==
X-Gm-Message-State: ANoB5pnA3GdHYtqNakqRR/rqn5gZQHfkEUpgkz7RDpdp+ZODd00/NbWd
        GQhRh+yz4qBQCWE0CwpjwOFqFSGd9bY=
X-Google-Smtp-Source: AA0mqf52TAnX1cWAQ96XDuvwPCxCy8n4wLWV5o+6wUepr4pO9rnWPI1F+BmGpVuyqa0Tukjf36JFuFHSLuw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d40f:0:b0:6fb:a7f8:8b62 with SMTP id
 m15-20020a25d40f000000b006fba7f88b62mr1103250ybf.313.1669849864582; Wed, 30
 Nov 2022 15:11:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:34 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-51-seanjc@google.com>
Subject: [PATCH v2 50/50] KVM: Clean up error labels in kvm_init()
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

Convert the last two "out" lables to "err" labels now that the dust has
settled, i.e. now that there are no more planned changes to the order
of things in kvm_init().

Use "err" instead of "out" as it's easier to describe what failed than it
is to describe what needs to be unwound, e.g. if allocating a per-CPU kick
mask fails, KVM needs to free any masks that were allocated, and of course
needs to unwind previous operations.

Reported-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6a2be96557c2..b8c6bfb46066 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5907,14 +5907,14 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 					   NULL);
 	if (!kvm_vcpu_cache) {
 		r = -ENOMEM;
-		goto out_free_3;
+		goto err_vcpu_cache;
 	}
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
 					    GFP_KERNEL, cpu_to_node(cpu))) {
 			r = -ENOMEM;
-			goto out_free_4;
+			goto err_cpu_kick_mask;
 		}
 	}
 
@@ -5956,11 +5956,11 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_async_pf:
 	kvm_irqfd_exit();
 err_irqfd:
-out_free_4:
+err_cpu_kick_mask:
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
-out_free_3:
+err_vcpu_cache:
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
-- 
2.38.1.584.g0f3c55d4c2-goog

