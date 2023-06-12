Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0872B98B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFLIBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFLIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:00:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2A270F;
        Mon, 12 Jun 2023 01:00:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so29112835e9.1;
        Mon, 12 Jun 2023 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556805; x=1689148805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV/mTXh/P+HK/c016dPT2W6UYy5AOVr8uOiiran4liM=;
        b=iegb2sJEV3NxeCdapW3bJRcA1eMQwKPGmzwuDTZNSQfK5LD346pv98ahxHWsYQi5z5
         8vQHXORB+U9t/y9OSzfIBADoE8m7k8Rt3lMUCqlPfcc3gYcJkkP+xtn24kVbPq+eQaeR
         x4aGnONQQiYSxxKmcABMILnaTJUIt2tDpkAPF4OyHS/pPQhuTy/BT4GfsDowD2bTbomC
         aLkNafaJC5nexOEDu2mKYbhp0nFv4AshOWODck7ACWkzkDzZXToMzVaIryaO+bjRA3gl
         w3msHvZhDcsPphd+OYLTQ/0aGruy0jekDhdqXCgmnJAgdD0ri1TjKUhMtuZclBFjdnQS
         CJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556805; x=1689148805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV/mTXh/P+HK/c016dPT2W6UYy5AOVr8uOiiran4liM=;
        b=C91aHbBKdUhtv4cX3eb+l1F6HbcBRLRZSH4BNSO45ssDifDtMup8wce2L4+Nd61ITS
         xz6K2FhynOGbdiqHKMdw3LzYFwrPOiCQzBAF9BsuXPeEGCgqe/KxU5bRs4iwK7ylbbVQ
         2e0lfqp3/xUbR6rpHVksZdZGMIiHV9tAOSf8x59fc3Bu99J4Gg/4AHTbf/rDN4zaz63z
         8Dj/oexSlNRllHRArvAhXefuUDw6GR+E3aOPim3CLVoef+77Cgo2MHeMOfUekQvKi4eo
         d73it2zSh16S03qWi0Xbf+AF+a4hAE4207OS55y7LrQwMJ/8zcL+TZsRcB+v29NBlQXr
         HxEA==
X-Gm-Message-State: AC+VfDxk02Epl9u9aLAXlk6hriCzrMX1xU/Um197BcJIvJOZhSfgjlrG
        nOJXVsRFbiU6kWWGEzKlJvI=
X-Google-Smtp-Source: ACHHUZ5N4JqPmARx5C1YV6jCq0GelWy/qhgBOWDGYmH4WNy2BrUQp8UewzQTisD53HoZe0Yuveq/3w==
X-Received: by 2002:a05:600c:2212:b0:3f4:23b9:eed2 with SMTP id z18-20020a05600c221200b003f423b9eed2mr6563679wml.38.1686556804733;
        Mon, 12 Jun 2023 01:00:04 -0700 (PDT)
Received: from arinc9-Xeront.lan (178-147-169-233.haap.dm.cosmote.net. [178.147.169.233])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm10552195wmj.5.2023.06.12.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:00:04 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
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
Cc:     Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net v4 3/7] net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
Date:   Mon, 12 Jun 2023 10:59:41 +0300
Message-Id: <20230612075945.16330-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612075945.16330-1-arinc.unal@arinc9.com>
References: <20230612075945.16330-1-arinc.unal@arinc9.com>
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

The check for setting the CPU_PORT bits must include the non-MT7621 SoC
MT7530 switch variants to trap frames. Expand the check to include them.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ef8879087932..2bde2fdb5fba 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3073,7 +3073,7 @@ mt753x_master_state_change(struct dsa_switch *ds,
 	 * the numerically smallest CPU port which is affine to the DSA conduit
 	 * interface that is up.
 	 */
-	if (priv->id != ID_MT7621)
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
 		return;
 
 	if (operational)
-- 
2.39.2

