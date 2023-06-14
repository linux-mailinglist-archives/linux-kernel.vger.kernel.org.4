Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46346720816
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjFBRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjFBRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:02:53 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492BB1AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:02:52 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so117570439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685725371; x=1688317371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZrtPESLe1mA5daPGrUc+60GXQlGnhOLsAUJu36d7rQ=;
        b=Qq3RLBS2mk0SnALShNCtm+TQlg+XH/AHekNH7/7QlGAv3Kwq/6fPi6+CvfRavpIs4G
         RjyTeXe+0RGaZAufFJ8EvFNFa8pOjeTTjjb8sD9rItu1zRExurnNtBOtX6w1QJedD+7I
         afR/Bn/wNwB2NO7fNerz8ES6XgY4MyN711P03otg/ynXmiG0KHjiA/NCjGChETeqa8Sq
         PPIW2euhDqJ/s3oFviuWT4EcIxz18d4QuSIOimUwO4KwNQ9xdjmAWN3FZO+WhB+n8/fm
         Z+b1LzGrVLf99x0xH1gni5y4fL0Jf+jIx8h2sro9EeSCJDdt5AbgU5s/l97G1yjsUE5q
         7IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725371; x=1688317371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZrtPESLe1mA5daPGrUc+60GXQlGnhOLsAUJu36d7rQ=;
        b=b8l+q3MjEoZExbEeHwSh4MJyHmjBDjz0GWjX10WqsCV4LIRcUo6uRu6G9qyCyn7wGv
         X80Mnj+hKLHfrv9UwUYyjoUrXMufInvgEkoJ6aAeMR7IRkah1WBzKP87xBLKfhOtOmT1
         rRgPwf03p65KKAYWUn+WRn13Ip22xY6q3dlzA3LOJmQEOblI6kZ+c6+ayn4JMYVItxcK
         gmeZMCYQteBweac+ylqdYQEbCk0MPLcNLOULeOxP7qmcBz9NxOc7stR4SA2bVhjoHYum
         +1Qd/rZn0sBQwbf2EYpDU2QIHQMfrmGdny5JdVv7eTsuGnR0oKBRPREph6yB1Pdbw4nf
         zGFg==
X-Gm-Message-State: AC+VfDxuJ7oJ/kVGHxi7tsIVHVrwVU1YSgc0AkeHusVL4zmFDz97m1oP
        L6MGj4J3RzOE0I9QYOShgocO6C6/oAdQZhqSRg==
X-Google-Smtp-Source: ACHHUZ7jQlp0MVeJbVOdhempnaGESwJq6ISHR98G4dlzn8EXHZtiMaS3iQFnqJ6k1wVSGZ9JZpTQJ2Y+ISmEsdfLAw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a6b:5904:0:b0:766:6741:8849 with SMTP
 id n4-20020a6b5904000000b0076667418849mr1203200iob.3.1685725371731; Fri, 02
 Jun 2023 10:02:51 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:01:45 +0000
In-Reply-To: <20230602170147.1541355-1-coltonlewis@google.com>
Mime-Version: 1.0
References: <20230602170147.1541355-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602170147.1541355-2-coltonlewis@google.com>
Subject: [PATCH 1/3] arm64: Add a capability for FEAT_BBM level 2
From:   Colton Lewis <coltonlewis@google.com>
To:     kvm@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Ricardo Koller <ricarkol@google.com>
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

From: Ricardo Koller <ricarkol@google.com>

Add a new capability to detect "Stage-2 Translation table
break-before-make" (FEAT_BBM) level 2.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/arm64/kernel/cpufeature.c | 11 +++++++++++
 arch/arm64/tools/cpucaps       |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c331c49a7d19c..c538060f7f66b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2455,6 +2455,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 		.matches = has_cpuid_feature,
 	},
+	{
+		.desc = "Stage-2 Translation table break-before-make level 2",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_STAGE2_BBM2,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR2_EL1_BBM_SHIFT,
+		.field_width = 4,
+		.min_field_value = 2,
+		.matches = has_cpuid_feature,
+	},
 	{
 		.desc = "TLB range maintenance instructions",
 		.capability = ARM64_HAS_TLB_RANGE,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 40ba95472594d..010aca1892642 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -41,6 +41,7 @@ HAS_PAN
 HAS_RAS_EXTN
 HAS_RNG
 HAS_SB
+HAS_STAGE2_BBM2
 HAS_STAGE2_FWB
 HAS_TIDCP1
 HAS_TLB_RANGE
--
2.41.0.rc0.172.g3f132b7071-goog
