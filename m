Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7F5F17BD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiJAA7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiJAA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:59:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D41AF931
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so3703269pge.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=M/spcK9wHVTD8Sd/Y0FAGZb50phXWK7By/2gXnYm8Kc=;
        b=a3A2SsPtQ9WnBAERm+S/X0qzW5ZN8giGyMAolX/ZSvBJAtdQVXwFc+agKJML8greuU
         sCyvFnkrobvE1RuJBAZ0qPQwaWEjLTkZ4qlwxzEXeJeakNv+RFxGoqybhYcGVP+rtKEA
         hEm9AxJTXsI6450LFVX2wpo6qpU2mjlIwnoO15CachELhJjVVZizw2SbO8S/QbwX9NJM
         CgOoNLIsW6p6nO1trhMWu5w5B1ZYd0ivQh/9Gk+c6HCZNqo+wIuajuh3pjbuZhKf650B
         ikEKgJiU1lwAaiYzMyRdyweY2yOQruVFodsbZdRNTqPp9TXWStmBtVeNIpMkDQa8jzIN
         irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=M/spcK9wHVTD8Sd/Y0FAGZb50phXWK7By/2gXnYm8Kc=;
        b=cMwV9xtKlc1Nevq8qRsf9i1go0uVtx8PHC8NmJIJqukfA2TCgCgwk3VUzkFRjwhR3H
         hiicjYrgwEU/8cKghfCMi71VwOEfJYQgFOU5XsT/mAr5VTA1WP56gOzKPJHncNzggm72
         6mxXP5XhanU/o0/l7WaocL9wuPOGbPnM+oh6pzbLdiFHFc7cVBMh4P8xySkiGdetmyqC
         ozSzXUfzBp55zf7elATGWVpiZfNAjZBgTNTjfmt4DAY896ef78s6w0SjkkPeXIpAuzx5
         D1xShBuZAtIFCVOLLTB+WYwKDuzJ+ykqlEkiMGScT1L/oz/Jbt2rmSY5YrknTWLCLaEl
         WYdw==
X-Gm-Message-State: ACrzQf3iW7iY7oGZJxYo6quMYqXPVzPtG0pZmtMOAYoT3dVJn8t2ly0s
        FR2yVcMihLDwj435B44hinj6Hm39ERk=
X-Google-Smtp-Source: AMsMyM4e5iuCFLGxaNpq8Mv1gv6Lgo21xWESrHHrXsuB08zVPqPVjheNWe+vLOtwtSpyQlff7n2LKTvHcO8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:18d:b0:178:28d1:4a13 with SMTP id
 z13-20020a170903018d00b0017828d14a13mr11507907plg.160.1664585967120; Fri, 30
 Sep 2022 17:59:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:58:48 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-6-seanjc@google.com>
Subject: [PATCH v4 05/32] KVM: x86: Don't inhibit APICv/AVIC on xAPIC ID
 "change" if APIC is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Don't inhibit APICv/AVIC due to an xAPIC ID mismatch if the APIC is
hardware disabled.  The ID cannot be consumed while the APIC is disabled,
and the ID is guaranteed to be set back to the vcpu_id when the APIC is
hardware enabled (architectural behavior correctly emulated by KVM).

Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5de1c7aa1ce9..67260f7ce43a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2072,6 +2072,9 @@ static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
 {
 	struct kvm *kvm = apic->vcpu->kvm;
 
+	if (!kvm_apic_hw_enabled(apic))
+		return;
+
 	if (KVM_BUG_ON(apic_x2apic_mode(apic), kvm))
 		return;
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

