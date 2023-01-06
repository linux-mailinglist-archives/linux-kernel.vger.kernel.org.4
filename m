Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3365F8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjAFBQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAFBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:37 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AEB7816E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4b34cf67fb6so3169297b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QiGveUbKaqMPt6iTfsOvtO6yQmlbHWlXsxHlqUGMl/I=;
        b=IgbrbTl5VVQEWYsKOJIdi6Yh1Rkg0pxnO5FKrfb/4/5Qxejylccur32ccSkChi1BWm
         uNrufnv52MO1GV4aPWUTlMIVQdCAw64PEWa6M/B6kgKNK6cZuFwD85AckL/9uoZHparz
         +298w25KwqbNpkDWWG3fvXwVJOprfJez5wLuAtZsf1CEg/vV/I0j2/tIj4s84NJ2x24a
         6xUmJHZcg6MlqBKqNcneW//MiQUT5D9tk2KcNx2zZ2UBS+Ekss9Guu2K2rJnWRh8PqYk
         hsoOAg/4wWltiJSgyf24wg3gGckY2Hk5Dsmn8pePTXlBQhal0Ru6ni9RiKz1Syw4a6zl
         QdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiGveUbKaqMPt6iTfsOvtO6yQmlbHWlXsxHlqUGMl/I=;
        b=lmM5A0LdrSjA7exHjBKhmgsuSmabrTwQDInbPm73UuLhQwCXeBz+leuNs9sPKp+T6+
         IRjdHvWTg2SdTCYXb53khkFep3e/2WKxgq3MYUuRRIucC3yBe0Vd+Ud+EEVJVfyben6Z
         eDqT65/FU4gyLzdv+SBRxx+rWIQEYDu1eIIxg+vvcasLwsIW+RUoIA4NCzF/kioi4flp
         0h0LLbhlEm2L78OyypkkFWTEloJoERysReQ59IMziCWAr8BMdv4L4BJxrC8tYALUQECJ
         AuGJhOlqvKlhbOyGpKm/yfU678t/rdG+5zVuU+ter88qCp9CGup+7dl7qPEu1ltaYSMt
         jGyQ==
X-Gm-Message-State: AFqh2kpRFE/2gSt8j2NPpAWMscZwuHxKhdbf1q0kHj7ijn4VkMqN5NjR
        4eLpFhaEGOokXA0KMYu/wxiv6vCzGKU=
X-Google-Smtp-Source: AMrXdXtfxGfz2gG4ErZYxvuoVjkwSn3FVdr74faXbyyI8MKRfjpjhpYAUJbYOlNFP1jqpsbpwf1rN5sAlGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6784:0:b0:460:c029:6c76 with SMTP id
 b126-20020a816784000000b00460c0296c76mr362480ywc.515.1672967629741; Thu, 05
 Jan 2023 17:13:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:54 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-22-seanjc@google.com>
Subject: [PATCH v5 21/33] KVM: x86: Disable APIC logical map if vCPUs are
 aliased in logical mode
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the optimized APIC logical map if multiple vCPUs are aliased to
the same logical ID.  Architecturally, all CPUs whose logical ID matches
the MDA are supposed to receive the interrupt; overwriting existing map
entries can result in missed IPIs.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dca87bb6dd1a..9c0554bae3b1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -346,11 +346,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		if (!mask)
 			continue;
 
-		if (!is_power_of_2(mask)) {
+		ldr = ffs(mask) - 1;
+		if (!is_power_of_2(mask) || cluster[ldr]) {
 			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
 			continue;
 		}
-		cluster[ffs(mask) - 1] = apic;
+		cluster[ldr] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.39.0.314.g84b9a713c41-goog

