Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAC654A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiLWA6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiLWA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:58:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034227CF8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-434eb7c6fa5so36826497b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv7Sq7HoBVZLuoe15+dVfh7DmwmErtwyqBsV25zTBHk=;
        b=dwSVlAZgWxSlftsojKgyDx43KpFpCJGRtc3IRFu3GmjsFZNeXwP+0HlSGWWwzg1wic
         Mm8K8eEYW2H1yntodiOGHv7lvnOm/1z24jmE/DoOEat/BXnpKDQetjSQ2e/jlISDndzn
         1nmJlnErn6cTNVPegHjYDWQB84MK9ay6ny7wDMYHPF2bxt/IRS4V3CpBw0hHNVnqSIPI
         AOuSn1InRMkW0W/W4Y6bnc9MzsuXj7+c1GJLKaVvotPIuTliO7YbpvONhosQQihMYApz
         5tjeLw12T/6UEC7CuL4oYzssc0CPUs+/hEDmPefuDbcWkak3eQWMtCmICA4OJuf63YKd
         I+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv7Sq7HoBVZLuoe15+dVfh7DmwmErtwyqBsV25zTBHk=;
        b=5u3kZBumqwOn0tP3N3p6ulHB4oo9uiaNcZyk9hj+XK7ki054RZBYqJYL5wnlr3zoao
         q+7tBfKCtQrgk9INLPv4KUMUftwI8fjFpc5XRGftv9tjRAn5jS/BBWESS56CAgRzumb7
         QEzjyQpCAJeKdODk1bTqbhMqTgg7IfcwHF7ORhdaX/Ysjn2mkMc45C6CpS4lde7jm/8F
         YwYZB3kWB5P7Ex2vsRmszFwvj8LyZnPhBVOW62ArUOct8XQHzwMrMiN7owDekLfnw23Q
         UCHrLHNP8OFDfsPqTn4Jw2NbAUFXSoBBoe8pfQSPtChcUBh4X4CnwISoIrp5N4JFk+GW
         NYug==
X-Gm-Message-State: AFqh2koJq75ITifEeKjT9PnfM0SLDS1WKYlpWnu0zLiLxZN7kjlF/oZH
        8mWlah9GOVnSK/4DzSvKfjT5MHQrvrk=
X-Google-Smtp-Source: AMrXdXstOrx3bUm5K/7Br+kFYpSxsgyLT1oZYQfRteln3A58NAAOzxF3mVNqbUjLF/5Fsax8WFKaA37+ZY8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9209:0:b0:756:3e38:765f with SMTP id
 b9-20020a259209000000b007563e38765fmr658755ybo.428.1671757078643; Thu, 22 Dec
 2022 16:57:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:20 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-9-seanjc@google.com>
Subject: [PATCH 08/27] drm/i915/gvt: Hoist acquisition of vgpu_lock out to kvmgt_page_track_write()
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

Host the acquisition of vgpu_lock from intel_vgpu_page_track_handler() out
to its sole caller, kvmgt_page_track_write().  An upcoming fix will add a
mutex to protect the gfn hash table that referenced by
kvmgt_gfn_is_write_protected(), i.e. kvmgt_page_track_write() will need to
acquire another lock.  Conceptually, the to-be-introduced gfn_lock has
finer granularity than vgpu_lock and so the lock order should ideally be
vgpu_lock => gfn_lock, e.g. to avoid potential lock inversion elsewhere in
KVMGT.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c      |  4 ++++
 drivers/gpu/drm/i915/gvt/page_track.c | 10 ++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 5d0e029d60d7..ca9926061cd8 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1626,9 +1626,13 @@ static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct intel_vgpu *info =
 		container_of(node, struct intel_vgpu, track_node);
 
+	mutex_lock(&info->vgpu_lock);
+
 	if (kvmgt_gfn_is_write_protected(info, gpa_to_gfn(gpa)))
 		intel_vgpu_page_track_handler(info, gpa,
 						     (void *)val, len);
+
+	mutex_unlock(&info->vgpu_lock);
 }
 
 static void kvmgt_page_track_flush_slot(struct kvm *kvm,
diff --git a/drivers/gpu/drm/i915/gvt/page_track.c b/drivers/gpu/drm/i915/gvt/page_track.c
index 3375b51c75f1..6d72d11914a5 100644
--- a/drivers/gpu/drm/i915/gvt/page_track.c
+++ b/drivers/gpu/drm/i915/gvt/page_track.c
@@ -162,13 +162,9 @@ int intel_vgpu_page_track_handler(struct intel_vgpu *vgpu, u64 gpa,
 	struct intel_vgpu_page_track *page_track;
 	int ret = 0;
 
-	mutex_lock(&vgpu->vgpu_lock);
-
 	page_track = intel_vgpu_find_page_track(vgpu, gpa >> PAGE_SHIFT);
-	if (!page_track) {
-		ret = -ENXIO;
-		goto out;
-	}
+	if (!page_track)
+		return -ENXIO;
 
 	if (unlikely(vgpu->failsafe)) {
 		/* Remove write protection to prevent furture traps. */
@@ -179,7 +175,5 @@ int intel_vgpu_page_track_handler(struct intel_vgpu *vgpu, u64 gpa,
 			gvt_err("guest page write error, gpa %llx\n", gpa);
 	}
 
-out:
-	mutex_unlock(&vgpu->vgpu_lock);
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

