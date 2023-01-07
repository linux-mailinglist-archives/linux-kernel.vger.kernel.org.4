Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F77660B48
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjAGBKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbjAGBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:10:37 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76C848CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:10:32 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y8-20020a170902b48800b00192a600df83so2230215plr.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SUs8tClANttqi+Hnol8wJcTkjKVIAnbsM87bTemrCQY=;
        b=qWWqo91BVV3+ytqxD755nsAH10ni6r17FBuf3NIVJ2t+6M9OJ5GZ0EPcOGUpCSvhAz
         bR+QCshs/pBpsOE8ASAe4TOXSVX0DvK2Sh5JpxYGmZdBYsfk+UfsSmEqF8idhpiegdok
         SmYHW+Fx0sjU9GyW903xb6vpardDBVq8T1gXoO3O5/8ovMWLlExiF+m7rLHfmHEzzDPE
         cM8xFE+Rn4wMOsSAWW9vN4cm2aDnnUS8dcOJJGJuo7ZCW/kxbxvVaVa8HykjSkkw4YFn
         vy2UORCYy6kp1pZYyoXum0+320A12BaWQZlxT4Fei5X9uZiF8mSdexxhJX6oN57zdkou
         jHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUs8tClANttqi+Hnol8wJcTkjKVIAnbsM87bTemrCQY=;
        b=M/oPUCkNuMJjC+EV08ZnT7MAOcZFaAkrOd67FzS80zaugfVZhcGFTh5cL/RyLU4YZJ
         41i6iCC/GS2zi5vL6YoQBKrwRwfqGBkWFwXFmyTHccPXUG4rV42RPKD439bcnKb+JQjW
         jpoF95cf0FB0v1vPYwRb3przCKgD8MLeVZRlqOEGbPos5dzfckbQVOsxvnmC89QbXWUP
         6JdBFRbwqKFJv7WwYyxtperh8xNYUUoToCaZX+HmspidizdBpN6Vw6THQlpiZMdemgIJ
         JdGYSaTV/2IgUrwr3AFzAdiFcx4jane/3QYxRje0af+J2xZYx/1uI6OMxADnj8/Wk6jC
         Sp1w==
X-Gm-Message-State: AFqh2kqi4jJIDiznkG+HPq03Zws0GrQpdzDD5Ln2a0FY/ukiBdJWtgoE
        uBUc16I5UW7w37LwwDoY/a9F2OY4pn8=
X-Google-Smtp-Source: AMrXdXt3bMUn4GBz+6Q3Ao/qEuOA+If6p/VLctEyUd0CmvrocjSXdNvyLH1tnvT8nWhQYYf7l77/Vx7K63w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b611:b0:189:e687:b350 with SMTP id
 b17-20020a170902b61100b00189e687b350mr4637509pls.33.1673053832137; Fri, 06
 Jan 2023 17:10:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  7 Jan 2023 01:10:21 +0000
In-Reply-To: <20230107011025.565472-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230107011025.565472-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230107011025.565472-3-seanjc@google.com>
Subject: [PATCH 2/6] KVM: x86: Inject #GP on x2APIC WRMSR that sets reserved
 bits 63:32
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
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

Reject attempts to set bits 63:32 for 32-bit x2APIC registers, i.e. all
x2APIC registers except ICR.  Per Intel's SDM:

  Non-zero writes (by WRMSR instruction) to reserved bits to these
  registers will raise a general protection fault exception

Opportunistically fix a typo in a nearby comment.

Reported-by: Marc Orr <marcorr@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index f77da92c6ea6..bf53e4752f30 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3108,13 +3108,17 @@ static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data)
 {
 	/*
-	 * ICR is a 64-bit register in x2APIC mode (and Hyper'v PV vAPIC) and
+	 * ICR is a 64-bit register in x2APIC mode (and Hyper-V PV vAPIC) and
 	 * can be written as such, all other registers remain accessible only
 	 * through 32-bit reads/writes.
 	 */
 	if (reg == APIC_ICR)
 		return kvm_x2apic_icr_write(apic, data);
 
+	/* Bits 63:32 are reserved in all other registers. */
+	if (data >> 32)
+		return 1;
+
 	return kvm_lapic_reg_write(apic, reg, (u32)data);
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

