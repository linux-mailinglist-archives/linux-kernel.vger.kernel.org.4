Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF6654A53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiLWBBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiLWA7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:52 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4526AD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso1900829pgc.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V8FAaAl0J9ffNWKaCLz4W642o24GOa7DnL8QonYcD98=;
        b=UzY0yUdAsSHqxmLxd4OyL4bxAdzwhGWK25Flfzl+3CSyBx4kwIJVNG/QqI/lEoiQWG
         1g9CTW0KbQfl4yxxYHicB7tZpBJS3+JDxVpagsj6ZvSPwtPG7I219mwfhejfgHJIY5TU
         vhuuyqRnoPGDIUURZgXyzgqXqjifZseZVKmtqXslCUeBPewP7CXDFYMObhbBt/jkxuZx
         9Q6fteMKITvfLQMXDCAl86dwX4NbXVPgBasUaJ4v7EfcPQCx9XXhZgIOGvdcj1OIJzZb
         ayyWomna9itTTfDShpmkFAtofYY7bdQoOXkARSJzHVtMPUYKFspGFs2sIEHpHx62vnLB
         Yj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8FAaAl0J9ffNWKaCLz4W642o24GOa7DnL8QonYcD98=;
        b=7qlpmNJ18I/HEd6ObG21u4w2T3eWinu8sEfgoEPjt5BZYa0DpGPsBOKp+keyo6m6Fq
         Nye00V++UBqup9O3PXwvVpxMEmm+Qa/A0cxf8j2MMpPligo5PlVjs/XgtChVlpV6PFWf
         w+P781qv3j0VKAg+k/EMhsPw67CL8gtcdp3UKh/AA2Z3/7PM7Nw5U9/JxXhPQ4V8yntX
         5MkeXGmCl/sWU3S/+bRlvmV2F1QDHCtdP5DOn/limQiTPaUEOhqEoF4Hi4dOFEm59Zsz
         CSiyFqxfKJAX4eGSLmUHddfFA1uu6wQkyGHHBTsplj4+H0B7x10pQZmSFq6oBzFtH5iN
         9W/w==
X-Gm-Message-State: AFqh2krbCS6DvZli82OtJe8cKZGygKB776mPGdlKthntsst0TUX9MdfY
        Xz6fNdiLzwb4hJy5miKvhLuO02hvkLQ=
X-Google-Smtp-Source: AMrXdXvFMAtq9aBAxQUI4uknZz6s0YjI8T1zwMJn1E+HEm5yUiOyL4AXuzXTzJ1SS2mW/rs793etyELbCXo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d83:b0:220:1f03:129b with SMTP id
 oj3-20020a17090b4d8300b002201f03129bmr188159pjb.0.1671757111704; Thu, 22 Dec
 2022 16:58:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:39 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-28-seanjc@google.com>
Subject: [PATCH 27/27] drm/i915/gvt: Drop final dependencies on KVM internal details
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

Open code gpa_to_gfn() in kvmgt_page_track_write() and drop KVMGT's
dependency on kvm_host.h, i.e. include only on kvm_page_track.h.
KVMGT assumes "gfn == gpa >> PAGE_SHIFT" all over the place, including
a few lines below in the same function with the same gpa, i.e. there's
no reason to use KVM's helper for this one case.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gvt.h   | 3 ++-
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index fbfd7eafec14..4fb94b19ffde 100644
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
index e4227ac6ab58..a1647177d1c8 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1607,7 +1607,7 @@ static void kvmgt_page_track_write(gpa_t gpa, const u8 *val, int len,
 	mutex_lock(&info->vgpu_lock);
 	mutex_lock(&info->gfn_lock);
 
-	if (kvmgt_gfn_is_write_protected(info, gpa_to_gfn(gpa)))
+	if (kvmgt_gfn_is_write_protected(info, gpa >> PAGE_SHIFT))
 		intel_vgpu_page_track_handler(info, gpa,
 						     (void *)val, len);
 
-- 
2.39.0.314.g84b9a713c41-goog

