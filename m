Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F035BF13F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiITXdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiITXcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:32:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB0785B5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ev16-20020a17090aead000b00202cf672e74so2324426pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=EpWQgthCzwVlN1+QDovdFCTrEnPbNzZiM48g8Uk0Cqs=;
        b=ICkmuWwmWjHn4KH3q8vaKoU16Z+bWz2DowxDhujdMEzB4uglAaJiFzMAss0+DLyuDO
         4fNdkoSB8JYdRaGEpHnzEnhiq785DVElXgbyUcuOChJgA41emKrbWTngTVeVcueUoOgI
         YFHuQUcSCcics6ETwR02K4I0A+ZayxoP7IhtLDAWhxt7mlhQBg5v5y+/dS+zbD9eKIS4
         rQPOwk/qRQTMyP9J2O2FiCtSr/VJBcZi6svRQL0s/afLyA7ZTzP/n4l95BkMARxEAs1z
         KLmOzY9/A/Vw1TJHiiN945z7KYKvMUzxuL4YY0HGjPCDBZkQ+IIua5Ey2487KkJLl4yD
         YLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=EpWQgthCzwVlN1+QDovdFCTrEnPbNzZiM48g8Uk0Cqs=;
        b=YX8h6pUQIF4vw/GZ1dxXoY636IERmQWzX0merQKZHidbRo9wbb5bGfk+9uIXuZ0eJ1
         qDfa3kjzxnG8IuudRwdkVPRi6U9VVNpbQqS2oW8rqDg8ZBVjXG0JX4zTOLkO2BkFnIlH
         31i+c5KTgK272lW/vwh1IFRgVTo2JmXeBaD/pEuaF6FU4iS5FHCTmAgary7L+fAWlG9G
         3AItbL+ajLMI9CzMcNfI66iPNO/SsqT76byzmFuWCx7O8j6U4jOQiz/P0mTwEE3mYA2Z
         FP0kzJu+82oj7156byPsDNs08iycnA0WU8ssyxu0FDrbJHp13lCO35ZdaAx06bTTcd8r
         OaWg==
X-Gm-Message-State: ACrzQf1Nj671SRQxS0xU+zAmUdJTYp2RUQlnXtfZyeE9bw31SS4cNbbt
        3aJqu89i2bxiDR/JNfruyY27fcju+CM=
X-Google-Smtp-Source: AMsMyM64WYPPbsmc8kPNJpF8TVe2l1U1WthIbKGNZq82LyCgxeCwhItfCI6/KUPndfsknD2/gAtJHYvyGoM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7586:b0:172:d0de:7a3c with SMTP id
 j6-20020a170902758600b00172d0de7a3cmr2021687pll.38.1663716729065; Tue, 20 Sep
 2022 16:32:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:25 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-20-seanjc@google.com>
Subject: [PATCH v3 19/28] KVM: x86: Disable APIC logical map if vCPUs are
 aliased in logical mode
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

Disable the optimized APIC logical map if multiple vCPUs are aliased to
the same logical ID.  Architecturally, all CPUs whose logical ID matches
the MDA are supposed to receive the interrupt; overwriting existing map
entries can result in missed IPIs.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a12360fd4df6..e447278d1986 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -341,11 +341,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		if (!mask)
 			continue;
 
-		if (!is_power_of_2(mask)) {
+		ldr = ffs(mask) - 1;
+		if (!is_power_of_2(mask) || cluster[ldr]) {
 			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
 			continue;
 		}
-		cluster[ffs(mask) - 1] = apic;
+		cluster[ldr] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.37.3.968.ga6b4b080e4-goog

