Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98175EDD07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiI1Mlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiI1Ml2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:41:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D682D1B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:41:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j16so20197824lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Zd06RtS/Nrr3P0Lw0WJBnLGx6z/NA6eV+iimAqCF4Pk=;
        b=L5pMtVVhH35O6FplZUIKnVB4to5VmyCNC5Cc0mTqmawGbjafKRBERWs0Hws3oxvd+8
         oE9eNYYweSkxTsBzu2WVLV7DCXVzB4c5n0gXInXx8xQT1bQrEtRXCsLIqA6T4QJ6xQE2
         8+0i6+7H+SAKY6jm1AVwgo57TvaNxrOJt+uKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Zd06RtS/Nrr3P0Lw0WJBnLGx6z/NA6eV+iimAqCF4Pk=;
        b=i5+sAAE5q96PxULkL2V3nB/OVJrMvLRjkB6X1EoZJY8Nrf4aFCPyBtVReBNv8QVVHu
         6To0y95h6XO3w/xRAmvREdT55xKJzlkuidtDNI4zOikZMzc7zzvfnloCqZfOB3rq0biu
         ds+1AS7nKLvDPr7+YA0opnXA27gdsFT3LJZ5HU0BPsr/C5z3pcPZlPDKpL6DJ5meNB4L
         pwIF67qEi972DjWdhuuJLz6JKTkvLSWWZvKWiKqZ2fbfcHA3IebwHgynIjQx/WDReW3c
         GHBrE9erMikSptsHCeHFSESV4k1pAia0q3Eq2oSGfZ53CrW4pYL/gjrz9jzyyqwJ6vOp
         s02w==
X-Gm-Message-State: ACrzQf2pqVEr3qt9kNh0E6h3f3RNvRGE4eXHkTFi4SOTl0fni/taZ1Tm
        /MBC1iQ/PV3/Zp1PWGkzikMvRQ==
X-Google-Smtp-Source: AMsMyM7Qf8SRtcyNBIQ1t4WtW2fyAZ7oKbZURcwJDSPs2npaQVfx80VVUldkD5mSzJ/Yg02Sxjp1Vg==
X-Received: by 2002:a05:6512:b0d:b0:4a1:baad:8d7a with SMTP id w13-20020a0565120b0d00b004a1baad8d7amr8283472lfu.293.1664368874120;
        Wed, 28 Sep 2022 05:41:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b0049b8c0571e5sm467396lfn.113.2022.09.28.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:41:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] clk: imx8mp: register driver at arch_initcall time
Date:   Wed, 28 Sep 2022 14:41:08 +0200
Message-Id: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have an imx8mp-based board with an external gpio-triggered
watchdog. Currently, we don't get to handle that in time before it
resets the board.

The probe of the watchdog device gets deferred because the SOC's GPIO
controller is not yet ready, and the probe of that in turn gets deferred
because its clock provider (namely, this driver) is not yet
ready. Altogether, the watchdog does not get handled until the late
initcall deferred_probe_initcall has made sure all leftover devices
have been probed, and that's way too late.

Aside from being necessary for our board, this also reduces total boot
time because fewer device probes get deferred.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
It would probably be reasonable to do the same to the other imx8m* clk
drivers, but I don't have any such hardware to test on.

 drivers/clk/imx/clk-imx8mp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index e89db568f5a8..9ddd39a664cc 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -734,7 +734,19 @@ static struct platform_driver imx8mp_clk_driver = {
 		.of_match_table = imx8mp_clk_of_match,
 	},
 };
-module_platform_driver(imx8mp_clk_driver);
+
+static int __init imx8mp_clk_init(void)
+{
+	return platform_driver_register(&imx8mp_clk_driver);
+}
+arch_initcall(imx8mp_clk_init);
+
+static void __exit imx8mp_clk_exit(void)
+{
+	platform_driver_unregister(&imx8mp_clk_driver);
+}
+module_exit(imx8mp_clk_exit);
+
 module_param(mcore_booted, bool, S_IRUGO);
 MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
-- 
2.37.2

