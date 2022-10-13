Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3F5FE405
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJMVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJMVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:42 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2019374F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:30 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q18-20020aa79832000000b00562d921e30aso1784665pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0wMVancUSCdQHm6xrhPLp8XHQC+Zfx0f39Z7/tw4F8=;
        b=FFpkcBRBwqGjxj/2Lpmkxa6nmJHRfRTkJpW/HdkN5dV56vwsisFFcKuCEj+zyvPIUN
         zbsnmso3/Zhfw4UCU8XmMyJxpZ+75WFMFFMg3MVqWCfm9cz3CYhKkTuFdXwfc70R8P2c
         2G1pnZFZmEpjNtMUldatsG0ALoHLtyh/xAd+i21jg8831ZyzvmLJld6tXHYg2Y1JmpPx
         RGR5YvjLX1ls8cG4ssSHfCxAPHC4iP6VRfVBrag3kWoH01c25sR59X0HfzCQqopGO5+j
         xvtnNaJhpA0E10sdWhUupebK+0P7ROqzAelJQhQG+eB38BRxvC6z5LwkHJmvFEyH+ab1
         AG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0wMVancUSCdQHm6xrhPLp8XHQC+Zfx0f39Z7/tw4F8=;
        b=wv/Xd+n6gkeKd4MMHLvn3duMTqFziie0fnFDFvKB8lePwfoAw51Srf/4aBhMYFK+mc
         1nH2wclGbN7PzZdukid55JhYC9e9g63IyNZvh+OgibX7X46e5Mzkhy69Xg+E5wMM/A96
         P4hziDiCi1VH4pFBsk6KKD9+BBhJWxBFujo0NJf+KqZOXch5r+qF0hSbIioJ7grspVDl
         ANp2o2oVpf3si5eNjkuigCPkW+tPr5aHTOl+Fc0uMl1vmyNymkiK4IlwIi2o7FunZBY7
         y8BAQaCdJtHUZSJ9dfCjeSwGtz4msCY8GA6XJq77KO6oAep/hhdMpXmh9jJDldtXKrxV
         +f1w==
X-Gm-Message-State: ACrzQf17N1Ukr4l1jdOo081Poc4TGM5jII7NXlVmPKybNmWIY8359CDw
        FjU4YMt4tHQtSjwQdHaGr9f/3pzCTc0=
X-Google-Smtp-Source: AMsMyM7BtIoFBOcy0PCnFfzJvpr6blOAVwNXcBS3RQH+M0TC6BP9D7fDhFf9cOn2kWZj8nqHBW8e53pMr5s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:868b:b0:185:be8:b316 with SMTP id
 g11-20020a170902868b00b001850be8b316mr1578925plo.157.1665695573969; Thu, 13
 Oct 2022 14:12:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Oct 2022 21:12:27 +0000
In-Reply-To: <20221013211234.1318131-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221013211234.1318131-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013211234.1318131-10-seanjc@google.com>
Subject: [PATCH v2 09/16] KVM: Clean up hva_to_pfn_retry()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Luczaj <mhal@rbox.co>

Make hva_to_pfn_retry() use kvm instance cached in gfn_to_pfn_cache.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 6fe76fb4d228..ef7ac1666847 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -138,7 +138,7 @@ static inline bool mmu_notifier_retry_cache(struct kvm =
*kvm, unsigned long mmu_s
 	return kvm->mmu_invalidate_seq !=3D mmu_seq;
 }
=20
-static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, struct gfn_to_pfn_cache=
 *gpc)
+static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
 	void *old_khva =3D gpc->khva - offset_in_page(gpc->khva);
@@ -158,7 +158,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, stru=
ct gfn_to_pfn_cache *gpc)
 	gpc->valid =3D false;
=20
 	do {
-		mmu_seq =3D kvm->mmu_invalidate_seq;
+		mmu_seq =3D gpc->kvm->mmu_invalidate_seq;
 		smp_rmb();
=20
 		write_unlock_irq(&gpc->lock);
@@ -216,7 +216,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, stru=
ct gfn_to_pfn_cache *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(kvm, mmu_seq));
+	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
=20
 	gpc->valid =3D true;
 	gpc->pfn =3D new_pfn;
@@ -293,7 +293,7 @@ int kvm_gpc_refresh(struct kvm *kvm, struct gfn_to_pfn_=
cache *gpc, gpa_t gpa)
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
 	if (!gpc->valid || old_uhva !=3D gpc->uhva) {
-		ret =3D hva_to_pfn_retry(kvm, gpc);
+		ret =3D hva_to_pfn_retry(gpc);
 	} else {
 		/* If the HVA=E2=86=92PFN mapping was already valid, don't unmap it. */
 		old_pfn =3D KVM_PFN_ERR_FAULT;
--=20
2.38.0.413.g74048e4d9e-goog

