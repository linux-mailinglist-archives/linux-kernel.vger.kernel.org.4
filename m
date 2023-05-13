Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51970131A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjEMAgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbjEMAgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:36:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9771455B7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55d9a9d19c9so154145457b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683938172; x=1686530172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XwIKHmmTJOUjvBBd2bP49EQ+CK24vBc6gAU6yUFfBBk=;
        b=ohttiLZpsPQ1r/sX8xxAl1twyVbCEqfRJ26GYnVK8hVZm7MK2GYEdF7ZA6KfDLoze0
         VbYx6XFNk1SS/fEqkJkTP+VVyjK0YnME2kR0EdngMXsub3zdq12IiUR9ARdG/yRIws37
         LfEjvabKiZQTFXLjNUKqSrTbDAINtLC0ylCNPiTI8bFwrLHzCB6gZm71eFcafVgYHQrh
         gV7/XUuGvowhA85sxAVxosReNVhIX1TZgTfGH7u3CwEH1CkV9y/ZgfeKuskmtH8catj9
         MbQiDX9sRdYTt+vys8ERmAvfiTqwtP41K4yYSq9PzQudo1zgo6YZnCt+7el6TsF8Goe2
         UUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683938172; x=1686530172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwIKHmmTJOUjvBBd2bP49EQ+CK24vBc6gAU6yUFfBBk=;
        b=TjLjq9kPRqknbS1lwyFBIdYs4tYxVk0uCWEKh1ek5U+rVUeJ2FXPMMAr167W09vShC
         9WPx+BcWT3vKdigNr+2Ln4BQUMgkn/V3LLBOZ/RGHdLR2y9md6LaNMgwU+PWmQri2DQN
         1sYOxJlfYsZap/iYx+lI5zv7tWUoYzt/MHjxdpyYy9sczwnER3Y1OW6CgZThroQaF5gY
         VdzvOp3C0YyQ9R56Ad77qMsN7GSfn0BliQW9DJ8wi7ZYC9vfzfYZbdoNSA2D0UuvVstG
         ra3Kp1j4xSIaz/uJhdtLwCESw9bKbBbmjZiwo2lSdtbTOmslPyIF7vzWyOSwbYHC96Lx
         Nrng==
X-Gm-Message-State: AC+VfDw/RfdQp3sjR5qCJ7+77YEJBvnBJsa3unHiH/YnKkDy948DZUXU
        SLKCpGjgliaEJRUO+l4PDbvTfSm+05s=
X-Google-Smtp-Source: ACHHUZ6ory0k/qFNjJuvZa2lN6LXysci1uDwM6JYHBj9iXnwBOWmSbi9qEBm6YL7pzYtMD+CEsW4NisJ8+M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af0e:0:b0:55a:5641:54be with SMTP id
 n14-20020a81af0e000000b0055a564154bemr16292331ywh.6.1683938171803; Fri, 12
 May 2023 17:36:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 17:35:35 -0700
In-Reply-To: <20230513003600.818142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230513003600.818142-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230513003600.818142-4-seanjc@google.com>
Subject: [PATCH v3 03/28] drm/i915/gvt: Verify hugepages are contiguous in
 physical address space
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

When shadowing a GTT entry with a 2M page, verify that the pfns are
contiguous, not just that the struct page pointers are contiguous.  The
memory map is virtual contiguous if "CONFIG_FLATMEM=y ||
CONFIG_SPARSEMEM_VMEMMAP=y", but not for "CONFIG_SPARSEMEM=y &&
CONFIG_SPARSEMEM_VMEMMAP=n", so theoretically KVMGT could encounter struct
pages that are virtually contiguous, but not physically contiguous.

In practice, this flaw is likely a non-issue as it would cause functional
problems iff a section isn't 2M aligned _and_ is directly adjacent to
another section with discontiguous pfns.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index de675d799c7d..429f0f993a13 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -161,7 +161,7 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 
 		if (npage == 0)
 			base_page = cur_page;
-		else if (base_page + npage != cur_page) {
+		else if (page_to_pfn(base_page) + npage != page_to_pfn(cur_page)) {
 			gvt_vgpu_err("The pages are not continuous\n");
 			ret = -EINVAL;
 			npage++;
-- 
2.40.1.606.ga4b1b128d6-goog

