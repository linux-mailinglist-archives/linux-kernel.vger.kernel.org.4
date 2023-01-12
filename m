Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF5666900
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjALCjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjALCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB9479C3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b17so11305207pld.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fyn0GdRRcwP8sEkoul8xRTQW4/xqEE84/pUO6q4jry4=;
        b=IEddBWfA0qPNO00OxgfoK4CKV9d09Bd4y54847jAwbFweYO9DneeymijJHbgA3Jx4M
         2T2ydzmm155UbNYt6KLnGDT23A5GegwW3WRjMDpuumJ7X2twAkq0s5wKQsrtcq5omnqy
         jFR2k1rNMMafgVv/HSyBj9ixCUBDkGE/AOoBXLz6ldxULtCiueCt4Qjz+IYE3USFmAOc
         RgFbc6lryzDLUurHPMtFT7e0Ae0v1TKRU7jFkNcZVpxrME3wERrB8eIWcArpbrQt2Kur
         VOly5rWj35eNold4uK02f8N1LQ0nbKBGHe+IqwgOx1RZg5jqP2uU9BFnbKSrHzFt1PQO
         TaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyn0GdRRcwP8sEkoul8xRTQW4/xqEE84/pUO6q4jry4=;
        b=oH62PyQRE86cNjY5YTCQ2FLRcbGkEW4N2WLI/z3y7sjBAm6ZF2Rgu2dITVpTzO87hO
         88ZnVqPqRDiWoQnxHhr7cOAdevEtEWv1LGBKREEOUtsPhHd5LWE4bFkvWJqqpLGeuB0s
         jGtBjPlauqgSHxsAoUte4gUyAoVFw0ebUXR74UM06Tru3A7Y+mH49TOouR3bhFe3vqTI
         QvRwFjCepPHKhJK6v0C7KyykTR8aRsHKzTqQrTgAaup9ees5hOq+gagjgyVUoBzFjQfK
         uuVfyVeFIUU6n6PU/IaWql2T1gPMkCRbJr+cPyQbDoPnzfCJhLLURIPXNoHTCBuiaJc1
         NJBA==
X-Gm-Message-State: AFqh2kp2Ylmb8yBg5loEmz6qqDnZ5zlrqjlOj8GoJCDCTyteUcngfu1U
        gfvJIeO06P1pZRg7zXkMcgZ/+Q==
X-Google-Smtp-Source: AMrXdXt+iyoWsGiLhm+hoj5To9SC8IuRrcK65ARRd+UXWQWO66EDPKTi8SA1qcl9YCgAUIAMBKs0dw==
X-Received: by 2002:a17:902:b58a:b0:186:def0:66f2 with SMTP id a10-20020a170902b58a00b00186def066f2mr75597838pls.11.1673491171565;
        Wed, 11 Jan 2023 18:39:31 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:31 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 6/7] KVM: arm64: Mask FEAT_CCIDX
Date:   Thu, 12 Jan 2023 11:38:51 +0900
Message-Id: <20230112023852.42012-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112023852.42012-1-akihiko.odaki@daynix.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCSIDR access handler masks the associativity bits according to the
bit layout for processors without FEAT_CCIDX. KVM also assumes CCSIDR is
32-bit where it will be 64-bit if FEAT_CCIDX is enabled. Mask FEAT_CCIDX
so that these assumptions hold.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/sys_regs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d5ee52d6bf73..5617de916c80 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1155,6 +1155,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon),
 				  pmuver_to_perfmon(vcpu_pmuver(vcpu)));
 		break;
+	case SYS_ID_AA64MMFR2_EL1:
+		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
+		break;
+	case SYS_ID_MMFR4_EL1:
+		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_EL1_CCIDX);
+		break;
 	}
 
 	return val;
@@ -1718,6 +1724,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
@@ -2219,6 +2226,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	{ Op1(1), CRn( 0), CRm( 0), Op2(0), access_ccsidr },
 	{ Op1(1), CRn( 0), CRm( 0), Op2(1), access_clidr },
+
+	/* CCSIDR2 */
+	{ Op1(1), CRn( 0), CRm( 0),  Op2(2), undef_access },
+
 	{ Op1(2), CRn( 0), CRm( 0), Op2(0), access_csselr, NULL, CSSELR_EL1 },
 };
 
-- 
2.39.0

