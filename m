Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55E6B5693
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCKAYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCKAXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904D5D450
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a6-20020a17090acb8600b0023797a1b2f7so2837619pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MQo4WmE7f97mSOHZkI3jr5btwmig+br9PEj++8GmA1Y=;
        b=bl3n2+O+/VcIrUul70a5c+psPIylTaKZidknn7ZUMJ1VKDYON2kZjsj+qY8mlUsf3H
         trT5CCOCqbqQzkNkr7qgSz7MW2T5nLyGwtnrq+dTu/4WboCT7gmBjgkcKB2lVQwxHML9
         P62aQv5xuNUt9STojA6Vr1mSxq8grcBmiGzmLRGU6MPnI6sz6t/Qh/JBg6pg+M6dEPLL
         TYko2KDQWHHz3Xs7yTY6tz4i2DxoK+UJdwG1yB6ish/k+gmiYui1QPheJvkZJuOzRuDw
         0h7vffFzjdPTnAg9LysYD0norRIil7HfS/4M4biE3kx7voJQNWrLPNM+Zdxyo5syMIlO
         6fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQo4WmE7f97mSOHZkI3jr5btwmig+br9PEj++8GmA1Y=;
        b=MvSpoRb7uHipT0C6wmlLaO8RlBeyRD79wxibomwB37f60J7THEc9Lf9K/cKr8pJ/uO
         F5Ah2gsYlCMAFOkEN7+mX1Tevos+t/ijTCKnah+UO5rWXP3TIWboDkaEZFXPtrY1SD9N
         AhU0IEgHfryg6HObuGFoKIjg+EAeLVm0SYFYV/IcwEPVs6Y5NQpj1s5XIv0Ugi3AiiYe
         yyVbdyoQLn7gg5/TaiV89SF9PiMPSdab0tZ4fGCjJCNPEcI6j/nz3/Ljp+A1roYT7VL6
         Mp/lxbh1wExK4CPl5DxXtFZbRi9P6aydFg9rRUSUzizCY4TLGhz2ktsFbcsNQU0DwDwm
         s7lw==
X-Gm-Message-State: AO0yUKVJpvVRwPjY5b7WyutVKS1XqBODFCYbPLLziV2PzBh16d/7IoCr
        0DPUpQMBILibtNsrOkpn9+Z0IZgO+Hc=
X-Google-Smtp-Source: AK7set+CIJ9m8jH9oNknQz7rK0QCgrymV+VOsddjSAaAVGPMq+29db0qr1UEOPNYnEU8mkEPVUrV1e/vI+o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4e04:b0:239:d0ab:a7c9 with SMTP id
 n4-20020a17090a4e0400b00239d0aba7c9mr9622929pjh.4.1678494201193; Fri, 10 Mar
 2023 16:23:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:39 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-9-seanjc@google.com>
Subject: [PATCH v2 08/27] drm/i915/gvt: Use an "unsigned long" to iterate over
 memslot gfns
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

Use an "unsigned long" instead of an "int" when iterating over the gfns
in a memslot.  The number of pages in the memslot is tracked as an
"unsigned long", e.g. KVMGT could theoretically break if a KVM memslot
larger than 16TiB were deleted (2^32 * 4KiB).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 90997cc385b4..68be66395598 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1634,7 +1634,7 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		struct kvm_page_track_notifier_node *node)
 {
-	int i;
+	unsigned long i;
 	gfn_t gfn;
 	struct intel_vgpu *info =
 		container_of(node, struct intel_vgpu, track_node);
-- 
2.40.0.rc1.284.g88254d51c5-goog

