Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCE67D6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjAZUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjAZUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:45:23 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375D7448A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:07 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c12-20020a056a00248c00b0058e1ca45515so1427452pfv.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gau1yQskHf3VXQpkYLtjLur+Qip6kit3p9HDDaJBRs4=;
        b=f1tvDTkJ9Rdj2sN9ssxN48UvzmplgYwTrZ0hhtRdBm9fRaPLn8g8VcDs0rLpbFcHEO
         27uS/Yu9hQmGtLZ99VCsQzwNchjpqj2B6r0Xr8JbcX69qEPLXE/ORk0iBr0fjYz0+nu9
         5FqcIFvNu4h5DsqJ5X6gcJE+XAjXWHcCit7jhK0MSJYvkTi209/LoB2JzX79iYN4FFQm
         K4XiVxY0vElKce6pOAA4fTVctu57lRe6ssarPx+s4HXm82RDYdSwG6tVPxToUsj+qnzK
         sNnF9xQEuFU6bWgkzcAgoyJ8kaKUPKPhSg7qXZMzPNbTFJyUSaAxOjzq7Jy1Wce9mH6r
         SUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gau1yQskHf3VXQpkYLtjLur+Qip6kit3p9HDDaJBRs4=;
        b=1eRZTzgjT9UiBsG6D0HpoZZPHCF7fJ1odRCLxsMbdo84dl45p2W0/51WSLU15LKumz
         h6yyJPyQ9wrKCHjFDpTzDp2LFBdw2tAQyCW02bH2qeB2YA3f6qVT9/zMYNXRNdBtsjKi
         +zLAgS4zYE7Id7NqtBG+zuiZa5pMGwwVEoIDclohkpGAUW25OdOIid3w1g3jH7eCiYPF
         G0SguyXvEQ0rlzrnMVbyr/nkWXQS0kJverTe0YYcHcW+9ebOLsRFoq98F8La++kKwSFP
         1BaN0pCb0AMFBCOOElSFWVE3wi7j5t8C3XEIK4sSKPPKz8Q2pihizHLn1r1p3chCOpct
         pJWw==
X-Gm-Message-State: AO0yUKWbXoRMpRyxVVDGsumwm0eCoKY/mnVqRToNk/nb+Ho2zJpCu5Yx
        bf9t9zHqZD1D6EgzIVGhbRfqY1fQicnOfoo=
X-Google-Smtp-Source: AK7set/TbnBjmUgqAAFzQMjbref3OlBWOk5pcb13kQePVWLM6NrlJPmaTSILrlFJ/sogPIbjRGpVECGiCbZN5ng=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:90a:2983:b0:22c:4174:3ad with SMTP
 id h3-20020a17090a298300b0022c417403admr156376pjd.24.1674765906698; Thu, 26
 Jan 2023 12:45:06 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:44 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-9-zalbassam@google.com>
Subject: [PATCH 8/8] ARM: mach-virt: Select PMUv3 driver by default
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
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

From: Marc Zyngier <marc.zyngier@arm.com>

Since 32bit guests are not unlikely to run on an ARMv8 host,
let's select the PMUv3 driver, which allows the PMU to be used
on such systems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 137f89ad0521..3802997fb36e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -400,6 +400,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_AIROHA
-- 
2.39.0.246.g2a6d74b583-goog

