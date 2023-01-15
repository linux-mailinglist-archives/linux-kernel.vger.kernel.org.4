Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962F66B0F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjAOMTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjAOMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:19:34 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11683EC77
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 04:19:30 -0800 (PST)
Received: from mars.. (unknown [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C053F36BCF6;
        Sun, 15 Jan 2023 13:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1673785168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GylWQHxNMSx3z9vgXlhWrepYKY6jU2ekJkywNe2jEX4=;
        b=6E4YdKsZQitsWtlzGJzJC3pltB4po1sYhO/jUqAdlxOTaNF4Ql43YpT7EmR9jiwa1Hrg/Y
        FvX60N67EmqQqu8ZrdY+q1uuvizL2lh9USEuegFPj3Nautc2XjsUnUF489VZDwHWMp57T+
        K15+NJFRShJ2fyAh2McNpArFLE28HlSHuDdFNceZsIx96BKs47j9sOnJRMbF9sYlT5o6Hm
        BvdP1FHhDsaNO/hRpteKzGicek6kuOFRpBl5uM7nxRxa9VVSM6P5u+4jOMbEwPuXVWucXv
        BcaEeGAGcOFu/xtJrURx4IYtatsb59S8ECUADHa0kGO2CWYtwUqebQ+sIZhtoQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Date:   Sun, 15 Jan 2023 13:19:22 +0100
Message-Id: <20230115121922.6359-1-sander@svanheule.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUs in these SoCs support MIPS32 R2, and allow ebase relocation.
Even if the default exception base of 0x80000000 is used, the
MIPS_GENERIC load address of 0x80100000 leaves sufficient space to not
need an extra 0x400 bytes of padding.

Suggested-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Olliver has suggested to make this change, in order to reduce the delta
with a fully generic MIPS kernel.
I hope the patch description makes sense, as I based the argumentation
on the behaviour of the code, and similar commits 7d6d28377783 ("MIPS:
Loongson64: select NO_EXCEPT_FILL") and dd54dedd947d ("MIPS: BCM47XX:
select NO_EXCEPT_FILL"). The change was tested on an RTL8380 and an
RTL8393 device, where it appears to work as expected.

Best,
Sander

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2db5c853992e..a8895aaa490e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -627,6 +627,7 @@ config MACH_REALTEK_RTL
 	select IRQ_MIPS_CPU
 	select CEVT_R4K
 	select CSRC_R4K
+	select NO_EXCEPT_FILL
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_32BIT_KERNEL
-- 
2.39.0

