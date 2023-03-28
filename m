Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47826CB3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjC1CTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjC1CTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BD42D4C;
        Mon, 27 Mar 2023 19:19:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so9515162pjd.1;
        Mon, 27 Mar 2023 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/9A2Wvuk2e7mWbwnwQigP3PrjzpmI/BM4Gbz8gqsvk=;
        b=qfJbGxSRMiBItcolvMBYBmxb3l30XCwfsyieOx5iaej61aOCI4nVxzkaDTorETPVo5
         5ojkiaWOAQu6BgpeH5h27iNx31tyOWtbeR/iQ6Eyl0FBoXVEP5ugELmWmiRnBZ9LSMoc
         +hg+fi74kWBZn4VxokfYaZmrqFGKRZvkTayUMXS1GQlE2U41azWBU4ZUlZF+SUhgQWzu
         DgOBOJxwGe/LGkPv83X1fMk4h87NbPyPuJT+hJ79gpVM/ttE2UvnxTi+ZAZvv1tpvlgP
         4NkpMVqqUTZy5KstFa0m0NK40Z6quqldU9Ieg7lPy2+Jh/CVw/tUWuxnftjDt7PIZ47N
         X9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/9A2Wvuk2e7mWbwnwQigP3PrjzpmI/BM4Gbz8gqsvk=;
        b=EDuJmXmG19oRm0nua0Afjwh/R7VWiVkWjt0//bZ/Sp3ENHgZpEifI75q6U9SvIaERN
         +otzZ1gvEc1fJ2LqBrYbcbXx24JIaprfpZ5wpTSvcOCPOx74HOVcBQWUOcqGeTBVgJaS
         7bJS51hvmzhetLdL/ukXpQcVUrSOSP0gq2r+UfC4yY27p22S2SUMlbLrvEsuQv0TCLqd
         P125ncq29mnZEcMOsDesTXK7M8kBLStfaxMbV2HDVIrhjBM4C1nPd1Np4qszGUA5/yGH
         d2Hu0+vUxfFqK+7Tq0uAH/AEf2F7b+kKguwRg5fyWTN6WydKbpJKV7YPGYXTP6aYlZ48
         RGJg==
X-Gm-Message-State: AO0yUKXo/UVsfDtwTpwnX3ahdaq/pmXmuF1oT5kaELOjxUpMB+H9+mu2
        Hx5WvxO8aDKOFcGOHtZXRZg=
X-Google-Smtp-Source: AKy350Ygcad6hsMA1rlTim2DCnOFxr/TlPrkYG1V4jpcJiFueHKkK3LUDz97r/BJsIuWZJ5AATApSQ==
X-Received: by 2002:a17:90a:351:b0:23b:355f:b26c with SMTP id 17-20020a17090a035100b0023b355fb26cmr15432934pjf.23.1679969973986;
        Mon, 27 Mar 2023 19:19:33 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:33 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
Date:   Tue, 28 Mar 2023 02:19:05 +0000
Message-Id: <20230328021912.177301-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add Nuvoton ma35d1 system registers compatible.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c828c4f5e4a7..7ee1d27f59dd 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -56,6 +56,7 @@ properties:
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
+              - nuvoton,ma35d1-sys
               - nuvoton,wpcm450-shm
               - rockchip,px30-qos
               - rockchip,rk3036-qos
-- 
2.34.1

