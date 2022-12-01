Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8639463E4E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiK3XNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiK3XM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:12:58 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22C9C62E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:10:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id k7-20020a17090a39c700b002192c16f19aso209895pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yXQhNujyCn0BKG7v31c4OGaNv+fuibQffzvzfRXOMY=;
        b=h6rsUUCphQInF8YIuJSydp7y3K+kWTxAbyRCfeyJQKJ+Y6qbtiTSAEs1qGlDllqT/J
         MMyCWI1z6QQ9M7p7Zu6QpSl/9m1uIwFhUqPqC0VY2dNxBAtSmKEBK4CCdgkZqO6Ul8Kx
         fACOhEYDJb6v1xuMAezabk8g2ZSsJuhT+lDS/T3ozQuYyR/lRYpg7LUF046Tas5T+NY5
         CeL2ERbYxquxucrniWQA910RogetkvuImYcNKj0ET57pNLum/MqlKCc6KP+V5OUAEk8P
         PnX37vQ/dZrpTC3Oabzm833Uf9cuKd5yhE1OeJVb9W6pQwUrjh0B5ijm+gc3WgDVn+HL
         6XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5yXQhNujyCn0BKG7v31c4OGaNv+fuibQffzvzfRXOMY=;
        b=11kldaleCIWDlWPis30BDA3D+hqfYO2aUMIzwEAMvA5hmsNCxqaoohEVc6aXiu4XO/
         o1HfehsRbYOZpaEFBpc3Rv6nYmLd8Hrw31FzVZO2iaktSzKxq1NgkMOgiNySGxYQtlGK
         K9b20sNuj7l61rAJTUIlnGXlOOSjilGoekV3wWk4E8LZ7wLdYsIMQsxuw2B8CGJlbOca
         nv0LZS6ViwNq6eVM+VqhLV7dUYR637+grwiL+Ek3McnWuD9wZigr0N34X1ptbDbQam7G
         0ZTT9BWpMW4PMy1lSplGaSBPldX0MlDoFeVJf8OJ5PEuvK4MWAKFn5HTxzLp9ETfLDlm
         ud8Q==
X-Gm-Message-State: ANoB5pkpD9HLe1S/utd58ufnGdYep8aM0ujBsbc3uhCaOYOGIbDAMQc4
        iN890M2uTc5mk8+fjOJis6Ww8Ut25Pk=
X-Google-Smtp-Source: AA0mqf4uayK8uJVSnmaHjmcUzYqE9zwUJpBZYJxTpzlvsNbotM7JFJFGgIIUFhNbqetWZOK5ykPGKeuQP1w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec8a:b0:188:640f:f400 with SMTP id
 x10-20020a170902ec8a00b00188640ff400mr45576276plg.143.1669849818577; Wed, 30
 Nov 2022 15:10:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:08 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-25-seanjc@google.com>
Subject: [PATCH v2 24/50] KVM: RISC-V: Do arch init directly in riscv_kvm_init()
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold the guts of kvm_arch_init() into riscv_kvm_init() instead of
bouncing through kvm_init()=3D>kvm_arch_init().  Functionally, this is a
glorified nop as invoking kvm_arch_init() is the very first action
performed by kvm_init().

Moving setup to riscv_kvm_init(), which is tagged __init, will allow
tagging more functions and data with __init and __ro_after_init.  And
emptying kvm_arch_init() will allow dropping the hook entirely once all
architecture implementations are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index a146fa0ce4d2..cb063b8a9a0f 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -66,6 +66,15 @@ void kvm_arch_hardware_disable(void)
 }
=20
 int kvm_arch_init(void *opaque)
+{
+	return 0;
+}
+
+void kvm_arch_exit(void)
+{
+}
+
+static int __init riscv_kvm_init(void)
 {
 	const char *str;
=20
@@ -110,15 +119,6 @@ int kvm_arch_init(void *opaque)
=20
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
=20
-	return 0;
-}
-
-void kvm_arch_exit(void)
-{
-}
-
-static int __init riscv_kvm_init(void)
-{
 	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 module_init(riscv_kvm_init);
--=20
2.38.1.584.g0f3c55d4c2-goog

