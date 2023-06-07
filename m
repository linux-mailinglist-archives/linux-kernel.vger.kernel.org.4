Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CC72515A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbjFGBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbjFGBCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:02:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23210FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:02:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb05f0e6ef9so10181338276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686099736; x=1688691736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JyEnJxnIYsauq/wSH1IM7vfFjE0o1hylh2ce6s6Y23k=;
        b=C/OMltvMIzfjvYtFziX8yWQNaRTGcBJ8pVtIQ97zHN8U1eAsZnzA7+xtl1uFr6bcSa
         AlL4dV//ptBOZZgYGa/KVmR17MrH8C+nPizWoZsE+bs/EaM5JpuDF3oSpgQDlcpKbwd1
         SGHkw+XbxcKpxnuQElcNWiiuY6b2zMNU+b5jVpILaG07IUR+wgFU6gTm/dnbSW2FwvCr
         stTjkNBflDFmeZz2nfMUQq4cAEIB2T3NlUC7VNqhDkC5vuLQEWo+NH6BD1BnaWrsOarJ
         4OPyBlbTbvStZkPaFIkuP9E+K9D0Kflm2Vn17/PwsrbO1xC7AZhwKpwbJFqQNEVnd2c8
         oIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686099736; x=1688691736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyEnJxnIYsauq/wSH1IM7vfFjE0o1hylh2ce6s6Y23k=;
        b=CLHnf2wVHjW+/5VHO7IlTI+PWjCppWtedQu3rIpnIjqQ/jbavzcfRPvL+TDM8SHXDv
         +WUgH/IG0JirNPCl3NKlYkOLrdBfLU455GGlNaQph6qDlUXyxf4P91FHkkEUQBplsw2G
         lKYNBv6g9ERE2H37LSayz1CLuebFZq3uJylu+K04/nrsFIlN64uv5RqYJvIipDNpcC+L
         xcaFrZAoem3XfBmt28mnK+IqHndx6QySeULp9UVsbcbcWheTAW4B3nf+36z9m0x+L8wP
         x3xjuhNdvgdfo8cSnf+JTlzGisi3b7RJH5cgnOBAc30V5do+k65ad0F866tF7aY3kRvb
         V5yw==
X-Gm-Message-State: AC+VfDzCOv6NoebH81KF9EYZoRAj9Wvx+7nkeaFHRtdpfjg/w9uThSDL
        Z3EYcGpRznoQJRstbVErnf6z0eWWcUU=
X-Google-Smtp-Source: ACHHUZ4MvXrHaFNari3YZ+IxskSB2J2fPXHKEZ3qPZEIMqZzn+iGLDZkHtk/iquHC25eZxEh9NBJzHGxLwc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1882:b0:ba8:95dd:3ccb with SMTP id
 cj2-20020a056902188200b00ba895dd3ccbmr2093612ybb.5.1686099736605; Tue, 06 Jun
 2023 18:02:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  6 Jun 2023 18:02:06 -0700
In-Reply-To: <20230607010206.1425277-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607010206.1425277-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607010206.1425277-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: x86/pmu: Move .hw_event_available() check out of PMC
 filter helper
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to kvm_x86_pmu.hw_event_available(), which has nothing to
with the userspace PMU filter, out of check_pmu_event_filter() and into
its sole caller pmc_event_is_allowed().  pmc_event_is_allowed() didn't
exist when commit 7aadaa988c5e ("KVM: x86/pmu: Drop amd_event_mapping[]
in the KVM context"), so presumably the motivation for invoking
.hw_event_available() from check_pmu_event_filter() was to avoid having
to add multiple call sites.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 1690d41c1830..2a32dc6aa3f7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -387,9 +387,6 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 	struct kvm_x86_pmu_event_filter *filter;
 	struct kvm *kvm = pmc->vcpu->kvm;
 
-	if (!static_call(kvm_x86_pmu_hw_event_available)(pmc))
-		return false;
-
 	filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
 	if (!filter)
 		return true;
@@ -403,6 +400,7 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
 {
 	return pmc_is_globally_enabled(pmc) && pmc_speculative_in_use(pmc) &&
+	       static_call(kvm_x86_pmu_hw_event_available)(pmc) &&
 	       check_pmu_event_filter(pmc);
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

