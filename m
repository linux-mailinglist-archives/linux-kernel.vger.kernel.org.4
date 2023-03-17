Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F426BE464
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCQIyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCQIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:54:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0E28E59
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so4625733pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAnpP91EEdF2z/jZBxaUpB4jiBizu8KLOHQYo1Pjrr8=;
        b=Mv6WklCG+Z9x32igzYqf8sCx7tqzbE8IQBJX1pk4OY+uIbWIuWqhwmwSFHy72vLxfZ
         Inyz/r6KieKg6DNROW+uGm1v0+/j7S1KX5W5xDSuwD/qIFDbF64WiqCQ6b0Xcxs+g4BH
         YtvJvsilA5EQlctvxlWa+09VeAa1EWNAP34ImxKrXXyWf04vD7ANtofQFNOt3zXlwl7h
         KWiUFqu7mhVt4Iy8JPZVwyNF2zkXwF+shu4LzYvctGjMssjO9SJ8pUHmJIRuVC1UW0Qy
         r+4OqraQ8IiJw7jWXd1vLjZ0+5L3ataGz4qQgolMkTQBUwbHmWiEo2AO1uPNbS+zq9WF
         Kcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAnpP91EEdF2z/jZBxaUpB4jiBizu8KLOHQYo1Pjrr8=;
        b=4B9K9F1LDcVP1A55AgFty9DdGVWD/bvB9+M9YJuvRPA76pSwCVrGNrauTFq51PplV5
         TU4VIVwWR2Hku9CqyQsEblPS0dLWlhkRssvXBtveuiqngi3VffJBqEZfRHhgC9qXhmn1
         h7SqLKU2IxYlwRa9nYLcfJRY6P52qMJNmbJnz5ieU9vKHyJH8SAg9Vq6l5keMiJxUCF6
         CzG/I0umZ+ZnR6T7KQfdkkweNqiQC8erCfhmLNC1HbRBIoOuNxq+t1Few5cZyn28v8Wo
         HmWun+WusXPbe0bz0xBCHNW82oa9MQltRUwvQpv12maJziPDlnm2jt6lNjJ10oqrWmaU
         Wkkw==
X-Gm-Message-State: AO0yUKUea2l3Kp7HLmotq6Xb4WHao2T+nAlm/0UI4/suApQ858OGUBTS
        8CV1swuBoOOr1sk7X6E49GLu7OU8XfPDRVf9
X-Google-Smtp-Source: AK7set+EaSWGJb3gVkFlnF4T05lKVmaKaQXFNKlGNKTHBWlLDjR6bJAmr6pYBB17lB4rU5GZ77Rcug==
X-Received: by 2002:a17:902:f98c:b0:19e:524f:272f with SMTP id ky12-20020a170902f98c00b0019e524f272fmr5964931plb.42.1679043261350;
        Fri, 17 Mar 2023 01:54:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm1030775plb.184.2023.03.17.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:54:20 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: hisi: Add S5 IO map
Date:   Fri, 17 Mar 2023 16:53:45 +0800
Message-Id: <20230317085347.10147-3-mmyangfl@gmail.com>
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

Hisilion S5 platform supports ARM Cortex-A7 processors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm/mach-hisi/hisilicon.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 2128e6dd5..fecc0b7be 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -83,3 +83,40 @@ DT_MACHINE_START(S40, "HiSilicon S40 (Flattened Device Tree)")
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
+		.pfn		= __phys_to_pfn(S40_IOCH1_PHYS_BASE),
+		.virtual	= S40_IOCH1_VIRT_BASE,
+		.length		= S40_IOCH1_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.pfn		= __phys_to_pfn(S5_IOCH2_PHYS_BASE),
+		.virtual	= S5_IOCH2_VIRT_BASE,
+		.length		= S5_IOCH2_SIZE,
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
+DT_MACHINE_START(S5, "HiSilicon S5 (Flattened Device Tree)")
+	.map_io		= s5_map_io,
+	.dt_compat	= s5_compat,
+MACHINE_END
-- 
2.39.2

