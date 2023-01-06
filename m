Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDB65F8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjAFBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjAFBN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1971FF5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:25 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-46658ec0cfcso2656287b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TSmJoHpGEg4kYZow7Hfuz8WMYi0D8WbHpbMSfsD+jaY=;
        b=svIrwG0BQCeHJr9kAw3C+ZqzVl4Z8noxUTH4Nm3fxagfr95d0yzpFEtYY0HeWbhhKa
         Mj7UpQwZ7gK6e4mFFGwm0yRoGFdQDHTTjKT6l5xTDNF8OFTJh2qF4SspR394jOniGrm7
         VB61W1PzyR7BbjmWZILBvd/PVnnDPQhcIb6iUkb+AW8JAjkUmWmRfBYZ1Q8StJ44SPZ5
         LDv7eYcCPaniI5y9ttvrcjEwaToRELdufqVSRdy9bWT89upLDk1TBMAJzDoeGg2Mx5WW
         EFeJq5rozALDwYstow/5AByuY7f51vDJ08FP07o3mQkp1a2xtOeuAxfqH1LPWOQly+pZ
         b+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSmJoHpGEg4kYZow7Hfuz8WMYi0D8WbHpbMSfsD+jaY=;
        b=jwmPhw9iDypZn1fOziSXDNFxg62mv3eBp0uTRkzu3SOQLyfbKhk4Bzf6yp4JLkyY2B
         S7kKZ2ltW0iUXtGcrPr/SrxxISO93gmu1Mjd2sKympT4aflMcRg0/1JeOObOSvSeIa7M
         HTccHwyQdYt6Z/euQH3iSSeWdUvHlJBizvp0sZhGig4BSqCPhtRBcpEGFijetfHwhLOx
         ThB7/EPPMXEf73JO+biyw89X6L5coR6u3iKHFeMjk846TrrsiBQwUjPLnf/j2Of+ggtf
         ncPK4hublW92enkMgLBC/TOUKD9fVknnjuGzE9p989SsEEBCEvuNd4oFoTa/D7dX6FwG
         VNVg==
X-Gm-Message-State: AFqh2krbwI0ZTgPknDVOZ2I2wf14nyYi3lSY+XFIUaI/NC3xQz6rbSCk
        KjVEHG5pz9XSySGpctqhiW/hbpsZR34=
X-Google-Smtp-Source: AMrXdXvRb8GUwaflHjmzqoT+l70tuGqw2W20zoxljhq4Dl3XelKFi0JCTXs13kako0Te+i2vI/4z9Eyl5lw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:c2c1:0:b0:4ad:5c08:7e67 with SMTP id
 e184-20020a0dc2c1000000b004ad5c087e67mr1617563ywd.75.1672967605381; Thu, 05
 Jan 2023 17:13:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:39 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-7-seanjc@google.com>
Subject: [PATCH v5 06/33] KVM: x86: Don't inhibit APICv/AVIC if xAPIC ID
 mismatch is due to 32-bit ID
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

Truncate the vcpu_id, a.k.a. x2APIC ID, to an 8-bit value when comparing
it against the xAPIC ID to avoid false positives (sort of) on systems
with >255 CPUs, i.e. with IDs that don't fit into a u8.  The intent of
APIC_ID_MODIFIED is to inhibit APICv/AVIC when the xAPIC is changed from
it's original value,

The mismatch isn't technically a false positive, as architecturally the
xAPIC IDs do end up being aliased in this scenario, and neither APICv
nor AVIC correctly handles IPI virtualization when there is aliasing.
However, KVM already deliberately does not honor the aliasing behavior
that results when an x2APIC ID gets truncated to an xAPIC ID.  I.e. the
resulting APICv/AVIC behavior is aligned with KVM's existing behavior
when KVM's x2APIC hotplug hack is effectively enabled.

If/when KVM provides a way to disable the hotplug hack, APICv/AVIC can
piggyback whatever logic disables the optimized APIC map (which is what
provides the hotplug hack), i.e. so that KVM's optimized map and APIC
virtualization yield the same behavior.

For now, fix the immediate problem of APIC virtualization being disabled
for large VMs, which is a much more pressing issue than ensuring KVM
honors architectural behavior for APIC ID aliasing.

Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 191b5a962700..2183a9b8efa5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2078,7 +2078,12 @@ static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
 	if (KVM_BUG_ON(apic_x2apic_mode(apic), kvm))
 		return;
 
-	if (kvm_xapic_id(apic) == apic->vcpu->vcpu_id)
+	/*
+	 * Deliberately truncate the vCPU ID when detecting a modified APIC ID
+	 * to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a 32-bit
+	 * value.
+	 */
+	if (kvm_xapic_id(apic) == (u8)apic->vcpu->vcpu_id)
 		return;
 
 	kvm_set_apicv_inhibit(apic->vcpu->kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
-- 
2.39.0.314.g84b9a713c41-goog

