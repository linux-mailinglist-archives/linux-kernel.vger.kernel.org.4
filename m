Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF370F21C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjEXJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbjEXJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:20:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F63132;
        Wed, 24 May 2023 02:20:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f50e26b8bso106613766b.2;
        Wed, 24 May 2023 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920049; x=1687512049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HSi9nI0Vdoo7olldvTKRpyWvo8hGHic3PEr2+B6W30=;
        b=mvpiWeCm5PWLRuR8ZVPFkuCwRwM2ADb4HlrCe9mCtdkeEdjGhr7lpteWYLy/Idm+uG
         4WZBbBvxVKjXnffbpqJ0PZnY8kXj1ekE8TzwUXA+inB6cAnHxFTYwH+rRGfBrkrRb6C5
         suycniREcCSRBAryOgFmajKBrwIzcrI7yiV0jznHDWmKJKo430KCld3usGdCxo7ARbFU
         NbGPfAAF/CLznVS98S/4Z0rVSTmLJC0j/hFPawOCaTLAMkDfry3SkUs0IRNqLjCUGwrZ
         CoKbo6zCBSIaJ/hIcalP/FCe5+jYc3LqCZ2tWR1DR7gGWHnKrsSuz8BWXY7tM/BbCZ9J
         Jg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920049; x=1687512049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HSi9nI0Vdoo7olldvTKRpyWvo8hGHic3PEr2+B6W30=;
        b=Kvt4OTq3ZhPsqPtBK8V8nQ6Z2dC6Sj2BcRwB17KuiGGq2g37lVkQY8gJcLUV82DvdO
         olmcv4iQ7AbnHKwAlGCT/GsZIcQtfGkjeZZ3bcCoFR2Vpnta/xQz2KqiTw7ZxOeIQ3J5
         5YfkMENc8ASWbNBTvFAHNQCKRz9jO7jyxpZzoPhDH0IAjQdRt7bJUY4HT5c6YV1BatOb
         mSMlqEOflFyMHOtkqhD7cMHMj+C2nfEJlIMHmsvyONgaiN5joUs0VgRpsJGxok1y7ayz
         3s7mcRC9FT0u+6/505FIJ87Mgy4yjdxe24QLYBNNZLkKRJHUc5TkRfDJ7tYmD95qN9HQ
         Y+8A==
X-Gm-Message-State: AC+VfDzjU2RBVh4J1mNnZt3+RgPUd/M9K9ErnpogsuDBxEuQRp3HQW5+
        Wl7GH8zIpzR5ODzwheodKPE=
X-Google-Smtp-Source: ACHHUZ4U/jA+zgcfnilFF7yu0vKhbCwB0As2RQWv0J1VRkwy8P5PS8onhZ6aufK7zvFCMwzgk0l4/w==
X-Received: by 2002:a17:907:9411:b0:94e:d951:d4e7 with SMTP id dk17-20020a170907941100b0094ed951d4e7mr15853132ejc.59.1684920048959;
        Wed, 24 May 2023 02:20:48 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:48 -0700 (PDT)
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
Subject: [PATCH v6 1/5] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 24 May 2023 11:19:44 +0200
Message-Id: <20230524091948.41779-2-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524091948.41779-1-boerge.struempfel@gmail.com>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
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
2.40.1

