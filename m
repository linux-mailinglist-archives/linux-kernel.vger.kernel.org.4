Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E246470BD73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjEVMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjEVMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:18:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477401FE2;
        Mon, 22 May 2023 05:16:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f850b32caso556726766b.3;
        Mon, 22 May 2023 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684757815; x=1687349815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4hNEGPM/k2Wei/lMuV138s3+HJRM8F0X5AH8IxuRIA=;
        b=fgTbTLbrzx4eo36no/L8MljlJBC1raKbuJH3jDHYd9gnY9AhIubXn/hHbnFm1TkYov
         rplpfCyGp1bgCgmoFg8GxDhr88mrhioacmZ2cH9/K59E6zaHJNIw6HVOXGkCnaMDmVHL
         IuKBK+g0SLZLZXW0tLFZ/Cjhbvq3/uGzlwd+drhLVd0mBTwzMLRFmyXPSkYNkoRANEo7
         Zr2zuRM1nrPhO1FZ10STqdJUhxFbt2TyLEDUf8uJJdeUqZCs1XEcm1oz1Q/ulHiUgIpN
         7jIDvc0F2RS7UanOrmUoIlX6kbkgozgyVfO9mCQ0+tf2XOEpf5jvQS4NZ2XWYIU1oWX+
         RNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757815; x=1687349815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4hNEGPM/k2Wei/lMuV138s3+HJRM8F0X5AH8IxuRIA=;
        b=ejsF6PdzbMKC0BI2yA/giOsmn8gMd1kK0h2J61B0OzDyaDoC5S5BE45rfnqlRm8uYE
         6izaJ9tMLRpT1nddKcOBj5Xt+qD6HHuWdyZ8oqmZXIaJHoM5ahYFgS81ZOiVDnWov3ui
         +Q4lPlCBVHJHc8azbfLrF0RESvtEn4Q5Mwxm7UPp0pOLBaQsvsauKX0ZUe7WD/N1JYzn
         fISOPNKTVv4OTgI/mOwaNOdT4RqlGGur0o2F2IlolvqIux/iX3Muy+Ts63Vb+LaTlAo8
         6YA+Nz4HZtFr3pp0bbxROhtP6HGNQD2FSDNLYmBRcc3G5iVYK6QHM7bzcFpcrg5D1vGX
         VMVA==
X-Gm-Message-State: AC+VfDy89cw/IhL/IBMgpNB9YjBqK3TSNhFYlRwxS3vrm8y+F0SCzbRD
        8rHfBz5TJmXZM3swr6sSSiI=
X-Google-Smtp-Source: ACHHUZ5m37/bUe5mAu+tGniN6yeCVXzYQceZL78+LqffaXJuXJdXrKLQp107cXJA8y5v2VuUCLVyAQ==
X-Received: by 2002:a17:907:60d4:b0:94e:c8c:42ec with SMTP id hv20-20020a17090760d400b0094e0c8c42ecmr10735915ejc.20.1684757815127;
        Mon, 22 May 2023 05:16:55 -0700 (PDT)
Received: from arinc9-PC.. ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090614da00b009659fed3612sm2999950ejc.24.2023.05.22.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:16:54 -0700 (PDT)
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
Subject: [PATCH net-next 23/30] net: dsa: mt7530: run mt7530_pll_setup() only with 40 MHz XTAL
Date:   Mon, 22 May 2023 15:15:25 +0300
Message-Id: <20230522121532.86610-24-arinc.unal@arinc9.com>
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

The code on mt7530_pll_setup() needs to be run only on the MT7530 switch
with a 40 MHz oscillator. Introduce a check to do this.

Link: https://github.com/BPI-SINOVOIP/BPI-R2-bsp/blob/4a5dd143f2172ec97a2872fa29c7c4cd520f45b5/linux-mt/drivers/net/ethernet/mediatek/gsw_mt7623.c#L1039
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 19afcd914109..9a4d4413287a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2197,7 +2197,8 @@ mt7530_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7530_pll_setup(priv);
+	if (xtal == HWTRAP_XTAL_40MHZ)
+		mt7530_pll_setup(priv);
 
 	/* Lower P5 RGMII Tx driving, 8mA */
 	mt7530_write(priv, MT7530_IO_DRV_CR,
-- 
2.39.2

