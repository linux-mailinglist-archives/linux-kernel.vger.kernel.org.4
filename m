Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2376C3D58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCUWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCUWBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:01:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF60591E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54196bfcd5fso164831407b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m01VVNtHv5a2CK3Ncdg5RaqOrgxf+NohQ23K4Xtg7Uw=;
        b=EZfbDVRwIoBx8cswvwhIDIwqFUYHYC6XCnbD20Tsx1OSz3sil1keddYVFHZ4PRh5/e
         Gudp/LPKWq9pdn+geXQkZg+/oYpzH551feiLqHH4Z9Fe0KgHstPhTA249VC1fJHQd0W8
         MrnZeveyaKWhgDZ/y2dJh6CzCZ2nDJJIO6Gr7hljgPcxHlnuA0tBdkFZkHk0CzUDx74Z
         JPeEnLmtnUD17XanmT2tGU1n0iUSzHx6I/YBjpbOGbBIKVQ2MqI3pc7MSrPzuWT1J2cT
         QDZF26YxhiYKldxhXENLBcM3ZJd/AJelJgUUN1ln7hkMXnXnKHRfCK2EgG75RJzSIOAZ
         Q55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m01VVNtHv5a2CK3Ncdg5RaqOrgxf+NohQ23K4Xtg7Uw=;
        b=hGei6jEoV+nWgBP6KpCUjP96c1aiErdh4aP4B3GdFupIsox3Db7cn4yUD4U9BOnRdz
         iijjulLYaevtWydS/rTvmAjFHUmHxmPXyt7wkP/JNFXPxIpxqiYG+Q8uNn5HQqOhSD5d
         P6K7z5mBcb6/CamZ4s2y50VuIuX2tHMLB2FksyWa50pCm8HOC3o2SfuxnntJJecw5Lp6
         Jnx1MtP+hLESvnHM1KTQHgYKRlENmb0KzdJvj9NjXBZ/TbAoM6288stGDHIlwqADRdXx
         9mLIdvm9LZVQgGC2DbJZjbq4H0z7lv2wNOVN++40/ZvM+ssBZUm2CRhW0SuBVi41e+Jf
         jvcg==
X-Gm-Message-State: AAQBX9fZKBl5GKx+HhWSBK/RTh+V3Hy1afDv/QmKIk8l+zk/OdBmwglj
        kGURrqpMhnwv7nS3NIkxEyjZhoG6Dk0=
X-Google-Smtp-Source: AKy350Z37plakpN/ldIsHVOhVv7kxZOn6TBL+Sf55vGyZqFCOF/7J3IVimc92fFhkKcm4JdKFzs7+2qlJr8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1881:b0:a06:538f:24b2 with SMTP id
 cj1-20020a056902188100b00a06538f24b2mr2291202ybb.2.1679436038986; Tue, 21 Mar
 2023 15:00:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:17 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-10-seanjc@google.com>
Subject: [PATCH v4 09/13] KVM: x86/mmu: Drop unnecessary dirty log checks when
 aging TDP MMU SPTEs
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

Drop the unnecessary call to handle dirty log updates when aging TDP MMU
SPTEs, as neither clearing the Accessed bit nor marking a SPTE for access
tracking can _set_ the Writable bit, i.e. can't trigger marking a gfn
dirty in its memslot.  The access tracking path can _clear_ the Writable
bit, e.g. if the XCHG races with fast_page_fault() and writes the stale
value without the Writable bit set, but clearing the Writable bit outside
of mmu_lock is not allowed, i.e. access tracking can't spuriously set the
Writable bit.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
[sean: split to separate patch, apply to dirty path, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index adbdfed287cc..29bb97ff266e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1277,8 +1277,6 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 
 	__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
 			      new_spte, iter->level, false);
-	handle_changed_spte_dirty_log(kvm, iter->as_id, iter->gfn,
-				      iter->old_spte, new_spte, iter->level);
 	return true;
 }
 
-- 
2.40.0.rc2.332.ga46443480c-goog

