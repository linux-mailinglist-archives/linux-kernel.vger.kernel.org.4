Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8A6549F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLWA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLWA54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:57:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641682250F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:54 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t16-20020aa79390000000b0057fd4bf27fbso1849784pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NBTVXhB5C1LBSgUVZgx9DDnSqNxpCLvQp+2Tt7daAzY=;
        b=PlfdJuINIz79VbNXj96aWe6+xyqOcNWgoFfBKXO69TEmccmX1942p1Kyzpar864asr
         XDLlrV4h/z3yt7ub3l4JawTQViMgB+vso07ZoO5qPG8HZ8ZwZ79n9sNsdI9q2RoIwbeG
         AbHqwyDWwx9IAhFNAoqcInUGxLMtyU01VX9lvM0rmbSOQgWKiNnfERh1rh/elzAovs+8
         3y70iyzOvz/NxL9S/TaVq/aBs6+nmTg/gOUzTp23eWU84817bdw4cPSr/sXHXzdSEx8S
         P4Mp5+sUcRqXpTl/uiqPGeug+OSUTglz8ISXwjwtbnXBQir9/d83nYa1sF0t6p/+TDh4
         ciOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBTVXhB5C1LBSgUVZgx9DDnSqNxpCLvQp+2Tt7daAzY=;
        b=aEWndq5wX2/7m3HU2cWNRwJhUXdxUtn0oKmRezOjiYtsqrky0DoCeLKUp1ZaOjbH1k
         jrYJ5xWZ4j6sRJc2Gm4PJEgR0rcYgkMOjXdezyMXfdJSEVrjLqMrBE+h76N61kfhoi94
         6mghMyH4biOQQ7gIHfys6MZh0G2k+w1j9I5s6GLeIEDYNNSoO8pRFhy5fQN/EN1EaQ9r
         /hZlGFf7WiTEOBuNcPxaty6gMUS94y3ghnOv0RjBDvcbU9CcQ46x+eRSSVJJO6VAMxLJ
         n6I6qwcKktxQ90h0+aCPLlHdxERoJqSit7CcwoKNshrRbd0aesbsi98f1nUISYLUmR5Y
         Iyyw==
X-Gm-Message-State: AFqh2kpgiddd3OfnRtQJORgw479d20weYWIcNuKWpGSfKIzh4TOpjROD
        rjr3yY8N8JYsyOy8RjWyssrW2/jc1J0=
X-Google-Smtp-Source: AMrXdXtuJpzQAA6YsAARKoo86Ndko68Bw/8PzP0Po4HgPrkiwdi87VkArdRLlydeD02n3c8sF2p0uUxApik=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c155:b0:189:9a71:109b with SMTP id
 21-20020a170902c15500b001899a71109bmr561626plj.171.1671757073922; Thu, 22 Dec
 2022 16:57:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:17 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-6-seanjc@google.com>
Subject: [PATCH 05/27] drm/i915/gvt: Put the page reference obtained by KVM's gfn_to_pfn()
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
index 6736d7bd94ea..9936f8bd19af 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1181,6 +1181,7 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	unsigned long gfn = ops->get_pfn(entry);
 	kvm_pfn_t pfn;
 	int max_level;
+	int ret;
 
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
@@ -1200,7 +1201,9 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	if (!pfn_valid(pfn))
 		return -EINVAL;
 
-	return PageTransHuge(pfn_to_page(pfn));
+	ret = PageTransHuge(pfn_to_page(pfn));
+	kvm_release_pfn_clean(pfn);
+	return ret;
 }
 
 static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
-- 
2.39.0.314.g84b9a713c41-goog

