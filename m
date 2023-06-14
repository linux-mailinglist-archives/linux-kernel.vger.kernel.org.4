Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE05720CDC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjFCBLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjFCBLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:11:12 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E53E44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:11:08 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-397f122786fso2224970b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685754667; x=1688346667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OHgmCWhsFgWWc85nvi+clBbGRI79fcIkNTIgsGqvymM=;
        b=rlxDfPJjRdF2a+2a8IL9CQM3ryLHp/fQFGIDzVWEwkAjbu3rsh9eN4/R438auoMsLx
         irdotbBF0L1VqKT7sLdHg3PikykqWcUlNX6wVlhaUAfH5PKTV+UUR+TyBafKzG8MjC4E
         tp1WnkLmqwfZvQaRXg6jlLso8YEnv2L36GuDh8uar0YoEOeMWHsovwHhs2G9+A+3kHmr
         V/qpzImsl5mxJI5ns7EKgEttGZ561aBmdHz/ppbAqpuZmX8j8rgPc/m4SgD+T641muzY
         vWeaDVcIuFit0C86mc8OyyT6Pgkn1zccHXMcLo0+BpC9MFyGHv6tOIf9BOGgQIFhgJGx
         UvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754667; x=1688346667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHgmCWhsFgWWc85nvi+clBbGRI79fcIkNTIgsGqvymM=;
        b=QR9/yZsaN2oWUP1o9Qm/fS60pkKs5meK/PGi9c6JE0Pgcct/fYaeM+9AhfESOWCTwJ
         AlHR9P4nTkcGfkLfbMxMseR7ErafuJANpM0N2YowJ5jFQHvIYflekENzmVp5iVYTR9vA
         LvuwJQ5LQZSTk0ecmumTQdTU8dFB4UCPwbq/elJPa+SSsEWjOvI6RLLUbL8RuJdrJFtG
         9x6SVGsT/5B3/Vz1kNgAT3eZi9edTTzQ1VA01jY/B8I6kv+4YPIxG4yL3aSrPK49rbY1
         qoaDKfAUslsY6D6fdDHFCK4k1OzVLG07Z1DDQsGGqqUBnNCyTv3PmmGMeHvJyz+djSu3
         Fcqw==
X-Gm-Message-State: AC+VfDzwNcbzgRxYgpf78NCSdUtyohxVCNbX7omzIKmDGYWfZ+VD6CPo
        ECoXIvIrDjhe0vV2lN6w33n9Pu6p8gI=
X-Google-Smtp-Source: ACHHUZ7fj12g6vQgJPTgDrxbgsW/k0ZxqGChmghKukBdZMacw+XVprDLohrghb7z31IURsAjBSVpN4gjegg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aca:a888:0:b0:399:ee8f:6cdc with SMTP id
 r130-20020acaa888000000b00399ee8f6cdcmr341691oie.9.1685754667468; Fri, 02 Jun
 2023 18:11:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 18:10:49 -0700
In-Reply-To: <20230603011058.1038821-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230603011058.1038821-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230603011058.1038821-4-seanjc@google.com>
Subject: [PATCH v7 03/12] KVM: x86/pmu: Reject userspace attempts to set
 reserved GLOBAL_STATUS bits
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>
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

From: Like Xu <likexu@tencent.com>

Reject userspace writes to MSR_CORE_PERF_GLOBAL_STATUS that attempt to set
reserved bits.  Allowing userspace to stuff reserved bits doesn't harm KVM
itself, but it's architecturally wrong and the guest can't clear the
unsupported bits, e.g. makes the guest's PMI handler very confused.

Signed-off-by: Like Xu <likexu@tencent.com>
[sean: rewrite changelog to avoid use of #GP, rebase on name change]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index edcf8670eb4e..efd113f24c1b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -402,6 +402,9 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			return 1; /* RO MSR */
 
+		if (data & pmu->global_status_mask)
+			return 1;
+
 		pmu->global_status = data;
 		break;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

