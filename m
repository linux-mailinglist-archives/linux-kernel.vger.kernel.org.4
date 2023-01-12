Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B9666CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjALIkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjALIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:11 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99612D3C;
        Thu, 12 Jan 2023 00:38:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so31110019ejc.10;
        Thu, 12 Jan 2023 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bifQdYT6k9+1DNQbBHa98RaQAwgSYemBoBBiUkTIS6w=;
        b=HgUpU/7xujgyKBn2Qz3w9IR+OQk+SAu6b1SP9tj2zjxNo4UrLIWW5UjVf6VexH8N9Z
         i8tUweFZ9gCE8rWP+sQZfHjYguyY9TcFmk8EJOBMMMJdDheR7e49sjvpc5BluNxdx3rK
         ggeIAdGnMfHCekCNQab29aQ/tMAVxJbV83t1MUXBpdU9jdZt7rK+z7OOOtHRUZtTk7Mr
         s2WHQWbg1M7rssFADVge7mxkPcXgmUa+FdVLDRrDG+ydc3hTsFg2iX10Ch7LrgPn9jJC
         Qu/oJqC5XdSTA1jNEEfN693uq+oDg7Ng0QIDHR2EHR+hbN7tZ+WPDHvIIvxOjhQabxlE
         nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bifQdYT6k9+1DNQbBHa98RaQAwgSYemBoBBiUkTIS6w=;
        b=5IXXSdHRh6ewyNWFjfLDsf/7OrekYRyH5yx22hUNkD/mmeosaxPboqDBmUOlrScLFs
         k8PkPiJQhxooR4AsZqr4pS/pk+Rd6fcgbmAcVEO/UgDw//NEtBnDXuHeAGmwB/dCbk7g
         JTOhfePknIE6jaiOWyjCmZkChpgW/RqDYkW7LsuCAh9aAz0NQ1i4zkUlWk3UC3lvtlNM
         Glox/NutSaVRAs/qz/hrIjGhzuOcrn5czHJ4QEo90OiuKam7A5EeBZ6CszMI4nfEapjE
         ZpzZ/UbY/lvqrcQGwNGOL4/ZnCXvkX9tYXKx6agelWMyzYi7xvHh/VlgTh15Wvz/uSvs
         jNeQ==
X-Gm-Message-State: AFqh2kquTymd/tBwEW1woJmXlKgmxX8VpRXAK/4JC4YMihKS0Dz20QdQ
        Oa9ssG5vsnn9Rmoy95CGsgI=
X-Google-Smtp-Source: AMrXdXtHn98f5GYr/AjsWDxBNbI5lJU1WeJqXLM+s7giJDCqt1gMfO2ByjuEviCBhKuBqDyy7WZ0fw==
X-Received: by 2002:a17:907:d68e:b0:798:d745:f87 with SMTP id wf14-20020a170907d68e00b00798d7450f87mr64914906ejc.73.1673512695500;
        Thu, 12 Jan 2023 00:38:15 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm5670410ejv.189.2023.01.12.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:38:15 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/4] ARM: debug: remove references in DEBUG_UART_8250_SHIFT to removed configs
Date:   Thu, 12 Jan 2023 09:37:46 +0100
Message-Id: <20230112083746.9551-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67d3928c3df5 ("ARM: omap1: remove unused board files") removes
configs DEBUG_OMAP7XXUART{1,2,3}.

The config DEBUG_UART_8250_SHIFT still refers to those removed configs.

Remove those obsolete references.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d0c1e4410694..8e49a44ec532 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1778,8 +1778,7 @@ config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 0 if DEBUG_FOOTBRIDGE_COM1 || DEBUG_BCM_5301X || \
-		DEBUG_BCM_HR2 || DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || \
-		DEBUG_OMAP7XXUART3
+		DEBUG_BCM_HR2
 	default 3 if DEBUG_MSTARV7_PMUART
 	default 2
 
-- 
2.17.1

