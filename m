Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6996DFEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLTT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:19:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E32115
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681327160; i=j.neuschaefer@gmx.net;
        bh=VaVzOQrTyDTUfR4+6RnjitXAQ8yivcJJAu9s49yRhF0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=N/sr0IkzMPWlKEOMRE5+z3QLMeCbv0CJDtcY5Mcj7y9XBXaqxoLqKeWxKDqay39tR
         xnB2Q/E0fnqeavSG05MMGqE+dhn1kcuoGnC1CbwJShqXpTaYwckmKsBsFQK6BZBkj5
         lJY1jwygHEdoANd2gg9p8zm5JHOrfLUBaIHwt6zMQ+30lb3X1mwZVAkcR+HPXK1HGy
         CfmT0llqi5qYZd58Ll/JqRNgELPW+r2zvOeNtGV3ZEXZZWQ3mT7lk4ZqVEfnk8YPqM
         bJDEE9V6dd3qpxKPyB4J3n5lgXnjqQ+pTsDpt+7X+qD/CuXyDkGOU5Z2ImdZswWutI
         wXilMIe2xgVPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1qYC2d3hkS-00wUx4; Wed, 12
 Apr 2023 21:19:19 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: Enable RESET_SIMPLE based on ARCH_WPCM450, not ARCH_NPCM
Date:   Wed, 12 Apr 2023 21:19:13 +0200
Message-Id: <20230412191913.3821805-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DrtxPhdAyUNp80ZrqKFGgQAMHjcR69ozwn61cg1yxBi0zg4gb9M
 tORRwRTTJ1DIayhrWWm7qL8A8i3DPaphizVtMReBo0Yxc5JOqV5ne/umxElAhTHFNVTIDVm
 jYx6GjWJAfggjIMwipJUhpH0OqTrBL7U50CV+ddSGHUD2Ti/AW2Hky/X3XxVJt2j5hv/pW7
 4Lcj7t451GqtzZeEPq/WQ==
UI-OutboundReport: notjunk:1;M01:P0:WC1y2a621Ww=;I9+wyziHjqc1N+QAiP4j66pWUY/
 QVbaQVnN0Cr1yqjHWZAbAVegVmeX1Okjj+CUyRqjQdGgB0XL7tn1EAeeJnfmTJ676/aq15OEX
 esDGfTzDUaOOVIiNu6a7bYX21RVuUJm1IjfuswSu39jwbaRRX6YV4QgvqeenTX7yWn8jdFJ/P
 C42SXeT0ubvbAFvspBe+/TpOq1CvM67JOwEq6kJMULj/ZJT8Rc++vLzS9BlBDYLvX4juXXLpD
 RDV+dO+LhNpcOqN5pt0RJlwK4ra8UA6xiV6sZK3mZS0IYIq7eKOsDmElKFPpAMt0Tb7nAh8yl
 IZYXRDvRniNr9vN8uJ3h2kySZPiU2eZzooSDOL4Da3wmR20Ocbf9T9rCi75tSF4CfpAQtsyrz
 KmukbsPD+Kw03MnTXlbqAOyvI3lYKH3UeKX6ztjy6MXJEPwaDZHnQ/y3xZgujWZiW34hpSRYc
 8G+wB4BIH4V5MYwTPA5coZs8PTnYyFy1G9kZoEIu1w4qCVe+XfUF7rnjD/BAmEL9BcYlKv5aa
 hUwDFNonrCWODSbQ3DKZmGFsRcGeBfDntbg6iYJ3/Yl2Xkn2C5R9rWIw2vY6jkUIJLVCxw2AT
 PWummMZv6yr5O3ynn6mKMCRLNS/jhEDm5OzmAtftrQGzGkM0NSKlJJMBGhU6yHqi7uOWZlKsF
 QzfmnXpy6C0iqsSoSK0fTXRzflS7lkyZ2FQCYf/dSVmXGxGJmYg4PfFLnJnyxWTPvs/UcG+dM
 62gww8ueRqxtqI0HBCk5ehGl8tjKR9ycwL/URkCjm5DOKvy+0GtIVSpAUwp5dxabVXDZT64du
 wu5lNVCea/Z13mqQT+qBCByOSHbYNq4L1uqbnPvQ4Pz/nFbyw9KT5ywTIiLq+56+PV9Z4q1dj
 BQ/TVX80pu48SDEnYfFZHaNVHdu1MKT7J6gLck20wMZDo0yWv1S8XiysAKEsIBWmXi89AQ+Kf
 lp+Ko9uIniRwnR6occomWUKMVQ4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset-simple driver is used on Nuvoton WPCM450, but not on other
chips of the WPCM/NPCM family.

Narrow down the "default ARCH_..." line from ARCH_NPCM to ARCH_WPCM450,
to avoid unnecessarily compiling reset-simple on these other chips.

Reported-by: Tomer Maimon <tmaimon77@gmail.com>
Link: https://lore.kernel.org/lkml/CAP6Zq1hjbPpLMWST4cYyMQw_-jewFoSrudOC+F=
PP5qOxJz4=3Dxw@mail.gmail.com/
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 4b36cdc73576c..16e111d213560 100644
=2D-- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -208,7 +208,7 @@ config RESET_SCMI

 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
-	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || AR=
CH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_NPC=
M
+	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || AR=
CH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_WPC=
M450
 	depends on HAS_IOMEM
 	help
 	  This enables a simple reset controller driver for reset lines that
=2D-
2.39.2

