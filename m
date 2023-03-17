Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2916BE462
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCQIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCQIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:54:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA005359A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso4493396pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOLGWcJbI33pKMiOKcsUUwQ3x27zjj86CViw4xcRW1I=;
        b=AY5X+pY0r49N1+Yqjy40dRA/4DcZQwQ9zZhaZKoPz5nHc+f37CXzCPfvsszYbrdzZc
         Kq3c617MzE84KZ36XW0iCJ1tzrHBNZnp4srUT1KN2V16XyQ+bw2J6v1DhLcKR/+4wBoF
         HHKDddAVDHYcOYhc6omcY+0Voew7lhp42uRTdnEfpeY+kbRmzwoRylNcmjMfAzKsX4bu
         uTnjIjxZiyv+H90XGCbSmN29eJr9b/XSzVJFmRJr+j1DLsfd4zLEfd5MSPhUwG+mBn7u
         AURs1iXfGHvyQW7X56lGVNvToSO+QcZ+K4fuqjOotJxXXqM0/hHbf5I/N4vLHEtNQS8Z
         yjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOLGWcJbI33pKMiOKcsUUwQ3x27zjj86CViw4xcRW1I=;
        b=Blo1kidhcQp5bO5fDZsjEReuYIwoJSONwwhYflvvZRoLIcnk+C6jXa4l9NJhaF6As5
         NNBCpi/WcEmqDlC5kc+jrjf0PwK5hNrUmmTcF7FL6FHCVcDl9iBuFs51DDFGx/2tNHvr
         6E3Q9V5DCEkyrJPyYGQIN0we3ptjV2+MLJ+AfcQ6IUT3/qk2OFCZCF+A2OFUFNd0BWOD
         U4IkdUSMYmMTJXrrT8UoKqrHoL8s3gz/E9aC9qlfpG8Xz+QMImHUILHIEtTUdrWpOgBe
         rFLZup54GyV6drw3bdECfJxkUTl0xbp+xPaVWck2zw9odAXuEsLLDUP3+xuHld57G5qq
         1vDg==
X-Gm-Message-State: AO0yUKVzqyDNQ9KMCC0MflycOyH0v9WN7Tc/NhnhXA9JDsQb+D4zaKXA
        drRHEN6fnsElq/0JzzbB3XQ=
X-Google-Smtp-Source: AK7set9BBRQyv/R21Y65BrGAavRWs9ugscwwJTs0DSwsY5hYxvlrxH/v5kNkz1HR0a96Lm65ad9zFQ==
X-Received: by 2002:a17:903:187:b0:19c:eda7:e0fd with SMTP id z7-20020a170903018700b0019ceda7e0fdmr7385531plg.59.1679043254381;
        Fri, 17 Mar 2023 01:54:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm1030775plb.184.2023.03.17.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:54:13 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: hisi: Add S40 IO map
Date:   Fri, 17 Mar 2023 16:53:44 +0800
Message-Id: <20230317085347.10147-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317085347.10147-1-mmyangfl@gmail.com>
References: <20230317085347.10147-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilion S40 platform supports ARM Cortex-A9 processors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm/mach-hisi/hisilicon.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index b8d14b369..2128e6dd5 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -46,7 +46,40 @@ static const char *const hi3xxx_compat[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
+DT_MACHINE_START(HI3620, "HiSilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3xxx_compat,
 MACHINE_END
+
+#define S40_IOCH1_PHYS_BASE		0xf8000000
+#define S40_IOCH1_VIRT_BASE		0xf9000000
+#define S40_IOCH1_SIZE			0x02000000
+
+static struct map_desc s40_io_desc[] __initdata = {
+	{
+		.pfn		= __phys_to_pfn(S40_IOCH1_PHYS_BASE),
+		.virtual	= S40_IOCH1_VIRT_BASE,
+		.length		= S40_IOCH1_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init s40_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(s40_io_desc, ARRAY_SIZE(s40_io_desc));
+}
+
+static const char *const s40_compat[] __initconst = {
+	"hisilicon,hi3796cv200",
+	"hisilicon,hi3796mv200",
+	"hisilicon,hi3798cv200",
+	"hisilicon,hi3798mv200",
+	"hisilicon,hi3798mv300",
+	NULL,
+};
+
+DT_MACHINE_START(S40, "HiSilicon S40 (Flattened Device Tree)")
+	.map_io		= s40_map_io,
+	.dt_compat	= s40_compat,
+MACHINE_END
-- 
2.39.2

