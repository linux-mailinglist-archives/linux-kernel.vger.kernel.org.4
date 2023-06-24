Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C073CAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjFXLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjFXLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 07:30:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D11990
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 04:30:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso15437995e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687606245; x=1690198245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRYaJVMtI2+V2Yy5LWABEK4iahmUg3ox3qudaa1bywQ=;
        b=Ot3PiZHGIRsBOazVE8UAaJ3/Yk5C5vC+D9CgOwenc9LpBe9HHXQq6flBjrE3hNYNgY
         +RN74+AK7hmcTdVZJENVCxA9Hi2f+YQNDyzLWEPygw+1B6DjMYofgQhPx1WbYY8TZJuv
         cEJaPO2QyUxqEuHw0c3hG1EFNjWgvAoazVAyPt8fA9VB5HdobiFxsep+dA7K469uOlrG
         Sg1o0MgH9i+PeNE4bZSynn9EEIqzVPvRgVlyrsgJSBq+TVOY6cLXZ3rOoHc4G4fYRVK7
         ZPoIo4/9kMmYGl7c/p5B09SbhUtP0Y+dfjI+/QaMS+Djba4ue7Q9X+Bfb1QIam8Z/h8o
         IinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687606245; x=1690198245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRYaJVMtI2+V2Yy5LWABEK4iahmUg3ox3qudaa1bywQ=;
        b=D4hvJhUD6QNGepFcCLlclZLqmu5orroosQTswnIOneG0V/L/kQn4KZIixmmHNLfizt
         tBhZBn0VAuVidBLvpd6L7W3/P7xgI3W2PPSJHosxp6S2pkdp5ZkdTXyYQa8lms8zjWvt
         0NVUbdZbGNVIaHhjoXv9DZokpN6W4PiqojrENYDVasISnrBY217UL4O4YNqUxUY5NiWV
         Yy3bx+zXTPW2Z82GLzaRrgjiPX0yJJph74BojI5QCj/y692TrZ+znywtKzEZlr7gn6+p
         GO+BFvcgjEKWdW+RfZf9pVFn5h+atG6X+um36sqoS/HlrA+OXfBfkMaO3R6xlknwbyt1
         uSAQ==
X-Gm-Message-State: AC+VfDyIZIwGFOQvhqXFB0UkArhBZ8OLiqsq0yjFncKKzV/mYgl2gkXN
        J2UQwdP39wkkvFkr55NsDn3fvqBPLVFRxQ==
X-Google-Smtp-Source: ACHHUZ5IU4dS6xvQKCWsBtDRjGB+ZmX9m5sNYJJxzfXFpbyFViNQ7m+fT7Ws2tgc050NYUIPlwpqnA==
X-Received: by 2002:a7b:c40e:0:b0:3fa:8714:86bd with SMTP id k14-20020a7bc40e000000b003fa871486bdmr410519wmi.29.1687606244738;
        Sat, 24 Jun 2023 04:30:44 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b003f9b29ba838sm1925790wme.35.2023.06.24.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 04:30:44 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@dune.hu>, Krzysztof Halasa <khalasa@piap.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: ixp4xx: fix IXP4XX_EXP_T1_MASK
Date:   Sat, 24 Jun 2023 13:29:58 +0200
Message-Id: <20230624112958.27727-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IXP4XX_EXP_T1_MASK was shifted one bit to the right, overlapping
IXP4XX_EXP_T2_MASK and leaving bit 29 unused. The offset being wrong is
also confirmed at least by the datasheet of IXP45X/46X [1].

Fix this by aligning it to IXP4XX_EXP_T1_SHIFT.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/ixp45x-ixp46x-developers-manual.pdf

Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Based on 4.6-rc7-ish, since I didn't know which tree I should use,
though for this driver it probably doesn't matter anyway.

Build tested, but not run tested.

@Linus

I found this purely by accident when I was looking for examples of
GENMASK(). Your recent push to resurrect ixp4xx in OpenWrt convinced me
to submit it in a timely manner ;D

Also the "ARM/INTEL IXP4XX ARM ARCHITECTURE" entry in MAINTAINERS still
lists your kernel.org email address, you might want to update that.

@Imre

Likewise, it still has your openwrt.org address.

 drivers/bus/intel-ixp4xx-eb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index f5ba6bee6fd8..320cf307db05 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -33,7 +33,7 @@
 #define IXP4XX_EXP_TIMING_STRIDE	0x04
 #define IXP4XX_EXP_CS_EN		BIT(31)
 #define IXP456_EXP_PAR_EN		BIT(30) /* Only on IXP45x and IXP46x */
-#define IXP4XX_EXP_T1_MASK		GENMASK(28, 27)
+#define IXP4XX_EXP_T1_MASK		GENMASK(29, 28)
 #define IXP4XX_EXP_T1_SHIFT		28
 #define IXP4XX_EXP_T2_MASK		GENMASK(27, 26)
 #define IXP4XX_EXP_T2_SHIFT		26
-- 
2.34.1

