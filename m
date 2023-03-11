Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7C6B56A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCKAZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCKAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:24:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C3111B2A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:47 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id bx9-20020a056a00428900b005f077bc6e5eso3615753pfb.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ESyGipRYk4Ln/Kp6qC+rdgnoNy41fSsqxhODjzs0Phg=;
        b=nrjkFrHs9nfahticnmpPuzM1CYGMtDvBGeJ80H++4AvdgBokB4ZvMSpboVXR6DnKwz
         rIrMxNOEpTJIbuDC451LiJD1sJD3A8vuRizVcYrS9DGK3p2ELkmjCt5Z04Ew7mYeQG99
         abO3WqdodG/z7VlBDvMGTwDpoYnVcdAyUjfitCfgT/YOhex7js+4OGHeNDmUtaacWeFR
         lakQe7TmqrZXF1uwepDOEl2OXS6bzVd4Nf2hJUarjHWDJiq3nKrS93ZACBW4D6ZXsdik
         ggHfLj17lKdB6jzVaXg1+OIqfai9+ixjDr2YJPEQHHKfDgh2ts89Xy1knXUupwP/3zLt
         MYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESyGipRYk4Ln/Kp6qC+rdgnoNy41fSsqxhODjzs0Phg=;
        b=Ci3cmvqgI81F6voOjgnoa0C3vaU9MCk+eTrmo+Pun+Zek/PonA6qyN3+ARgMOnZB6c
         xW94hepFcyZ8qp3451+T+ML52We6LxFEHahLg31ldRhLQfCNJH9PIvwEknOTEr6IbK9e
         sD5bI2CEnk2IVAXCmKSEYimXU4NcJvzbb8lzzAxbO4Beyh60H9abzlvIyJIGqt4Lip/s
         CVk1SIY4lX42tRtBWO8Mm08N0O+KtsxVkOaaIZWsnUYBpvKpkHixP1RRZkGILaNyeFFt
         /sMFF/Pz7hLTEnRZht27MedfKkQbrH6dUu10sxTFHwXSqEADa8rcpMQyW8H4LJvCpWHy
         PV3g==
X-Gm-Message-State: AO0yUKV3tpuHSvYAPGbmZW4PGRdY677l6x2qkAwZx98FVAxgA9MQa6E1
        1qq9Pdt/gNu6ddzl/IxYXPIgmPl+2Og=
X-Google-Smtp-Source: AK7set8ALguNt/xEXYjM2EKJOWmie4pyNNfYyh6xWvVQ0vhlbgx8Y3S01gp5F3vekW87OoBuxJLe6aI201U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1088:b0:237:6178:297d with SMTP id
 gj8-20020a17090b108800b002376178297dmr10196936pjb.2.1678494214249; Fri, 10
 Mar 2023 16:23:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:46 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-16-seanjc@google.com>
Subject: [PATCH v2 15/27] drm/i915/gvt: Don't bother removing write-protection
 on to-be-deleted slot
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

When handling a slot "flush", don't call back into KVM to drop write
protection for gfns in the slot.  Now that KVM rejects attempts to move
memory slots while KVMGT is attached, the only time a slot is "flushed"
is when it's being removed, i.e. the memslot and all its write-tracking
metadata is about to be deleted.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 292750dc819f..577712ea4893 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1644,14 +1644,8 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 
 	for (i = 0; i < slot->npages; i++) {
 		gfn = slot->base_gfn + i;
-		if (kvmgt_gfn_is_write_protected(info, gfn)) {
-			write_lock(&kvm->mmu_lock);
-			kvm_slot_page_track_remove_page(kvm, slot, gfn,
-						KVM_PAGE_TRACK_WRITE);
-			write_unlock(&kvm->mmu_lock);
-
+		if (kvmgt_gfn_is_write_protected(info, gfn))
 			kvmgt_protect_table_del(info, gfn);
-		}
 	}
 	mutex_unlock(&info->vgpu_lock);
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

