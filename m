Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD9720980
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjFBTF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjFBTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:05:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FCE76
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:05:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so1879964f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685732712; x=1688324712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=If31y072xq4e6P4sxZ7wENONrwovu6qw7j2QcnCLwYM=;
        b=iw2od1eb1LLnTIiTck7tEolOQHlCSsiuiuK5Az1wQSsyQuGpmGKl+Ddz6oaTtYMOzE
         T5Pnesq+GFxqESCem3TjpoUlvFNgtO2PKO1B0wmLT590vpkWUz+hZIgTV49nhewaoPhO
         /R3iGhEYJouZbX9L1pxez8SCfqDXal7HKVE7A29/lYBlkkB14Z+itAmcRkIA7BlSJAZl
         iooncu6iVfqshI8TqaN7O8K152pq1VBbizt+FTAQSLTp9nsQ2Srm5C/AJJlUFwbKsC1K
         s3o/b2T4EwBTJ8ng314F/99Imw/npLH8nX8MwWUCryUxytFt+vMpaQRNOed9724L0UZZ
         LKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685732712; x=1688324712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If31y072xq4e6P4sxZ7wENONrwovu6qw7j2QcnCLwYM=;
        b=i67HJEdbJLYasBiuI3PCGCB1w3EdVWtc4tytsNsbF2rHlPyltqDcLwrpYnx6N892O6
         ncLw6VAg0V14RMB8UiVPZM3g5WrCBWvZM6ft5/wo9jY5Wa71bu9Y4jdnjkT/y7n8RsQK
         sx7eMfzCf3yrBBDJixDT1RYcaPGvKd/2m6KbuPa8BfrWA6ZOo0Hy4s5SwdTY7B8bOVVL
         BYeQ3W/DaluWXHisaYEIofPVyXoEC8cEN0uKeWBzo3W6tWW3jEdi9a0AkkMzQQ95Gs6T
         Ozv65JFSJ+zsvHU4sI4I+caFjrDJKTOn6kFTXN8Bg0ms3Dwh+wHoSx0ug5NFip/AtqnN
         C9DA==
X-Gm-Message-State: AC+VfDysV/KsKxcEHujGkZBrq2mJn92apdhHvcltoIbB/h6LnWOVThnO
        Qq9fiJ7/OVB/VDgOSRtkCT0t3g==
X-Google-Smtp-Source: ACHHUZ49cV0H3yp9vW9BOannfVeKeUwyqy/UKFpf4uPItZATZzhUiTC+cpJxJ2yN3zr/xYJXdhwL5w==
X-Received: by 2002:a5d:6b0a:0:b0:2fb:92c7:b169 with SMTP id v10-20020a5d6b0a000000b002fb92c7b169mr585237wrw.10.1685732711749;
        Fri, 02 Jun 2023 12:05:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7569:c0c0:3a0e:c54d])
        by smtp.gmail.com with ESMTPSA id y8-20020a056000108800b002ff2c39d072sm2361029wrw.104.2023.06.02.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:05:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net] net: stmmac: dwmac-qcom-ethqos: fix a regression on EMAC < 3
Date:   Fri,  2 Jun 2023 21:04:55 +0200
Message-Id: <20230602190455.3123018-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We must not assign plat_dat->dwmac4_addrs unconditionally as for
structures which don't set them, this will result in the core driver
using zeroes everywhere and breaking the driver for older HW. On EMAC < 2
the address should remain NULL.

Fixes: b68376191c69 ("net: stmmac: dwmac-qcom-ethqos: Add EMAC3 support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 16a8c361283b..f07905f00f98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -644,7 +644,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = ethqos_fix_mac_speed;
 	plat_dat->dump_debug_regs = rgmii_dump;
 	plat_dat->has_gmac4 = 1;
-	plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
+	if (ethqos->has_emac3)
+		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
 	plat_dat->tso_en = of_property_read_bool(np, "snps,tso");
 	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
-- 
2.39.2

