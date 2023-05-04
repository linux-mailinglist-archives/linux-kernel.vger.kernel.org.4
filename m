Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5386F4F68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECEQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjECEQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:16:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495591FCA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:16:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a04468981so80113857b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683087395; x=1685679395;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YJtw62GtGvLodxqlrImmwkb/DnaRXZEiakmDP1KOF8=;
        b=o0hLaITSqsgzFYxltV5RMId55xRCG7Tk7YDz8q1/OPDSGMvILQefICkgC4ZdxBqB5J
         MjLh+sCmNZ/i4oT6P32JokhR9S9qC2/MKjtHdKTuKxzkXSNBAbjhBRq0E/+wDTsfICmf
         QPnSYSpFQGfgPh9SoetmTsBGucvMVaYAmUMEavxgR2YWDVf6noAnJ89JuBro7gMQGiaw
         46+qLbWVjPzPWWnT54vf6Q78PH7/VeL+0L1rdJR/T3nSdmKeYD7tQoYXhZ5QylK8X6/B
         G9ars/m9dekJeHaxs+6U0IcwtX6U4wqxu8SGm4tm5PQMv+kIkL5tmwiBfhlNHnMSuy1e
         8WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683087395; x=1685679395;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YJtw62GtGvLodxqlrImmwkb/DnaRXZEiakmDP1KOF8=;
        b=UZ3JYNpzm2vabXEVBXEDqxtxO/L5++RodGH2H8PmOhGDS9MAfKayH4ypVZFZtzvg0P
         3WTPTQ+bZBtPYFUjzZJjMcc2LBzmIFkFBO7QYDs5BdylYa0yUurpgoTSTGhLVB4ddLgz
         o3pSTaA2mQ6GRa+uA1V5unGOw22T5KR+0YnzKjtyxX1gR1Uq+yt7kz5vcj8WH3tcswLX
         o8ciKgw7qEy3JpzbKkuKE3nR8B0TtDnchU0AQsvAd03uSnym4EfMlecas9Vc8l1mjZRr
         N+6faxjI/yTkgxtXQ8O0HWAHAKtZCxPhFCZ5vsACdieqicmVn5bl+G0Wzs0h0WotUKl3
         mBZg==
X-Gm-Message-State: AC+VfDxSzJPzwd9gUp1AHLk0DTTgXQuGpd/minELrQ8D/fbUto+bpeLB
        HlKfpCoYpRWTRTYGzFjeJRBIMrhQGfBZ
X-Google-Smtp-Source: ACHHUZ7+2ASkPEkBngTb5kF2Pga79bea/NaDa0+puZhbsdGsdaq/QBqPR8/RdIFb+ghPhxLGJrN07edkfjw0
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:b145:0:b0:552:f777:88ce with SMTP id
 p66-20020a81b145000000b00552f77788cemr11660614ywh.3.1683087395559; Tue, 02
 May 2023 21:16:35 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Wed,  3 May 2023 04:16:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503041631.3368796-1-mizhang@google.com>
Subject: [PATCH] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspace to
save/restore the register value during migration. Missing this may cause
userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to port the
value to the target VM.

Fixes: b07a5c53d42a ("KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable TSX on guest that lack it")
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 237c483b1230..2236cfee4b7a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1431,7 +1431,7 @@ static const u32 msrs_to_save_base[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL,
+	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
 	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
 	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
 	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
-- 
2.40.1.495.gc816e09b53d-goog

