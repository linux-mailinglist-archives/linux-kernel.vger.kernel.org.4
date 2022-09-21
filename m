Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A55BF228
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiIUAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiIUAdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:33:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA4796B0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:33:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a056902038300b00696588a0e87so3683176ybs.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=jS6wDbw1pF8Ah0FgPiebKmSPM6cE3vh92J7x5AZxxS8=;
        b=BXLnvleOcPw2Y/CP9Ur+TUIGjrRNHf90WKKjZAL9Icsc0hEgdcWSuQ+GHVYb1EUn7B
         sg7UYfZNRpVmJtSJClj570j+DzZOIqw4J10R/J9Yt7QeCVYCKTpKQGufMZPkwcZhkNUl
         3vaoURIDkAnxonLZR0kp8E9GOTPxPNNt2Uho8o+B4y7tM55x9dF6kjtMv6AEMiukUUVr
         9k2MNMpEmt6zvG+nctg/UgWyL5RXO74DdhR2N9XX4q20RL0XpVSV68ufwiv6eT0kEN2P
         i58uBMosfJaPWh3cFlR3V9rNs3L5A+Vc+LFEiAaNl1sbw3jHRaKk/mS0dRmTHm93SlWB
         i4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=jS6wDbw1pF8Ah0FgPiebKmSPM6cE3vh92J7x5AZxxS8=;
        b=iFAuX1PhlWj8bfsFKDc37LIAAewQcfPXj2WaXUv5kTq8nbGC1eeRVIyM2KRg/muhZo
         NJEd3eTBAZq/bLiJGXLjwEF0WfiPKVtN5PrWgiujXaxlJT8I5GXUKEU4JOojLROSAPTU
         6r/alMVOgwgEuin8wy4LA3PhThQvaRXao9bH2uc9n2tvuVq6lWx7ej0qCXMh37TrhgZp
         EpogsOJox/ulu4+a09nnRspGo1fMmV4Ts8WMQTgnb6b0TVvF9qcsXZ7I0h0lt9WPGbiL
         LA2rFqdqtbvjB9anQ+2FRv7Mk8HjMg5XMu97F9/M3nydUTVeTXnxY8YuDhefakuEbEvH
         7CQg==
X-Gm-Message-State: ACrzQf1P15t7sqku+bCXtCedDbsbHEOi9/Pp105FPmP7Qq2roxIdGjaN
        LGQx8ABeG6DOgt8grIqJN9z3CejC5PA=
X-Google-Smtp-Source: AMsMyM4FwFyakAFj4uLb7acHZDkmCOLDogY8I+5AwDxw4BtkzCD4DzOXBcnEDpQ/JYhzAy9RSZ7GSFvqyP0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:81cf:0:b0:6a9:4d0d:5ee6 with SMTP id
 n15-20020a2581cf000000b006a94d0d5ee6mr22583489ybm.153.1663720381243; Tue, 20
 Sep 2022 17:33:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 00:31:57 +0000
In-Reply-To: <20220921003201.1441511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220921003201.1441511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921003201.1441511-9-seanjc@google.com>
Subject: [PATCH v4 08/12] KVM: nVMX: Make event request on VMXOFF iff
 INIT/SIPI is pending
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
        Sean Christopherson <seanjc@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
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

Explicitly check for a pending INIT/SIPI event when emulating VMXOFF
instead of blindly making an event request.  There's obviously no need
to evaluate events if none are pending.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5922531f6c52..8f67a9c4a287 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5193,8 +5193,8 @@ static int handle_vmxoff(struct kvm_vcpu *vcpu)
 
 	free_nested(vcpu);
 
-	/* Process a latched INIT during time CPU was in VMX operation */
-	kvm_make_request(KVM_REQ_EVENT, vcpu);
+	if (kvm_apic_has_pending_init_or_sipi(vcpu))
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	return nested_vmx_succeed(vcpu);
 }
-- 
2.37.3.968.ga6b4b080e4-goog

