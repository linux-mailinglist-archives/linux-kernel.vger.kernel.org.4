Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880256B5685
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCKAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCKAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E342E0D7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l10-20020a17090a598a00b0023b28afea55so470083pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QHerbQhjH53h/ZHwU5QVI9hxX7GhCGiNGgQsrmW50t4=;
        b=UOOoJWfUcA7GC/99pLDncOCYw/ZSKy8cgsGXbxX58KzT3NzGZc7wH8lCmf0oAQfpKq
         hjcxQRGgLkPGKlCawvxwrkvukATCRtgPYnMbqSBD5uscgj39B0vmTkhnvMgcmdk9NbiB
         K64ViJd4ne0EYEYjfGG5d6kPwirzxEw5lqcOzrUdA91bj/3z7WW2O16cfG50mdYHyi+F
         8belCrRQbBfaK2WzD/PQejUgzYcU2vR3vMegxSCF5ZB4v6jnYTOpdFATSuu9h0apkhxu
         Icms8xYjSzdS9QnEO7gSP/EblQydpusmTx4NQaAaKuJOjwYY/5w93+mXKPJyeqcneA5b
         krDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHerbQhjH53h/ZHwU5QVI9hxX7GhCGiNGgQsrmW50t4=;
        b=nIL1sUBsxhlgo6m1XY5qBdCSk7cmELin26/0WvdFyAorp9YZqaOh81gPlIIaWv0KL/
         e2cJcTaVIRIwn1dNEXwBpEF1ugGOGLWDF1Bl8dPe8VpZFlDcfw3OVygff2jcTWsR5E+i
         hlQgGn0gUKa7CzTtqSp2rMEVvHu9l2atVk70QLCfFs2P8gYn2P/T3h01pmQjXwVjXhEp
         SRTr8BffdFn/5IuohSlEMINj8YK9s4YX54cnqNd+txx3KWKdar7KPFPM4Mw3aRvc/YG4
         Rpay1UPp3p4NA7InfBbdGAeuieitkPk7FudaHBxJJDWMcJuXo8jOgNYwKosqIcNaVsby
         KUgA==
X-Gm-Message-State: AO0yUKU4Fvi2Bn6rGME5raVkqUNScMhWgoXNiA8AOJnMfptwdOIMTDhp
        8mFO/iInEAqSpKJFbv1B7Ccf8Ztct/Y=
X-Google-Smtp-Source: AK7set+gdgZfxdjSIjTd5RQzPMMLwiEtm11ePUcERkI8TTwlF9ygfQgPOwzIK/GJCHY+nwoJewM4Elogmg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef8b:b0:19b:370:f7b3 with SMTP id
 iz11-20020a170902ef8b00b0019b0370f7b3mr10076584plb.6.1678494197458; Fri, 10
 Mar 2023 16:23:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:37 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-7-seanjc@google.com>
Subject: [PATCH v2 06/27] drm/i915/gvt: Put the page reference obtained by
 KVM's gfn_to_pfn()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the struct page reference acquired by gfn_to_pfn(), KVM's API is that
the caller is ultimately responsible for dropping any reference.

Note, kvm_release_pfn_clean() ensures the pfn is actually a refcounted
struct page before trying to put any references.

Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index d59c7ab9d224..15848b041a0d 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1160,6 +1160,7 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	unsigned long gfn = ops->get_pfn(entry);
 	kvm_pfn_t pfn;
 	int max_level;
+	int ret;
 
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
@@ -1179,7 +1180,9 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	if (!pfn_valid(pfn))
 		return -EINVAL;
 
-	return PageTransHuge(pfn_to_page(pfn));
+	ret = PageTransHuge(pfn_to_page(pfn));
+	kvm_release_pfn_clean(pfn);
+	return ret;
 }
 
 static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
-- 
2.40.0.rc1.284.g88254d51c5-goog

