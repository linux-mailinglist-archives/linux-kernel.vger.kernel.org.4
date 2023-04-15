Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0016E30C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDOKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDOKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DAF8A6A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ud9so51647143ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555407; x=1684147407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2p4W5eau8bFWAzOfsvO6/XIL8xZyE8Y7G5G/91OHq0=;
        b=XSqvT0MjSDdLTrS54l9ymoLk0dcAi+uusPHgm963TQ8wCFPSVMSeE1ZFT5wOxDlg5T
         KzeQ3q30t3Y9XN6PVBlq9WJICKGIDYBdlFruiisSKJP5PfpUx68xKyBj8yWyIZnpId8P
         gVNolNHrl0D0nNByF1+1+TT+E/LJ+yhV7hmJf+m5LdtBKshrsr5IMPcz2i2QSFDTNJ2/
         SlUJsGf/MUsg2LWtRPWfnc9rKY5b4QszIT14GBCrS45t+uljNM3nU1G27X/cZ3X7qeKl
         criRn8R2npvBXWn34nDI+taICL7B4ZQl8pJiHEI5G2ZlHcbojOBnvhHSbXcGdKO7M95J
         WNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555407; x=1684147407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2p4W5eau8bFWAzOfsvO6/XIL8xZyE8Y7G5G/91OHq0=;
        b=TnDzyZxQURf1lUCU0RHAlJozUuX11UIFtpW0/LUkL1E6Qv0vKUN4/NkT/TCVHmW04a
         7nFnHzLCDL76mI1W+j/G6SxfykvisxxYN1Fu9h3MW4l4sQtVZOLA5o4smdrFd1A5XkTs
         oaHMfjAlOsSgoMz2j2kah5rcjdAp2WRDfq4Nr2gk7KRyeZQFh0z+ZlAJNJiW8nTaFjyg
         GipPEwqM8weEkfE5tT3saNZQhTKt0xueNwzqOWEXBKpPtZBiyTTxIByhgxBIWGkdPHer
         OmbZ27/aDJgTXpFPzcu6eoPP4xN236CmBqbwRnbHyy5edj3pOB3bIT/l5mnU4uegRyAa
         MP2Q==
X-Gm-Message-State: AAQBX9cUL04q3xxhdt8l+GVEASv8fbrgq26epN4j6XNBtQnwlqZqmNCG
        VEiIx0FVxSoOPf3Q/FYDzrgl7Q==
X-Google-Smtp-Source: AKy350YHGBB50ymOjH++0GwAiv3zGH2q9RmNoc2RqYpIg9DKEFNk7nmLsO7o3uBbLq3E/8fWE0lc8w==
X-Received: by 2002:a17:906:fc2:b0:94a:6874:713d with SMTP id c2-20020a1709060fc200b0094a6874713dmr1476846ejk.56.1681555407506;
        Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/15] w1: matrox: use inline over __inline__
Date:   Sat, 15 Apr 2023 12:42:59 +0200
Message-Id: <20230415104304.104134-11-krzysztof.kozlowski@linaro.org>
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

Switch to inline as preferred by coding style:

  WARNING: plain inline is preferred over __inline__

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/matrox_w1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index 662108b1d806..fb38d92b2f43 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -63,7 +63,7 @@ struct matrox_device {
  *
  * Port mapping.
  */
-static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
+static inline u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
 {
 	u8 ret;
 
@@ -74,7 +74,7 @@ static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
 	return ret;
 }
 
-static __inline__ void matrox_w1_write_reg(struct matrox_device *dev, u8 reg, u8 val)
+static inline void matrox_w1_write_reg(struct matrox_device *dev, u8 reg, u8 val)
 {
 	writeb(reg, dev->port_index);
 	writeb(val, dev->port_data);
-- 
2.34.1

