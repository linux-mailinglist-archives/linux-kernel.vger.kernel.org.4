Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4F6C7355
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCWWvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCWWvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D043F2CC6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id pt5-20020a17090b3d0500b0023d3ffe542fso2466836pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679611896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQKo9HpZj3ZEv4kIrjCBob838arhh4bkeXrq4uWEKDo=;
        b=LNY/QzxbzbhyA9VmS9kiylWseefOzWJ9qsPVn7rINA7YwhtfLzrh6Sup2s9HzqfUSo
         4u88dHMQ4PSjnZAeaRilx1hRj/znb+o86P/TkL2p+BzCNbwIzhPhGmkIraJsutwCECHQ
         27+Ly3TJ8jbU03ffDHowXnUhqb5wzPqCfcTkzkjgoMECmBSwArn7f/cOapY6DmaEEsQe
         wiivMiOukrysbzpOWTVLtjhTYvsAzITxWsRtSWJGFiTq1RV/1m8MSeRmWnhMOJFqJH7I
         BtYeKZfTSK/xI+qiGMgwDsjRt/2JY92HxnZOgaLjmgk/qS9Dz85HTTCVDGGmFP9mx0pl
         KThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQKo9HpZj3ZEv4kIrjCBob838arhh4bkeXrq4uWEKDo=;
        b=xG62fPE+zxRBygbMzgPlxpHxiGohmD5kunSMlTBWwxbWRWxJC6ZLH6yC8YkD4WW9iV
         h6ATLi5Ip0rcP12NiGhBhBJ2L4bCA4e4HFxBNCx45+pJWywKrTbyN4TDbmKU22mr5E6T
         aZQaeh4Naa28wkrnCGJP6DWg7S8TsZatTNXd+SJJpjuiXq9TYRdDyHrj9hAbTmEKPTVZ
         xefzB5lsYODQtrHqqBtnm8eZ+j/hLzRLHSJl0mYTHJQHRzWwG3KBnDl7o2qW+n+4i/GN
         kuAncLF7jChWe1jjp66fYBPJvOt+RM64+iWDHvnH9PVns0RRDVNBuQtMQXzyadvR6UGu
         quRw==
X-Gm-Message-State: AAQBX9e7MsDtBkuiGBxL7QvYSaj0hR1ORftL4e6+q3/wIv+CDpJzMfjg
        Mx++CBRMGrIyGryoAfqqQmySkwYD/04=
X-Google-Smtp-Source: AKy350biacHclZnR/BQV5O2gN4h5yzyjyMmEX82IyWmLOcoi5b+AfSuce/MmgedjoZHNDsnfiShsJ5iLUZU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5141:b0:23d:50d0:4ba4 with SMTP id
 k1-20020a17090a514100b0023d50d04ba4mr213723pjm.3.1679611896176; Thu, 23 Mar
 2023 15:51:36 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:50:32 -0700
In-Reply-To: <20230216154115.710033-1-jiangshanlai@gmail.com>
Mime-Version: 1.0
References: <20230216154115.710033-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167934171585.1941509.10365014118525996265.b4-ty@google.com>
Subject: Re: [PATCH V3 00/14] kvm: x86/mmu: Share the same code to invalidate
 each vTLB entry
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

On Thu, 16 Feb 2023 23:41:06 +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> FNAME(invlpg) and FNAME(sync_page) invalidate vTLB entries but in
> slightly different methods.
> 
> Make them use the same method and share the same code.
> 
> [...]

Applied to kvm-x86 mmu, thanks!  Made a few tweaks, I'll respond to invididual
patches (if I haven't already; and if I forget, I apologize in advance).

[01/14] KVM: x86/mmu: Use 64-bit address to invalidate to fix a subtle bug
        https://github.com/kvm-x86/linux/commit/753b43c9d1b7
[02/14] kvm: x86/mmu: Move the check in FNAME(sync_page) as kvm_sync_page_check()
        https://github.com/kvm-x86/linux/commit/90e444702a7c
[03/14] kvm: x86/mmu: Check mmu->sync_page pointer in kvm_sync_page_check()
        https://github.com/kvm-x86/linux/commit/51dddf6c49b9
[04/14] kvm: x86/mmu: Set mmu->sync_page as NULL for direct paging
        https://github.com/kvm-x86/linux/commit/8ef228c20cae
[05/14] kvm: x86/mmu: Move the code out of FNAME(sync_page)'s loop body into mmu.c
        https://github.com/kvm-x86/linux/commit/c3c6c9fc5d24
[06/14] kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_spte)
        https://github.com/kvm-x86/linux/commit/e6722d9211b2
[07/14] KVM: x86/mmu: Sanity check input to kvm_mmu_free_roots()
        https://github.com/kvm-x86/linux/commit/f94db0c8b9fa
[08/14] kvm: x86/mmu: Use KVM_MMU_ROOT_XXX for kvm_mmu_invalidate_addr()
        https://github.com/kvm-x86/linux/commit/cd42853e9530
[09/14] kvm: x86/mmu: Use kvm_mmu_invalidate_addr() in kvm_mmu_invpcid_gva()
        https://github.com/kvm-x86/linux/commit/9ebc3f51da6f
[10/14] kvm: x86/mmu: Use kvm_mmu_invalidate_addr() in nested_ept_invalidate_addr()
        https://github.com/kvm-x86/linux/commit/2c86c444e275
[11/14] kvm: x86/mmu: Allow the roots to be invalid in FNAME(invlpg)
        https://github.com/kvm-x86/linux/commit/ed335278bd12
[12/14] kvm: x86/mmu: Remove FNAME(invlpg) and use FNAME(sync_spte) to update vTLB instead.
        https://github.com/kvm-x86/linux/commit/9fd4a4e3a3d9
[13/14] kvm: x86/mmu: Remove @no_dirty_log from FNAME(prefetch_gpte)
        https://github.com/kvm-x86/linux/commit/91ca7672dc73
[14/14] kvm: x86/mmu: Skip calling mmu->sync_spte() when the spte is 0
        https://github.com/kvm-x86/linux/commit/19ace7d6ca15

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
