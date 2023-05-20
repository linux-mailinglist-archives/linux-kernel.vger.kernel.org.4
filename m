Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468B70AAA5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjETTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjETTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:09:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7EDFD;
        Sat, 20 May 2023 12:09:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510c734fa2dso4184143a12.0;
        Sat, 20 May 2023 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609760; x=1687201760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Prd49snigix6d9LdTUvvFg72tuSsEwzo0jpnKwNXRk=;
        b=ndI3RtV5qmFrjHrE6BKMjECSkT20DVBp7Fue59KF0+oaitRjsrEcMladLVERxPc5UQ
         e/LsHMtgtkrGylZMv5O4JnivQhj5OL4MdXbiSwc5IfxdboznIpiikyJf/S99yZ8JryQw
         yktfPync3jHIUGhOvZGYvtUuZZTRa/tH3lGuvweh02Ki+lKA4KEjXJbvrC4ZLnsjH7dt
         0fQHvezbu2jrgev7rqUOKcix0i+LnHPu7e0PZQ3BL9lAMdmPCyHvJ33pSjPJXhoQyLFQ
         2/CoTTN3rZTuBy9wHRrfFmMhbcEOodkaHnhYwpiq/UTPpzeueQrHn2Ib8V1uID0VCGx6
         /HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609760; x=1687201760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Prd49snigix6d9LdTUvvFg72tuSsEwzo0jpnKwNXRk=;
        b=CJXnZAlvuiXPNb0B5rZt1J5piVSldZ6ojXUEjx1jxmHgiBDUnlbEeLhQ3z0jAqfSMr
         4HRhPtyZUpkyz/j6Jf75OOLlgAzEt4mnJbqCS4YPVKo0R1M/+hTzFGyrn5kCcDfxkBRp
         0TjB24XRcUTOgnqQYox59AfJTivfY+lY5xEw23B0yWxSqqTHULMeg8WeIuJgLEs7ffNU
         B1r0GZqPSLJCJgaP6wP3ZdbXjTzH0FWSjtY4nWGKEbY62wAPmlprX8crhZdWkYk5nTvg
         pr195CL7PZYGJqAfZSDjAAijENGTtadl2xvsY9+8acr5ooURnjEfw137KcF9AQT4GwCQ
         0XCA==
X-Gm-Message-State: AC+VfDxAJqnQ7FWpyFdq2xEFdnF5Xz54i8IBEgf0IofCqGrVQVUrEkgv
        ZAJXA6fS+0MOYgGlQxIcyldBcobid0IGLh19
X-Google-Smtp-Source: ACHHUZ76/oWY1oGRjWs/DHANNHrsB+kDQgU8CeglBDWDZRg+EPTSOsRPu3rZ3iR0oZNvNzGhkJ9DQg==
X-Received: by 2002:a05:6402:1603:b0:4ad:738b:6706 with SMTP id f3-20020a056402160300b004ad738b6706mr6368047edv.2.1684609760129;
        Sat, 20 May 2023 12:09:20 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900cb504b662390cd6b.dip0.t-ipconnect.de. [2003:c7:8700:c900:cb50:4b66:2390:cd6b])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm1065889edb.64.2023.05.20.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 12:09:19 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Sat, 20 May 2023 21:08:52 +0200
Message-Id: <20230520190856.34720-2-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520190856.34720-1-boerge.struempfel@gmail.com>
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 include/uapi/linux/spi/spi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 9d5f58059703..ca56e477d161 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,6 +28,7 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -37,6 +38,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.25.1

