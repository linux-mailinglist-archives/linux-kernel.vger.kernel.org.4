Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F673F85E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjF0JKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjF0JK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:10:26 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7919AE;
        Tue, 27 Jun 2023 02:10:15 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-312863a983fso4811800f8f.2;
        Tue, 27 Jun 2023 02:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857014; x=1690449014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4zAJ9Fvhu5nWIa1wd1+G4v+5opDCU+KXPZNXrryFuI=;
        b=URY9rqD959L4eJQv/oej3IZF4wRbYHqJBFqgWIPNq2dAlnle2TC7TvAQ/77vfkSYUo
         JoqchEayrCkmDo/YJFlp3gZECVBLGtmP/Dx4sHTGOeqPjyHg5dfjn6+Eb5W45umbuaHA
         d3Nkb+UXPie1nI6yhg80/AoKs/7dvAB1HWR0Xt+fFFGoLiMVpEsLtsCTQvEW9RD1JJRX
         NawKRE1u9udLCXNmasBqiWZCBo4TimEnv7Hk9XP1k/kbz8zeutUvJt4mQARWT02cCoIo
         U5+ooJyiNVO3hwJlBVGY8zDB8HzPZnCQRoxGPYwtGl1UvFfoNPrtvGCAAJrpEz9+JJg1
         7/dA==
X-Gm-Message-State: AC+VfDwzzC8hVvP7UWoxlz+m8MvF93sHMpvddtP9KtBbNz8SnSp07w6b
        s+YkEFuH9D9pcG1RFr3ACwk=
X-Google-Smtp-Source: ACHHUZ4+nIz9PePMmf0jMSCKrOYy3j4NoC8eln4/j0Dq2hIJQ4EFvcMz0M0dDlQTVSFzPCrD1cOwnQ==
X-Received: by 2002:a5d:63cd:0:b0:2f0:2dfe:e903 with SMTP id c13-20020a5d63cd000000b002f02dfee903mr21368230wrw.69.1687857013952;
        Tue, 27 Jun 2023 02:10:13 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b00313e4d02be8sm8880122wrs.55.2023.06.27.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:10:13 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v6 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
Date:   Tue, 27 Jun 2023 10:10:06 +0100
Message-ID: <20230627091007.190958-4-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627091007.190958-1-tanure@linux.com>
References: <20230627091007.190958-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Amlogic T7 SoC does not have a always-on uart,
so add OF_EARLYCON_DECLARE for it.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/tty/serial/meson_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2501db5a7aaf..c24e105a98c5 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
+OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
+		    meson_serial_early_console_setup);
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
-- 
2.41.0

