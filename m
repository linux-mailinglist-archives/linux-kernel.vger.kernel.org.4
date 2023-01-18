Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C3671614
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjARIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjARITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:19:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8246E833;
        Tue, 17 Jan 2023 23:47:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so10280687edd.4;
        Tue, 17 Jan 2023 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LCPLBgrIk06G/mmYXIxpu2GlEPHwjS0EL5galTqjKo=;
        b=mk6DYCPA+0dr5KzN8hWOljeu2+D2BOIf4y69CviWz0TxGM8p3ohAy/qdgWh+4tP7Pn
         RU8t83mIghKo4gQNvEx22yvEMHQpZ6qlduuloCBR9WWdCLEkbSl73vXzNhzQgefnK2CS
         JavXdDwYnoUjDgJTrtUjWN5YAgI1LgXr6n0YKvFpZ34QyA0AxZMjLUvlMQT/q7Cwvkmr
         nawi1MgAM45bvssJ8V0lWmj8v9HfaEZVSFE+6zlrxcYcDKzQ04RuIowZkQr+Etiau4LM
         pzQKX4TqbeOGYVBcQnpSQBERHLtm9Nhftr5l9o9QfqgkW8/OB+pyXuBUl8NDmqoNeav4
         KpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LCPLBgrIk06G/mmYXIxpu2GlEPHwjS0EL5galTqjKo=;
        b=F3fy+O7MkwwiTz7Z+zD3H5iaEPlWlvuVdiI7Kxgy0Wecq6equ/sYEE7bkXCFtpgyxY
         otH68oswe+ABiCM5xNfzirvO9Ox09sQ2bRUvE06onkmAoOkhnUrMMM/hX9F/JHjh0exd
         XRXGA2QYulipprkNcl0q3QG56q0KzFFWDnEfWp8aSyBXbAY4cGg/v1ZxA9Mtd/y4E8uk
         C54ygW1fFvfV3Cjs9TbcK0uJKaA9oCpXHlIkhASMvYsEhTciPoe3exZOP+GmDyphLvyC
         0NxkidXqmCifwkzyrer+cRBnYQui0eaw1h5EuD2m+pTlgRvNrChYslmPmi4zqaDfgzR7
         bKkw==
X-Gm-Message-State: AFqh2kpWWgjJYRhj3DjU1f8aw9AXkqxA27UJHkVgmFQ2CxVaKf76oJAb
        BLhJoUETWc8QuTM98Qa2i74=
X-Google-Smtp-Source: AMrXdXs+nGvLJcMIXH6ilNgO1yBx9w5fuQ2adsLupLu+3b5xhhSHqIu/FadeRG05Q0MYZTQT1snkNw==
X-Received: by 2002:aa7:cc91:0:b0:46c:6ed1:83b0 with SMTP id p17-20020aa7cc91000000b0046c6ed183b0mr5821272edt.9.1674028036849;
        Tue, 17 Jan 2023 23:47:16 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:595a:333:19d3:2dba])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm13813184edr.32.2023.01.17.23.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:47:16 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] counter: fix dependency references for config MICROCHIP_TCB_CAPTURE
Date:   Wed, 18 Jan 2023 08:46:59 +0100
Message-Id: <20230118074659.5909-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dfeef15e73ca ("counter: microchip-tcp-capture: Add appropriate arch
deps for TCP driver") intends to add appropriate dependencies for the
config MICROCHIP_TCB_CAPTURE. It however prefixes the intended configs with
CONFIG, but in Kconfig files in contrast to source files, the configs are
referenced to without prefixing them with CONFIG.

Fix the dependency references due to this minor misconception.

Fixes: dfeef15e73ca ("counter: microchip-tcp-capture: Add appropriate arch deps for TCP driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 90602536fb13..b5ba8fb02cf7 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -63,7 +63,7 @@ config INTERRUPT_CNT
 
 config MICROCHIP_TCB_CAPTURE
 	tristate "Microchip Timer Counter Capture driver"
-	depends on CONFIG_SOC_AT91SAM9 || CONFIG_SOC_SAM_V7 || COMPILE_TEST
+	depends on SOC_AT91SAM9 || SOC_SAM_V7 || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	select REGMAP_MMIO
 	help
-- 
2.17.1

