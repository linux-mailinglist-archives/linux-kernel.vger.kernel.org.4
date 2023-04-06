Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EB6D8D55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjDFCLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjDFCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:11:28 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850F6A52
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:11:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b8-20020a17090a488800b0023d1bf65c7eso10110712pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680747077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3lDPjhvFiBmDOPalF3zTKr7ivZUHMdU3+5uyp30dE=;
        b=c4yhP+kcITRix0pLhRDCVxeDdsbODPWLUNNHm6zQMthv1cGSbFQ0B920lnJmq/yrwY
         tcbSjR7i/tx6yNkWH23MrNqIiAoDeM90g+6gzC7vgDS3osKZ1V9uvkxSGaAiP9SggbBb
         D+3B0dCDfbINn8ZYoyXzRBobqDHEFmoXlt1Bj03Eg/13CeqOmIi4i94CbAc1RNJmH4+5
         levi5QuubBNxyT5dHckxJ/3ttFNevDBaTPBkyVZz05EJWwEZlIrRHCJR4ybO22zqsiN/
         srvIxLB1GacQMbLVoHZlFvcdA46YtSdf/B43KDhtBNuOMjH91jJCxJI/sz5DEXvsvVVm
         WYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3lDPjhvFiBmDOPalF3zTKr7ivZUHMdU3+5uyp30dE=;
        b=HvJb0DnwLOOXYCmip8x87M66QspAnIlb4Kx6FPLH3cdWJsOS7HtZXDVuuYU0R95Lbp
         iN79xqQDN40DU3MGhaqMe2Lq2RmyPLOjwVBj+i/6vmfVa/PxOjGm5JdybUknUmBuyUu0
         JxeUO75sdrqI7C1oUrs+h+COPcuI+SefEOuNEjOWdUkczUAWMELVUuaOLC6A6keEyHOa
         luH9MLP4C9eBCJVhHXvfiq9qBzovzq9MVUVJWCph5yME+Nj57G9OV+BnOkjEgXcl4ikK
         Z+xaBv9FxHyhH7m3j3A8nvxY7R+j/KiUy/8eg6SusNcjG5k3OjFDIbTs5UpsedJEYWri
         MMMg==
X-Gm-Message-State: AAQBX9eMyxKIr2pdDqAXocH3GUANjwYG0vK17bWBTqVQ2DZIljgdagN0
        BbEhqRIxWtA7pCr+R/hg3Wlmmp3fejQ=
X-Google-Smtp-Source: AKy350YQNoeyjuiw/AyREIM4++ZkWIFNChwNjKlAdjOablfO8xRFKpoF20bHqQMtXpbhoR0ERBFYKEgtH2g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8887:0:b0:62d:ccc4:2e03 with SMTP id
 z7-20020aa78887000000b0062dccc42e03mr4651560pfe.4.1680747076880; Wed, 05 Apr
 2023 19:11:16 -0700 (PDT)
Date:   Wed,  5 Apr 2023 19:11:06 -0700
In-Reply-To: <20230128001427.2548858-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230128001427.2548858-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <168073931597.699581.10258108748120088305.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs
 are available
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Weijiang <weijiang.yang@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 00:14:27 +0000, Sean Christopherson wrote:
> Disallow enabling LBR support if the CPU supports architectural LBRs.
> Traditional LBR support is absent on CPU models that have architectural
> LBRs, and KVM doesn't yet support arch LBRs, i.e. KVM will pass through
> non-existent MSRs if userspace enables LBRs for the guest.
> 
> 

Applied to kvm-x86 pmu, with a Fixes tag.

[1/1] KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are available
      https://github.com/kvm-x86/linux/commit/098f4c061ea1

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
