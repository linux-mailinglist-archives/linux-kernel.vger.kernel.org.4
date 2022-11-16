Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4C62CC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiKPVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiKPVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:07:59 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7585CD34
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:07:32 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3D57A2C027B;
        Thu, 17 Nov 2022 10:07:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1668632847;
        bh=QRj1PuAIkYt+nXKsnn0wuBRmh8w11dK0S/SK+BuFe2g=;
        h=From:To:Cc:Subject:Date:From;
        b=llFcXeywk+eREeFjoXhwMvjW0dOLpNcizJYwpDxaQ39g+sBWjR0ao0uqx/Pokx+2G
         2tXm5IUZzFqHDjnxuzDddaEzt74sahWOoLRLfAAPgLMCL1t6sm3oZAP41bPjoD5h8L
         Xgo07fwAeOZl8MJWUD04vVwf07PsY2YFXnHrw3Zo+X0iWERQ2sdb90bqPcZSfSWm2O
         N/9mCfCX8RJEP0d/qtpmuizYlThkL6khixHVDK6eO83nFfQpwt9U0+zzD/0dHNcGkg
         0zn2X1UAlW4O0xMk0bz22JRW8hoFxETNWSkxEiiCObb5f64eR+JPApnT/j23pC/73k
         r5evbsGdzfr3Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6375510f0000>; Thu, 17 Nov 2022 10:07:27 +1300
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 1986C13EDD6;
        Thu, 17 Nov 2022 10:07:27 +1300 (NZDT)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
        id 15FBB2A2608; Thu, 17 Nov 2022 10:07:27 +1300 (NZDT)
From:   Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To:     krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH] memory: mvebu-devbus: Allow on ARCH_MVEBU systems
Date:   Thu, 17 Nov 2022 10:07:17 +1300
Message-Id: <20221116210717.31313-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=PqrtkDE3 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=9xFQ1JgjjksA:10 a=xfACtVhq-O2_VhWpyGYA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell EBU Device Bus controller is available on more systems than
currently supported by the Kconfig definition. For instance the CN9130 So=
C
has this controller.
Allow ARCH_MVEBU systems to configure this driver on.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index fac290e48e0b..63176665b4e2 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -159,7 +159,7 @@ config FPGA_DFL_EMIF
 config MVEBU_DEVBUS
 	bool "Marvell EBU Device Bus Controller"
 	default y if PLAT_ORION
-	depends on PLAT_ORION || COMPILE_TEST
+	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
 	  This driver is for the Device Bus controller available in some
--=20
2.38.1

