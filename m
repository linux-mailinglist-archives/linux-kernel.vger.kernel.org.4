Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA46B567C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCKAXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCKAXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:37 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420E2B298
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:16 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id lm13-20020a170903298d00b0019a8c8a13dfso3628831plb.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r49XytvkzC3ENPPvGwyC5xpl4Ljg2/LRKUh4AJANr14=;
        b=Zpt7qqXUP9P3hTZayirZMVkamUEUKqACeon7oYYD97xhyXG29DKFvc2SehXuaMK1eh
         96bAuuC0sdckifi7A5x5BvHjSYp6n5kOQFXB0UoJB1YbHPV06dxE1l1SqnXubOFXmRsK
         Z85nrGTBFlhudy7NMByKLTHcgoIlcwlw77krq/LeeXJrbT4i1RgCaCjiipszhzOC68N1
         Wqgm7NqjACHAxcRBAe/V0X19VDezwBvGmMGY2dfPUEgvNyjcfSdH8o9zcchvrm2jY66q
         QaFVvRsnIfOiGjSgjPR+aPpZh8DNkEiAG84TgnZaQn3CnSP9MOVs0GtZw+JsxOyoPRG9
         pjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r49XytvkzC3ENPPvGwyC5xpl4Ljg2/LRKUh4AJANr14=;
        b=CDBJ4G3tSTaN08bjosI7pC1eQLWPYX0iPI9lNcWdkMeUI1Dm+ryIEoINtJgdNeWvwt
         NInhWa6pfXgt77jQHTjNZenhuFVHQyv55q11qtn+MBV7uMrOsLgatbXXwG/S0g0PGL62
         uhBHL/uQ8S7cLb3j6WUsKLQtRfOiv067kPwx/yO0gQs+hO/kLc4E2B08SL+uflV/mKPO
         4SpK8CpRFjDOh4fF5EGDabeYoyt5Ft7JGR6+0TQ+9/5tONW5y2EKDLNcsAIv24KZRpvb
         HVwWCJBtVlM2Dao07uT0ve09/TeP9VI5cJLKf+TdVonqI6ldKbIURXv7equKA+5xfW7R
         1SsQ==
X-Gm-Message-State: AO0yUKWlBLXtjJh+KKhR3vABtBjF/EYaoUffHRq2FMjYLxIpIzPyRbpz
        RsPve3sAa7EpXro+fb+P3FGlVOI7/cI=
X-Google-Smtp-Source: AK7set8lYctWIEVQhZKOHEthwTGecs0QEL8AybuNs+im1tcttQnv6WGZC5mS7H7PWE7VWu3+BvN7S4Enjn8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7bc6:b0:22c:2048:794e with SMTP id
 d6-20020a17090a7bc600b0022c2048794emr10002028pjl.7.1678494195444; Fri, 10 Mar
 2023 16:23:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:36 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-6-seanjc@google.com>
Subject: [PATCH v2 05/27] drm/i915/gvt: Verify VFIO-pinned page is THP when
 shadowing 2M gtt entry
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shadowing a GTT entry with a 2M page, explicitly verify that the
first page pinned by VFIO is a transparent hugepage instead of assuming
that page observed by is_2MB_gtt_possible() is the same page pinned by
vfio_pin_pages().  E.g. if userspace is doing something funky with the
guest's memslots, or if the page is demoted between is_2MB_gtt_possible()
and vfio_pin_pages().

This is more of a performance optimization than a bug fix as the check
for contiguous struct pages should guard against incorrect mapping (even
though assuming struct pages are virtually contiguous is wrong).

The real motivation for explicitly checking for a transparent hugepage
after pinning is that it will reduce the risk of introducing a bug in a
future fix for a page refcount leak (KVMGT doesn't put the reference
acquired by gfn_to_pfn()), and eventually will allow KVMGT to stop using
KVM's gfn_to_pfn() altogether.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 8ae7039b3683..90997cc385b4 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -159,11 +159,25 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 			goto err;
 		}
 
-		if (npage == 0)
-			base_page = cur_page;
+		if (npage == 0) {
+			/*
+			 * Bail immediately to avoid unnecessary pinning when
+			 * trying to shadow a 2M page and the host page isn't
+			 * a transparent hugepage.
+			 *
+			 * TODO: support other type hugepages, e.g. HugeTLB.
+			 */
+			if (size == I915_GTT_PAGE_SIZE_2M &&
+			    !PageTransHuge(cur_page))
+				ret = -EIO;
+			else
+				base_page = cur_page;
+		}
 		else if (base_page + npage != cur_page) {
 			gvt_vgpu_err("The pages are not continuous\n");
 			ret = -EINVAL;
+		}
+		if (ret < 0) {
 			npage++;
 			goto err;
 		}
-- 
2.40.0.rc1.284.g88254d51c5-goog

