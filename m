Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12665F8CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjAFBOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjAFBNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:25 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5F71FF6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:24 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id d10-20020a631d4a000000b00491da16dc44so198549pgm.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=skmNHPbTYLwyxoraHBJpLpuS512+i4UR+d4KzIFrXzo=;
        b=eHspZ09DmK7JKDuAkYFgw2Tmeu1pkc8IkPzAYI2GCsgpOY4NyVmsDEUKctJkeXrE5G
         LzYk2RkJgeauHLVZqTm7drTchkyldaitSOOoRqSr/yjfeEX5NiuSamVpMc+U2c7qLwm0
         DngxD2loLWSr9XkOBdkVspM0ynT+X312xS8jTpu12DQVxNUrLf2h1jHb9Cj7PvkPYJq9
         PhfxFoez2ibzGpvO7NqkRNK/0zsGH8c+GZf2gzf2Gb5NhhqUfFIKjJIioj3koUdYLD1X
         CU1kGCr00qZon5e991QguAtr2xKfe87a1tWqbR3kLl7vIweiPI7nyLBf2MzZ7dQo82LK
         Tm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skmNHPbTYLwyxoraHBJpLpuS512+i4UR+d4KzIFrXzo=;
        b=ghda/v9xypluNcHAcY1xjwPKWv/Eyvmh2G0yXbT2TTQXVhiCMHzBDptGkLkRECjMiy
         wHvB4LC8k/3PoBA+A+lIqSzqjznPdw8XEtGluyxka3hIiknbhsqnCctz9A0G6qscDj6T
         YrkVvdPgRMbE7DJ/sIRTbEeRJzzfJlCALH3yPjL+Xv/bSthPwCPEQsM8EoDKXj83nqpj
         beDlTgysCpV72do3CRCESZgYc9ExkbQmbB7729gJBSF891khIrUgV/tgSp5b2lCgcuS8
         8MOPNy3Us/Oizorz9zwQQUcIsjI/HK6uUR0UBxnKXCSkfQlPCN6fRtTM304/y6vhhm+1
         g8cw==
X-Gm-Message-State: AFqh2koJwcVDwmD7MrAo0KChFFcNPBsbjb8ZqckAGkgFLSkTYu2MrT+Z
        lnn3HT5UjTPQsgFZzRDeutA7trftnDw=
X-Google-Smtp-Source: AMrXdXvwxPom+8pP9fNt6a6nAoWVR8+muMZ9FIRFEqS1HHzsnhrSJPf0g6plar5raO5p9grs5bFtPDq/NHI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3c81:b0:219:dbed:ade9 with SMTP id
 pv1-20020a17090b3c8100b00219dbedade9mr4575858pjb.125.1672967603847; Thu, 05
 Jan 2023 17:13:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:38 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-6-seanjc@google.com>
Subject: [PATCH v5 05/33] KVM: x86: Don't inhibit APICv/AVIC on xAPIC ID
 "change" if APIC is disabled
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

Don't inhibit APICv/AVIC due to an xAPIC ID mismatch if the APIC is
hardware disabled.  The ID cannot be consumed while the APIC is disabled,
and the ID is guaranteed to be set back to the vcpu_id when the APIC is
hardware enabled (architectural behavior correctly emulated by KVM).

Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
Cc: stable@vger.kernel.org
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 33a661d82da7..191b5a962700 100644
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
2.39.0.314.g84b9a713c41-goog

