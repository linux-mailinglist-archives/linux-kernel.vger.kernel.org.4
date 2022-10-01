Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD26A5F17D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiJABCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiJABB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:01:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A42B40C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00176cf52a348so4224545plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=uSNLoOQS29RMH65csyjC62wfSsv+FVU9ZImwILmmR5M=;
        b=cu5cnfvlhzILzZOTu90hhEus/JcWHKk0Ix+eguBuS8jVRomLlYtEBLLAIExsCXHVev
         g6ruv5FIBCh63KA5C7qYvzCkgmXv2U425RFzDDfjzHrlpv/ut3aSqLJ02sVsS/9G9UoZ
         lJgNpEzVPZINtboSHrKUIpfnM2LBuTVEekL/n/jFQjTQUcvhsbKx4xl8fV+SkP9oFLTE
         fjYjfkNn/+6bwf4SpzKgEjpA+D8aEf3ADt1yH2NQrIE4amB2Hyq7FAY5nU6eV3jPtans
         1i0rhHatQHKOmRNzLhHQrwh1Vpcziwky8q+EK7eG9nxMkxSwSSyGWHNN4qDzMRWc1z1B
         sJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=uSNLoOQS29RMH65csyjC62wfSsv+FVU9ZImwILmmR5M=;
        b=jp8lhEnUe5UyF6OXHqair0gWYrIq+KUKJhIyVD2Bl+PE0AQEn5KKVPXb/hU9hTR03S
         ZOanitRMby2gkksVCwVu3rQOth2TZcaVbzOVwqOyH+E4Un0sSWCjVju6cdIZs1YyuMnU
         JqBxfE6RtwHZ14ThTHHedZtpZCC1i5j3wVwYTdY3tGuePvtZRLlVgJ+mT087lcEUMnQI
         labFg17+qB6+39gJ9oD8aY75vPD4hZ7IczUqprwUBeWOd542YFdzxNFRGYDkIbRuuJKV
         OYX6nw1VtDGM2xIpx273RcVc+/JCNrSLkVKQa+ZbH5HXgSIts01fcPiiuFIU92W6G7DO
         SbRg==
X-Gm-Message-State: ACrzQf1mYikRUcTb4gLbIomSB1mqnZfxL4yt12qvBOVkOr+w+I6iFgRW
        F3NWAR5opW2AAN5gkq5/C88QC82+4lQ=
X-Google-Smtp-Source: AMsMyM6w6MsNyc53d3SQWAWyqqwFCLjE7PmFUyn7cfk2sU2zLrZqqrfhahhdh28Gf0e/BBKIXtmJ9oeRBTw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:be03:b0:17b:80c1:78c2 with SMTP id
 r3-20020a170902be0300b0017b80c178c2mr9683660pls.34.1664585989336; Fri, 30 Sep
 2022 17:59:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:01 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-19-seanjc@google.com>
Subject: [PATCH v4 18/32] KVM: x86: Explicitly skip optimized logical map
 setup if vCPU's LDR==0
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

Explicitly skip the optimized map setup if the vCPU's LDR is '0', i.e. if
the vCPU will never respond to logical mode interrupts.  KVM already
skips setup in this case, but relies on kvm_apic_map_get_logical_dest()
to generate mask==0.  KVM still needs the mask=0 check as a non-zero LDR
can yield mask==0 depending on the mode, but explicitly handling the LDR
will make it simpler to clean up the logical mode tracking in the future.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 42b61469674d..cef8b202490b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -286,10 +286,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			continue;
 
 		ldr = kvm_lapic_get_reg(apic, APIC_LDR);
+		if (!ldr)
+			continue;
 
 		if (apic_x2apic_mode(apic)) {
 			new->mode |= KVM_APIC_MODE_X2APIC;
-		} else if (ldr) {
+		} else {
 			ldr = GET_APIC_LOGICAL_ID(ldr);
 			if (kvm_lapic_get_reg(apic, APIC_DFR) == APIC_DFR_FLAT)
 				new->mode |= KVM_APIC_MODE_XAPIC_FLAT;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

