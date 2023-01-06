Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7165F8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAFBRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjAFBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:16:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494D66A46
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:26 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u2-20020a17090341c200b00192bc565119so113041ple.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W3CTpeuTrONtPW+ec2MrTe8ezQAG+SLQuSBj7Ovyik8=;
        b=S6d4NqHLamXPB3TUzvg3wWGtflUgM+3032jxUGcWO+TIgGbYTgEZ1dItWZfCPcvS28
         iXiyK0PdzysKJ3KTu6Vh++OXSwnsJjuZYij3xPUTqg48YQLoigPTIE+PNWDsCfWZ05sp
         5UXanJYrEQPO/nX6a/lpM3SyeQFam6jOg7eWs4/vILF0zjgMJ+ozejPA1ldsMHpnuTlW
         l9iOORsEIXr1u9vl+1jNxDhB125UO1MvGvwE1MjXJiiQsPS3/+Ye/MSHUYhlAC/i8aBe
         e6tsoVldGRzmGu+eMdRHuhLOUBg9x9DNQmGvOQo2AEHznkFuR/mgi8UDZin3miEW1ZWb
         nWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3CTpeuTrONtPW+ec2MrTe8ezQAG+SLQuSBj7Ovyik8=;
        b=rkIcHaF/fcTiOp0HQLduRp/ogrp2oEFLv8Xuj0RomG1LT2l4UKJk1GMejcPHnp0/aX
         P7v55pCjqFd1dZrDipxm4QBJULO3MuI8Cb5aETUM/U8M2Imh5LwyNqjx7FB6XYRwwMYP
         z44Y1Csf+rljcIT37NDb8r9OZoDl9eupzxvzkbgOcyzqkV5GvJsV2yzg5ruTTk5vHHjF
         yB1JyBE6UQvfykWVK+WrtADTKe23eGhqv58CAPR+eIF8cBoGlaDlqXMMRmyKbJ2LdWPI
         7Q7yR62qxyw636gXe4v1zwcmkae6LjdnZn7aHFD5orzbPc2iWumvd/DNVyyHgulYurPT
         Gm1Q==
X-Gm-Message-State: AFqh2kqxDed6cEv8fhADuycuVzAGSREpwJtq8W/JHxKLoFzh1ZiiB6o0
        CwxcT84/6UHBDnWJKLeLy2QwlBYUtYU=
X-Google-Smtp-Source: AMrXdXurLBy7RyZTd4A490U1pCV44uNhtw92Xvqpe1ooafmPQQVUKqN/ZszlQdE1ZwrkqYWej1YXiB6zPRs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:7986:0:b0:581:5a36:b2f8 with SMTP id
 u128-20020a627986000000b005815a36b2f8mr2165620pfc.32.1672967645128; Thu, 05
 Jan 2023 17:14:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:13:03 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-31-seanjc@google.com>
Subject: [PATCH v5 30/33] Revert "KVM: SVM: Do not throw warning when calling
 avic_vcpu_load on a running vcpu"
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

Turns out that some warnings exist for good reasons.  Restore the warning
in avic_vcpu_load() that guards against calling avic_vcpu_load() on a
running vCPU now that KVM avoids doing so when switching between x2APIC
and xAPIC.  The entire point of the WARN is to highlight that KVM should
not be reloading an AVIC.

Opportunistically convert the WARN_ON() to WARN_ON_ONCE() to avoid
spamming the kernel if it does fire.

This reverts commit c0caeee65af3944b7b8abbf566e7cc1fae15c775.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ff08732469cb..80f346b79c62 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1034,6 +1034,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		return;
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
-- 
2.39.0.314.g84b9a713c41-goog

