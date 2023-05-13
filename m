Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BEC701323
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbjEMAg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbjEMAgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:36:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFD5FCD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so13055678276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938175; x=1686530175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bws/OjWeywvM9XkLtSpHOYJ+ALa04I5zAABYQaubhUE=;
        b=2nK84DtH7omdb7lgN90xeHzmaSrYcT1rO5f/Jmgj+Dv+zaVTUQfWKOjbL4BOhWtkOH
         CphCTTunIGNQIxuE3yQ2akHe/1RH76qxPs6uXyStOp8VMHUkHauNlfxC5o5QJkgjGNZX
         VE0x7PQn9vR51EdpRjP3q312V9jMDcwrBozE6gq5to2f2TMIcI2+jGpwh8SVNdO/jT1I
         Ueje6zg7QEiBe2RJ0mo7uqdWXz+87j9Yl989iyAL5mT032xiSRUFwOyWkjgsZxB9dTjP
         7MkO4YuqPEwMFjmSSiu9igcaZ/+IMY85RpkB88NskeeCtT+NtikPvSF5EeCr7kfnC2UF
         GF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938175; x=1686530175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bws/OjWeywvM9XkLtSpHOYJ+ALa04I5zAABYQaubhUE=;
        b=hqPZwRslNyKOCrkk6NpnrnddkoS1p32y2xV+wHs2s3oiRltX7npfrv8P7FScatBax/
         Ab8TX5BHT8LD/9N9NDRl3ES4pocp6wujVWirmg191P1U/R3wtQyjTyTKlImTO8QaOgkI
         /9KB63YG7Tp3Q2TbX5oJlLYfnwRWkPG6Yh1Be135hJ1uAKfn/r2eU81q4MN8GrL0+3W9
         tnkktIJ9yxsP4NLWL06zM3g5CzffgO8IRt1hDWtQlcdE4KcualAgaMYPZJop9iCR7MtA
         KklQ0EFR6UApDgFt5MKWSVr6op36Ejz2wvKuyyvOqAuiUXRdZz0g25ob7LfxjWoqV5w8
         1oPw==
X-Gm-Message-State: AC+VfDwspDHVEdGgdROQc9THR9B16TbpW+VyHkgpQXfUUgtHNeTrWOKR
        Fg32gJBWYed6Xt4JxP7UKhUZ55WxwfM=
X-Google-Smtp-Source: ACHHUZ4K09KxXj/DOOYSy7/m5VtpOi/JikwvVDfoLnnXWJCoYBtEIIsBAZMRE15JnhV2Yyt2NzyHcgNL0lY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:11c9:b0:b9d:ed0f:b9db with SMTP id
 n9-20020a05690211c900b00b9ded0fb9dbmr16402286ybu.6.1683938175412; Fri, 12 May
 2023 17:36:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:37 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-6-seanjc@google.com>
Subject: [PATCH v3 05/28] drm/i915/gvt: Explicitly check that vGPU is attached
 before shadowing
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check that a vGPU is attacked from is_2MB_gtt_possible() to its
sole caller, ppgtt_populate_shadow_entry().  All of the paths in
ppgtt_populate_shadow_entry() eventually check for attachment by way of
intel_gvt_dma_map_guest_page(), but explicitly checking can avoid
unnecessary work and will make it more obvious that a future cleanup of
is_2MB_gtt_possible() isn't introducing a bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 5426a27c1b71..2aed31b497c9 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1163,8 +1163,6 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
 
-	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
-		return -EINVAL;
 	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
@@ -1277,6 +1275,9 @@ static int ppgtt_populate_shadow_entry(struct intel_vgpu *vgpu,
 	if (!pte_ops->test_present(ge))
 		return 0;
 
+	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
+		return -EINVAL;
+
 	gfn = pte_ops->get_pfn(ge);
 
 	switch (ge->type) {
-- 
2.40.1.606.ga4b1b128d6-goog

