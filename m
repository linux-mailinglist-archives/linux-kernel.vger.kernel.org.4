Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2356BC590
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCPFUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCPFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:20:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82CAA262
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:20:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso4970094pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN29kza4KP9+va9q8WQlQCM3UUiFt6hAQqDjXosgzqs=;
        b=muzRYG4npi5Fc+pBJCCHrt/h4NEe3GwxCYPXhlBC2XF0Ypm5YpzWQOkTd/7jltf4rI
         ha9wslI/6XTVb5f4gwyFVZfmazKVY0Z14ReT6xI2FPYBPf/AZYte+I+3N+OH3F+nugRY
         vQB70q2AnoeOUU6nLsIKS6woKvEQwiqWlTIiRruqr7unVdkDlQEuRZH7/w0QKE4e7zgp
         JG0gmv+wjyRoQ1TVYL8k81h5BEHGGafjiZH4nzUrN/JtucKJ2U1EgqtsnUuPTWF1fSiV
         GsrUVx/EZmQZZ/s/AxcKQ5GpSSwVLO8M8148R7rkeTDXFqWx+io6wqB5mHta8lwr46ab
         uAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN29kza4KP9+va9q8WQlQCM3UUiFt6hAQqDjXosgzqs=;
        b=rk5el88VuNrshUCxCjqAiK0Xj/K8oGyiP+SLtxyH4L+QRarn60J6F1GB9HsJ08Sy9U
         m6YMylWP7f0KSVjbk6VnRmrFejt75Rad9nlEkLv4vZtRdTsZvFVd44DZltCb5o01ael9
         wGLpGHHD/THosCCDdlfTCXYc5rvBwzx2Vn3KYXY2B+ex85YTk3JBtqL/gxOAvzFMAgc6
         fOc/o2wJG2EAryk4Uy8QjIYDMhUzIYsdI5hESjav4oqwFwKQ2+lNj6+dRmZ4iu7eud93
         u0/Zc2s2pTZMBmm/peu6o8+l6HXGi6EJhu4tFmm9i9PJjAauL9fxD+SfuXN3jgg6VBhR
         SIYA==
X-Gm-Message-State: AO0yUKV0vHj07LZHcMZmUa/17jXQu8VjOssFnUt4fJpS470snJbv49iP
        cW1XEEv6N6C1GqHXb1I4XCo=
X-Google-Smtp-Source: AK7set+PvqwxPTJ0mHbgfxxOfLfXi24zg5IjBzLiPkmV1jFA5jjMCPOv+hdI7+J7/GWt5tb0wf1SOQ==
X-Received: by 2002:a17:90b:388d:b0:234:b082:48a2 with SMTP id mu13-20020a17090b388d00b00234b08248a2mr2448834pjb.28.1678944008407;
        Wed, 15 Mar 2023 22:20:08 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b0019a593e45f1sm4475708plb.261.2023.03.15.22.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:20:08 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: hisi: Add S5 IO map
Date:   Thu, 16 Mar 2023 13:19:34 +0800
Message-Id: <20230316051936.1775033-3-mmyangfl@gmail.com>
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

Hisilion S5 platform supports ARM Cortex-A7 processors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm/mach-hisi/hisilicon.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 9f56b0f56..f9109df8c 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -83,3 +83,40 @@ DT_MACHINE_START(S40, "Hisilicon S40 (Flattened Device Tree)")
 	.map_io		= s40_map_io,
 	.dt_compat	= s40_compat,
 MACHINE_END
+
+#define S5_IOCH2_PHYS_BASE		0xff000000
+#define S5_IOCH2_VIRT_BASE		0xfb000000
+#define S5_IOCH2_SIZE			0x00430000
+
+static struct map_desc s5_io_desc[] __initdata = {
+	{
+		.pfn		= __phys_to_pfn(S5_IOCH2_PHYS_BASE),
+		.virtual	= S5_IOCH2_VIRT_BASE,
+		.length		= S5_IOCH2_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.pfn		= __phys_to_pfn(S40_IOCH1_PHYS_BASE),
+		.virtual	= S40_IOCH1_VIRT_BASE,
+		.length		= S40_IOCH1_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init s5_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(s5_io_desc, ARRAY_SIZE(s5_io_desc));
+}
+
+static const char *const s5_compat[] __initconst = {
+	"hisilicon,hi3716cv200",
+	"hisilicon,hi3716mv410",
+	"hisilicon,hi3798mv100",
+	NULL,
+};
+
+DT_MACHINE_START(S5, "Hisilicon S5 (Flattened Device Tree)")
+	.map_io		= s5_map_io,
+	.dt_compat	= s5_compat,
+MACHINE_END
-- 
2.39.2

