Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E512F5FE3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJMVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJMVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ADE192B9A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h19-20020a63e153000000b00434dfee8dbaso1575352pgk.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Js4rwjsW6iIwbX3VOZw+Ue+OSoWJ6FRkZ2WqW5Mnw=;
        b=YFtv89DAnR5aI0XcjusnNfre1iUUFeX+FG5+Sjlu+cBR5Br5DMTjfEA/fWvvSWjOe9
         qleW6wvYLwBC3TnG0PiE6Yfr9LOJ3zOOv5R+SwNTyFqmzegCCnRMDfuj5mSkgLqdvlpR
         tpFCZ8Efs75QDGh0h///oq7iGCXmgtWaNQ8D89JKktSH1uGHYgzs/UVYpXvydxyHSOEu
         ZVlyQnj2SYH+rrJo+dWEzzhs4F6Qq/Cq21G4tJPZaqAiELtteZgN4syVtkjWWyd78HTt
         dNQoMbkw+DdnCI070hDk6W8CEt9C2u2Vi63DbpALlIHoVJe8avwk/sBteEnAlNZRYADW
         Yn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+Js4rwjsW6iIwbX3VOZw+Ue+OSoWJ6FRkZ2WqW5Mnw=;
        b=cRC9qhsv0H61Q8aMIRmhhriBEtdLPtYrzLT5kBWqEoPAF6cFSm2n9bZZocc6WK+ZZT
         304NHBh72Wl00es76lroMDNPZNJDauuuJzzusyPnheo6Iqe9K43vNyj8+iVapzKSn5wN
         0S1s/AIhMOo2ZUbUoDgXOBCV+YzGUW4j2LJccEu7GzobXK7Cd71EiQh8b3JOZ72W/KA4
         ykQUcLX73eomUCqhofyKjy8LuYOD6Ihp0HGZCPM7L8I9prKM562vELJIQ4gyeADrk5p0
         HshZr9vn/2iilnptyZ+hFIu3jWS/T4vtZWpDMyXYR0+xp0Szgv084A8qKoBqphTG0Cak
         VMhw==
X-Gm-Message-State: ACrzQf2xc9oj4N3ogRrG/I7DIsemSV45udl/gDIXkCA6yftL4Y1cfs9M
        0e0gBesO4S++ZTrHPmwYycE0g0Qjr9M=
X-Google-Smtp-Source: AMsMyM5/5YVpY1nzSJShOOKrI1737xNVhS5agX9dO3x+QhWK710GBWxc0llMNoRwpiNUHSrBafMZJCqHfaQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d990:b0:20d:9c20:90c with SMTP id
 d16-20020a17090ad99000b0020d9c20090cmr1895243pjv.203.1665695567569; Thu, 13
 Oct 2022 14:12:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Oct 2022 21:12:23 +0000
In-Reply-To: <20221013211234.1318131-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221013211234.1318131-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013211234.1318131-6-seanjc@google.com>
Subject: [PATCH v2 05/16] KVM: x86: Remove unused argument in gpc_unmap_khva()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
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

From: Michal Luczaj <mhal@rbox.co>

Remove the unused @kvm argument from gpc_unmap_khva().

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 23180f1d9c1c..32ccf168361b 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -98,7 +98,7 @@ bool kvm_gpc_check(struct kvm *kvm, struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_gpc_check);
 
-static void gpc_unmap_khva(struct kvm *kvm, kvm_pfn_t pfn, void *khva)
+static void gpc_unmap_khva(kvm_pfn_t pfn, void *khva)
 {
 	/* Unmap the old pfn/page if it was mapped before. */
 	if (!is_error_noslot_pfn(pfn) && khva) {
@@ -177,7 +177,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)
 			 * the existing mapping and didn't create a new one.
 			 */
 			if (new_khva != old_khva)
-				gpc_unmap_khva(kvm, new_pfn, new_khva);
+				gpc_unmap_khva(new_pfn, new_khva);
 
 			kvm_release_pfn_clean(new_pfn);
 
@@ -324,7 +324,7 @@ int kvm_gpc_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	mutex_unlock(&gpc->refresh_lock);
 
 	if (unmap_old)
-		gpc_unmap_khva(kvm, old_pfn, old_khva);
+		gpc_unmap_khva(old_pfn, old_khva);
 
 	return ret;
 }
@@ -353,7 +353,7 @@ void kvm_gpc_unmap(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)
 	write_unlock_irq(&gpc->lock);
 	mutex_unlock(&gpc->refresh_lock);
 
-	gpc_unmap_khva(kvm, old_pfn, old_khva);
+	gpc_unmap_khva(old_pfn, old_khva);
 }
 EXPORT_SYMBOL_GPL(kvm_gpc_unmap);
 
-- 
2.38.0.413.g74048e4d9e-goog

