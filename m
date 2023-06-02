Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796271F7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjFBBXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjFBBXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:23:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605F1B5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:22:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b03ae23cf7so6942325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668974; x=1688260974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXNA4frNVbyK/VK5UJk0y5hVGmAfJ3/L7mZMsF+Debs=;
        b=ffHjqiBjCvce6CRxC8S8V/5PV32SBNbNg5npnOcKnrbM7KDaCusjJvavHMNLekX7m3
         hpqylvq993mnGqaD6yNASSM0if2Mk7u1MQaseW+ZQFOapPY+CnxJK9TeSglfq1cGQDJJ
         JjQswBdBugf42sqOa3TmhOXSyNgLLOI3Zhi4U5IutBj00Os32FI1ec3393X4cE5w/wJ+
         L/MKchT59UEUxZjUtT1hxHVMzoZCB27maz/dxz92BkZHy8hCBw+dZRFeDM84caKxj3Ed
         Q57jSZQ0mYWrMMGJ47J6A/kugKSeRI772HmK501YBxbZ5HuNUxC1GOEDz6NBXdGx7WGU
         dZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668974; x=1688260974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXNA4frNVbyK/VK5UJk0y5hVGmAfJ3/L7mZMsF+Debs=;
        b=eEbxLDvJrzomLdSRUS31w0sGY4qjS4pZYoOVuLVIWuDP4/4ZANS98Th+qP0QxBCYy+
         gID6cCeFAAtzXGKfSpFKsoOqmOUCiw3PEAQluLnTuGjbDXhjrcoZBOmpYvRIof7XLuMv
         uPMnxedNPbZLiJsgXVXrhmkyi9LCYPgax26fc4pxSoBVS2URtUD30kZptcEfdPonZv0z
         Gj5V4LSyIOO8PhOq2shoGN0RQ3FdkypCal074+xmobbA/Fp53cWgKVpbZHI2QfDTaeUN
         jalA1qTwiwXzKU/oqFuzB4U0tb36cjoUHj3m0h5c3vtYHwu/KjosEjQQNkZN6Z6rm+5M
         ucPQ==
X-Gm-Message-State: AC+VfDw95nM0weYDYNq3aMaX16Y2/JCptwYefkctUbPq0OE7O83LNzxG
        ZBKa08Qh8bebj6nJd8JQ3MHIq0NhZjs=
X-Google-Smtp-Source: ACHHUZ5fFydB50dxXaixwlIMVmfg/hggqZdidYr06HqK8UF5xC8z/J8d4AkoSA3p89P0M9AQ0ra2P12dA1c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c6:b0:1ae:485e:d192 with SMTP id
 o6-20020a170902d4c600b001ae485ed192mr271922plg.8.1685668973984; Thu, 01 Jun
 2023 18:22:53 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:22:44 -0700
In-Reply-To: <20230523032947.60041-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230523032947.60041-1-likexu@tencent.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168512505582.2748967.2085008237309190510.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Assert on @mmu in the __kvm_mmu_invalidate_addr()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 11:29:47 +0800, Like Xu wrote:
> Add assertion to track that "mmu == vcpu->arch.mmu" is always true in the
> context of __kvm_mmu_invalidate_addr(). for_each_shadow_entry_using_root()
> and kvm_sync_spte() operate on vcpu->arch.mmu,  but the only reason that
> doesn't cause explosions is because handle_invept() frees roots instead of
> doing a manual invalidation.  As of now, there are no major roadblocks
> to switching INVEPT emulation over to use kvm_mmu_invalidate_addr().
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Assert on @mmu in the __kvm_mmu_invalidate_addr()
      https://github.com/kvm-x86/linux/commit/762b33eb90c9

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
