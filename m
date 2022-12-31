Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B765A36F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiLaJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:59:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4AE0C6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:59:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b145so11710759pfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+mH6yo9QDzH3j2h09MnjaYAWpR4f/pKw+YySSE9cdM=;
        b=fRK/PdfPbHcHarX93IwTpy/Ytq/F07RTxGR6RD/gj/F9Sxo+MKI9gDZ4FA2FOxsRPq
         VPo4+eZzOMMydHrWh+mBvPP4NY6L9kj0/WMcG/yW10m3NaMKnsyIy7tZ+uNzqFZ8PqkN
         KzrLBw9BMP8p3fXse0VXng/zXsJ2JSc+nCv3MSShNjrR/Ye4wtm/al5QoRQ85eNZSz+t
         W7hUDVpUhmQ0VhW7mD+d5uKpxJTKPOWvPo6gFDNK2cWb9kClTn8DHNSD2e5ubcC8OPCi
         zxtKsaeRe8RCeEUQtrfZJLcgzxNbV3M/rTrhTFtE0OXB2lMrvNPWMfRtXtla1jhObyYF
         krGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+mH6yo9QDzH3j2h09MnjaYAWpR4f/pKw+YySSE9cdM=;
        b=O1HROAe28jp/cqCeBjNrn7YWNE4J1VUcX3UTEJcTAQZwglE1sRRTxkwkcjW3iesCuB
         vSeWDa6yDsdSQWkHc8zGPcTjd979MUnLIZLhjNfW5N25bFMKcA9UIqUv2EwlKanVr3xt
         Cn+h0WcJNIOVsH6xZJU+nisVry1Y08KKBo3EnHnI0KSxYJVE704E9mtmS+HMO8Jnwpgz
         asFnK6+6p0ej5vWHtdQr3pbRKlaCwmaMdoF0ApKOwo/zn+ZWBJksM6ilzXEap4vaiiKO
         qjvtzfu0gQLwltFRV+vRO9X/pbhrF3a45hrb9FR5edzswPQccMZ4cOgMJkf0hrAZZQ7+
         LkCw==
X-Gm-Message-State: AFqh2koKU64EQys2QEqKMZ8b80QCQxs7pH6SyNhl0hR9U+I9+YVNBY4k
        j87VfYmmHdKkgIr9ETMyvr0=
X-Google-Smtp-Source: AMrXdXur7RrG2roADR6sHAZPDR/bZV5urMU1ARSL4dBcVxSS+Mh4meOvFZJXX6xPGKJv8iacJWcjVg==
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id q13-20020aa7960d000000b0056c3fbac5camr52384277pfg.16.1672480741039;
        Sat, 31 Dec 2022 01:59:01 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i128-20020a626d86000000b005768b4f2d0dsm15128137pfc.64.2022.12.31.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 01:59:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx8m: Fix incorrect check for of_clk_get_by_name()
Date:   Sat, 31 Dec 2022 13:58:48 +0400
Message-Id: <20221231095851.2573710-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_clk_get_by_name() returns error pointers instead of NULL.
Use IS_ERR() checks the return value to catch errors.

Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/imx/soc-imx8m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 28144c699b0c..32ed9dc88e45 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -66,8 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
 	clk = of_clk_get_by_name(np, NULL);
-	if (!clk) {
-		WARN_ON(!clk);
+	if (IS_ERR(clk)) {
+		WARN_ON(IS_ERR(clk));
 		return 0;
 	}
 
-- 
2.25.1

