Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C8654A38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiLWA7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiLWA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451523056D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:16 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i4-20020a17090332c400b0018f82951826so2403418plr.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nnuDgdp4qEuIP+nl5eVB41E8zn+MCFzhd5zm41ZDAFc=;
        b=YL/Dz6cmVRO/+CzEBXHrCDLQqLAKHeq2+QFU2IONT+tFrm99UB/5FYjjcdkvqq3ewo
         QpxBRBxnwmtL4mBRKzeBJHLRBASTjqHF5AvagoSK6pkoZfgl/pdMQ8v4M9Sfu1gLTfx4
         XgSctJALtSXKQlewtYLNczl+53miK/q/PcvVleLhVFYNrmIr9D9D9BtOsqlDmv0UB5wq
         ZOlFE0cRCYfbe1i7DTTxis9EBnnwdY20o4ay1OAf/8kasmqbRyFeKvxCYj+xPRgP7GSh
         DeMr2HEwCrP9l216wxotZhmPNcMsTqUeS6Ad0RHtllfzAAILGuxSPZ3IxTu0EjqzznZ5
         jD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnuDgdp4qEuIP+nl5eVB41E8zn+MCFzhd5zm41ZDAFc=;
        b=d67qhPDF2kqcRqu/d2MNOuC1UvIgpkowcOKMuATw+cJE40JobNCpEjaayfWF+5nbZD
         Bez2W3P/k8gbPwbrYYVYRW0DZ28WbB2dXDMKUOoon8gXrXLUBKIWv7Vk9gtPeOvo0eEb
         Rbqk2/WM7oOR5QGhvD4z0l6hL8DbgTLHI6r0qwbZm40MTTXKWvDE3Hw6bqOSSMhNo2Ry
         5wuluZ+6V87YT48wNg5Wjz/veAKttAXp/Ogw5UODZKQKkdt+iX1wU8f+mDb/Bvi9HWYG
         a1XZkug5z8aWFx2q/5MJAlQWf4ZS3w3rrrBzaaWZVe/ePNEqg6jHi/9sNCzpVpPirtb0
         281w==
X-Gm-Message-State: AFqh2kqhqr2HegwzbI0UwQ6kB7gqnMNR10LGVgw3GGvtpJ6pVRAOH7uz
        6fTJfs1+pdnzILXIe+CyR5rRxw/FPDg=
X-Google-Smtp-Source: AMrXdXv5BPzxNVgTyJnuA1gVGcmsttgw3dWhco6HdLgdiG3VrS3xp8krh0HZY3Z/zi1ZITbwwOONH9mH6A8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7e8b:b0:189:b0a3:cf59 with SMTP id
 z11-20020a1709027e8b00b00189b0a3cf59mr601702pla.42.1671757088348; Thu, 22 Dec
 2022 16:58:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:26 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-15-seanjc@google.com>
Subject: [PATCH 14/27] drm/i915/gvt: Don't bother removing write-protection on
 to-be-deleted slot
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
index 5ff17a212107..3c59e7cd75d9 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1659,14 +1659,8 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 	mutex_lock(&info->gfn_lock);
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
 	mutex_unlock(&info->gfn_lock);
 }
-- 
2.39.0.314.g84b9a713c41-goog

