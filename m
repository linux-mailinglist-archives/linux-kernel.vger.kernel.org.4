Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B86B5695
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCKAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCKAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:42 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197A15DC94
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:27 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so3599145pfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl93qHhMLxKPHFQ6pWyH1Q53L+c+frE+R34SS4aDFMI=;
        b=A5bTxFpKv+szN66TzCvK19Ft/76A37Tb4WVt01WT+cWiPfjrtrU6V1LalIMKYB3vWj
         ahwkahPbFFRuYQ445gPRNRQVd2F+wQjsbyOSuuqsNtmiCkidRkFo5DFY21I9BaQKcean
         RIRti0nwCel+5OGumdPl+/xlnhiYx6omnIN/W6UtHdN4BNfSwvQ008OchTLboAurnPh/
         8pxe+MncULYhV5yvIt0yo+RdceNc/KoEmZbj/GQ7dhEloJRuBk3xjGAKj8+3Sz5SfLoD
         WY0JV5dsRGiY9Kztz2yk+BaVx5kLBKuomQBRTk504BCjSrzFojBQgcdgeD7GMaoJ27I4
         CgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl93qHhMLxKPHFQ6pWyH1Q53L+c+frE+R34SS4aDFMI=;
        b=5aoDKFyqEs8WmaMEcCN4Iokcm2A3cuv5FE0eOdRlnlvdjzG+GFFfPn/dZBjIxs7I3g
         b7FFefuurJeM+phXrF48p0isIyc6+sVwVFrHBzl0JDBvvzDc7gmgK7vVK/wERzO9bzq+
         BdfNrTKVy6X2cLJEr3cxllBiTgbZGsZVxRHje1m/EozoX9ksNWt6bV2ovNTIYLS9Sayx
         I1NHSlUZVqEl5z1jiHQsoZbTgrHsukj77J+fmdORmDhsssMLxhNB8F2/jiMzUzwL0Azw
         oOvUhwWkIuBPaSKV8qLlvv/uiZJbtT4QCdrqIDUmQVzrjZNd+abazM8NoDsNC4sQHTQ/
         paqA==
X-Gm-Message-State: AO0yUKUjAOv1ptQtBFh5CSzSsljjTi43BzzZMdIqQWgYB4FrBkImVO4f
        +Y4G0GHgW3p25oKaigrFxdQ0qHCQOiA=
X-Google-Smtp-Source: AK7set9uc4Nnn+1fAkc9FZ4r8kS5/jc1gb92nDxbeYrH4aHwDZMmi6LsPtfr9YZ5EHgtE1HMCGhKO3AiQbU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a3cc:b0:199:4a1b:c5f4 with SMTP id
 q12-20020a170902a3cc00b001994a1bc5f4mr10345631plb.2.1678494203093; Fri, 10
 Mar 2023 16:23:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:40 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-10-seanjc@google.com>
Subject: [PATCH v2 09/27] drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()
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

Drop intel_vgpu_reset_gtt() as it no longer has any callers.  In addition
to eliminating dead code, this eliminates the last possible scenario where
__kvmgt_protect_table_find() can be reached without holding vgpu_lock.
Requiring vgpu_lock to be held when calling __kvmgt_protect_table_find()
will allow a protecting the gfn hash with vgpu_lock without too much fuss.

No functional change intended.

Fixes: ba25d977571e ("drm/i915/gvt: Do not destroy ppgtt_mm during vGPU D3->D0.")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 18 ------------------
 drivers/gpu/drm/i915/gvt/gtt.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index e60bcce241f8..293bb2292021 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2845,24 +2845,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old)
 	ggtt_invalidate(gvt->gt);
 }
 
-/**
- * intel_vgpu_reset_gtt - reset the all GTT related status
- * @vgpu: a vGPU
- *
- * This function is called from vfio core to reset reset all
- * GTT related status, including GGTT, PPGTT, scratch page.
- *
- */
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu)
-{
-	/* Shadow pages are only created when there is no page
-	 * table tracking data, so remove page tracking data after
-	 * removing the shadow pages.
-	 */
-	intel_vgpu_destroy_all_ppgtt_mm(vgpu);
-	intel_vgpu_reset_ggtt(vgpu, true);
-}
-
 /**
  * intel_gvt_restore_ggtt - restore all vGPU's ggtt entries
  * @gvt: intel gvt device
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index a3b0f59ec8bd..4cb183e06e95 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -224,7 +224,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old);
 void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu);
 
 int intel_gvt_init_gtt(struct intel_gvt *gvt);
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu);
 void intel_gvt_clean_gtt(struct intel_gvt *gvt);
 
 struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
-- 
2.40.0.rc1.284.g88254d51c5-goog

