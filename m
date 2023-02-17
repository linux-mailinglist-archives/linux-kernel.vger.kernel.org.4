Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1269AC41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBQNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBQNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:17:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0BF53ECB;
        Fri, 17 Feb 2023 05:17:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u22so1713259lfu.5;
        Fri, 17 Feb 2023 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67ZjQMFl9MopKMUr8Q8rD3tQTxsScrYHj6lDCLlYReQ=;
        b=X6qY1lciga9RtfeJ9EC21Br0bqqFiuV70+Fe7la4LL95n3/Z6ZykJEvhueo1ubFUXa
         FB098R1YjRVpfpWwxC5zQ6pbpPEEFjG5rygG+ABKj9GP1N1Qh76FizmeQDmlYYQ0yQWk
         T7N7HhGrF3wlcvIyW2SF+ArGp2hORiwnulRFSWqQQP+bXAS3yEaDTOKC3nQ9T8ewW7h/
         bx0YtE6+VXZhsNbqzQLc9p6vy7TDTBqzw8yfOKBEVvVgDm561o8Gdxci5dhKhI9Q1sRY
         OHf8p9eThcVp/GsoLsBztAAP1x9RGkHLRy0m/ZPJ1FFmNuF/VxcIzTYKijDraF1XjB5/
         nDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67ZjQMFl9MopKMUr8Q8rD3tQTxsScrYHj6lDCLlYReQ=;
        b=xz1LGtupUb1IID3tX0wKI/V88RG5TkXDtASsBAYvmB9hXQMAusqsJpA7xO7vKJDeYz
         dT4pajuB1AZ8yLvhQ13LAwwaL02JWcyb1ugV7w8e9Ku4jjYQqLDBKcCSbKcPFOCefjtU
         GKveKEI876Zr8QRKzlsCujfP0bIyY3i/nQtLRLmosoReOIEj64Fuqwt1nZn7ZPAUoAza
         WdO5vsWrexvhgJB3w6AtFaLMbVd9nVUMQaHB6Ia/I8NYQRGCsbfo42S00iAs0M+4AQeq
         ZXbZdlcmyoSFIQ6Whx61p9MSFL9WfWnsRIgfiYTGr4Q3NS4P+YL+Itl1Q+qJ9G6iyFRF
         M/ig==
X-Gm-Message-State: AO0yUKVkbJ/YPUVp9htFQ+5UWIBXpwzpnX+tjvEXxy/VotIwj0VusXMB
        qfQcdo4I0OOAZ6xkNiKF+UU=
X-Google-Smtp-Source: AK7set8NnpHM5q4xxy7c9GwpwdEJdJZ0GVGKa9VD8sId667fINupwk3xnWdf10GUwtrDpX47Mzfj/A==
X-Received: by 2002:a05:6512:23a1:b0:4cb:4326:682e with SMTP id c33-20020a05651223a100b004cb4326682emr1904402lfv.21.1676639849136;
        Fri, 17 Feb 2023 05:17:29 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8bff:fb00:c81a:1ac1:84a6:458f])
        by smtp.googlemail.com with ESMTPSA id j11-20020a19f50b000000b004d85f2acd8esm677580lfb.295.2023.02.17.05.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:17:28 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alexander Sapozhnikov <alsp705@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] arch/x86/kernel/acpi/boot: fix buffer overflow on negative index in mp_config_acpi_gsi()
Date:   Fri, 17 Feb 2023 16:17:26 +0300
Message-Id: <20230217131726.12666-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'ioapic', which may receive negative value by calling 
function 'mp_find_ioapic' at boot.c:465, is used at
io_apic.c:128 by passing as 1st parameter to function 'mpc_ioapic_id' 
at boot.c:466

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 arch/x86/kernel/acpi/boot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..abb78822f164 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -463,8 +463,10 @@ static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	mp_irq.srcbus = number;
 	mp_irq.srcbusirq = (((devfn >> 3) & 0x1f) << 2) | ((pin - 1) & 3);
 	ioapic = mp_find_ioapic(gsi);
-	mp_irq.dstapic = mpc_ioapic_id(ioapic);
-	mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
+	if (ioapic >= 0) {
+		mp_irq.dstapic = mpc_ioapic_id(ioapic);
+		mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
+	}
 
 	mp_save_irq(&mp_irq);
 #endif
-- 
2.34.1

