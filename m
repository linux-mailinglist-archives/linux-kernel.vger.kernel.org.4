Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD1736B28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFTLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:40:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF654A1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:40:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so5369591e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687261257; x=1689853257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNFZpEh4/cl7s83JmJ5khDQ6aml5OmK6AW+M363aFjU=;
        b=biDDrOKTzHLYitPYod0RIO44Z1JCB7Vq+G/s+gIYRJ2XB3b8jr5tsk0/Ye8+Kzh0LE
         Eh+8lJrPZvu97GzuuyWh78xXH1gh8GVwXM9ymXeSG3xrnPYwkR20MrEBXlcBtDrp2gUD
         pmxc6LeLO/SoMTCZtrJz2gDxUEYFN7NpO4t9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261257; x=1689853257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNFZpEh4/cl7s83JmJ5khDQ6aml5OmK6AW+M363aFjU=;
        b=bmH+bsOE1f2i8p55AqRn9/w7xdPWgByvGIUACAhccJ41WVNTU/tNH9n3nD461VjAey
         c8imF1x6uASA+ML6otHxHPSKL4KGwcOOCCO6tZWASBzwdK4dGJTzALDIcNiAdD6ykqxN
         4QBoULWEZl4yoTHOnOWNZAtsDXXGDfq6vQzvrwe/xyvAAUGvwEnwG2dCwPhjEWbWaYZy
         Zus40OeaIL2V6vRVrmeCHrvGmrlbC7hQV/UAE50fim6mZkKJhAh9DEIZR0qyzdmGhtkv
         4vGbRsvgjSS2whLVAXXP8UF2pr0QwSP4LT2W2E+LdGv6Zs3CuyMeN4+sAIZgP6gS6vdv
         EdcA==
X-Gm-Message-State: AC+VfDy7ev67MsaD4+BfqO/VXWgbH7R/8p3Fw4PpFLfOmCbsh1k1yfRy
        8cOVkD9sN8Jhz2YIALPZHg1tZvuyNjmP30lxhh37ig==
X-Google-Smtp-Source: ACHHUZ7q/79IAx2fL0zq/CrCtVLiuxKFTR+X1CC55xo2T25ZTgPLBk21UNhluCFwBxX9meKQmLwfHg==
X-Received: by 2002:a05:6512:3284:b0:4f8:692a:6492 with SMTP id p4-20020a056512328400b004f8692a6492mr4413487lfe.32.1687261256749;
        Tue, 20 Jun 2023 04:40:56 -0700 (PDT)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d12-20020ac2544c000000b004f84162e08bsm329879lfn.185.2023.06.20.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:40:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dsa: microchip: simplify ksz_prmw8()
Date:   Tue, 20 Jun 2023 13:38:52 +0200
Message-Id: <20230620113855.733526-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ksz_prmw8() in terms of ksz_rmw8(), just as all the other
ksz_pX are implemented in terms of ksz_X. No functional change.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/dsa/microchip/ksz_common.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a66b56857ec6..2453c43c48a5 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -578,17 +578,8 @@ static inline int ksz_pwrite32(struct ksz_device *dev, int port, int offset,
 static inline int ksz_prmw8(struct ksz_device *dev, int port, int offset,
 			    u8 mask, u8 val)
 {
-	int ret;
-
-	ret = regmap_update_bits(ksz_regmap_8(dev),
-				 dev->dev_ops->get_port_addr(port, offset),
-				 mask, val);
-	if (ret)
-		dev_err(dev->dev, "can't rmw 8bit reg 0x%x: %pe\n",
-			dev->dev_ops->get_port_addr(port, offset),
-			ERR_PTR(ret));
-
-	return ret;
+	return ksz_rmw8(dev, dev->dev_ops->get_port_addr(port, offset),
+			mask, val);
 }
 
 static inline void ksz_regmap_lock(void *__mtx)
-- 
2.37.2

