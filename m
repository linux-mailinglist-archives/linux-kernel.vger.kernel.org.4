Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3A686479
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBAKjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjBAKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:25 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF1126EF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:10 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id hp2-20020a1709073e0200b0084d47e3fe82so11611070ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd0FeyMlG74m/nm4XHJil0DTW7Kcn6gyhw0b15r3ih4=;
        b=VtqJzQK9sDGnSBOg9QMtSeyNfUP3G5EGSiBFDu5xjYOD0Uh5vmcmxL62Smu27C/dLn
         tGW60izEIgX7nRCyqz+Vu2uRkJm5JXvaOw8QvBN9CudqLuhuLdMXChD9+PquNW/OXjhj
         iGpXQZLw5mdFNVyqZ66l5DfQ8DO40a5W1cSAyy28AyyckjjBb6Uf8gxjVKDIZhdRUgJt
         D5TNbzz3Y96Mafu24UqZCFrSDCud7a/BoBgKrDMUHFxbU6MySQJXiJ4MnwxKMo5X4STE
         RG+EHkAzMugg355mzM+h7RrBHvoQbI0GCpqL8eZupXxeT0q5SM/utc3i1JwRxfjGBoS6
         1fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd0FeyMlG74m/nm4XHJil0DTW7Kcn6gyhw0b15r3ih4=;
        b=GYA0MwJ0j4SWPf+6npEKVjM6tKvwL0qGNrS19yHhcRmMDqmeqGlHrJVAUztGm/qfFd
         Yj3c596wGzeoq5wJD7mrigsrqY3s4wf2+Bk4ohd+ICyNFHp6HsK4R37FeSrw46IUZVpS
         Iyd3VXooENzPm6hLJeIfv9t7/1DMnh0IcJHSbvXNP9pcUpqosFucuUI6HDZ9atodwKBD
         sFK4TrQVrJjtfue1AsRYgg3ME3+CNQR5VGXmettG2f0X/D+0qP9fkV1Z7CYFGeie7mvu
         TQ4+pZBKLjOWvvqKacE0sPggHeYAB/U4fR2VdecAbr7h3W5D1l1uu4/HxtjhPlJtgpFL
         zZmg==
X-Gm-Message-State: AO0yUKXVdwrn0S/1oEnSKKg7ADLjOaN4jb4jYMtdeUAmfZNmPf5YBnWh
        +EbEQTh93mzAHkDkcFO1Yc6v1/90LjyJ
X-Google-Smtp-Source: AK7set8pUWH/EIRKqNBELwGkOXfTUro9UW9voB6iL5jldWiapgA0tzxfry3rHjCWX353kPSCNlq0/jQ1X/U8
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:906:1781:b0:878:7d2c:6ba4 with SMTP id
 t1-20020a170906178100b008787d2c6ba4mr572762eje.42.1675247888973; Wed, 01 Feb
 2023 02:38:08 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:37:53 +0000
In-Reply-To: <20230201103755.1398086-1-qperret@google.com>
Mime-Version: 1.0
References: <20230201103755.1398086-1-qperret@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201103755.1398086-4-qperret@google.com>
Subject: [PATCH 3/4] KVM: arm64: Use sanitized values in __check_override in nVHE
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

The nVHE EL2 code has access to sanitized values of certain idregs, so
use them directly from __check_override instead of the *_override
variants.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/el2_setup.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index fb7d04b81033..1cc29960fcdb 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -196,6 +196,7 @@
 	__init_el2_nvhe_prepare_eret
 .endm
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 // This will clobber tmp1 and tmp2, and expect tmp1 to contain
 // the id register value as read from the HW
 .macro __check_override idreg, fld, width, pass, fail, tmp1, tmp2
@@ -219,6 +220,19 @@
 	mrs	\tmp1, \idreg\()_el1
 	__check_override \idreg \fld 4 \pass \fail \tmp1 \tmp2
 .endm
+#else
+// This will clobber tmp
+.macro __check_override idreg, fld, width, pass, fail, tmp, ignore
+	ldr_l	\tmp, \idreg\()_el1_sys_val
+	ubfx	\tmp, \tmp, #\fld, #\width
+	cbnz	\tmp, \pass
+	b	\fail
+.endm
+
+.macro check_override idreg, fld, pass, fail, tmp, ignore
+	__check_override \idreg \fld 4 \pass \fail \tmp \ignore
+.endm
+#endif
 
 .macro finalise_el2_state
 	check_override id_aa64pfr0, ID_AA64PFR0_EL1_SVE_SHIFT, .Linit_sve_\@, .Lskip_sve_\@, x1, x2
-- 
2.39.1.456.gfc5497dd1b-goog

