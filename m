Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465216EE052
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjDYK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjDYKZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:25:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05712CAE;
        Tue, 25 Apr 2023 03:25:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2474e09fdcfso4770303a91.0;
        Tue, 25 Apr 2023 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682418303; x=1685010303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvAqq7vb9DF2nKzu2bS0JuzdS+URG2WEwFTC3+AC1JQ=;
        b=kglRNpV1I25Xn5ebT5OeWsfxM4qQ5UzRfFRrKN5wKFkS0t1M6gB6f+XRBcthVe3bY2
         L0JP3jFnaQ3Jbl2Llj4cn2CxqnzieVysR6E656zXut5GlxKMbadaaBsHTaH6aRZD3yue
         z3l26hk0zpo6Plo7PyITVO724xC3HnHauzLZi+KRojrgjahLtbZ/RaDCtbAmXMUjIptO
         OZpYTUvOO1zhcSL5oHYKRp0pZdT0uSzIWMcF0fj5Ed6J+n1g8lgGq8KFrVOQihzoTyNM
         OoWLEonpqpqvvQV7vWjojmEBeG5RkDiebblWBQkVJq2D6XmsTBD2crtPRQWeyHr7+Av+
         RucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418303; x=1685010303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvAqq7vb9DF2nKzu2bS0JuzdS+URG2WEwFTC3+AC1JQ=;
        b=HMve19cNamGibsdMxRh489ctD4RsTburOdPkh8ZHXCvsxZS/NTsbAtO+sAOOJA0deo
         vs1mqzleKpFY+P0bgw/9iXA048r3AMs49UjRdltzNwu1tcLRZO/z1GOv51t1FxEfjXFD
         oUbyPS3lRCKKbTTndMyHPWmWoOHho4zZ/F1X+P5NtxFUUdaXc/sT28WxqtG0HKTpVpL3
         7lqfHnF517GbzkFWnaJ7ydIjjxqg6a3dalJkfo9/GE7sUBOGUbctOnt4Ci8YgLKEBEj2
         14L80uzqz3C2xrfn7ZqrFLgbxyOA/y0qhrkxeCN7f55P9cOX3rnMSz7C9BxuxJfCV3u8
         h7Xw==
X-Gm-Message-State: AAQBX9erW1DeMYvV6cfmWI7LXF3SYhgkAUvHFMhk7KPF/+7nNxWYWSY9
        uVZNJgeFsm1GJ1m32XbOITE=
X-Google-Smtp-Source: AKy350b+oYxBE9oqvQYHJzfRSZ4R43nZJjdWkA3mO5rxJ9ObN5ORia4PGTU1/UxZkSxxyhpwGfgS6g==
X-Received: by 2002:a17:90a:ea07:b0:240:d3b7:e850 with SMTP id w7-20020a17090aea0700b00240d3b7e850mr14583513pjy.49.1682418302794;
        Tue, 25 Apr 2023 03:25:02 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a63125e000000b0051b70c8d446sm7644715pgs.73.2023.04.25.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 03:25:02 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v8 11/11] MAINTAINERS: Add entry for NUVOTON MA35
Date:   Tue, 25 Apr 2023 10:24:18 +0000
Message-Id: <20230425102418.185783-12-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425102418.185783-1-ychuang570808@gmail.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add entry for Nuvoton ma35d1 maintainer and files.
In addition, update board binding paths of NUVOTON NPCM.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14fadebf42fd..1550a08908cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2501,6 +2501,18 @@ F:	drivers/rtc/rtc-ab8500.c
 F:	drivers/rtc/rtc-pl031.c
 F:	drivers/soc/ux500/
 
+ARM/NUVOTON MA35 ARCHITECTURE
+M:	Jacky Huang <ychuang3@nuvoton.com>
+M:	Shan-Chun Hung <schung@nuvoton.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/*/*ma35*
+F:	Documentation/devicetree/bindings/*/*ma35*
+F:	arch/arm64/boot/dts/nuvoton/*ma35*
+F:	drivers/*/*/*ma35*
+F:	drivers/*/*ma35*
+K:	ma35d1
+
 ARM/NUVOTON NPCM ARCHITECTURE
 M:	Avi Fishman <avifishman70@gmail.com>
 M:	Tomer Maimon <tmaimon77@gmail.com>
@@ -2512,7 +2524,6 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
-F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1

