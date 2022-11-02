Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E284617201
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKBXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKBXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:19:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995425EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:19:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 125-20020a630283000000b0046e9babe7b3so90198pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2jZZfFf52GmkjzF4UkJBFUQx8TRwCaNEoxRzKdccz/c=;
        b=eS+ADSAUDBr+3HDHnDb3Fr9sF+Jb8/UT2oH309j3Rm/86ObG6TRCn9IyhpjUkKBdpE
         kcCNHyv3vwGiHYQRvOqDpsz+Ka9M2XEJCdBD1BDMQE+yHelvK5eIZBtBOFMFVOay6VLL
         HRD1UaccDMN8QRmrJzaFGA2kakGK5P4xJGBM94BuLtDJAAqDK7hBLTZ7oOdfic4lXqK4
         Fr39ZfZInLrcHKiM8fxmsZrdE64FtenP1A0FKcDrTDJZkpQ1QUJo1/Y5EttLt8eZYz9U
         +9QTVq6+Q+Y4pZ8EkuhDPhDFtAlj3OJomhnuiK5WjSAlU9kpBh9BdzMjPScyheuXuiwK
         D0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jZZfFf52GmkjzF4UkJBFUQx8TRwCaNEoxRzKdccz/c=;
        b=xK0JZJQohatZx8jas7WLet5Ejx1HmBBDU5hHYxr82eaYFqIrl72703OZMPUGyumdGw
         UxlVG0tRVUUSokQVIVwO4+Mbf2SVxA0cd9BYCHZ3Hgb2l4eejfeQdgGMO0TLH8LwNfPh
         GGKVXdQPYg3fPJt159s9VFRitmuPmfnbkCqagDUMe2ve+R70+gBo7bRkrWGheD9wszwj
         8Z5oD2sfYDWi5J0fyoyzy077RqxpQe6/in3od5IigiSCFM9dHNIbyvdw8Vdb93sTBejD
         fTV8yThNH/szZu9gfZXUOZOUGs8BAZ4F7hC16B1oiaVGBZM5v/ja/C5S5wW5OcacGgi8
         GqNw==
X-Gm-Message-State: ACrzQf08Uku4kMEvKByKRAU1mZf4ChCpZxvFEF0ZRKSthJMBkFqFPB+U
        pk6WPCT/ZCBJ5dmttCKkcnNerGss+V8=
X-Google-Smtp-Source: AMsMyM6vYYJQBYlQiDcX1wj97hZ9g1pk+rDBzdLxVoyiEkvTNhgYg+UmvFixquw/EG51V/dsQ+i+Sr9IedQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e7c5:b0:213:b7d8:1c4c with SMTP id
 kb5-20020a17090ae7c500b00213b7d81c4cmr25473196pjb.114.1667431166266; Wed, 02
 Nov 2022 16:19:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:34 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-8-seanjc@google.com>
Subject: [PATCH 07/44] KVM: x86: Do timer initialization after XCR0 configuration
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
        Vitaly Kuznetsov <vkuznets@redhat.com>
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
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
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
index cd9eb13e2ed7..9a7702b1c563 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9320,13 +9320,13 @@ int kvm_arch_init(void *opaque)
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
2.38.1.431.g37b22c650d-goog

