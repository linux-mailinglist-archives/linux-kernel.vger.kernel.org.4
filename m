Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0C6E9FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjDTXHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjDTXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:07:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E454EDB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:07:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555f6759323so10588207b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682032025; x=1684624025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=spiv9id599WZH/5+e9mbOrS0EC3ezR/yOJLBFDi9UCM=;
        b=k4mBon9snwg6USJmHKiahBS/oZJU+2PSYrW2E5PdWXT/iAcB9ZArI/7313xrRrnh40
         hdQ8MLu2pkNpDwwzyxIwflCrjcM8HeegGzsojWby3+vEpQQmmwyfP8JOPRZQ7RiuwOZs
         BQlmWeCoXtXOdtQao44YGh7jnXI1p853qpaA7yxPZm7WknM0Um/tezs77tSxxRs5FDkx
         lHfFwjMxJviRmrHj+Y4deA9XE6Mn/MF4us0Sss3uwSiTvQCNUv5umWFxUsh0hp6m411P
         R3J8sECclgKB3GxMX3imN9TSLVyUfvSQeVGk83ODq1LHYouVBJeoDzQxJTcz0usVOTCR
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682032025; x=1684624025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spiv9id599WZH/5+e9mbOrS0EC3ezR/yOJLBFDi9UCM=;
        b=H12jSfMfJUPV3wIAHabHOwW9fv/vzxUs5VEF/1JgCrGcagnEm9VZHBCVxahfnQcsYE
         2Y13V4lb5VYfZyWo2qsIvNwzwjI71OhL7F7GByotgUNa2SpgPudcPgD9gT8v5ZonP8qT
         f1d5HLUJ5pEyaG92W4825XeOGnVmx6VkdFOIsXCqUaMVfpKcZjy0xzBELCkSq9nkkRRI
         gt8HajbFqdHFaV+w/Z1Aeec+LfnkE5/GeQccecz8Kti+lR2951H9XIAMUjuJgW1wUFA2
         eQM0QNVg380vwcc8Jxy8UuhKTY4EGhkvK1SB3bvYcxjVdzR1adrV4YQJ/Z0h+Huapk+L
         iS+g==
X-Gm-Message-State: AAQBX9cack9wuXr6RpCUoUgazcL7pKb/vA+ChAeBghEC9fD7cjl+OY2l
        F1buudYqJ+i40ZPF5Z76NJD6AKqzerw=
X-Google-Smtp-Source: AKy350bVPxvaQpinDCnk0+CQ1oDu/SdOS9AZEl/yje+xHlgPceusnSzxVaxELhTC5wqN/A/fGrurcMjy2AY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9f04:0:b0:555:fecb:bd14 with SMTP id
 s4-20020a819f04000000b00555fecbbd14mr272353ywn.4.1682032025656; Thu, 20 Apr
 2023 16:07:05 -0700 (PDT)
Date:   Thu, 20 Apr 2023 16:05:58 -0700
In-Reply-To: <20230413231251.1481410-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230413231251.1481410-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <168203178177.2322082.210263549285859631.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Preserve TDP MMU roots until they are
 explicitly invalidated
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 16:12:51 -0700, Sean Christopherson wrote:
> Preserve TDP MMU roots until they are explicitly invalidated by gifting
> the TDP MMU itself a reference to a root when it is allocated.  Keeping a
> reference in the TDP MMU fixes a flaw where the TDP MMU exhibits terrible
> performance, and can potentially even soft-hang a vCPU, if a vCPU
> frequently unloads its roots, e.g. when KVM is emulating SMI+RSM.
> 
> When KVM emulates something that invalidates _all_ TLB entries, e.g. SMI
> and RSM, KVM unloads all of the vCPUs roots (KVM keeps a small per-vCPU
> cache of previous roots).  Unloading roots is a simple way to ensure KVM
> flushes and synchronizes all roots for the vCPU, as KVM flushes and syncs
> when allocating a "new" root (from the vCPU's perspective).
> 
> [...]

Applied to kvm-x86 mmu.  In hindsight, I should have speculatively applied this
early on to get more time in -next, but practically speaking I don't think it
will make a difference in the end.

[1/1] KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated
      https://github.com/kvm-x86/linux/commit/920d6bb77d55

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
