Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7068A2F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjBCT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:28:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E171C594
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:28:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p10-20020a170902eaca00b00198dd431ec1so1535354pld.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvoxEP7Nplva4MzlDA7W4XNJEUEXXd+N/4Z4GM8dC2Q=;
        b=dq4cgVqDREWhgjpIoJfDa+A3p6xxbzcLyVJGtvLa/V7CoJW6H9Cu6rQ98CK0vPae0U
         cD8L4ox0jevG14e4DnZWH8fm72ypGb30L0bmwZCi5nd0Pjn7naE+mKfHmiBB1EK2DAgN
         cQA8mpsPbslgoxlbZQ2vEPI8PSg/yQOWMSRyLXfgbtWb7nSCKt34OwvNGnq/8qNhW5yt
         WF4+dgOP4BgUwaUSkwyNdmRkXEHUCoOiqzz1rLjOz8bWLJMiV5WRtQ5jrlkvgHTRVhpV
         4q6/7JYef1DTp2adDwnJC/ljaN+vuPvWhnKoRt9yVTxX7bsoAIIQAcLhL+avml5alamo
         Zhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvoxEP7Nplva4MzlDA7W4XNJEUEXXd+N/4Z4GM8dC2Q=;
        b=tYIroD7J/MV75AYPfS0Oio/2F57+YIOKSItK6PaYVoEOWIDrJnuhgiMgmSbSkta6PP
         WNGOdSLF2qERDjeNDLdhrSe0Ke+zr+WzI20C6uCk7oIVO6z3cBvW+wpyMQ6WsD3GAZa7
         Kz1IzQLfT+j58bH+rx/lVvj7gnMVpyrYTQ0e5BrWlgzZ0XNgDREr90LSL3GjWRdip3KI
         8iWLuoijbbLsnnr4s2vA5SLIX17XbF1dX2obKGSfuViaRmQkcaOfNrjnsy1XZneNg8kC
         fQSUeU/C5hBBY+tO96xNSHgmC9G9k07EbLL7H5V1g8xPbjL5rUGRQFlQFy2tTuMx6AJ1
         AWNQ==
X-Gm-Message-State: AO0yUKVB1uL8Zre30QlxPRoffBaJi4Uz7qMKx1FZjf3TJmwLqUV8zI3b
        DWyEr5uuYwcKLmbQfuS5ilVgPfmRQfEr
X-Google-Smtp-Source: AK7set/ADjbyMhNOe6MyOQvMsn6FzBmUdBWOkNS7y0BtmHvhVqQtCvzROZ0f7hpQMM5qMDfE2WTF1B/0EbXX
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:6b0a:b0:196:7cf5:ba64 with SMTP id
 o10-20020a1709026b0a00b001967cf5ba64mr2638442plk.14.1675452507082; Fri, 03
 Feb 2023 11:28:27 -0800 (PST)
Date:   Fri,  3 Feb 2023 11:28:18 -0800
In-Reply-To: <20230203192822.106773-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203192822.106773-2-vipinsh@google.com>
Subject: [Patch v2 1/5] KVM: x86/mmu: Make separate function to check for
 SPTEs atomic write conditions
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Move condition checks in kvm_tdp_mmu_write_spte() for writing spte
atomically in a separate function.

New function will be used in future commits to clear bits in SPTE.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index f0af385c56e0..30a52e5e68de 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -29,11 +29,10 @@ static inline void __kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 new_spte)
 	WRITE_ONCE(*rcu_dereference(sptep), new_spte);
 }
 
-static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
-					 u64 new_spte, int level)
+static inline bool kvm_tdp_mmu_spte_has_volatile_bits(u64 old_spte, int level)
 {
 	/*
-	 * Atomically write the SPTE if it is a shadow-present, leaf SPTE with
+	 * Atomically write SPTEs if it is a shadow-present, leaf SPTE with
 	 * volatile bits, i.e. has bits that can be set outside of mmu_lock.
 	 * The Writable bit can be set by KVM's fast page fault handler, and
 	 * Accessed and Dirty bits can be set by the CPU.
@@ -44,8 +43,15 @@ static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
 	 * logic needs to be reassessed if KVM were to use non-leaf Accessed
 	 * bits, e.g. to skip stepping down into child SPTEs when aging SPTEs.
 	 */
-	if (is_shadow_present_pte(old_spte) && is_last_spte(old_spte, level) &&
-	    spte_has_volatile_bits(old_spte))
+	return is_shadow_present_pte(old_spte) &&
+	       is_last_spte(old_spte, level) &&
+	       spte_has_volatile_bits(old_spte);
+}
+
+static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
+					 u64 new_spte, int level)
+{
+	if (kvm_tdp_mmu_spte_has_volatile_bits(old_spte, level))
 		return kvm_tdp_mmu_write_spte_atomic(sptep, new_spte);
 
 	__kvm_tdp_mmu_write_spte(sptep, new_spte);
-- 
2.39.1.519.gcb327c4b5f-goog

