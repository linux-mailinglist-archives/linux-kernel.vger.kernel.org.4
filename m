Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025C06952A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBMVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBMVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:04:10 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494221A2B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z8-20020a170902834800b001990ad8de5bso7976224pln.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d5Y9CwOq9CkLMA/pzajcIbcjKDJQOL+VAkXtqdrmoQ=;
        b=dQUCK+3atvzjAYnG6diZ749RR4YR1PjBljouKrQXGQ1jhV0ZMQ0ytCKw7uOSonFRaP
         scXi1sRg6thyg+6ldgeP5rzi78mly8cke/IMPcv9qWsCtpOkSQei4quBvfLN0HLs9nEs
         /BBALLqR863Yln2NaRRgr5ICFSTE9rTDtvre6So1yrA+4VNsqUk9ZKHgwWuy+OyZtWzn
         P8BsBL7dEEdGxwpYn7K5WCYExVUhArxceaJ4ezy6fl4U0cpWAIeOrLHgqxur/GBlTtTA
         rpd9IbIG6/bOTywsMcSUTtw1ZK755V/zzQerNorhGLQEMnakuOQi3Sq2//FiRgIpaU4B
         CCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d5Y9CwOq9CkLMA/pzajcIbcjKDJQOL+VAkXtqdrmoQ=;
        b=k0+7lEPBg9gywaBthATU2MjFvNsWVI1kifrokxzPh8Yqr1P/F66xVRmpnrIuXB6iG8
         kfY/Ax/fKyWN9uHkXso2FIg0IsYJYTSnGb/I4Wt+n54D8vYrEh58cGbtGyZkZZZyJPiv
         yWiuXeziTvvphZSHtSyQexYwPaIBwnQwMFLvypMF9Y6IdQQIO23rcH5lWc60Y5ZbPcxm
         s8TvMcZVgZlUNoVspj3M0BKivwIAhfS52dxuvtBGl1Y0b+s6SyFCwARaX4C+tb8cfMHB
         0yEKgxGzZ1XI4Lu+bezCB1udYJQzmoMTS1w37zs/0kwH03lhEqraGWYGojBqdZl5n5yu
         tKkw==
X-Gm-Message-State: AO0yUKXSHQw3E60agVnlj9L7/8P8lxQklVHv4yAXXFE16q+uDAourKfN
        4e+YVxdpx9UjWMEbJ8fIurv+0v48BzH7390=
X-Google-Smtp-Source: AK7set/acRsddQkT9b91dxC7gpzYx4jToPjVSTJJ/eAZPdxerL9ylmXMUS+Raxg5ZILhlWxD65DXjP3BZXzpS2Y=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:90a:7d13:b0:230:eeba:2176 with SMTP
 id g19-20020a17090a7d1300b00230eeba2176mr4399859pjl.56.1676322225854; Mon, 13
 Feb 2023 13:03:45 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:19 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-9-zalbassam@google.com>
Subject: [PATCH v3 8/8] ARM: mach-virt: Select PMUv3 driver by default
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 137f89ad05211..3802997fb36e6 100644
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
2.39.1.581.gbfd45094c4-goog

