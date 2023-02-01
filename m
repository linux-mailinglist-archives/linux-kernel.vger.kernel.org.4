Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5939468647E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBAKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjBAKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:42 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BEF22A30
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:13 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso12627867edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5K0pl1+Hpl1utWVuYLmia50ybxVZ915Svs1mkYim4pM=;
        b=AZ9csdjMBU+FO+3CE5q5XDNRyaZ+1mlI2Lj3G1o2WNntXFQVTVDho9LCPGR3ZrjnXW
         JzNnaFIPmXpm1MpNtgYY9TfcRGV/I80g3/DhYrNneq1VaDoh+xCyAM3n4ZUB4PFiJqFv
         GGn8eklaQ1dnG02WA+6uKaN01WVr/3jbL7WzodfEkxccXhoCtmRiM0EBfAG3LxVXbQZV
         i44+kQsGiH2Ml3pjlbpo89OSHLLMHSBeFOAjyXQ0oG8pg4GtPyrrCZHUYYir8456Jh6h
         5dDC6ExL1FQ8xWFj8hVPrPcEDZ8PoUEG/UNWhCmCOrvuvhxntp5jsxy0+egWKDo9xi3C
         UstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K0pl1+Hpl1utWVuYLmia50ybxVZ915Svs1mkYim4pM=;
        b=kMJ3trocu9HwZfv4gzNVvXZKzBWHkOCU2J40p0aFTm8JqRAQFNSt9XMuwetjc8grre
         X6qLDVYTDaV3/IuVq96K8H5UuqroWU4HfGG1szhXp2haynqaNlaJThal84E1ntuok5rA
         FFbx0F0x82a1KY/KZZb/24MEyujTDXphex2miEzarpFJ1Cy9qBngozap7Lnf6kSw8qCC
         iysTkRFpgwlpg7M+0U6djdCuurFa0K7Nz5bxbPd2iQ8CEe9734ltDzy0XN7SYiYyTwGH
         /I20FTfV6o6f241bEeQHaHrISTg8IqbX0FlChGkRsdEk8gHIbvnpXD/qaOrYZ+Iaahv3
         zsXg==
X-Gm-Message-State: AO0yUKWeasW6jnWdhXoOl/tGP2I4aP+MryLAU+ymGYts6AxRBbiYd7B/
        8n4KCgSnS5k1LKN+PIG+FoxqzW93w+zh
X-Google-Smtp-Source: AK7set+MIwBZlCh4FsMdr7pXxaPBRLjcasYsOx+njItP8dkSsNSFXlEsZ3xNBcQ6mJPWDYNmVw5G7qWj5uvy
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:aa7:cb43:0:b0:4a2:46c7:888b with SMTP id
 w3-20020aa7cb43000000b004a246c7888bmr446208edt.36.1675247892003; Wed, 01 Feb
 2023 02:38:12 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:37:54 +0000
In-Reply-To: <20230201103755.1398086-1-qperret@google.com>
Mime-Version: 1.0
References: <20230201103755.1398086-1-qperret@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201103755.1398086-5-qperret@google.com>
Subject: [PATCH 4/4] KVM: arm64: Finalise EL2 state from pKVM PSCI relay
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, Quentin Perret <qperret@google.com>
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

The EL2 state is not initialised correctly when a CPU comes out of
CPU_{SUSPEND,OFF} as the finalise_el2 function is not being called.
Let's directly call finalise_el2_state from this path to solve the
issue.

Fixes: 504ee23611c4 ("arm64: Add the arm64.nosve command line option")
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index c953fb4b9a13..a6d67c2bb5ae 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -183,6 +183,7 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 
 	/* Initialize EL2 CPU state to sane values. */
 	init_el2_state				// Clobbers x0..x2
+	finalise_el2_state
 
 	/* Enable MMU, set vectors and stack. */
 	mov	x0, x28
-- 
2.39.1.456.gfc5497dd1b-goog

