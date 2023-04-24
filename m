Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E36CFF54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjC3I6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjC3I6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:58:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625983E8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:58:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso18907777pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680166709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DARmMfXxqHb2Ls37OggPINW15nuQ84yCV7KESHjLY2s=;
        b=OXoX2NCxtPATlq8jnBH3sThb7ycsR+0Oe6TcPImZJi9tCnRpIHfnfMjFvh2OLeHSO7
         M7F63PjkEBkJdxcACVhouJSazYLSPB0gy7jVYsu0xN+szgvXnNWoZ7Oh0kFFo4CWOLgC
         d+rHEFtEcJ4GCWJzO34ClqYb+5IULO9O4L5x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DARmMfXxqHb2Ls37OggPINW15nuQ84yCV7KESHjLY2s=;
        b=hAXdlrP7JemcxZ1ioJbxRq0yjRhi3XJMOR9lU2QErTfHiqTNHfw9YaItx5Uh32uE0S
         ASyTMvEldTcAElHQtq+6XKh90vDis+ix9/b5JdipcLkR6VW1jEB3p8RWtDL72062BKlK
         3BSXtHx1kG6u7Jc9FJ4tvxSVfRzXUICHmo3zA+AmPWRGEkDJ8hNKHsQL/OIDcWi0YsLK
         NC440GMzlxa2nHIbqw+luygGebqYRza4nkQ864Efq3v9GOScnP82FjqrvbjEMsgvTHBK
         iUEn972clgAva0mKd4jq/3c7qsLtW6/zX03xJD85EGcPtPqBIz4XFVCYGcDZIYOS3VkH
         nRRg==
X-Gm-Message-State: AAQBX9cdZ5QKFCYT+SgkvMhNZdx4RE7WUdbH4tYjGG3vthZOvBx/suvU
        Vjh4pjtljTZ7Dm2arfOshmemlw==
X-Google-Smtp-Source: AKy350YitOtGSTe/IC945dOZxknelnREFOYZr+go4eGipagCeEp7bTT+/hLXchLclFceYZl0IfvvWw==
X-Received: by 2002:a17:902:fb85:b0:19e:b088:5900 with SMTP id lg5-20020a170902fb8500b0019eb0885900mr19155304plb.38.1680166709092;
        Thu, 30 Mar 2023 01:58:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1320:eef8:d0bb:b161])
        by smtp.gmail.com with UTF8SMTPSA id s5-20020a63e805000000b00502f1256674sm23134697pgh.41.2023.03.30.01.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:58:28 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 4/4] KVM: mmu: remove over-aggressive warnings
Date:   Thu, 30 Mar 2023 17:58:02 +0900
Message-Id: <20230330085802.2414466-5-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230330085802.2414466-1-stevensd@google.com>
References: <20230330085802.2414466-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Remove two warnings that require ref counts for pages to be non-zero, as
mapped pfns from follow_pfn may not have an initialized ref count.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c | 10 ----------
 virt/kvm/kvm_main.c    |  5 ++---
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 86b74e7bccfa..46b3d6c0ff27 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -555,7 +555,6 @@ static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 	kvm_pfn_t pfn;
 	u64 old_spte = *sptep;
 	int level = sptep_to_sp(sptep)->role.level;
-	struct page *page;
 
 	if (!is_shadow_present_pte(old_spte) ||
 	    !spte_has_volatile_bits(old_spte))
@@ -570,15 +569,6 @@ static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 
 	pfn = spte_to_pfn(old_spte);
 
-	/*
-	 * KVM doesn't hold a reference to any pages mapped into the guest, and
-	 * instead uses the mmu_notifier to ensure that KVM unmaps any pages
-	 * before they are reclaimed.  Sanity check that, if the pfn is backed
-	 * by a refcounted page, the refcount is elevated.
-	 */
-	page = kvm_pfn_to_refcounted_page(pfn);
-	WARN_ON(page && !page_count(page));
-
 	if (is_accessed_spte(old_spte))
 		kvm_set_pfn_accessed(pfn);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 007dd984eeea..a80070cb04d7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -165,10 +165,9 @@ bool kvm_is_zone_device_page(struct page *page)
 	/*
 	 * The metadata used by is_zone_device_page() to determine whether or
 	 * not a page is ZONE_DEVICE is guaranteed to be valid if and only if
-	 * the device has been pinned, e.g. by get_user_pages().  WARN if the
-	 * page_count() is zero to help detect bad usage of this helper.
+	 * the device has been pinned, e.g. by get_user_pages().
 	 */
-	if (WARN_ON_ONCE(!page_count(page)))
+	if (!page_count(page))
 		return false;
 
 	return is_zone_device_page(page);
-- 
2.40.0.348.gf938b09366-goog

