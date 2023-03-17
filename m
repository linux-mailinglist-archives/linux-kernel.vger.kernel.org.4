Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B96BF1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCQTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCQTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:51:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB704DBF8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso6248177ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWp43EKSObLScNJyve8NVm0+M7i+tQFxyt9k8TiRe9g=;
        b=e0o+1QipaOeuxF3SQj+/1I0NUJYANsvskj+jz+/JVVr1JI/Gi8EhYKPNYf6VCam0BD
         BAsjPkgg5/ctjSm5fbatVkc37cbroqyTAJ5lMHDQqqUyK1lU4+hREwmj8Q8fnx7emkyA
         FqesCCLDpG94eJAu7iyFgDIMb2uvcOYUTcrQgwHxZ/qSMHGAbwYNX1NfDIvwCrf3/yLh
         Qlzcif76NWl2d5Dec/ik4T5zqD5Ogl0pkotQHRqs3F6j3Db5VjWme4evtJbL06vcVC8k
         5G2KHySl3FJNxq+4Y1E8Q2s1mqtvNv/IskSm5DyA1K7kEWGH1hY/bYV0pIPrlheqehC+
         Vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWp43EKSObLScNJyve8NVm0+M7i+tQFxyt9k8TiRe9g=;
        b=GCl3f91qggQyHd4/xjgVGYtxKt7A6UYUY8rLxRXTVXVYAM5ES0CKI4FWnDQW9CbAA2
         DvhefmOHhfzNyoIjzEnHJgCkmHteUr8GonvvovDbAPJuhXeJd73g5QNP2OqEs1lO9vU1
         I/2GGPutuIrEh50c5PYdZ0Z3m0jjdbAoXNPYyXsllzeTSqOmoabj/KkYo1utRbXrPfK2
         t+n/3rf74EqJgQcePwOMKjsDxbnEaW1v68omgb5uxTZ6cfse8VTZG4IcO5l2WR0f0Xjo
         rSsVWmHYUKuh3SdQSBOA07WkY7rqXEvN2peFJb9g1zTjg8QYuxlY3p7CzU2E/w4C1R8q
         6VeQ==
X-Gm-Message-State: AO0yUKUixR5YTUpgo+TJEP3NPGf5NlD2QkWD68YxFNW9mFiy4F9FL24d
        AZZflqgOTqkoXd6bp64NV6Yz6j1FArhWx88=
X-Google-Smtp-Source: AK7set+1dZfI1V93G2NNZOWgyqiVDUpszfGni5yoPVSFDzoxKaFlWRR3P5jO5zsNV2xWLmuL0WJ9RjPmhL3qVro=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:2d1a:0:b0:8ed:3426:8a69 with SMTP id
 t26-20020a252d1a000000b008ed34268a69mr511377ybt.1.1679082648198; Fri, 17 Mar
 2023 12:50:48 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:27 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-9-zalbassam@google.com>
Subject: [PATCH v4 8/8] ARM: mach-virt: Select PMUv3 driver by default
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
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
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
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bc12857e81f9..6f0a2576d17f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -401,6 +401,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_AIROHA
-- 
2.40.0.rc2.332.ga46443480c-goog

