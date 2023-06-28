Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441DA741C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjF1XCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF1XCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:02:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1E10FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:02:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd6df68105cso39888276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687993326; x=1690585326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TgcRnMBiwytN42C20IsBvP22VrxLJ1BowisshxmO+E=;
        b=0Pnqr0+OxjfhybkHDCWXt/R4e/vT7iFG9b+zcv1f2L9pYdEvM2HfQPW508gqD+8rsJ
         D6XTT6f9HW2Gmolpss4op8XCBMOADvjf2wVJM2OpSIZE9pwMZYRGjBj/OkptZoo3GDph
         yvy4jpc9WO96GXO9kZj5HA7+p7e4vsK5N6Wc6O2oSz9BGdKGlYLUFxTJlmcn2RJFSJxV
         j0vtkH2+DHACzyfR5FL7HnIxGu+4xqqO1SvqQn9Y+MO1uPpUIcgnqwlw7ugIRB3/mT90
         zvLyUuSrFUxOKJVe2V7AyuqZqM1l326mgiR2R5wivVl0C24vVxNYDdg/4NdL3vg+rUI/
         RQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687993326; x=1690585326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TgcRnMBiwytN42C20IsBvP22VrxLJ1BowisshxmO+E=;
        b=RrmCrqzS7ub5mIiBgdGmyhuCMnblff/lKawxo2WMZDS/MJ1GVNEhu0cwyAhRMc52yF
         nDUyh8cbgcSO9eae4LFOAYdomHQubiRskxyl4LrKPD1CjlB8Y7CyKSEl3gjHpmoYX0Ua
         oDSghrwlbqNTHrl30XQetsdGTqbKjZ1yRbTdMueLemz4fjsUsvd0c3Ek94ma/4/0CVWq
         q+OudoErw/3urio7GXsVkxv5Hgo4UjwNkt26TuKobjw5lAodTmwjfxtWKwoV4wzQOGoY
         IKyfSb7E6Hbm7Gr8jhVr9TrShDzyS7OEpdj5JRT7l2qznQJujsKeH3IH3VY0QuZI4bd4
         /BAw==
X-Gm-Message-State: AC+VfDwxnNbipxPyLRjXI8JhL0BDr+TkV3dV01VQUygLFmS+nQVZ8jnu
        z7ISD2o4qhnxiMpGIdkxTYyM+U7dyrU=
X-Google-Smtp-Source: ACHHUZ43FYck2+67Wxaifcydlv7WfsEjEVVURxxAG9hOCQhssyWJFqBKBpR68fBHRIKK5hbttoYNn90kaZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18c4:b0:c1c:e037:136c with SMTP id
 ck4-20020a05690218c400b00c1ce037136cmr5724775ybb.0.1687993326647; Wed, 28 Jun
 2023 16:02:06 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:02:05 -0700
In-Reply-To: <20230616023101.7019-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230616023101.7019-1-yan.y.zhao@intel.com>
Message-ID: <ZJy77R5dQE3uFymG@google.com>
Subject: Re: [PATCH v3 00/11] KVM: x86/mmu: refine memtype related mmu zap
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Yan Zhao wrote:
> This series refines mmu zap caused by EPT memory type update when guest
> MTRRs are honored.

...

> Yan Zhao (11):
>   KVM: x86/mmu: helpers to return if KVM honors guest MTRRs
>   KVM: x86/mmu: Use KVM honors guest MTRRs helper in
>     kvm_tdp_page_fault()
>   KVM: x86/mmu: Use KVM honors guest MTRRs helper when CR0.CD toggles
>   KVM: x86/mmu: Use KVM honors guest MTRRs helper when update mtrr
>   KVM: x86/mmu: zap KVM TDP when noncoherent DMA assignment starts/stops
>   KVM: x86/mmu: move TDP zaps from guest MTRRs update to CR0.CD toggling
>   KVM: VMX: drop IPAT in memtype when CD=1 for
>     KVM_X86_QUIRK_CD_NW_CLEARED
>   KVM: x86: move vmx code to get EPT memtype when CR0.CD=1 to x86 common
>     code
>   KVM: x86/mmu: serialize vCPUs to zap gfn when guest MTRRs are honored
>   KVM: x86/mmu: fine-grained gfn zap when guest MTRRs are honored
>   KVM: x86/mmu: split a single gfn zap range when guest MTRRs are
>     honored

I got through the easy patches, I'll circle back for the last few patches in a
few weeks (probably 3+ weeks at this point).
