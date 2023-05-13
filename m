Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52266701374
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbjEMAjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbjEMAiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:38:25 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3BEE71A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5308f5d8ac9so1121426a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938213; x=1686530213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=txxFy4l/0CjWXE2Lls1C8TlXhZ8gDD/lHA0CcUxieGg=;
        b=1haVJ2yfzvTDJ7OWiHD70BYBmN550CeOMY4hpPZ+nSFvEJEzGlp9zifp2JC9DTsBnT
         RJZuYPoZBC56u7q5NVSap0DjOvLwxYApwLH9hRiHGYxDoZJvwxzHUiwRC9eia+w/uZP7
         EBybQwdiAWLVgS8BlsYrTOIiunclWLH+LI0gc9Tnj4BM3xt3lZRaMifAigMxY42RgfDp
         cwJG3qN9EWZwmkGrQazhnNhAbchLqLap871kMkvWtbxo/QXAGrSEZskw2tAXxrat7ud/
         D5ZrbarX8RzkvaRosayYzhljq+hKPOqhGf/8xnjwY+T70UILI2/0G0yJJiJRMoQtMPm0
         3+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938213; x=1686530213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txxFy4l/0CjWXE2Lls1C8TlXhZ8gDD/lHA0CcUxieGg=;
        b=arQ4RyV6qvGXYTUsSP1QTIoSxaAVOm4zmP8YPJuycuk+zSDgdy+832a9iKHVT4zStN
         1BSKkJW5FEKENoFP5QD/1yLdMVo/ah3D5aJIUOjXH4Jxbh/UVcDEbCsk7zVjGK0gn/kx
         kPSM/yb5vQQphFSSCHk13sVJdRRKqWy97OXHsJbv5xH/gHmhewvI3dEM1QEfHSSn5qLL
         NCo3Cl35G91a3DGOL80CXBnHWoOkz/gt3CclX5kPQAKcCxUSP8RK+aItYkD89lmJD1iv
         /zb6S9M+pYXECrgXW9Z65lC/21R4jfXAGROIu486FQYZcP1rMkxsKzByn82RnBtJqAUR
         msjw==
X-Gm-Message-State: AC+VfDzc0+/1pNNAuYn0sLWNvLmPzJ2dRI/WfHyO+HYA5TEZbny4htzM
        XnrvvBlz+kTnyoscWAp7jEVaHpk1qtk=
X-Google-Smtp-Source: ACHHUZ43CFxrthXwP0PrBV5od9hQAGg5BAA+rVUflMCCD1sy9tgjBk8pzYcx5eiJpCd5q4pFPenl/fUx+Qk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:148:b0:246:f99b:fd65 with SMTP id
 em8-20020a17090b014800b00246f99bfd65mr8121515pjb.5.1683938212995; Fri, 12 May
 2023 17:36:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:57 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-26-seanjc@google.com>
Subject: [PATCH v3 25/28] KVM: x86/mmu: Bug the VM if write-tracking is used
 but not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug the VM if something attempts to write-track a gfn, but write-tracking
isn't enabled.  The VM is doomed (and KVM has an egregious bug) if KVM or
KVMGT wants to shadow guest page tables but can't because write-tracking
isn't enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/page_track.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 29ae61f1e303..eedb5889d73e 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -90,7 +90,7 @@ void kvm_write_track_add_gfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
 			    srcu_read_lock_held(&kvm->srcu));
 
-	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
+	if (KVM_BUG_ON(!kvm_page_track_write_tracking_enabled(kvm), kvm))
 		return;
 
 	update_gfn_write_track(slot, gfn, 1);
@@ -122,7 +122,7 @@ void kvm_write_track_remove_gfn(struct kvm *kvm,
 	lockdep_assert_once(lockdep_is_held(&kvm->slots_lock) ||
 			    srcu_read_lock_held(&kvm->srcu));
 
-	if (WARN_ON(!kvm_page_track_write_tracking_enabled(kvm)))
+	if (KVM_BUG_ON(!kvm_page_track_write_tracking_enabled(kvm), kvm))
 		return;
 
 	update_gfn_write_track(slot, gfn, -1);
-- 
2.40.1.606.ga4b1b128d6-goog

