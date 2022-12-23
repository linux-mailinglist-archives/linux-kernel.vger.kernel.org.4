Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B76549E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLWA5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiLWA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:57:48 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F720998
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o11-20020a17090a9f8b00b00225b041ba39so2302092pjp.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KwIE4ETZbha1iVHVnmmk26NjJzT7Ww98bDHeI8SzWEM=;
        b=VdmJ3vuW5hwx3kJCnM8faRJP7RuSvtbP2ikWNhpFTp9I9z0DVVcdJ0RfscWi+OoGoi
         MJ2G5H/yD95pjyp//Pb2jYl7A1gWkqRHGZf2J32KbjsKXqp3gU3YboP6KKuyiMaD/AAr
         Z4u1PblzAICguwGToRHR80qO4jWKIisB8zsX66tglczJgHgpnkX/z0MTFX/GN81elusD
         X4oC8eqWPYcYBtDK58vck3vcbZzBkrMVqKhuWer4YBW96UOB5yjMiHVT8pk1wkRZ8D6y
         IoBiiZe2OfEeW8J0ouvD8oVG1pVP9aTU5g6XrC5yWQaGBH6sOX3ntS60GO2VjtyS3ZB+
         hOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwIE4ETZbha1iVHVnmmk26NjJzT7Ww98bDHeI8SzWEM=;
        b=FyX4PRQkBNjDM+kkKQRfk2iB3E0ZPCu8dcRVVgLx3QOui+BBR1asKMHTcupCisO+iT
         rQrK9x3POxx9jyFGiaX2tdhMDLRpXtptRf0z01Mwk94LmA7j8QOiaHjBIAMKmCX1WDKI
         b02oXK2PIS+RFxI5STSPHMhWikWpvPOVhKPt2CMm06cQQhjjfwPMxVpoJxGWGN4oUs7W
         Fuo27+so5U3BTsBBoi+eCb/+5tqM9FF2ItsuxXzTjZgjD6ZNVLJh5dSOYeoJKfwVn6re
         Yws+WF3GDyBqPc/nt5ffUzjIEe/6Ld8gfF6lJVcOVUStJWVG7sFBgNG7QHbr5Jm+kEKK
         pe1A==
X-Gm-Message-State: AFqh2krCR998MuScZNd4TMZpqS3vmJKgXW+I4S0xfAdWfIa8mQpTFZPf
        VBJ0zXf+SJtL2tWq4p/LR9mw0AS+ZS0=
X-Google-Smtp-Source: AMrXdXtkgpf6dDrWJjo57M40NYNaWtKweyvUHpN66Us7oNs+QBzk+DEmGWx4z2DdCJIQiZm1KZ2ESd9jW+0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c217:b0:219:aa90:3198 with SMTP id
 e23-20020a17090ac21700b00219aa903198mr779140pjt.112.1671757067336; Thu, 22
 Dec 2022 16:57:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:13 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-2-seanjc@google.com>
Subject: [PATCH 01/27] drm/i915/gvt: Verify pfn is "valid" before
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
index ce0eb03709c3..d0fca53a3563 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1188,6 +1188,10 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
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
2.39.0.314.g84b9a713c41-goog

