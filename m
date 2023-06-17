Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1C733FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjFQJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFQJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DD2688;
        Sat, 17 Jun 2023 02:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0776C61164;
        Sat, 17 Jun 2023 09:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B979DC433CA;
        Sat, 17 Jun 2023 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686992680;
        bh=dN0u2j1tR/l904xOI1ryxBqN0KJIfbBjlVN87fe2ubQ=;
        h=From:To:Cc:Subject:Date:From;
        b=F8fqGm0oqCFZoLyRTgi3y37lY0GB6NwMie2dQRm/QrOUuD3nIjrDVFtGdzOZ9BtIi
         0WYS5ie6cdvD8+pzyA1bASQBQZZcPO9jpSa2wJzh43+KbCfUcfjSjmqBNwIUuftRvR
         d843ihXLpKrbxW/BZNKP9zXuFgAX6KeQBPr4AWB+6Vc59+In728+mefpPlgkZkuP3r
         LPuI9o/e5868FRBWqfqd/TZ1n0wH/kg09TQy2n7FmQzTHCV35IZ1zQv+9+mXEdmAKo
         HBu53DdcxfQaUEIXiq6p6wBXSslHM1ad8szd9+uGiAcZ9IxreIu6PIn5Y9849oAwh2
         /EpmtcL02QICQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS
Date:   Sat, 17 Jun 2023 16:53:19 +0800
Message-Id: <20230617085319.2139-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc host drivers should have enabled the asynchronous probe option, but
it seems like we didn't set it for litex_mmc when introducing litex mmc
support, so let's set it now.

Tested with linux-on-litex-vexriscv on sipeed tang nano 20K fpga.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/litex_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 39c6707fdfdb..9af6b0902efe 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -649,6 +649,7 @@ static struct platform_driver litex_mmc_driver = {
 	.driver = {
 		.name = "litex-mmc",
 		.of_match_table = litex_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(litex_mmc_driver);
-- 
2.40.1

