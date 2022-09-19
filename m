Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E315BC4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiISIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:55:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E6464D9;
        Mon, 19 Sep 2022 01:55:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso5439552pjd.4;
        Mon, 19 Sep 2022 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MMkRjNbatJklpFghNZh+6S773eFMltyEZW7eycnWeXs=;
        b=RABW2tDqXoFg4LQ0NjP3HVYaOt+0OJLZuPB8x0CS2U9SMOMCrCB7dSCnNLyZoEQHLF
         RKajIoMLS8m8F0kYmhMgUlPnfTVgsR/0sghQ2ia+B21YqPFs56FPzphpx1/d9iSt55id
         1DRX6KkLs1nE1zb2LmlRM2uKumPFmiMssMrYihFIEEQrZeBxFHt7SCXTmHdaKePx4mLW
         y0dt8focSVsxwbgrvRZ3KlsKlNscSdE/wfROPvOE83ZXbsNztIvqKkLuwfr5kiAdtEcV
         y8CFHX1UBluCb0KDog7DguTqI0lcpLiwBfZuz8+7IuUKhkfEsFIFbD916vSD+ucwTqFU
         17eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MMkRjNbatJklpFghNZh+6S773eFMltyEZW7eycnWeXs=;
        b=U9S4J7vJA/a/90nxN5B7WwwRPxoT2iFnjTd9Qec+P1IGmqwVqAJTee92G3SVlUZAiv
         L2L9kM1B4y4mjOxJVbEnonkg6kdmMIKCyHSNR3Md2SCHJNpHoUoWV5OI024qkbhFQ0Lw
         TCUDKlO8YTJU1bmkOhVpnuSOYHS5rDXvQ8HRtj2SrVjehshdO9tpMTzVTGpt8zNcsR7+
         1wXbfjT+kgK37yWGoEzPv8so7iswYVpP61NppMOZaeCC9C/zOuJO07e7cbMMbc8jbu4+
         5rL/2fgkGy/C6hZyoOWxyeC6xY8jLlEQj211YxMtbGBK/XSTR3KmqSxt9iGcI74aa9tx
         0Pfw==
X-Gm-Message-State: ACrzQf2zose8LGFnaxKKfcwzKYVpeoHQyhAn8AD6TiZ8sId8/cul/onX
        kFhJjx97kp6VOveFrCG2enmptArE528zcA==
X-Google-Smtp-Source: AMsMyM4qJlCxakHFEM9sLtYdvDPPYfuuDH6DFtcswTBBIpdYndlunojk1JqYWvDRar2iqo/sAeKElA==
X-Received: by 2002:a17:90b:2398:b0:200:a861:2e86 with SMTP id mr24-20020a17090b239800b00200a8612e86mr18806211pjb.233.1663577709566;
        Mon, 19 Sep 2022 01:55:09 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id i29-20020aa796fd000000b00538056de6ecsm19801091pfq.52.2022.09.19.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:55:08 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     etremblay@distech-controls.com, l.sanfilippo@kunbus.com,
        u.kleine-koenig@pengutronix.de, robert.hancock@calian.com,
        ilpo.jarvinen@linux.intel.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, jirislaby@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/tty/serial/8250: check the return value of clk_prepare_enable()
Date:   Mon, 19 Sep 2022 01:54:55 -0700
Message-Id: <20220919085455.1582310-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of clk_prepare_enable() which could fail when
cannot enable the clock.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/tty/serial/8250/8250_of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1b461fba15a3..23e9b9e8c940 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -298,7 +298,8 @@ static int of_serial_resume(struct device *dev)
 
 	if (!uart_console(port) || console_suspend_enabled) {
 		pm_runtime_get_sync(dev);
-		clk_prepare_enable(info->clk);
+		if (clk_prepare_enable(info->clk) < 0)
+			dev_warn(dev, "can't enable clk.\n");
 	}
 
 	serial8250_resume_port(info->line);
-- 
2.25.1

