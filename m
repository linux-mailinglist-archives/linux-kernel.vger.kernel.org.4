Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668616E3025
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDOJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:39:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E411703
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:39:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f3ebcso478620566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681551554; x=1684143554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PD8jCsTeYQriV7wAE/0X2NbGvAxABXFYQJ5UMz3CRWU=;
        b=NnUr0nrANizbMwQ+OFrF8pPZ2lV1uF3KsyCnXSIcC9HdXf4MHfvO6g5y/zxoVUHFtL
         uq9Qrz7vM/97m2FKTXwdX1dwEY1cQyOQbWlE3PeHNACR88mGlh9McXEKe4mW7c0sda19
         sQm+bFX/OSfCD4lyW/QG/iFnVFV2VJmcSjkL2f7n5yKOeqbLY8HRP20055jfP942d3rD
         y7FjiWFeAdZJsVXOwnp9uygq7/cT2Xj295Ual3vEhYfQzL9Fw4mFQKe3xG+QRx5uqsGX
         IJsP9K4yenfkVb0QyLB5uxhrUTJSCmJ22kbLxfq1JwiP8yNccHmFf6Ia+npbA8qjKRYa
         vapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681551554; x=1684143554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD8jCsTeYQriV7wAE/0X2NbGvAxABXFYQJ5UMz3CRWU=;
        b=b3lkwXGoUlvz0AerKBLo4XRJn1acN0PqauzUSZHvItJ+8M/9ahyYPti2E7MNMtDHcQ
         FGG2t8hLQ4I9x9KUbYMNA0+gkivhxLj0jKQbRTZCUflCpxySXrQ8qA/sbTvPytc4xgT5
         tyHMzVoV/8Hpp5iKV59AtVSJAhYbCbialK/7ZMzTzMMcR6qMiILGyVPeKhvsdqWSq9F6
         kDe42ul8q5lmeC4/rwN+3a0xcBjWySMeYoJFNO7LD4F9AlTpet+ZbICtK8A1OMfr2I+C
         w+A5RO2QNq5cE23WgTbx4+MtKM/kQhtNAVjetVvkyxolDJJ8Ezpgfz/6js40QGFwvQ8v
         Hv7w==
X-Gm-Message-State: AAQBX9dfosDo9slyjAvJBOT4oFHQLaOo6MH9ApDDvHf8sWR59SI2m/i+
        PeUOr/3F+Nl2LrZR+xngWZ2Je4zo44I4QnrVt6E=
X-Google-Smtp-Source: AKy350asCKZBROr26HaKLvDCLIsRVIkYjmh3G+qHfV5bk+GEx7t7sSH24egMT3zZMYzka4a82hh6Cg==
X-Received: by 2002:aa7:d616:0:b0:506:8e18:9e65 with SMTP id c22-20020aa7d616000000b005068e189e65mr2116159edr.9.1681551554352;
        Sat, 15 Apr 2023 02:39:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402014400b00501dd53dbfbsm3115490edu.75.2023.04.15.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:39:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: w1: add Krzysztof Kozlowski as maintainer
Date:   Sat, 15 Apr 2023 11:38:56 +0200
Message-Id: <20230415093856.41948-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Evgeniy wrote that he no longer takes patches for 1-Wire/W1 subsystem,
so add Krzysztof Kozlowski to help reviewing and handling these.

Cc: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/bdcf41d5-cd61-1e95-0b21-b8fe401644bd@ioremap.net/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f74d8571ac9..189001228c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22594,7 +22594,7 @@ S:	Orphan
 F:	drivers/mmc/host/vub300.c
 
 W1 DALLAS'S 1-WIRE BUS
-M:	Evgeniy Polyakov <zbr@ioremap.net>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/w1/
 F:	Documentation/w1/
-- 
2.34.1

