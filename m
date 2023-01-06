Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03165F8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAFBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjAFBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:36 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9F3227D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:03 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso97691plx.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+A51GFnbIGYLOWeoxnDIO9I82OkrlDigpTJkMvBwJMw=;
        b=F8yzvupPXsGW06DH+1jZGD+zuxJ+ciFFDXXj42wqvm5h/vD4rhWkB30ytSbi5IxBuA
         Q5xYNnENse/uvcUlUomuo7rHIYID/0orsR2GikNSViLFaGeDyOT+YXUA6lCTMd22/TEh
         aI3kr97jkgXyYnUf4ENzElIjb1HTY47wtaolr+BE6/YVwz1ssR3YJf4tpjzZ3nVYqzMY
         ZnhnbxON18+UcKHIAdr2Cljg4XsGGn9t9JwVHz2zt8nMQ5p+aGq4LDXRs9h5/BhafCxC
         FGAk9Wc0ZmsylkByffi09PfVC11igMnAmYKf47AhvnSHzgj81CSlQ/MCY0a9Im14Ntm5
         vS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A51GFnbIGYLOWeoxnDIO9I82OkrlDigpTJkMvBwJMw=;
        b=FLqfTxCUDuRqQxt013VPfPTDqeajE8ep6hltxOHTAHOHm6SBOQqLDDu0hey33qCFEd
         3/iYRkaH/QkiQGlKZr3rAiERv/YEdqjhSjY64FTMFmwu2j6hL4HQUN2ji2dJnlK+EUr5
         RmlA06yeHZZBro3nWT/SdzA9x7sZ+aXqi++pweouJC7D18t24hFcgSdYo2nOukKIzWvs
         ohryWhE4p+h7w+r6z4jPe/AN0DQUDpPKkWYnZsMHfrCy7HKU8qZcZnKcnFSbMruUZYno
         VEIik/uDyM3XDf4/To4e155JM1mZCQnM3TgikCn0661hZ1aAICwtKzcUUh7kEO/ZEv82
         NOIQ==
X-Gm-Message-State: AFqh2kpfc6LMMwQh2rWpteNMF92w4kV7yDqqJEbymBHJpcB4gGE9suSC
        NDBZaqjmf/xaORMXtNhvYwhC338braI=
X-Google-Smtp-Source: AMrXdXsYY7BVFxPRMEfoT/emgTWWz1OhSiCaBGRQGPHU+fL6h44G8pju8fB+2riNfABFA2yT830hOts7P8A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:46d8:b0:226:6523:7849 with SMTP id
 jx24-20020a17090b46d800b0022665237849mr1263637pjb.66.1672967627955; Thu, 05
 Jan 2023 17:13:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:53 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-21-seanjc@google.com>
Subject: [PATCH v5 20/33] KVM: x86: Disable APIC logical map if logical ID
 covers multiple MDAs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
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

Disable the optimized APIC logical map if a logical ID covers multiple
MDAs, i.e. if a vCPU has multiple bits set in its ID.  In logical mode,
events match if "ID & MDA != 0", i.e. creating an entry for only the
first bit can cause interrupts to be missed.

Note, creating an entry for every bit is also wrong as KVM would generate
IPIs for every matching bit.  It would be possible to teach KVM to play
nice with this edge case, but it is very much an edge case and probably
not used in any real world OS, i.e. it's not worth optimizing.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fd7726ff95c6..dca87bb6dd1a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -343,8 +343,14 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			continue;
 		}
 
-		if (mask)
-			cluster[ffs(mask) - 1] = apic;
+		if (!mask)
+			continue;
+
+		if (!is_power_of_2(mask)) {
+			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
+			continue;
+		}
+		cluster[ffs(mask) - 1] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.39.0.314.g84b9a713c41-goog

