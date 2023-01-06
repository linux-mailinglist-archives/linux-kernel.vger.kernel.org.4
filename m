Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A89265F8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAFBOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbjAFBNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:42 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6B755C0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a72-20020a63904b000000b00489753edf13so193132pge.21
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oP9W5uEc0+NE0fVZ2qt9BCyCXd37G2flkZxHxmfC/SM=;
        b=lhDl+F1m6Gb0QU4uj7oQnM7HxwxTzwFuUmvYMgYeFyh51hje6BROAa43BG6gPCKOQ9
         mXg2BNy7HNWgQnFTSvJ76inFBvNiKBUNM0ekR9tSNdfBgbsItS8r2eW55T0KiR1lleuO
         zsJ9gMXPeJOJK5DofJFUl3QAHW4fOodnMdMud/78Ky9bo0+QlOyU9O3SDaD0baeAJl0Y
         AzBavAYI+JEMNEG286Nwgd1wgNkre5V0hbGrdGe7ilPJLhohyfPUElcrdiyPGfEy5PHM
         FHwabkbcnCagvLjwMnmj03+7Yo4DoX9huXkkR2rNhT6nmkfz1ecQ2jnLi4jXTswKTZu7
         h6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP9W5uEc0+NE0fVZ2qt9BCyCXd37G2flkZxHxmfC/SM=;
        b=K1Z0eM4j96kaKReb1gHwYMMJPoYJUp+M18QymSzO9/DKzx5K1891ZVXiWM8OeKLvi4
         tLthWc4gRoqf5oW5J7/aTCxsCGI5wlKBoEqM5Nn2liRejk9zhTRaJFcNviNVxvhdL/Ow
         ractCGiM47yftZb5Eo1JuS6tLzOGcCnpVRR+9oWGLc4OjCY3Am5vCF4P1AQ/gn2Erquu
         m4RtO83Ti8aSOYgoQJM2Glf7/9WWd6lbV3Q8PC7NtwT60P+S/41cd0oxvsxj7iEi8T7y
         D7rZpQ1j31gAXQQARkz1IMrjBuAbM8dGJXci2RlyHkNsIv5xwlQx/GZy4hmgRAflaHT6
         XC/g==
X-Gm-Message-State: AFqh2koVYtZTG+TU1k+6eppaPFFV7nGNRjyEIGe6RLtI3TEBBENBiVjP
        7iYOAmiA9yCaHqHpr8NCt0vUbUqo1vU=
X-Google-Smtp-Source: AMrXdXuo9NMFxPPxTioFXxvW8HWI9616amHLNe3R+YqEc09hS3vc70SRtVnQtbxqS1unCUr1aTSKNQ062xM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a98a:b0:189:bf5d:c968 with SMTP id
 bh10-20020a170902a98a00b00189bf5dc968mr2459776plb.118.1672967621397; Thu, 05
 Jan 2023 17:13:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:49 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-17-seanjc@google.com>
Subject: [PATCH v5 16/33] KVM: SVM: Add helper to perform final AVIC "kick" of
 single vCPU
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

Add a helper to perform the final kick, two instances of the ICR decoding
is one too many.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index eb2ad5b54877..76da9f19272e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -317,6 +317,16 @@ void avic_ring_doorbell(struct kvm_vcpu *vcpu)
 	put_cpu();
 }
 
+
+static void avic_kick_vcpu(struct kvm_vcpu *vcpu, u32 icrl)
+{
+	vcpu->arch.apic->irr_pending = true;
+	svm_complete_interrupt_delivery(vcpu,
+					icrl & APIC_MODE_MASK,
+					icrl & APIC_INT_LEVELTRIG,
+					icrl & APIC_VECTOR_MASK);
+}
+
 /*
  * A fast-path version of avic_kick_target_vcpus(), which attempts to match
  * destination APIC ID to vCPU without looping through all vCPUs.
@@ -415,11 +425,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 	if (unlikely(!target_vcpu))
 		return 0;
 
-	target_vcpu->arch.apic->irr_pending = true;
-	svm_complete_interrupt_delivery(target_vcpu,
-					icrl & APIC_MODE_MASK,
-					icrl & APIC_INT_LEVELTRIG,
-					icrl & APIC_VECTOR_MASK);
+	avic_kick_vcpu(target_vcpu, icrl);
 	return 0;
 }
 
@@ -443,13 +449,8 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
-					dest, icrl & APIC_DEST_MASK)) {
-			vcpu->arch.apic->irr_pending = true;
-			svm_complete_interrupt_delivery(vcpu,
-							icrl & APIC_MODE_MASK,
-							icrl & APIC_INT_LEVELTRIG,
-							icrl & APIC_VECTOR_MASK);
-		}
+					dest, icrl & APIC_DEST_MASK))
+			avic_kick_vcpu(vcpu, icrl);
 	}
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

