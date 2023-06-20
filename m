Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57543736B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjFTLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:41:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4DE71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:41:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5979835e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687261259; x=1689853259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc0VF9QAKItzIoQIN+TGeSbpZSwD884ZJlY6XLWEwnQ=;
        b=OSo/IOjpcTOvWjExcqsUbvuVyXnARS++fI0WVy3bVnpKwZGoSPB4IrOxk/VnscG8BF
         FfeSlGKun5ERhfnpb5CLB13pbyP1lWPKhVHkcU8hsfjhGbLJJtwZAFIiMr/anJHqRSP1
         +eIcUHFwHvqjxUsQOzyIPT2Qmnbt5eDVXiQBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261259; x=1689853259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc0VF9QAKItzIoQIN+TGeSbpZSwD884ZJlY6XLWEwnQ=;
        b=dRAGp31KW0QsnNOcvgb/iGkxWhFynsVxRhWtrrvLdq/FdqBUnwIxVV8TNaDnCr7wOm
         wW+K6mOtUTXAvzJ5PwhWLGHQw52F0plp3+GdViPxjJGoc3ufyp8uFqL98yc5WM/6ztlr
         pISE/gm/x1AZ55EYDns04q1k4XqN9X175IETpQ89f4Qzvr1U1IN5thTh8HnyEQ9np15F
         IxLGoudOnCYkxAQXgNcP13H5IOd1oqMOgFsLdSCSnbFYxvua5bhWDvCbxbimTJ/cMUwA
         dsjdTjrvoMgn7zcLTgCnWa2oQduXSg+XqjqJRq46aSnjPAwLugtcPwKoZL32I1Z67IU6
         J69A==
X-Gm-Message-State: AC+VfDyzCt4yvO/LTyBFIN6oX3s+T3GNRe/egGUmmPQHrW1TiX8/OWW2
        CKNI6oqdY2Iy5Y0dj2RwFtiKEg==
X-Google-Smtp-Source: ACHHUZ7vTB7KJs+ED1EvGxXyIkcZbS3zd6TkV0QsQM3gGOpK8DiScTUsVPoFeq/WVfuUiSUwiOZvhQ==
X-Received: by 2002:ac2:5b12:0:b0:4f3:dd96:bf55 with SMTP id v18-20020ac25b12000000b004f3dd96bf55mr7093121lfn.11.1687261258951;
        Tue, 20 Jun 2023 04:40:58 -0700 (PDT)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d12-20020ac2544c000000b004f84162e08bsm329879lfn.185.2023.06.20.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:40:58 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: dsa: microchip: fix writes to phy registers >= 0x10
Date:   Tue, 20 Jun 2023 13:38:54 +0200
Message-Id: <20230620113855.733526-4-linux@rasmusvillemoes.dk>
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

According to the errata sheets for ksz9477 and ksz9567, writes to the
PHY registers 0x10-0x1f (i.e. those located at addresses 0xN120 to
0xN13f) must be done as a 32 bit write to the 4-byte aligned address
containing the register, hence requires a RMW in order not to change
the adjacent PHY register.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/dsa/microchip/ksz9477.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index fc5157a10af5..83b7f2d5c1ea 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -329,11 +329,27 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 
 int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
 {
+	u32 mask, val32;
+
 	/* No real PHY after this. */
 	if (!dev->info->internal_phy[addr])
 		return 0;
 
-	return ksz_pwrite16(dev, addr, 0x100 + (reg << 1), val);
+	if (reg < 0x10)
+		return ksz_pwrite16(dev, addr, 0x100 + (reg << 1), val);
+
+	/* Errata: When using SPI, I2C, or in-band register access,
+	 * writes to certain PHY registers should be performed as
+	 * 32-bit writes instead of 16-bit writes.
+	 */
+	val32 = val;
+	mask = 0xffff;
+	if ((reg & 1) == 0) {
+		val32 <<= 16;
+		mask <<= 16;
+	}
+	reg &= ~1;
+	return ksz_prmw32(dev, addr, 0x100 + (reg << 1), mask, val32);
 }
 
 void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member)
-- 
2.37.2

