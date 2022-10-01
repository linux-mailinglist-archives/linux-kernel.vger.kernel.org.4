Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC085F17E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiJABCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiJABBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:01:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E5DCB44D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f4-20020a636a04000000b0043a18cf1a5aso3683880pgc.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=hhcjKYj23YWXw5bc06GwUk4XMJj5K2PGd9rVASFSpWo=;
        b=qtM8qb/++PwpgXE2ygkDVfIK//jRrXsh1Omp8NBBjy0Bi2V4L+SL0932+qwGCRQ1eO
         gQVyVdaJpR0xll4/hJ4iUhPV18G5g6CmWEml+Nu41FjKWXxNHqsyU5cI/LIMxOKbeZJu
         AO4YL/N+HJGs83bExHbqGrJAiGNKstEA8+jouR1/Q7Q2iCKe2mktRsSWjRZsF69BAFUT
         WdHLiHD7zI5GhMfOJqkkc9MIOEEXzu0Mb80wASiV7p6Znx7/JoBXUsYcG7iEtYCiANUI
         jOUXmvJ5NbNOLJHuBH9MbmrDWyRwGYcOp79VFDiQ/l/9E//lmqUG7eHAEC0zlE2yLY2g
         0Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=hhcjKYj23YWXw5bc06GwUk4XMJj5K2PGd9rVASFSpWo=;
        b=YYmujReRGDmyLnpN67W7Z7jy8UyWZxm6C4h8ipCZKKi06U/Y6NZU0mVp2hzes78AIA
         sBeNPQNPo+/gn93BOof7eNOXSx2b5aZaXFRckGPzNpi2oy9exjNVV8+CcI6xZizKKuYO
         z3MV3PW4eUohAIJfLl4NQTTSk02JXf52bvW0xITXkOATH+DWcPROd86O6rjo3oMyorQL
         ORh6Wf2maEOGjJuDZkI8gLDLM/8AteQxP/vsIicG+yBRbR5eNA37d3gcIFSPgAep7O42
         MVhdJLLwJtCSymW4XEH893UBn+Sr1XvMGmkbD2p23XAOjyZBE1Tj94TRKd1BXSgY97ab
         9vJw==
X-Gm-Message-State: ACrzQf2dwMyrph1AQRWOhapmm32J3mYDuC8MuAsOGgKu9AL23bHvqp/H
        /uD/tBMBO/OppXd7vGO7bhyQGGUiAXg=
X-Google-Smtp-Source: AMsMyM6KQ7OLb2NI9kzXe2RozSCiOLmBy6eUO9tIPcSGSxDHZtFK3SySAG6SKJ17NWpDOjDwB4/9hRfn+YI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2442:b0:176:c8ee:a5d6 with SMTP id
 l2-20020a170903244200b00176c8eea5d6mr11245653pls.20.1664585994392; Fri, 30
 Sep 2022 17:59:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:04 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-22-seanjc@google.com>
Subject: [PATCH v4 21/32] KVM: x86: Disable APIC logical map if logical ID
 covers multiple MDAs
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the optimized APIC logical map if a logical ID covers multiple
MDAs, i.e. if a vCPU has multiple bits set in its ID.  In logical mode,
events match if "ID & MDA != 0", i.e. creating an entry for only the
first bit can cause interrupts to be missed.

Note, creating an entry for every bit is also wrong as KVM would generate
IPIs for every matching bit.  It would be possible to teach KVM to play
nice with this edge case, but it is very much an edge case and probably
not used in any real world OS, i.e. it's not worth optimizing.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fca8bbb44375..7fd55e24247c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -338,8 +338,14 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			continue;
 		}
 
-		if (mask)
-			cluster[ffs(mask) - 1] = apic;
+		if (!mask)
+			continue;
+
+		if (!is_power_of_2(mask)) {
+			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
+			continue;
+		}
+		cluster[ffs(mask) - 1] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

