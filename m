Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF56E30CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDOKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDOKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8DA5EC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so2021914a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555409; x=1684147409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/p4NRTjs3BLjzJ+cn6r3EmwmpCVSEOW5kd0Ht7+9co=;
        b=YXcbgRwsSgr/cZJsxc8wHJKyT2TNmzYL0AS/8ZRCR5I23P+xV4iRCgOJJ/b+doiGoP
         1PMy18o+UMdWKonNljUZNVQ6z2oyM1sNBaWRa/bmOS3qGWngxZZ8QsD+SEh1LcjxOdPl
         goRDvRwsJ8qKJEA+smv6WiMmABWP43MzDflZ/29iv24fcUwlrhR1U++ZdwDJPlfQyQ0n
         v5taaDS/yUDTaNe56P+LON+qY7Q32ruraDVQniSE97D/mU9IaHmcwWmpCjObjjV8yE2Q
         y5Ooz5D0Rv6GXP0BDgj0s5uh3Fa9RLcj2JmUowCBxWc6qx3A4+26bonHxm1DbgQ61qvG
         LfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555409; x=1684147409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/p4NRTjs3BLjzJ+cn6r3EmwmpCVSEOW5kd0Ht7+9co=;
        b=AA44z3cb7SyZ9PeoIKNwKA32bkwg7xIJVewFQA7gh9yAi15RqEQ9bR/Hej3rI6erXt
         LoD3ANzbDBSD9aABcdf4xWIKH/jZGEpuzwo7swliVmJ5H2M0cuVFb0xyfrw2m0bY0Ray
         UIgMH0YmZNEDwYx4dx4qEl8tzUDSoKdaSVMf8HpNlCmk9m0/ym/W4zHfYdXU9P0V/HY2
         V9RCAuDWoY8twxajN5FNJF5k7nJPxfEJ9zbrCs1E3yrvXxu11fnOAw1oxqGK/gb0vrl3
         Az3CQRvlsaidR4IDrKMMtMRNLl4xmN8/RAfuUO0Q7tXK3fB9+ylkaWbvdYDnADfkvU6K
         J5Jg==
X-Gm-Message-State: AAQBX9clYOebpIsf0yBCsIRPAmLYo04N75rI0nbJVWTOdi8xDcso9mfa
        jJEePQ1Z9zGLndRsdTqRZcowGg==
X-Google-Smtp-Source: AKy350b8nFIjeKtfcK+zDkqqPw0+7OElRQc6Y3ogylMJD+VwGYTUHrhFdnCujozs0PidPBblAjvWmA==
X-Received: by 2002:aa7:d509:0:b0:506:7d34:51d1 with SMTP id y9-20020aa7d509000000b005067d3451d1mr5623056edq.29.1681555409487;
        Sat, 15 Apr 2023 03:43:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/15] w1: omap-hdq: allow compile testing
Date:   Sat, 15 Apr 2023 12:43:01 +0200
Message-Id: <20230415104304.104134-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap-hdq does not depend on anything from ARCH_OMAP for building.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 692cac3ff0ee..ad316573288a 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -53,7 +53,7 @@ config W1_MASTER_GPIO
 
 config HDQ_MASTER_OMAP
 	tristate "OMAP HDQ driver"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || COMPILE_TEST
 	help
 	  Say Y here if you want support for the 1-wire or HDQ Interface
 	  on an OMAP processor.
-- 
2.34.1

