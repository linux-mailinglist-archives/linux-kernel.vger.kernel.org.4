Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0473701361
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbjEMAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbjEMAg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:36:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA7D8A69
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7766d220so13071423276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938196; x=1686530196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9ozwCpjHnKuZzXt2q5sOivdZFc4Nc1/ByY918eytKG8=;
        b=D9PGBYXz14YFqZyr7IaovRbgDiR6WTvi3zlRF2wwdcP+lzW1RfSJxQO8VTuiPcnxEM
         CqTHM2DXnYP5uIsznTvGnaln6DkLckevCJYMK8R5xVAYe7Ve8MWuYBwF7qU2pJ7x5bJ2
         CRKIfVxtWC6jP8UdqdKQbHUkXsag1bZanrjOwpVhT6xZYBGU3k5WoZP2fPkei9/38eGW
         yyfkF1CDlpWwIxUAYH6rvX28AYs+14C9GuWSgxLLOiczuTEko1ZHbXiJ2lsM9uaASBhD
         xMpec4KcBm5RcsTRAjtN6BzapbEqUqjwVe4DcS4kuDgcw19s1NGWMGBEMLpaOXWAk6cR
         zUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938196; x=1686530196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ozwCpjHnKuZzXt2q5sOivdZFc4Nc1/ByY918eytKG8=;
        b=XbDq0/igWXHHI63rd09X+kNcDSNj77tBenokKVHnmrcewUn9MmZkkNC1lIAj5l/FzH
         RFtxO23nFppxbina2d8cIp9dnEXYTKu02VFCO4UXugO5S22rNtTtwlkcySoah0u5mfgQ
         froJbhLnwzFK7d63CSaOXIC/TCWYRwTxDFVBSbiSJn3WPNQqiOmQQ6oxmL6vVRpXE+NG
         hvmkrgxzjFiAAekGrey/isNOY/pHE/F+pTRgkIFsK154SqtjXpOxRitO4f1juyb92CNt
         DNbSi9NRYSIi0Pc+9hndw7qELU61r8eLy1TYg9GQyLkwjJJWcaO3jmkFhPpvnJetQ66q
         KbaA==
X-Gm-Message-State: AC+VfDw5qsJ3BBZcBJ0hjgCz5Zjf03aoMvNe0Sl7KOYDn+jEtzOkR8/Z
        qwXnm/Q4Sr4HUBkYHKmrwzurquII1n4=
X-Google-Smtp-Source: ACHHUZ4TYtt7IPY3gV/SDUTNpHg0VKTyBm4IgdvOZZTxQSyFY/VZvBmxbUmZDydpyT7ilx8mpMjqlhAo3x8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5282:0:b0:ba6:3564:661a with SMTP id
 g124-20020a255282000000b00ba63564661amr7139261ybb.13.1683938196053; Fri, 12
 May 2023 17:36:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:48 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-17-seanjc@google.com>
Subject: [PATCH v3 16/28] drm/i915/gvt: Don't bother removing write-protection
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index aaebb44c139f..c309a77f495f 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1629,14 +1629,8 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 
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
2.40.1.606.ga4b1b128d6-goog

