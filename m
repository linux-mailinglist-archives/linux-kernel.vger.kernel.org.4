Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF66B720C5D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjFBXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjFBXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:33:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D33197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:33:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-653843401feso403718b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685748784; x=1688340784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=88IydSMT3h4MdgZedrdgoEtngKl/WmRfHDWOuNscQw8=;
        b=pEHPhuEb5kqwcEzdnoMQsduQWHqF7mPaSb55QalrwPyEi4aqtMLBsI8lMdOzk8bJKV
         WDeRHKXRdGpS6xsiuoo4O7Cu2xAsE21ZUGRyIiltQDgh/Kt5tmuyES0sSKqyvpDnFTJv
         lEyURT5JQMY+5XDQ3LFqFDSHlrtmVPLIzKc0OZqGne0xIpGtM12fj0Zv8IAvfzSYzcg0
         9Uab/x8qPHEQwXy0xZ35ltGuBhs3jxiRuf9yksdXIuXUGST6F9S9c/JH7mdNAr2Dc6FK
         j/zBAvloqpza0OavffT0JC29z5mjr/x4plcVZ2Y+jA0MGVFPeA5WLLzulVNa037P9FkG
         my3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685748784; x=1688340784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88IydSMT3h4MdgZedrdgoEtngKl/WmRfHDWOuNscQw8=;
        b=P4kRvwNvtcIXi7CdkM8AUPYRzPi1ocDj0fD/Z6VWBXFw2dXct0qsXUnteg7i+7I5PJ
         mNKwvuAOJtgjLH1OeUIjOMWcGGVUbpZ7pcNBvbALkLoY03L4f4sizwz4Dz7mL4TISMoq
         xxymzU0+UBK2UUYASOqmxukZ5w/GEkhl8Q2CtrF2hBU5Ebz8BtiIiVDWeckFCS3cyjhp
         VwOrWvU+gpz2nzobcjUBRFx3eGTeleDHDVHV7HX9sOasVWtp2h/sSmeu3Vjt6lrbdCNz
         WN9LX1xIJv5dc1ibI5zQFqGH92qeuZcWehCgNRhcjlfD1qaZF6ZRoo8AseaeBPbLY2tN
         iFew==
X-Gm-Message-State: AC+VfDzkL4yIDqRd4p0CPDVD3qSAE4GwV3EMAjMb8yYaRMetkyWQvDJJ
        XS9bfDolES4hAW00Yb1MJl8A4QjRUXE=
X-Google-Smtp-Source: ACHHUZ7vfJ8zCT20X9/IDVE+rN7mR0ic3gV08hpng76/5pSSylpcXLraoJZN3YaFhwOSc1g/rHyzyPnzIek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e24:b0:64d:2cb0:c60c with SMTP id
 fc36-20020a056a002e2400b0064d2cb0c60cmr5046418pfb.5.1685748784040; Fri, 02
 Jun 2023 16:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 16:32:48 -0700
In-Reply-To: <20230602233250.1014316-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602233250.1014316-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602233250.1014316-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: x86: Bail from kvm_recalculate_phys_map() if
 x2APIC ID is out-of-bounds
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
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

Bail from kvm_recalculate_phys_map() and disable the optimized map if the
target vCPU's x2APIC ID is out-of-bounds, i.e. if the vCPU was added
and/or enabled its local APIC after the map was allocated.  This fixes an
out-of-bounds access bug in the !x2apic_format path where KVM would write
beyond the end of phys_map.

Check the x2APIC ID regardless of whether or not x2APIC is enabled,
as KVM's hardcodes x2APIC ID to be the vCPU ID, i.e. it can't change, and
the map allocation in kvm_recalculate_apic_map() doesn't check for x2APIC
being enabled, i.e. the check won't get false postivies.

Note, this also affects the x2apic_format path, which previously just
ignored the "x2apic_id > new->max_apic_id" case.  That too is arguably a
bug fix, as ignoring the vCPU meant that KVM would not send interrupts to
the vCPU until the next map recalculation.  In practice, that "bug" is
likely benign as a newly present vCPU/APIC would immediately trigger a
recalc.  But, there's no functional downside to disabling the map, and
a future patch will gracefully handle the -E2BIG case by retrying instead
of simply disabling the optimized map.

Opportunistically add a sanity check on the xAPIC ID size, along with a
comment explaining why the xAPIC ID is guaranteed to be "good".

Reported-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e542cf285b51..3c300a196bdf 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -228,6 +228,23 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 	u32 xapic_id = kvm_xapic_id(apic);
 	u32 physical_id;
 
+	/*
+	 * For simplicity, KVM always allocates enough space for all possible
+	 * xAPIC IDs.  Yell, but don't kill the VM, as KVM can continue on
+	 * without the optimized map.
+	 */
+	if (WARN_ON_ONCE(xapic_id > new->max_apic_id))
+		return -EINVAL;
+
+	/*
+	 * Bail if a vCPU was added and/or enabled its APIC between allocating
+	 * the map and doing the actual calculations for the map.  Note, KVM
+	 * hardcodes the x2APIC ID to vcpu_id, i.e. there's no TOCTOU bug if
+	 * the compiler decides to reload x2apic_id after this check.
+	 */
+	if (x2apic_id > new->max_apic_id)
+		return -E2BIG;
+
 	/*
 	 * Deliberately truncate the vCPU ID when detecting a mismatched APIC
 	 * ID to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a
@@ -253,8 +270,7 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 	 */
 	if (vcpu->kvm->arch.x2apic_format) {
 		/* See also kvm_apic_match_physical_addr(). */
-		if ((apic_x2apic_mode(apic) || x2apic_id > 0xff) &&
-			x2apic_id <= new->max_apic_id)
+		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
 			new->phys_map[x2apic_id] = apic;
 
 		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

