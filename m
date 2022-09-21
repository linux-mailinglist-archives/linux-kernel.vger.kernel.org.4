Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88095BF12F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiITXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITXcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:32:07 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC6786E3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so2613271plx.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=5/6FMBIKl7OpmtLyPOM5pBGrFGPOcVqV/DcFkynnS6M=;
        b=s6+5XZf6F5dXMsJyKLZY5aQvs7eLYN+0jS3lvOV6Gn+mpcEHU8ZxePDesPRPZJnRi3
         aP8q2i9p/0JWeuNLQ5iyFkHI5jMty46WlVqOFKGlzg+mIKZf+9ob1KU6jj/x6Tx3lj9u
         owSuI55rLbxAOdJRZL09jX6iPFG48sc48ww5HbTZ0D3V5MBzmwg1HXoMHEELTau0XKpo
         1PRSBeXEEc6HELf0ZuUkMS/a2bm+TMYKOBAFc4n85s+9+6at3O6CHh74xI/R3ZmjHlYm
         T1IO7j8yPchz+pR2HcYXnqmFF+JReRd/hL07GhJa6MuEdrFGeEdg8hLF1o223qyYus1J
         Y9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=5/6FMBIKl7OpmtLyPOM5pBGrFGPOcVqV/DcFkynnS6M=;
        b=St01C4p5QiNAxdASRClUbLdzgDO2VE2DzvRqqni15MhRZ9R45wQ5tiliWyUluQFgpz
         rvnNUEwGaRhhHtd8YMtt995J1CBUYF+cBDCSS4x3JC+s1uBk59qeOWwGf6udGi81TP8Q
         A8laBvKaO2GfBu1t16cVvZhfEtDU6FGQ0HW50DrIwjlZz/Q2kAc0bAO+nm8eOlJk6trM
         OLonCqjKKYHzM/g2g8qgbiI+Hoh9cktdRcp0UZe7/SFWye1eG9QZZFookfHIkV23FJGI
         9aCF3dDZntokVJn0scV3c9QK3PXOgA8AVEUMnet355OzhKVsPBEOJA7wTpd7+a8buX+r
         2wHA==
X-Gm-Message-State: ACrzQf2mEXsCmBL04CivmhiAQVrWV9l1YOo1ySRsat2uzoixS7b6RtDW
        LuDV5IjJLgYBCPF4ydFXcvx7j19fBYc=
X-Google-Smtp-Source: AMsMyM4S/MFB4YYwNLQSoEWeVX9mF1SL0kxwn81DPo6+LX6WXUoG4iZ+FpWOarIh3lTy685Qkyl63M6Kkeg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e805:b0:177:e8af:ba43 with SMTP id
 u5-20020a170902e80500b00177e8afba43mr1972705plg.171.1663716717590; Tue, 20
 Sep 2022 16:31:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:18 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-13-seanjc@google.com>
Subject: [PATCH v3 12/28] Revert "KVM: SVM: Use target APIC ID to complete
 x2AVIC IRQs when possible"
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

Due to a likely mismerge of patches, KVM ended up with a superfluous
commit to "enable" AVIC's fast path for x2AVIC mode.  Even worse, the
superfluous commit has several bugs and creates a nasty local shadow
variable.

Rather than fix the bugs piece-by-piece[*] to achieve the same end
result, revert the patch wholesale.

Opportunistically add a comment documenting the x2AVIC dependencies.

This reverts commit 8c9e639da435874fb845c4d296ce55664071ea7a.

[*] https://lore.kernel.org/all/YxEP7ZBRIuFWhnYJ@google.com

Fixes: 8c9e639da435 ("KVM: SVM: Use target APIC ID to complete x2AVIC IRQs when possible")
Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e35e9363e7ff..605c36569ddf 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -378,7 +378,17 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 
 		logid_index = cluster + __ffs(bitmap);
 
-		if (!apic_x2apic_mode(source)) {
+		if (apic_x2apic_mode(source)) {
+			/*
+			 * For x2APIC, the logical APIC ID is a read-only value
+			 * that is derived from the x2APIC ID, thus the x2APIC
+			 * ID can be found by reversing the calculation (done
+			 * above).  Note, bits 31:20 of the x2APIC ID are not
+			 * propagated to the logical ID, but KVM limits the
+			 * x2APIC ID limited to KVM_MAX_VCPU_IDS.
+			 */
+			l1_physical_id = logid_index;
+		} else {
 			u32 *avic_logical_id_table =
 				page_address(kvm_svm->avic_logical_id_table_page);
 
@@ -393,23 +403,6 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 
 			l1_physical_id = logid_entry &
 					 AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK;
-		} else {
-			/*
-			 * For x2APIC logical mode, cannot leverage the index.
-			 * Instead, calculate physical ID from logical ID in ICRH.
-			 */
-			int cluster = (icrh & 0xffff0000) >> 16;
-			int apic = ffs(icrh & 0xffff) - 1;
-
-			/*
-			 * If the x2APIC logical ID sub-field (i.e. icrh[15:0])
-			 * contains anything but a single bit, we cannot use the
-			 * fast path, because it is limited to a single vCPU.
-			 */
-			if (apic < 0 || icrh != (1 << apic))
-				return -EINVAL;
-
-			l1_physical_id = (cluster << 4) + apic;
 		}
 	}
 
-- 
2.37.3.968.ga6b4b080e4-goog

