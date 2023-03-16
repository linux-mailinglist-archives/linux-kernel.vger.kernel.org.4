Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35366BC58F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCPFUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCPFUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:20:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F4DA9DFA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:20:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso4969957pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnS/2L5eapvwqGTZQsUuWuWrYgLcDrvgqwnYFYygers=;
        b=QE826bxyY1maP+6E6wVynxn9Mv6IuqRQViB2FhQD0h/chSW/Kw+weOZ4aZ4wVs81Pf
         Ing4sukZ64gzdoNgoFnEKc1PUpuvKZmKztMqw5eFxiRCO8X1OIjuVsEGuhYJOkjl/Jqf
         taUF8/Q8HWqTvOx3TQmc1s2avXtx3xP0JavcyM3wlC2IBVTz17uGXho9CLqP0sRoe65f
         vdOyOoCURiYufz8tH653p2RPal+y1gioShzqK6otX5Z01blem1kiFqghfcjNxYaJergQ
         BF9XVxFbTiGT9aWCVT+nHcza7vCFaZ89i89ufYjjHTfRjOfmpXqO04UtM7B/bUPc5DS6
         1ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnS/2L5eapvwqGTZQsUuWuWrYgLcDrvgqwnYFYygers=;
        b=ETdVZNVcPRt32zKHYi7IgqD/3ui8R/b2t9bacTQwURSfL3vm0vPl4AkGPprOVJq2+T
         C6qSL7B0NRp9/Vx6u9FBB+V0JvK0XLkQ79zHqnvE/M5KEC68n0tHRCZ2CyK58cofJCzO
         pMkHT+SKnuL1gG6Hzg2ySG73SH4J24QrJnqrPTLVXTLoNvbcD/WSNHY9bzLBk4gEcF1L
         mFxJe70y+IJUL8nkEin1y93R0IodKU5txq2Fm6oujOExX0k02VCRm+zKoPV8R+YOZ5Ex
         JY+oHJJQPccpxCb0VKMC8/+xN4Z7M/pGejgMZ9hphDGXI8ejEGsQUqmBHGYhEiPXB3t7
         4B7g==
X-Gm-Message-State: AO0yUKVDUN+i1ctotz/1Qv/adkJs7MBVmHyev5ZVXCIKctwj9N7LH4sW
        myB1MQZDpcWtXHxg4jMy4gzMEvld2LE418mG+D0=
X-Google-Smtp-Source: AK7set9cI/OHaF/cbDFfzC0cU9Z94ikfd7AyHCR0H2ZEwPcKdsECly1zQatRRbZthu1DOkP6YL7UfA==
X-Received: by 2002:a17:902:ce92:b0:19c:fd73:5586 with SMTP id f18-20020a170902ce9200b0019cfd735586mr2269077plg.38.1678944002224;
        Wed, 15 Mar 2023 22:20:02 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b0019a593e45f1sm4475708plb.261.2023.03.15.22.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:20:02 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: hisi: Add S40 IO map
Date:   Thu, 16 Mar 2023 13:19:33 +0800
Message-Id: <20230316051936.1775033-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316051936.1775033-1-mmyangfl@gmail.com>
References: <20230316051936.1775033-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilion S40 platform supports ARM Cortex-A9 processors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm/mach-hisi/hisilicon.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index b8d14b369..9f56b0f56 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -50,3 +50,36 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
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
+	"hisilicon,hi3798cv200",
+	"hisilicon,hi3796mv200",
+	"hisilicon,hi3798cv200",
+	"hisilicon,hi3798mv200",
+	"hisilicon,hi3798mv300",
+	NULL,
+};
+
+DT_MACHINE_START(S40, "Hisilicon S40 (Flattened Device Tree)")
+	.map_io		= s40_map_io,
+	.dt_compat	= s40_compat,
+MACHINE_END
-- 
2.39.2

