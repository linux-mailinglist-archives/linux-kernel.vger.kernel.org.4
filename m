Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47D70137B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbjEMAjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbjEMAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:39:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A83106D9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso20741833276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938218; x=1686530218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kZXl2d46AVzuxVL4wEArY8+PLpXkOpan9Ss3n2LOe+w=;
        b=PJ5ujw7k63/285aFZkaQIW9C8AITUzrBCxCkRLS/LiTK9rN7s/xhYfAhELQh3Xc0Dp
         qwHgb9Q+rR7cr9mg0FC2zMKRANFPFRynMfwOlg6sMHOcrz01TJa1ozCj4rJ22fB5EanQ
         plr70rxThmIu9VPuBvntxszlIAqp7P9+Cb0RXR9VYF1Tfha3i51cp7E02H+pfNU7gjwH
         Qsu0+cJSYB4yfMq46ZR7bCp/XTq4ITg86KKOK42YezbsuXPb5UA04cUNk5Wy9d7M4J4Z
         I6JBX6bi0Ec5M9URC0LcHCdWva32fRIe1s1LV8JbP2g40yLwGpBkoH9gr5riwEj5E2wV
         iXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938218; x=1686530218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZXl2d46AVzuxVL4wEArY8+PLpXkOpan9Ss3n2LOe+w=;
        b=KgV0ydr3dtyZJggXkKERuMUuSgXRMV/Z6WF+OI8PEVBi6woE9Yhbe9+10AU8VPld9u
         uNhW+fpVmQ2zCitucmYWvI3du1QBSRk7tEL4oAdNO9G99DgfNst+AYrU9wJEaLG51vaW
         zjXTDYxLCIhE3GtvoD6d+0zPGxzWxL3Z/hFwAE8PgG6ADAt6K6lHJihgw1AjRdASLaKb
         BhKA5jzfcFdzo43npV8b8ewiwvaYXVSnZBuVy2Y2BBcpM6Irw4/gGa+hon+W+Sm/mnZk
         hnBmq6uDlaIdn0ecU0kltRoTC7W08yV5+Kwze5rKaPq/iYr0EcsF8BpwEIK5mHvoxCl3
         NhSA==
X-Gm-Message-State: AC+VfDzXV6mJJ11YtHgXL6QY4/e5+PFRwooZv4eenis3W0lK0yMB1F7l
        LJfc89TyGTsrQC9cD8lFj57eYOoOLw0=
X-Google-Smtp-Source: ACHHUZ5UUSJXsA68sfe6L609Rbep1n1mm8SDVeM7Zb2GXmQQSlQpMUrMf5Upl9tIWgk9JCqeiRH4Jn9I8yE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1283:0:b0:b8f:6b3b:8a0a with SMTP id
 125-20020a251283000000b00b8f6b3b8a0amr16018115ybs.6.1683938218722; Fri, 12
 May 2023 17:36:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:36:00 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-29-seanjc@google.com>
Subject: [PATCH v3 28/28] drm/i915/gvt: Drop final dependencies on KVM
 internal details
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

Open code gpa_to_gfn() in kvmgt_page_track_write() and drop KVMGT's
dependency on kvm_host.h, i.e. include only kvm_page_track.h.  KVMGT
assumes "gfn == gpa >> PAGE_SHIFT" all over the place, including a few
lines below in the same function with the same gpa, i.e. there's no
reason to use KVM's helper for this one case.

No functional change intended.

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gvt.h   | 3 ++-
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 2d65800d8e93..53a0a42a50db 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -34,10 +34,11 @@
 #define _GVT_H_
 
 #include <uapi/linux/pci_regs.h>
-#include <linux/kvm_host.h>
 #include <linux/vfio.h>
 #include <linux/mdev.h>
 
+#include <asm/kvm_page_track.h>
+
 #include "i915_drv.h"
 #include "intel_gvt.h"
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 597ffc9d12fd..191b4484cc7e 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1584,7 +1584,7 @@ static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
 
 	mutex_lock(&info->vgpu_lock);
 
-	if (kvmgt_gfn_is_write_protected(info, gpa_to_gfn(gpa)))
+	if (kvmgt_gfn_is_write_protected(info, gpa >> PAGE_SHIFT))
 		intel_vgpu_page_track_handler(info, gpa,
 						     (void *)val, len);
 
-- 
2.40.1.606.ga4b1b128d6-goog

