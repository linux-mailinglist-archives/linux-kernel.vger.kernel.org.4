Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5093D74AF2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGGK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjGGK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:56:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA6211E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:56:23 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD98A3F363
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688727381;
        bh=QIqxOuEMfymVjnTNBLkJVxXaeMv8lGdAOtu8dboON2E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sz8hLHD0IpVzIkrrdjuERdG1JnV6tigT6HxaYKj3+/6kdc74yV1KyhJAKejy0Kz3P
         lRezd4QOteLNspAr7ygOR6+277iELvTRhWIaR6Il9fDrMOiUv6mlJEsIOCd5GaUqr2
         B0c7ORbo8s/rodjXMfFsnQ6w6HU9BQLxcQM3yDhNyWl43jYshL3F1Bx+IpA0IwJol1
         iG+1l+38JIXlRKvKbAXy5mL/ciAIhdfqhXip5XrTfU9KWmySIv3p07NcClY1UP3P7t
         7GM4kXkI/+SZ1O0zjYKfsGXDu20OFkg2TWC5tmQPsGlKu7QOrT1GARdh1I0sUCVPF6
         90z1mQFAQYzuQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31273e0507dso955527f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688727381; x=1691319381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIqxOuEMfymVjnTNBLkJVxXaeMv8lGdAOtu8dboON2E=;
        b=CWRMTLij2X11E6XU33DvJ0zn8UT6c4qm5HM9GDtZ6Ah1g6hZit3cv9I4BDGiJB3LpT
         UDhqZAw1H4H5qiKF7txztG3WIt628SdSHz7J7KP17XvZj948rDeQZAo4eXu1IFhVAd18
         IWOxCFtYgqL9ZpftDAZnUj08IZy7jbWBKX2kkRQjq/GmdrGncnxTuFDo2OvGTxPrqoBN
         ECDhTMAXv1zhxMGg3NFgwAzHqMDuKkKpb8dg0+VRUxE/YpGaFFJCEvmREbfRpSiA8Ij9
         wFIhajquzVNpIoDLH7HczuwqLi2QHPihFVnbCKwFHlDSp4/gjkqgFG3eQkYOtn2/BUrK
         UtPw==
X-Gm-Message-State: ABy/qLaYBqpuNdMW3sn5X7N5HO+6u9LmEYb//Lm3FGmM1t6UQVNWm6q2
        nAIvC+eFIlv0vJxQ8GZO3bvYrljXeOjC+gD1Zd5J/At+ayjWZ7Nb7aYfWudHeisbWeAl9ykRx78
        JLcyl+r1dsGbks3NQ+keEj1PnO8cZinbT/NxCNJ6srA==
X-Received: by 2002:a5d:58c9:0:b0:315:8a86:cf7f with SMTP id o9-20020a5d58c9000000b003158a86cf7fmr367722wrf.70.1688727381178;
        Fri, 07 Jul 2023 03:56:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPcBq/x3luqhHqQLHkwNXy6JFR/UiDrKJ2jq4kuJt4OATrPTgzodB7T+9UvAt45nd4W5wtWQ==
X-Received: by 2002:a5d:58c9:0:b0:315:8a86:cf7f with SMTP id o9-20020a5d58c9000000b003158a86cf7fmr367704wrf.70.1688727380897;
        Fri, 07 Jul 2023 03:56:20 -0700 (PDT)
Received: from localhost ([137.220.91.195])
        by smtp.gmail.com with ESMTPSA id f18-20020adff992000000b003143c532431sm4164228wrr.27.2023.07.07.03.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 03:56:20 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Add support for modern x86-64-v* march
Date:   Fri,  7 Jul 2023 11:56:00 +0100
Message-Id: <20230707105601.133221-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for setting march to x86-64-v2, x86-64-v3, x86-64-v4 with
tuning set to an early family of CPUs that support such instruction
levels. By default gcc sets generic tuning for x86-64-v*, which is
suboptimal for all brands of CPUs with such instruction set support.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 arch/x86/Kconfig.cpu | 23 ++++++++++++++++++++++-
 arch/x86/Makefile    | 11 +++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 00468adf18..70e70b4733 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -294,6 +294,27 @@ config GENERIC_CPU
 	  Generic x86-64 CPU.
 	  Run equally well on all x86-64 CPUs.
 
+config X86_64_V2
+	bool "x86-64-v2"
+	depends on X86_64
+	help
+	  x86-64-v2 CPU.
+	  Run well on x86-64-v2 capable CPUs.
+
+config X86_64_V3
+	bool "x86-64-v3"
+	depends on X86_64
+	help
+	  x86-64-v3 CPU.
+	  Run well on x86-64-v3 capable CPUs.
+
+config X86_64_V4
+	bool "x86-64-v4"
+	depends on X86_64
+	help
+	  x86-64-v4 CPU.
+	  Run well on x86-64-v4 capable CPUs.
+
 endchoice
 
 config X86_GENERIC
@@ -318,7 +339,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || MPSC
-	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
+	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU || X86_64_V2 || X86_64_V3 || X86_64_V4
 	default "4" if MELAN || M486SX || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fdc2e3abd6..ee97501970 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -154,6 +154,14 @@ else
         cflags-$(CONFIG_MCORE2)		+= -march=core2
         cflags-$(CONFIG_MATOM)		+= -march=atom
         cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
+        # Note gcc for -march=x86-64-v* sets genetic tuning only,
+        # rather than something sensible / minimum tuning from the
+        # same family. Set mtune to early family of CPUs that support
+        # such instructions, which works better across all CPU brands.
+        cflags-$(CONFIG_X86_64_V2)	+= -march=x86-64-v2 -mtune=nehalem
+        cflags-$(CONFIG_X86_64_V3)	+= -march=x86-64-v3 -mtune=skylake
+        cflags-$(CONFIG_X86_64_V4)	+= -march=x86-64-v4 -mtune=skylake-avx512
+
         KBUILD_CFLAGS += $(cflags-y)
 
         rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
@@ -161,6 +169,9 @@ else
         rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
         rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
         rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
+        rustflags-$(CONFIG_X86_64_V2)	+= -Ctarget-cpu=x86-64-v2
+        rustflags-$(CONFIG_X86_64_V3)	+= -Ctarget-cpu=x86-64-v3
+        rustflags-$(CONFIG_X86_64_V4)	+= -Ctarget-cpu=x86-64-v4
         KBUILD_RUSTFLAGS += $(rustflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
-- 
2.34.1

