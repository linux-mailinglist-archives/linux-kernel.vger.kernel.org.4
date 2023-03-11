Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6756B565A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCKAXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCKAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509EA13DCD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:08 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i7-20020a626d07000000b005d29737db06so3631960pfc.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5rhB2a1dGUQodXCAV1sLu8Trgm2geLJIaCstXFeDsp8=;
        b=GB1gArfoEAh+1WeCcjFVNp3vGLQPOrtMQm3umapPCUNXovRZEPAgcDRZpaYhW1tf9+
         CvhEy391fDyT2xqQ1g8qmuVWNBmP7UVJsFcL3mgm7RaKcql7bw7PdbrcK9UQnXnwem1r
         FU9LJcIGnJbh9gm9H/XJuz/Dq+mHbXKaD4dBo7vYXZwCIQctrdx+IoLOGg34exedOP+u
         2UIixuFO6RzJmTnpt07kkUCpmLTwmKqAgAU5/2WAo13OkxqmFkUmyMZjfrqgOFlBa7hO
         I1fwoI7LFYng69bDtaVnS5BZj1UDwY7V1Vyazsgnc4KzZhcVvFJZLbViqdtNYTuGxtqF
         FROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rhB2a1dGUQodXCAV1sLu8Trgm2geLJIaCstXFeDsp8=;
        b=i+lFpoHDLwAGQ0guA0dH8+mtFRHI2NqSwjeHG2vOEieU4CtNf2Ewj6WYGRuF9FmMZG
         5kai/X+5N/j5bl/nk6OwyjQ88uoIagMe3qUsYhkDVK2Q8ZqtisReb+zRTnhrpTvmmV5j
         ur9VwkixCNQM7vIhN5okYOIKmctqPGyDZbM3zDC4iHh6a8IPgSv4mSr1IvZXx1FNpuj/
         JvjIvAqrrkZKmQHcwoQXznPGfUhs0AuknWZdAG9fmj/gik3oMVOpLsPE/AXZDd2rV6fa
         t/ZhpUZNmp4Dp3msJaZ1YZuMZb25XXV5tVLYOio1VJ+QN4UhcW48SyRchexQnYDCxyYG
         Zhpw==
X-Gm-Message-State: AO0yUKVnuQzjsqU1LLyrJu24L02RNwr/yMKG2fOOSMq5Gt65ohCh5ash
        OhaLBMFnR6dYmqqkmZ25roP2GDuqsq4=
X-Google-Smtp-Source: AK7set9sw0CZVcFqZrfDflUkQTT1tENe6w88Dfa9HFRo7lMUTe6dGvFxBL08Vzw0chBY7MhZsiabz11wK80=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7556:0:b0:501:26b5:f43d with SMTP id
 f22-20020a637556000000b0050126b5f43dmr9777394pgn.0.1678494188381; Fri, 10 Mar
 2023 16:23:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:32 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-2-seanjc@google.com>
Subject: [PATCH v2 01/27] drm/i915/gvt: Verify pfn is "valid" before
 dereferencing "struct page"
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

Check that the pfn found by gfn_to_pfn() is actually backed by "struct
page" memory prior to retrieving and dereferencing the page.  KVM
supports backing guest memory with VM_PFNMAP, VM_IO, etc., and so
there is no guarantee the pfn returned by gfn_to_pfn() has an associated
"struct page".

Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 4ec85308379a..58b9b316ae46 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1183,6 +1183,10 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
+
+	if (!pfn_valid(pfn))
+		return -EINVAL;
+
 	return PageTransHuge(pfn_to_page(pfn));
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

