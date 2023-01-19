Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A606672DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjASAxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjASAx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:53:29 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203866CF6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:53:28 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 207so308231pfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IXbNGk1Rp6vnGeIjsEQdbEHN1GzpYSLEjRV6tcy+bQ=;
        b=Zf3fLJi8FPKT8KnWjF3HPu7sb9vd/WvxqweRrRZcEuhZi8YuehAvVILzCyWRn0IXLF
         qDWawspnY2X6cgysFRCzOALD89pEhJFH3cjxVHjDkdKjJaHnmKBsbVVFJlejnAng0IRN
         6b3j8ml8MvFvMSPQU4CsXQGioMWJFpJ6s36C8yDvQwGWrbWzL7AZXY7meFNHzh85uqrp
         M6cQ4SJ8tOpG135StIShjdsPFAS6YnA12z2R/IWSAFsX57a+oR2bBwbXC2/v2wb0USKr
         i6R+72TVUcBI3eXJ5cDm/7VJHpN3ZuY+QROGRHxpJcnoOb2UGWkj2t6l/sUjl1qbJJCZ
         ivdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IXbNGk1Rp6vnGeIjsEQdbEHN1GzpYSLEjRV6tcy+bQ=;
        b=SSMEXI7PwQ/sn3sJTLpOGinMQSgT3VygFaLYO3CtZDP8K1wxFh9fV1ferKFkua1vGa
         ktv4EH6695UUrlGwW+kZOHve9nchiOBnZtbz+sQGoe0kHH8AP6z/pZPX2aA95cF/w23y
         hWAShUpBW2xcZzQzyuFnEedNyqhiJ14oyraklfza4mlriMI/XvjcFgjwTj022YeXgTf+
         VpFUFS6RcNJGSui7Ha6ujZcTvYOQ+u7j/WK7cuJKm5TFVr71iOHe0zKYCE7o3miwnAk4
         gVYSsVxXcqqqxz25PS6Zs9+NsQvqiDFF71Tz73pBdIx9qTvEe8rG9edNwhGlsSZIF4AF
         w60A==
X-Gm-Message-State: AFqh2kry7tjz2NKQL7eRk2UR2fBWdu27uIhEARQRi2mg4ND/CpZRlgQs
        HRW945GUJRu7HLPOtlEzDMZq28W0CBiT5M6A2GZfntzu
X-Google-Smtp-Source: AMrXdXtD12rUxg+H7Qk3E+rQJGKE/0dGnsop8AXs6Yy4pXMszdyZPlttlZSIia78ig0tERbNQYFfXqbjZyg9lkfWUCw=
X-Received: by 2002:a63:5c7:0:b0:478:dfd4:fc2b with SMTP id
 190-20020a6305c7000000b00478dfd4fc2bmr899526pgf.234.1674089607879; Wed, 18
 Jan 2023 16:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20230105095848.6061-1-jiangshanlai@gmail.com>
In-Reply-To: <20230105095848.6061-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 19 Jan 2023 08:53:16 +0800
Message-ID: <CAJhGHyBgYW6JXN=4JcYiRZRv3hBq58aKs4OmDPA11gwfioeVgg@mail.gmail.com>
Subject: Re: [PATCH 0/7] kvm: x86/mmu: Share the same code to invalidate each
 vTLB entry
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 5:57 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> FNAME(invlpg) and FNAME(sync_page) invalidate vTLB entries but in
> slightly different methods.
>
> Make them use the same method and share the same code.
>
> Lai Jiangshan (7):
>   kvm: x86/mmu: Use KVM_MMU_ROOT_XXX for kvm_mmu_invalidate_gva()
>   kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in kvm_mmu_invpcid_gva()
>   kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in
>     nested_ept_invalidate_addr()
>   kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_page)
>   kvm: x86/mmu: Move the code out of FNAME(sync_page)'s loop body into
>     mmu.c
>   kvm: x86/mmu: Remove FNAME(invlpg)
>   kvm: x86/mmu: Remove @no_dirty_log from FNAME(prefetch_gpte)
>
>  arch/x86/include/asm/kvm_host.h |   7 +-
>  arch/x86/kvm/mmu/mmu.c          | 177 +++++++++++++++++----------
>  arch/x86/kvm/mmu/paging_tmpl.h  | 207 ++++++++------------------------
>  arch/x86/kvm/vmx/nested.c       |   5 +-
>  arch/x86/kvm/x86.c              |   2 +-
>  5 files changed, 176 insertions(+), 222 deletions(-)
>
> --
> 2.19.1.6.gb485710b
>

Hello

Ping.

Cheers,
Lai
