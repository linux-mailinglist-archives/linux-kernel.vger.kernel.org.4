Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2568001E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjA2QBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjA2QBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:01:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F701C5BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675008042; bh=ST8OOQg87jft8uBWiLegaKtj4NQH5sKdp3sJcQviw1s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ozbjeuxI+VbA6JOUUxFtJKOJpgwdtwT/hBzwmSJvShn0pMx/1NEU0lXrfKsa6bTwj
         VltGN7Sxao9X+6ZUV3Rom4eF19SCwqnEyCOD0OhW5wjkTztxXgxLJ6s8rXldJv76e1
         ZcewKHazaAuPzQcrAM7/P47AYSDiwqgjUDxAHkSZrN5tcobl8lqwsY1Eeag2AqMuSc
         jiklzu4Ben9jjKkyVTL8/jsAGvNr0DtM0CGGHhr+kCkMkFV96fCzlGxZvCTstFAStH
         0HjwVHAS9ghx5mHoe6WHmzLksE9DdS/MQVhrn7xeCfkY8GFYJoEEPcVpTmw1LILEI2
         IjyvtHUD4fkQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1pLc8u24jS-000dJC; Sun, 29
 Jan 2023 17:00:42 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        William Zhang <william.zhang@broadcom.com>,
        Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Allow DEBUG_UNCOMPRESS on ARCH_MULTIPLATFORM
Date:   Sun, 29 Jan 2023 17:00:38 +0100
Message-Id: <20230129160039.1598347-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y0zPz2/jnU5cxEONk1thuk1kU48OxSyRLv3zPI9kf5biySYnbcD
 L6yPgyS1d/zwA2yyoLwQZnGq6+Bq+Z2m0a08gUGM/IQE3/B75IxMraejM9Yf7wdQetw9CD5
 cEbIUaBWl9jPmNgd6CqcvOV2mFxMV2Q8N7oJAf7YEIy4hepoY/T0gqo7ragSWRtMbOA81WK
 PU5jgBlGozAGgDfNyR+8w==
UI-OutboundReport: notjunk:1;M01:P0:N6GIuGLhNBA=;PeIzAQ+tA8Qcn2no/E33dZNUyVr
 A/TdGiBCVPbXXR3RyTKzjq8lIbSzyIZ6PdQZMGKvL3wLgjZRrOfGl7VB+ZxNSeHSh2UXkuwAs
 YdPEFr8TbIUixWYvthJw8oiKpEI+5ewznagHNJk3+k/kN+cy8mD4SUvSFyZ27yUHByxdf14Cd
 9TKpsfiEhDpyRGTy/JCjRvWD6gymquIT2DZxI9DiQm1p2be+RSdldEGHeaOjlJUOu3aTF84MJ
 MxsIj9xtpCo2UqcDq3QoTEDRIEkAYCM345JbYt7GyqnczAmGz2RPw8SoLl0ksEUW19Okxn47W
 8cgdXBVkRi60Il5lTAMEE9xqmBLd76PPEQ5G/W6/9qkNdSSUL54X3zjFFLikTpkLGgfPtUoYb
 qC/+EaYJkFBZbpBsJqrDF0YROLBDCrMphUaje/4oD30DQYn9P5qCP49kK82BfMF7rjmxsOSgR
 lg0kGIJlJ1AhusTju3x6KhCHBSAK8rwAAjOMGxKm9yKa9td9zPB8k1YmVNIiOEmKSFrqzlME8
 jXr9mz752BbDp4JnRviNyo3gdfjwe304kK5A1eSbDCbLESMHqhfNW/rTULT98dAIdEYpe6D6P
 vvPyNPpO5chMa4vw5JfEDRP/nMkfJsC2wVONe4ggVYuzpzInPmz0F2gT/OpCv5ry47JR4Ot/S
 qn5LdTxVLo8jxVrJAdEdpV0iPenIuu1UAkIVZAFtVmUbUam/3hapVoPR3pBsgZnF2lpuE91Mn
 QnA96dUMUbV60vn+dxBZyelvo4FXtV+NX/foi1RWDh+WVDP+TNg1c7Jf1zk70Qc1qLI8+oDTN
 1N01zg3CCs6Wx2HoRvdAOCGftcTORA1OgHXOwnEbXuvaLh757q5pDenDZnOj7qgY+34cuZVLi
 El2tTgjMJxdwxzG4xDDhp/pI8/yEDkghopbgdjRbiMtabv46U31j6NiGnAl070YCVoRM4nb0p
 iVytDIzIUGlHtQNtEHI6w/wPsVE=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel with DEBUG_UNCOMPRESS=3Dy will only work on one platform, but
that is already the case with DEBUG_LL=3Dy (and documented in its help
text), and DEBUG_UNCOMPRESS depends on DEBUG_LL. Therefore, I don't
think users need to be prevented from enabling DEBUG_UNCOMPRESS on
ARCH_MULTIPLATFORM kernels.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c345775f035bc..655f84ada30f4 100644
=2D-- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1904,7 +1904,6 @@ config DEBUG_UART_8250_PALMCHIP

 config DEBUG_UNCOMPRESS
 	bool "Enable decompressor debugging via DEBUG_LL output"
-	depends on !ARCH_MULTIPLATFORM
 	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
 	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
=2D-
2.39.0

