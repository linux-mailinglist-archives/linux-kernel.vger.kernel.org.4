Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6996C3D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCUWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCUWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:00:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059551FAB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id p5-20020a17090a428500b0023b4776f0daso5311458pjg.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=31NgJMjMJW7CSjSko12tKGd+dlWKG5Xzh4U0zIk6tlA=;
        b=IB2gAfwr5yVRY7nH94N+NGMOeubdkqvhLL7Aw102uL8KAUo4EtZIiSOzmdoqk82CCD
         nxlWAMimTDK1t+giIs+UirPjyczFnJ3CAiPrE/D+K8MHL7SC7B26jKcP3qqx10p3fO8V
         fRAoSR6Sg5DrSZ+Kcz6WIULBnY/hejORQBZtdeBFL12p8rRdBx6tGcNJMj7VB6Wwb0Vg
         jMuR5d/qEOCbfTdvb42J8Qp9ibkLbAXst4X62GFKQHjs9j+QPbqJDquuN+pioC7fPGcL
         EAQAaRcxquKF4+Q8bz9TXagJNG/fNQ1funnN0WRVuA1tpUjwmBdmS9q38Y+eTVLNJU0x
         qc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31NgJMjMJW7CSjSko12tKGd+dlWKG5Xzh4U0zIk6tlA=;
        b=lW1sgHj7CFyvOFTCnhLRRDpd+JKeHKsQ6Wp7ZcFBnqq+lHspv3KU3VQWSpsx4pS60R
         jqWRqbprH0Xp82RSbGZAMGqZrwyNFeKocsP+YaTssvLUH3Oab6ofgWia9KR29CKMD8Bb
         1CMH7RaZyfuVRINb/sekwpeiNDgO2dF0aJ2uKn+OBtG1fvaEcN+PN9v9fAtR/H7rpKgt
         wBLXXchEFm6w2nj0YBBMiZQpvizQw0uDvJ5A9lwACa+YGzQ/4FFzPvurklft2JYqphZV
         /8OlUgSi6xxqaNnP/TEZWB7SVL8nu8YHNtPb0SRkhQM4SNaoUCa2IMbm3nJlpFs8zD4M
         Vi6Q==
X-Gm-Message-State: AO0yUKUfTVoCtxSa0eicD9Ncy2B6Au+0BIAKmerXnYKNKGTUCKP/5Tsz
        tUmBHDmLGwtOSNM1DgDOQumpwbe7SJ4=
X-Google-Smtp-Source: AK7set/cErfnTfsBWKRiZ7VBh0P9I4swkYzrwUU8mgwuXWxpb/kt+IdT7jdftdLuXfHQs1bYWME89hZ5D6o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:724b:b0:19f:2164:9b3b with SMTP id
 c11-20020a170902724b00b0019f21649b3bmr232120pll.13.1679436032611; Tue, 21 Mar
 2023 15:00:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:13 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-6-seanjc@google.com>
Subject: [PATCH v4 05/13] KVM: x86/mmu: Drop access tracking checks when
 clearing TDP MMU dirty bits
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vipin Sharma <vipinsh@google.com>

Drop the unnecessary call to handle access-tracking changes when clearing
the dirty status of TDP MMU SPTEs.  Neither the Dirty bit nor the Writable
bit has any impact on the accessed state of a page, i.e. clearing only
the aforementioned bits doesn't make an accessed SPTE suddently not
accessed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a70cc1dae18a..950c5d23ecee 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1691,8 +1691,6 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		__handle_changed_spte(kvm, iter.as_id, iter.gfn, iter.old_spte,
 				      iter.old_spte & ~dbit, iter.level, false);
-		handle_changed_spte_acc_track(iter.old_spte, iter.old_spte & ~dbit,
-					      iter.level);
 	}
 
 	rcu_read_unlock();
-- 
2.40.0.rc2.332.ga46443480c-goog

