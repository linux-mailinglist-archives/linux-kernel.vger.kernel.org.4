Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52CF5BAD52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIPMVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiIPMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301BB1B9E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so813074wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EKLE8G7VsXBfz2sMQKTlT9oA8vhyiMjcMlyDKxWNGcA=;
        b=G3bghYNZxVOKWOCFldlhbHPkiUjddVLXde8clBPCep+fF3caWeBs0Z2V/p+jfQ+3Ln
         AG+Zch/FjojUC9f6dy8KHwkEVuYChfzFNgl6TXQTTypk5oEXtEyOztSg/ltMl/q8mL5j
         dGEIBHxXh15Tw5vkS4Tw9JEiwWPi8PbTiF9Qd/GnZ3iygtKycYHYJYiO8qeEwz9PXSBV
         iziz25XBXmgiHhqe1vXMA/31gX4GHMeMBxpYQWidC1eJjFX54Hc7krTtDpbCg5AZoqRr
         xpryOfQBojEextA4bX7il+jUVYiPLCiPQcgWpSAQgJZAclkQ0cZG3jISuCQOYcZ9d8Kn
         y19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EKLE8G7VsXBfz2sMQKTlT9oA8vhyiMjcMlyDKxWNGcA=;
        b=l1kjkltcGwkLS1lAJ6DTbsSnaNSIy4nYZNBX4SCqAZnxDQtt93SO4GnOTABgZ3sHc9
         oCdfTa/xTT6zCl1JnP/PbLYrx1gSFIIKuf2dkGiigjJnGzs3hJB5bxFzRVoCkJO1Lhza
         A7e9OtM0+yjMETLNP6dKiTmh1l07ZjBosawLOzEkWBwzG2LoNXR9i33uqOWnoQhqaQva
         M0LiyHhIiSlWtA2vR6Cr9dXJ3biqJ2MpZ4N4d0wFXyNjarueegMxb5tHIc60c9L1aHGU
         o1mtrTR/wWOE/PqyK2LgPXIpNWmt/iNNwSIfwgvGtABn8TY8LqK0sMZ6BXVo4Kvqs6v2
         IIJw==
X-Gm-Message-State: ACgBeo1/as94Qp4ypxcNLoDp8ET6w2c/kqFSgOQ7b8MlGCA1MaHvuhT+
        lJNO4UEoQsYb2KBXOY7vX0rLyw==
X-Google-Smtp-Source: AA6agR4OUU5qldq6AYPd8MeNobZKHt1W4FgEM6kfE4s+0ZzJRxXNvCGw9IUD3/kD1I2oRAyXZEAwug==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr9977979wmr.27.1663330878330;
        Fri, 16 Sep 2022 05:21:18 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/13] nvmem: u-boot-env: find Device Tree nodes for NVMEM cells
Date:   Fri, 16 Sep 2022 13:20:57 +0100
Message-Id: <20220916122100.170016-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

DT binding allows specifying NVMEM cells as NVMEM device (provider)
subnodes. Looks for such subnodes when building NVMEM cells.

This allows NVMEM consumers to use U-Boot environment variables.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/u-boot-env.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 9b9abfb8f187..d17a164ae705 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -92,6 +92,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 			return -ENOMEM;
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
+		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
 	}
 
 	if (WARN_ON(idx != priv->ncells))
-- 
2.25.1

