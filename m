Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0574BF07
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGHTxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:53:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393D1A8;
        Sat,  8 Jul 2023 12:53:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso376613666b.1;
        Sat, 08 Jul 2023 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688845993; x=1691437993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVW/bBC+uKDhPQ3FjSGENdiWFw46dm/KEy0pvQHTDT4=;
        b=bujg8cJ5hi3Moj0Y55nBBhHxVligDoOqGyu7ELw1EgLs08nGc+VK8AY23C2Tb58uY8
         gMKcgxmv68em5r6JDmU32MSvoSv8llNmHQlLDjmZSeaRSxuy5x9yOeeZghPpjrThlzp4
         cks8kC6AfWaw/gI5DEQNXi7MfKCqIzNOtUAWPHl+7mtTq+Q2f+JariKXCbpfABn2EN6J
         b/xlrTGXhMlnJDNskZGMCrAv3JbuFSdSy/tqGoB/KUexfWXibfABfq5a+WQot7gAzwTo
         yOHv6gQbDo5AnYztFUQ7GjzS4W6ZDUmcD9Z8hRWDQEbwUdUCYtCEwM0kuji5MEJ0m7/O
         +1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688845993; x=1691437993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVW/bBC+uKDhPQ3FjSGENdiWFw46dm/KEy0pvQHTDT4=;
        b=QJHpjPqKSzHIZCEAljh9LyPdwsyLWZn4dvmM2nowJLbsBtn69JkaMRg7FL6hwc/+ml
         IlF6A/Ddv8z7snW9n+e2XZfHN7JH2OG/4/n5ldqT7nPmYrkVbmuFiU0fKhJXxTpchDJ/
         K/aA/Df1zuSAMM4yLG9gIrgDgTIz471674A72glB1y0L5U2uKLe5m1gTcymn9YlNBnAq
         fzYYQiVjMhXFZ/WsJt9O54m3OGF/2zPw2GNBPDhFS9Cog7PbAs7wDSpKNLVHh1RzXxdM
         LmxZ1nNSMJFOvbjxrban3r9+tmJCrAKgymEx5IvY4RZm3UQxmEgc2Axv3CR/g4UAXam6
         dVPQ==
X-Gm-Message-State: ABy/qLYoVabv/tGGOC3mpwv8cPaFQEVRcIU9tTHffdrWMyz3xfYdWvSx
        ybizfgRfEvxxS/+6atYdu/k=
X-Google-Smtp-Source: APBJJlElmJCz4iIpNX1e0yEbK+gCOYsdjagPLAiYMrYuyKy+teIi8vKCamVr85oKctgVnIoUme6Wsw==
X-Received: by 2002:a17:906:ecae:b0:978:b94e:83dd with SMTP id qh14-20020a170906ecae00b00978b94e83ddmr5995155ejb.75.1688845992958;
        Sat, 08 Jul 2023 12:53:12 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id hk8-20020a170906c9c800b009821ce1ea33sm3880966ejb.7.2023.07.08.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 12:53:12 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: add myself for spi-bcm63xx
Date:   Sat,  8 Jul 2023 21:53:08 +0200
Message-Id: <20230708195309.72767-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the driver is unclaimed. Since I was the last one doing
substantial work on it, add me as the maintainer.

As it is only found in legacy products, mark it as "Odd Fixes"
instead of "Maintained".

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * fix the driver's file name
 * include the right people

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc201627c2e0..2594a0643e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4169,6 +4169,13 @@ F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 F:	drivers/spi/spi-bcm63xx-hsspi.c
 F:	drivers/spi/spi-bcmbca-hsspi.c
 
+BROADCOM BCM6348/BCM6358 SPI controller DRIVER
+M:	Jonas Gorski <jonas.gorski@gmail.com>
+L:	linux-spi@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
+F:	drivers/spi/spi-bcm63xx.c
+
 BROADCOM ETHERNET PHY DRIVERS
 M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-- 
2.34.1

