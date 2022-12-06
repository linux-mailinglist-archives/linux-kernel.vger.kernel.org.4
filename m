Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844B643EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiLFIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiLFIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:34:23 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62E6448
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:34:21 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z4so16399050ljq.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dB5uxVvRgkCzh5zZI2hSHtW59YI+R9FGNxGFZk/czLU=;
        b=ETUfGkLMmSB3lUZx24YJ7ZDNKO9dSec+Gd7bcEY9KnBBnJ1woJsRWeQLgxh/84onVi
         mvgaEXfTP2R2Q0FBAoSIlG1Zp4pGruCo0hRioadH8GXMR7PRX422Gd3xgMFxD1FEi6vB
         wzdow0IHCLio/y0554G+lMwrtGADFujdHpgqHoWinr2ut4rBCOQRtR8BQlG5u1pafvj+
         K+3NxFKUDX8SZZLmF3d4g6eNzffWf7AbLeZilYtVlVanJeP6z3FnxAcRwm2cHyyb4Qdw
         GnUztDIr85lbqQMfIMiTW4DjvcXjTmeGf4TwvateJtSIIGCIk0IXMQCZE+wQTqXQPHoa
         qvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB5uxVvRgkCzh5zZI2hSHtW59YI+R9FGNxGFZk/czLU=;
        b=aKBKHVjGavcTndj0gL6purpMz5EBBCd2yxsILPX9rYeuEzptaRnsOS8bBPjSJyBiB6
         v1p+32OPtxB1CYXCDH1MvV/6lcLXg3pYAqWQWNoPNOp64ov20uRDS8hO8pza3lRR4gLe
         hBsWUSjRQ0d3kdmjD8Na6H3bNFuWlIMk4pP53/eZa8Jl9f8pCzet94BB7GHZXQZH5aks
         r9ddlJtds9k+Zypeweh/0ZloDrZauD1pUthHZ2EKNlMJqZZtmpJuMdUo2fs4zXLlwgXN
         NxvvjTsSCibfhI69Y3gVmU8sjaQmZBdfRkDTvr5D2gMElOAD23IdemZZ5q+lBObNUYJb
         KWUQ==
X-Gm-Message-State: ANoB5pnnkGzsfy+p9A1a5GBP4CJiI301Ouv8GxNeBM4UI4rE5kIpjyhY
        8Klqk+8aym/EW4uvyV0vGIdcbtU1gPPYLCrAUIw=
X-Google-Smtp-Source: AA0mqf5Da/gaQ+2OpANyCGySTMEe3xJ9baBAC/awJat/NeHnvPcOfhUsnsRlv/V2JOFoVJHagRvpnQ==
X-Received: by 2002:a2e:7212:0:b0:279:88ce:43a9 with SMTP id n18-20020a2e7212000000b0027988ce43a9mr17393202ljc.354.1670315659683;
        Tue, 06 Dec 2022 00:34:19 -0800 (PST)
Received: from localhost (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id bf37-20020a2eaa25000000b00279c92b4a04sm1572963ljb.9.2022.12.06.00.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:34:19 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     hdegoede@redhat.com, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com
Cc:     Sergey.Semin@baikalelectronics.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: libahci_platform: ahci_platform_find_clk: oops, NULL pointer
Date:   Tue,  6 Dec 2022 09:34:16 +0100
Message-Id: <20221206083416.705111-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.35.1
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

When booting a arm 32-bit kernel with config CONFIG_AHCI_DWC enabled on
a am57xx-evm board. This happens when the clock references are unnamed
in DT, the strcmp() produces a NULL pointer dereference, see the
following oops, NULL pointer dereference:

[    4.673950] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    4.682098] [00000000] *pgd=00000000
[    4.685699] Internal error: Oops: 5 [#1] SMP ARM
[    4.690338] Modules linked in:
[    4.693420] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc7 #1
[    4.699615] Hardware name: Generic DRA74X (Flattened Device Tree)
[    4.705749] PC is at strcmp+0x0/0x34
[    4.709350] LR is at ahci_platform_find_clk+0x3c/0x5c
[    4.714416] pc : [<c130c494>]    lr : [<c0c230e0>]    psr: 20000013
[    4.720703] sp : f000dda8  ip : 00000001  fp : c29b1840
[    4.725952] r10: 00000020  r9 : c1b23380  r8 : c1b23368
[    4.731201] r7 : c1ab4cc4  r6 : 00000001  r5 : c3c66040  r4 : 00000000
[    4.737762] r3 : 00000080  r2 : 00000080  r1 : c1ab4cc4  r0 : 00000000
[...]
[    4.998870]  strcmp from ahci_platform_find_clk+0x3c/0x5c
[    5.004302]  ahci_platform_find_clk from ahci_dwc_probe+0x1f0/0x54c
[    5.010589]  ahci_dwc_probe from platform_probe+0x64/0xc0
[    5.016021]  platform_probe from really_probe+0xe8/0x41c
[    5.021362]  really_probe from __driver_probe_device+0xa4/0x204
[    5.027313]  __driver_probe_device from driver_probe_device+0x38/0xc8
[    5.033782]  driver_probe_device from __driver_attach+0xb4/0x1ec
[    5.039825]  __driver_attach from bus_for_each_dev+0x78/0xb8
[    5.045532]  bus_for_each_dev from bus_add_driver+0x17c/0x220
[    5.051300]  bus_add_driver from driver_register+0x90/0x124
[    5.056915]  driver_register from do_one_initcall+0x48/0x1e8
[    5.062591]  do_one_initcall from kernel_init_freeable+0x1cc/0x234
[    5.068817]  kernel_init_freeable from kernel_init+0x20/0x13c
[    5.074584]  kernel_init from ret_from_fork+0x14/0x2c
[    5.079681] Exception stack(0xf000dfb0 to 0xf000dff8)
[    5.084747] dfa0:                                     00000000 00000000 00000000 00000000
[    5.092956] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.101165] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.107818] Code: e5e32001 e3520000 1afffffb e12fff1e (e4d03001)
[    5.114013] ---[ end trace 0000000000000000 ]---

Add an extra check in the if-statement if hpriv-clks[i].id.

Fixes: 6ce73f3a6fc0 ("ata: libahci_platform: Add function returning a clock-handle by id")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index ddf17e2d266c..b9e336bacf17 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -109,7 +109,7 @@ struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con
 	int i;
 
 	for (i = 0; i < hpriv->n_clks; i++) {
-		if (!strcmp(hpriv->clks[i].id, con_id))
+		if (hpriv->clks[i].id && !strcmp(hpriv->clks[i].id, con_id))
 			return hpriv->clks[i].clk;
 	}
 
-- 
2.35.1

