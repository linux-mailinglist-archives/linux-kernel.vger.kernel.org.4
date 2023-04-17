Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1645B6E3FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDQGnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDQGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:43:13 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F48B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681713792; x=1713249792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GjxLIzvkA5tUOCfQ10qspzjnkzXFiG8ZCETl0fV8HDA=;
  b=UlXz09f7Ddz34N4fhF170JhO9tPtsbfLUOmhz+PGK2dID5/2DrWAj+3/
   z6ObsrqhyQ27bRyo0uUql0IJl32u3giI9CsINyuNvCD6VAnq52BEsyPHx
   YMPbnpgE/Tj2I7eJTJ9G3+g3eptpNoRS6Tv2xsJATh31XlctjubNRQT4l
   iqOsEKvxJ3vYXSTMQONO0OD+zzKjI6VEcyPTetvtfUyl3LIEqczmggNRg
   SXucHYRLq6IS5+QTPDCOrIgkA8UmaHmtEGMfw2Sk+KjEpNNmZEKJHF9XY
   wsTfEbAQ5/74z2Xq1fKLbX24PJ3EWYvZL2C+wzoJSTTzXpd75rKK1sEJq
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,203,1677538800"; 
   d="scan'208";a="30354672"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Apr 2023 08:43:10 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 17 Apr 2023 08:43:10 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 17 Apr 2023 08:43:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1681713790; x=1713249790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GjxLIzvkA5tUOCfQ10qspzjnkzXFiG8ZCETl0fV8HDA=;
  b=SN92wd5pxWOXCQkGZI7EMgpCTOSUu5cS5k7pcSoB+F9GywMVoygZeYQI
   gLYlw4LZjx68lJxgAofoRZHtGQ1dmM7v0cLdSfj9etVwGm+5x/cR6Kr+r
   tPbp6q8aaBv3Op9mwEGP/so9uMBfwRmX0fVaZ+tIf8sxVrDpnenULMGe+
   +hojIoe0DEcUOdbeGqBJ1AFb+wgwd16oRvx8aulguczv2ptlFlJu5Gbf5
   1P8zaA+T6W7PYNM8eyDkYyNnlYtxAJ6XXa1/qj9W7g7JtcWYBc8NBeJl0
   B1NpSryfYl2/9e0Th5qVScUfsbbWk/bbaegxqVLjS9HUyhmJeYLz9RYMj
   g==;
X-IronPort-AV: E=Sophos;i="5.99,203,1677538800"; 
   d="scan'208";a="30354671"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Apr 2023 08:43:10 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 10810280056;
        Mon, 17 Apr 2023 08:43:10 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v2 1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
Date:   Mon, 17 Apr 2023 08:43:06 +0200
Message-Id: <20230417064306.16074-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the arm & arm64 module + board DT files as well as x86
platform GPIO drivers.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* rebase to next-20230413
* Explicitely add corresponding maintainers

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f74d8571ac9a..5418f1a77a932 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21344,6 +21344,20 @@ S:	Maintained
 F:	Documentation/hwmon/tps546d24.rst
 F:	drivers/hwmon/pmbus/tps546d24.c
 
+TQ SYSTEMS BOARD & DRIVER SUPPORT
+L:	linux@ew.tq-group.com
+S:	Supported
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	arch/arm/boot/dts/imx*mba*.dts*
+F:	arch/arm/boot/dts/imx*tqma*.dts*
+F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
+F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
+F:	arch/arm64/boot/dts/freescale/mba*.dtsi
+F:	drivers/gpio/gpio-tqmx86.c
+F:	drivers/mfd/tqmx86.c
+F:	drivers/watchdog/tqmx86_wdt.c
+
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
-- 
2.34.1

