Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2170EA22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbjEXAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbjEXAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:15:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C438FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:15:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8338f20bdso408955276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684887353; x=1687479353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3Ei1WsPfm2Hux/Q1LRXJnHLklVga1WAMQvUGJxh54M=;
        b=GuJuPO1fHWpYBq0IegjDxU7i2PDrHifCbc6UzKN9oK8SeKbGW13LY8iBOefEqcUN9T
         LW/RdfXTvTw3Juimg1YUW+SI2yODcw/kmUGZtr3ANPf0iFhwE2kFH86Jn0FPKpvwe8TW
         4gi4gDkr9yLLGOAt49/UxoBuSOc5gj9Z4IaQmskvEfp2LB1PVvjbqIDPLPeXATfbVdPF
         rHEuq6gpPl5POMDswIy5tu2Nj3yinLRUyFFnLMFnGWCKhKe2E/zGislCS+qTOfi3obum
         9yJtVlvMkRZl7r1p1yXxS+iuFg3+n4NIc2mD/o5QYxhp57WhjJg3HyP9UygbIPHQsY0p
         wehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887353; x=1687479353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3Ei1WsPfm2Hux/Q1LRXJnHLklVga1WAMQvUGJxh54M=;
        b=aNKRpA0XZMM5sPu1bCGhGWhe/Xd0K5RlH70k4E9uUiVGONZFpK+MQk+9R/fJBK0hAd
         0oUZC7DNNwp3VktIm6Cqn44BHxpDeFIZ6Mf3XMPOcc43oZgwwQXNt3GT0AF4vg2taS4z
         eJPOy/y3+aCIaQDgNmrD8FdARmsbXD9/uvVQQpn6V4zWWOLybHjX52fAlqZkNC1Si2xF
         CXAvgIBT9V9QMrMRmoRMqZgsgbltPzwLqB7AI00YSCqqoX43PhAsa4Fln/t96C0cxj5b
         6XwIo8PSUZJeC0MghgjmHlsXUTSVfKgo1yLwmEul5Lyw2dmBsm2WB8zHmybXa6Uq9PBH
         R2Zw==
X-Gm-Message-State: AC+VfDy4/442Hr5uzbVoAvNS+lkbh+UBOwWqmiNtR26k/7JltwFhGcoG
        l2RneD+MEGNXfNI0U6rukHRU6HE63+w=
X-Google-Smtp-Source: ACHHUZ5+ZqmN9qXIv2YP0zRnN2CY9UdjFotfELZMEk+iCUjSF4s4rHPqxARNg+z81Jvqj32TeGV3cm3HLa4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b127:0:b0:b96:7676:db4a with SMTP id
 g39-20020a25b127000000b00b967676db4amr9654331ybj.0.1684887353658; Tue, 23 May
 2023 17:15:53 -0700 (PDT)
Date:   Tue, 23 May 2023 17:15:52 -0700
In-Reply-To: <20230509134825.1523-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230509134825.1523-1-yan.y.zhao@intel.com>
Message-ID: <ZG1XOHBKZbxNEjQK@google.com>
Subject: Re: [PATCH v2 0/6] KVM: x86/mmu: refine memtype related mmu zap
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023, Yan Zhao wrote:
> This series refines mmu zap caused by EPT memory type update.
> Yan Zhao (6):
>   KVM: x86/mmu: add a new mmu zap helper to indicate memtype changes
>   KVM: x86/mmu: only zap EPT when guest CR0_CD changes
>   KVM: x86/mmu: only zap EPT when guest MTRR changes
>   KVM: x86/mmu: Zap all EPT leaf entries according noncoherent DMA count
>   KVM: x86: Keep a per-VM MTRR state
>   KVM: x86/mmu: use per-VM based MTRR for EPT
> 
>  arch/x86/include/asm/kvm_host.h |   3 +
>  arch/x86/kvm/mmu.h              |   1 +
>  arch/x86/kvm/mmu/mmu.c          |  18 ++++-
>  arch/x86/kvm/mtrr.c             | 112 +++++++++++++++++++++++++-------
>  arch/x86/kvm/vmx/vmx.c          |   2 +-
>  arch/x86/kvm/x86.c              |  10 ++-
>  arch/x86/kvm/x86.h              |   6 +-
>  7 files changed, 122 insertions(+), 30 deletions(-)
> 
> 
> base-commit: 5c291b93e5d665380dbecc6944973583f9565ee5
> -- 

To save us both a bit of pain, can you base the next version on top of my PAT
cleanup[*]?  I am planning on applying that series "soon".  Thanks!

[*] https://lore.kernel.org/all/20230511233351.635053-1-seanjc@google.com 
