Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E49677F21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjAWPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjAWPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3A2917D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q5so6463705wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQrsbaoWMRqz/6zcr+gxlvsS+z2BwQ6sf3IkSGfrHIg=;
        b=DrZkJqf8Lx/ikr2BhspNugPkwAK39BkOWz2sYI9KIsWgPfrmz3MxCIAlThf9eQMRoU
         0jFC/YJ/sI0ZvwfIPyUKQOcYKAjNBgQZ903EVlEmHIJERffJSuQbWtWQOQplD4P6xzXT
         vjbQhlypnRB9rEdBr17ZgPxaIuIfR28dVJhRctEPx+xF8mt3sF7Xn9NHD/tFZthCCP3J
         N9cjFd21wGYV/rg0RlP7ggPd5GuxBxGv3h40ZGahorcp0z8jWPFrnpEgdSfOiixLtos9
         M3vRGjxu6YizEJCkQmiusSvfeahaywTgfrHTZygFlKjEDsvmsqohvwqFgejQlMBcqr7Z
         7qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQrsbaoWMRqz/6zcr+gxlvsS+z2BwQ6sf3IkSGfrHIg=;
        b=aL+EwMZ3V4EUjvFccZ+oiisEVZ1YsMCEhsubZWVHnhSYCP+vReWGOWWMnAFkn2XBik
         mjmoN266KPW0zlDcMcNb/FVjEKYGEJAk95BEWLm8S1HSyEEVVKQh7iuKbIRq524QZz/B
         X1V9iHMNymbmu2iParaqbfwOwNWumx9wUuukAg7cvVqemik6gwRNq3UyYvPgTnWAODeW
         mlLeGZRkNKaEIkQue99kcxupMcGqnsI/jW8ccdIXPoVEOI0+PWxVPCi0VM7NKLnrHOMT
         q214ibFh84Vz6gAhUOr9uCrV5Fm3mvIeBBj/PQcCZVoIkK3GZ+vlx4vRVNq5PKtXgP2n
         iC0Q==
X-Gm-Message-State: AFqh2kpsXWq7Lk9ER96rCFb06sIJB4f1toEMb5omdhblIo1JQq5cOpyr
        it77LX73k7hfkepmpA40vv+eSA==
X-Google-Smtp-Source: AMrXdXs32d96ovFaMtHszqx/rc2fx1h5rF19uqq0L+W7R44WRoQBW69g+WiSqNVd5szTAMO6f6ULYA==
X-Received: by 2002:adf:f9ca:0:b0:2bf:9424:c163 with SMTP id w10-20020adff9ca000000b002bf9424c163mr9542845wrr.57.1674486815043;
        Mon, 23 Jan 2023 07:13:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/13] dt-bindings: serial: restrict possible child node names
Date:   Mon, 23 Jan 2023 16:13:00 +0100
Message-Id: <20230123151302.368277-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The re-usable serial.yaml schema matches every property with ".*"
pattern, thus any other schema referencing it will not report unknown
(unevaluated) properties.  This hides several wrong properties.  It is
a limitation of dtschema, thus provide a simple workaround: expect
children to be only of few names matching upstream usage (Bluetooth,
GNSS, GPS and MCU).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 11e822bf09e2..21992e9a3c2b 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  ".*":
+  "^bluetooth|gnss|gps|mcu$":
     if:
       type: object
     then:
-- 
2.34.1

