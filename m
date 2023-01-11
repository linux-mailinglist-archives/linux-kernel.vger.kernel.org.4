Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCD665D94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjAKOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjAKOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:19:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762425E8;
        Wed, 11 Jan 2023 06:19:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so16893975plw.11;
        Wed, 11 Jan 2023 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsRiYaskdg0sGF5xunXMD9m3T+0b8GQ25pP1FBEfa78=;
        b=jA174vWChBCl1oLhIVR5CZgUkaLSxfe0qehzqMNvikd01BgCeK4vndS4AsU1qHWsUR
         oY/kx6YXEvOcEPcFjTCCOpItrgok6kroMOFaQWvRu/exo0a91OLN2LEU8iVymYS1Z0of
         6Wu3tKdwNBEdxCxv4XIs9GsPJquwneNlGzJokf6wOnZyAC6Gf5VraR5M5tawHaIFpo2S
         G3lkp2rCyH4zYhCHelH1W/CSJAyxGQiHT9tHQV/oH2xslrSUhutL+s90kqLjqyA3ty5C
         ZOP85fCu/tG45BE9Zp+puSWPBJM18Ow2EQhWxmoeuCj5PZKvhuZOwWRgSuauyGpi0Mtr
         z/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsRiYaskdg0sGF5xunXMD9m3T+0b8GQ25pP1FBEfa78=;
        b=D77CQxUIjIxvI67ZWcldo3Gi4VrF6gktyByzVUna/9iR5iSh7LbAe60iFDeWtYne1U
         77Iv1YNiOxnHknRFADgfiTvGyzgzJdGcU1rVtlEbDsl4+VtgvwZ2K+CfrA5icUG3ElMg
         SPeSdwSRq5+kTA+9zLdSmaZ6uird7tZZRbU7ILzkpMiloazrJJ+ZqRzdsMWa7Qp42RxI
         D0bWQlv8osJ4Dg+3F+K4JeOdPJ2cD49TapUQvCsGtx67+Nr7LZ7E6as1GOSl75EY9eFu
         844wpwbvGYGBzM4O9SDQrGvwfrklTk0+k0XwsUxS2pwoZmC49FbAp4Xh5t9KH+qzJEK+
         RzfQ==
X-Gm-Message-State: AFqh2kp9/ggxaozDVMJChYBNXvtWUwDkwEgjobVO/0c+fYj8ftF+L8Uu
        DJvg2wpIeF39qQZgZH/pWYRQJM/aeZQ=
X-Google-Smtp-Source: AMrXdXtNmyFF0rzHzX3WLWGUuTpjIv6w0bvpnsqbHgl8eHwackz8i3wblisqkyKz7glu3xsxix2pVw==
X-Received: by 2002:a17:903:1315:b0:192:ccfc:c178 with SMTP id iy21-20020a170903131500b00192ccfcc178mr35630421plb.52.1673446768369;
        Wed, 11 Jan 2023 06:19:28 -0800 (PST)
Received: from localhost.localdomain ([240b:12:500:6500:140c:f2c2:6a66:e450])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b00189c62eac37sm343480plg.32.2023.01.11.06.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:19:27 -0800 (PST)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     rogerq@kernel.org, tony@atomide.com, krzysztof.kozlowski@linaro.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH] memory: omap-gpmc: fix multi-device handling on the same CS
Date:   Wed, 11 Jan 2023 23:13:46 +0900
Message-Id: <20230111141346.1516-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

This patch fixes the handling of multiple devices on the same CS by
replacing CS name to "name" of node instead of "full_name".

In c2ade654dbf7d02f09ad491f5621fc321d4af96b
("memory: omap-gpmc: Use of_node_name_eq for node name comparisons"),
the name for setting to CS was replaced but it doesn't fit for the
comparison by of_node_name_eq.
In of_node_name_eq, the length for strncmp will be obtained from the
node that trying to register and it doesn't contain the length of
"@<cs>,<offset>". But the base name for comparison passed from
registered CS name contains the prefix, then, that two lengths won't
match and false will be returned, and registration on the same CS
will be failed.

example (Century Systems MA-E350/N, AM3352):

- Device Tree

  /* memory mapped gpio controllers on GPMC */
  gpio@2,2 {
      reg = <2 0x2 0x1>; /* CS2, offset 0x2, IO size 0x1 */
      ...
  };

  gpio@2,10 {
      reg = <2 0x10 0x1>; /* CS2, offset 0x10, IO size 0x1 */
      ...
  };

  gpio@2,12 {
      reg = <2 0x12 0x1>; /* CS2, offset 0x12, IO size 0x1 */
      ...
  };

  gpio@2,14 {
      reg = <2 0x14 0x1>; /* CS2, offset 0x14, IO size 0x1 */
      ...
  };

- dmesg

  [    1.596402] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
  [    1.596434] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
  [    1.596489] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
  [    1.596511] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16
  [    1.596564] omap-gpmc 50000000.gpmc: cannot request GPMC CS 2
  [    1.596586] omap-gpmc 50000000.gpmc: failed to probe DT child 'gpio': -16

  ("gpio@2,2" is ok, "gpio@2,10", "gpio@2,12", "gpio@2.14" are fail)

Fixes: c2ade654dbf7d02f09ad491f5621fc321d4af96b
("memory: omap-gpmc: Use of_node_name_eq for node name comparisons")

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index d78f73db37c8..3e3e84e34795 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2202,7 +2202,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
 		return ret;
 	}
-	gpmc_cs_set_name(cs, child->full_name);
+	gpmc_cs_set_name(cs, child->name);
 
 	gpmc_read_settings_dt(child, &gpmc_s);
 	gpmc_read_timings_dt(child, &gpmc_t);

base-commit: 13f35b3c72f4075e13a974f439b20b9e26f8f243
-- 
2.25.1

