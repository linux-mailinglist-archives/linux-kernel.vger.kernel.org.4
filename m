Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D667A734
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjAXXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjAXXtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:49:23 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9D49022
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:49:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so7519180pgc.19
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cSFedQsv7Wc1M6mfIq8Uerd1CseDG+3+LjpR3/a1jI4=;
        b=Vp+bCCyRCOzXxx9AZRk/kLf2yoM9R2H7MV3TG8iO4ixZfrmXyu3VH5OT9URCnFT6Ao
         SnOE2UHK2AnZMfppSvxPBExJYZ4Fxe9T9DFqELJjMzTPwm3THgO6m/pOUi4AULV2sZ1b
         5BNeuoAAa7KPpu6EiXS3gy8WFApTYM5YBCvJTG6h76zjPe9l+cRD0Zp1KCyUns7fe6nX
         VX1PrSIkSYQxk0xiGxVaWwC1UOgh09tR1C/pu6yybMIHQDasONsVEtBIkxqac5Q4XQoh
         QATfefxt08qKbI42PfLX9jDT1Nf1BnuHKNDKAqU040eTQcTdnTjdSThoIhCikZ1drvSv
         bb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSFedQsv7Wc1M6mfIq8Uerd1CseDG+3+LjpR3/a1jI4=;
        b=fUQLB5PwoVt4kkBGvUmTTcDZIMWjCx1l4ys+ntLOvMnQ3wEfQAgM+oeZyLgMsu0QTv
         gsaFrLiyzjTa/TuGAsrgTKgmEVVW79kAXiz1eJS8xH/O1vSIGUsJ02BzleRNwGymLI40
         bI7qn91jR4U9W+vuFl3Ir9rixBoXWr1GIwnJhZFtu8s8kwmzJXwS4V/UEGCqJS8ObLlc
         T+EvUCD9n9/IJewza4Vk6MWYqf3MJcbvbBMpk87W9cvUYF3npOI1gklYSU5PyZ1ixFbB
         RcRRqv1Xr4dTSMfWyzTVfLTycbTWjHh2sAX8JHoNQ4Oy2sjd38WUu6QE2EoajobsXM8Y
         x98g==
X-Gm-Message-State: AFqh2ko3NQjkk49Q7KScQ4gVZweJ4XZfzK4wnwNlR/KvbyxHHqHHBtN0
        nlTxumFP7vNoK8KrRgqgVjAjYZs4ELs=
X-Google-Smtp-Source: AMrXdXv339G7NMnbhLg4zibqJM/2hsDjjR6Pg293Q4PQitRC5ZTlozoeYq7nwj6TlxtlrhWWEQeAgD92yFo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:bd97:b0:192:9e63:e2bc with SMTP id
 q23-20020a170902bd9700b001929e63e2bcmr3138979pls.11.1674604159781; Tue, 24
 Jan 2023 15:49:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 24 Jan 2023 23:49:03 +0000
In-Reply-To: <20230124234905.3774678-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230124234905.3774678-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230124234905.3774678-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: x86/pmu: Don't tell userspace to save PMU MSRs if
 PMU is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Like Xu <likexu@tencent.com>
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

Omit all PMU MSRs from the "MSRs to save" list if the PMU is disabled so
that userspace doesn't waste time saving and restoring dummy values.  KVM
provides "error" semantics (read zeros, drop writes) for such known-but-
unsupported MSRs, i.e. has fudged around this issue for quite some time.
Keep the "error" semantics as-is for now, the logic will be cleaned up in
a separate patch.

Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Weijiang Yang <weijiang.yang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b6e1af63531..25da2cc09e55 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7081,8 +7081,10 @@ static void kvm_init_msr_list(void)
 	for (i = 0; i < ARRAY_SIZE(msrs_to_save_base); i++)
 		kvm_probe_msr_to_save(msrs_to_save_base[i]);
 
-	for (i = 0; i < ARRAY_SIZE(msrs_to_save_pmu); i++)
-		kvm_probe_msr_to_save(msrs_to_save_pmu[i]);
+	if (enable_pmu) {
+		for (i = 0; i < ARRAY_SIZE(msrs_to_save_pmu); i++)
+			kvm_probe_msr_to_save(msrs_to_save_pmu[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(emulated_msrs_all); i++) {
 		if (!static_call(kvm_x86_has_emulated_msr)(NULL, emulated_msrs_all[i]))
-- 
2.39.1.456.gfc5497dd1b-goog

