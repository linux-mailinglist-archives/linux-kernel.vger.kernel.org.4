Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5042370BD63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjEVMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjEVMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:18:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139E1BFC;
        Mon, 22 May 2023 05:16:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f50e26b8bso750867466b.2;
        Mon, 22 May 2023 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684757803; x=1687349803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOz3FMLGe/kTMEltMrvKqCCw9Yz4vcJ+Yr7EPAljZ3I=;
        b=fuq5xMh5QeKKUpQOPlVevL5RMj4Mdz0Tk5r/V+Yu3p+xhEmUXAbcglm14LFiiF9VlS
         S8kjR8VPmtEjfEZuv2ABY/Cn1QBNbs0pmScOZRUoUkY5bL3jc9EIW97xNRwrdv2e3IZh
         C+1GKM1j59M8cTCOLX5xnIm3V01MVJ86dxgj+t0daNrMcr0MfFD6hLcdqxp0wv8waVwx
         xqGzWNFwug5vjs4zIdeqAPPIYL+Z+vj37Q+Tqtaw9kd2t314MoyTxwtbtDH1r2AHyt4s
         Gl8gpcg+p+JD1dbJgx5Oc9vpulqPvih5H/D2gy8Ld/Gxz6OnUKycO7JBzzgD8aHvIoq8
         hrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757803; x=1687349803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOz3FMLGe/kTMEltMrvKqCCw9Yz4vcJ+Yr7EPAljZ3I=;
        b=G7IDO29YMOmB8N4y0pNEp2f6luPslhjZAN7jDYM9Aeb8Xs3TA9204dEepPRtIJUihq
         w0lLHNjKxTrnF8E29iAsHEa9VJAIyksznNcMzHhqLai9SC2t683EpX9RTwcI502Gf/Og
         1TQj+hwut47XL75zNFMzkv6sNg9jVMN2LVL9+qUrhzzNXMjCtdAE06HeaR8a/R+U9xDx
         Jbq+lx57BNBFCpjAcJWur8Xe5KIWtL5riIwZSibDgbhkST88Z+6HCfJ6ZMCAxe4oVTnU
         j+TRNrQMGSt+PuRB2MC1/YemU6S6uJwoZWCYinuA5s065dIviOn8nnu2ACKJbjgF1ULx
         F+Yw==
X-Gm-Message-State: AC+VfDyrxEtZQlR+eSnUTNqhrxXpR0xTrC2V++dSptO3AVk/esuJLNEs
        R+PfNGtIP+QQRKB7JiPEBWlIfR2f1XzAq1Bv
X-Google-Smtp-Source: ACHHUZ7axMa1F5LzzMgJRwk3Tc7YfoPBpyFJ6l9vcFkJW1FELcAvedTGajpVnr2j57Ka8knzp60tYw==
X-Received: by 2002:a17:907:3604:b0:94f:6d10:ad9f with SMTP id bk4-20020a170907360400b0094f6d10ad9fmr9384418ejc.42.1684757802926;
        Mon, 22 May 2023 05:16:42 -0700 (PDT)
Received: from arinc9-PC.. ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090614da00b009659fed3612sm2999950ejc.24.2023.05.22.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:16:42 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 19/30] net: dsa: mt7530: set interrupt register only for MT7530
Date:   Mon, 22 May 2023 15:15:21 +0300
Message-Id: <20230522121532.86610-20-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522121532.86610-1-arinc.unal@arinc9.com>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Setting this register related to interrupts is only needed for the MT7530
switch. Make an exclusive check to ensure this.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 99f5da8b27be..0c261ef87bee 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2029,7 +2029,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 	}
 
 	/* This register must be set for MT7530 to properly fire interrupts */
-	if (priv->id != ID_MT7531)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
 	ret = request_threaded_irq(priv->irq, NULL, mt7530_irq_thread_fn,
-- 
2.39.2

