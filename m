Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6565F8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjAFBNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjAFBNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A838571FC2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id ca10-20020a056a00418a00b00581dff62bb7so44734pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u78lWz0VYuMoumoWecLZd2qogPK5CLyQBtm8aEankL8=;
        b=r72UhPty8x9ytF8Iu0v50uaCclT3TpYbGwsVR9/P8cMx301hLhNCR327Vpg9/8+MKB
         FZwWPgFTEkCRezgF/NvAylGFY+ZVbioXnCFi5a4Do3aPoA4V1Ftp++44CtX/vg1fIbDY
         7F/lyInJV2zTpqirwvtfT9mgRfECdomLHhkVgaa+1zZ2tyWa40y6t/mkrAV6nmFDIBA9
         1ZxO8XSBX6fp+ikrFwNcH9mdoqlMFc3kBeyaFkjOK1H3LRw7sw+QMGDSC/6IPCJksiBe
         ZDtQJmFGPZ2SZEK3y584t36Qvgyw61f4Uv0vX2ffYYxcMdxJEMAIGxxQy4Li2OlOCX5j
         lHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u78lWz0VYuMoumoWecLZd2qogPK5CLyQBtm8aEankL8=;
        b=LoLr8fB7nLR8oyLSs1hv/JP0W39jFTonpyReB1cSEMph0uRv3Xlj8Ys5OKJ0z2ooeS
         nGQ8f82dmXHLqlL6GcKNlTGfb84qCIPjqGv3QSC6PlLaP/i5zW/VNpmG49xySrf3nn4z
         cy9VLxBZpaPEqCQhzp4aLIEhUoMMj/L13hCoxFMam8ycptV/9VAUWpPBIa0ixAavEdyH
         VRldN6AagUKst/24QaH9t33nVbxcJeaOlfSLoHu3QgfbKmnxih0oBREpfzfDEFzUu28r
         4aIxyg4bn8gLgnPllJ6T3k59bQ9VrvlpfhtEnQ6KBVsvk9IxmzUw5wKHOIcgUCWRo3UC
         me1Q==
X-Gm-Message-State: AFqh2kofwVOaP1eNqdH7+jT6pvE2PU+O9nsl/mQI6e+8lSXyIFNRm04q
        A/QAPtEy/QciVa50M3ruf2T0/NT+SFU=
X-Google-Smtp-Source: AMrXdXsJfjaK96Xi6oTG2qgtI86m5NvdBb68nC9Wz65W4q7Uep1k89PqXLVg7qLeQygr32NJ4hzYoqEDR1k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:378f:b0:219:a032:1760 with SMTP id
 mz15-20020a17090b378f00b00219a0321760mr3216899pjb.88.1672967599607; Thu, 05
 Jan 2023 17:13:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:36 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-4-seanjc@google.com>
Subject: [PATCH v5 03/33] KVM: SVM: Flush the "current" TLB when activating AVIC
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

Flush the TLB when activating AVIC as the CPU can insert into the TLB
while AVIC is "locally" disabled.  KVM doesn't treat "APIC hardware
disabled" as VM-wide AVIC inhibition, and so when a vCPU has its APIC
hardware disabled, AVIC is not guaranteed to be inhibited.  As a result,
KVM may create a valid NPT mapping for the APIC base, which the CPU can
cache as a non-AVIC translation.

Note, Intel handles this in vmx_set_virtual_apic_mode().

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6919dee69f18..712330b80891 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -86,6 +86,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		/* Disabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, false);
 	} else {
+		/*
+		 * Flush the TLB, the guest may have inserted a non-APIC
+		 * mapping into the TLB while AVIC was disabled.
+		 */
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
 		/* For xAVIC and hybrid-xAVIC modes */
 		vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID;
 		/* Enabling MSR intercept for x2APIC registers */
-- 
2.39.0.314.g84b9a713c41-goog

