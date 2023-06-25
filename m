Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E073D0B0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjFYLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjFYLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:55:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516FBE48;
        Sun, 25 Jun 2023 04:54:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso12764271fa.0;
        Sun, 25 Jun 2023 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694095; x=1690286095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P92bWlxvLPvIdpok+J0oz+l7hsQ5ESNWmNXsRKJJM8U=;
        b=STvo+L/c9+EnsmIy2Q9jnhy6YYDwi6zoMcibgrPcSEQZ/aBQ8/zDHtHOha+wENbtyh
         5UpKnBR+3SU5/3C3AfNimfM4PjctTRUeMKhsY6+o+VPMFX/Wow3w/FfG3FgfuZY8fUnf
         8qLHgPd63fcyTfFWl0UHFqTCvrdkPGN4vTBC+4nFnkuhH2wCmYVjnPeZwazkiYoIvY4K
         ftlkFAcKW+gE9f924mujEyhGrhKJmrCVLpmwoNUhhZAsxnt0VMrixuQY8q3yCQlxk8LQ
         5mkatJ1fn3XdXK631rt4y7CdQ4hX3dm0xBrbIZiILOcE4YweosO7CmV2O8xtQcphr/DF
         vXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694095; x=1690286095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P92bWlxvLPvIdpok+J0oz+l7hsQ5ESNWmNXsRKJJM8U=;
        b=PZkzB5xnLjWSLIf0FOc25jXkOFRHEqIlNg3eyFrcYlDLBUngn9ifBxWcPk+u7pSpbc
         aG6HaUUtrpW2f4ZT/UQFpmpYKRwYdi7MPRT7AnvoL7kqgUzJoSUdhqmO3yxLtRV6IwKt
         c/5Hw1bA+jUIgisUuF6vQEjC9CUA/FNNAbx+j69JGNBHikb/5+N1abSgjIF+wvyOHun8
         JwEBh3bZoIMYTdDOlM4iDlhx/OcpKlBGUhRnuqK5+pRauEKOhN1MH4nemrzbFV2mN7tO
         7pKm3uKaC05JHYK0I3I51y5QTCfrlGXpZDO459UVsWJWK9q7PvkA2nFegQO7ec2I6PDq
         s6ig==
X-Gm-Message-State: AC+VfDwnZk0YgQ/Gbs4d+31zDrVRyJSnSVQCSIX+UT9fJEiCJnV3IMnj
        8H2WEaKLsK4yGRDWilbganmjCSHZitJ6oA==
X-Google-Smtp-Source: ACHHUZ5W5Q5IDS5hMK/BmnU3K/CHXC8OrnfQXZO4x1oulh718H1qzA4mObooRGJsOIlXPFLgLlKoZA==
X-Received: by 2002:a2e:9d59:0:b0:2b4:6e21:637d with SMTP id y25-20020a2e9d59000000b002b46e21637dmr12426985ljj.35.1687694095170;
        Sun, 25 Jun 2023 04:54:55 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:54 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net: dsa: vsc73xx: fix MTU configuration
Date:   Sun, 25 Jun 2023 13:53:42 +0200
Message-Id: <20230625115343.1603330-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625115343.1603330-1-paweldembicki@gmail.com>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
MIME-Version: 1.0
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

Switch in MAXLEN register store maximum size of data frame.
MTU size is 18 bytes smaller than frame size.

Current settings causes problems with packet forwarding.
This patch fix MTU settings to proper values.

Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - fix commit message style issue

 drivers/net/dsa/vitesse-vsc73xx-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index c946464489ab..59bb3dbe780a 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -979,17 +979,18 @@ static int vsc73xx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	struct vsc73xx *vsc = ds->priv;
 
 	return vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port,
-			     VSC73XX_MAXLEN, new_mtu);
+			     VSC73XX_MAXLEN, new_mtu + ETH_HLEN + ETH_FCS_LEN);
 }
 
 /* According to application not "VSC7398 Jumbo Frames" setting
- * up the MTU to 9.6 KB does not affect the performance on standard
+ * up the frame size to 9.6 KB does not affect the performance on standard
  * frames. It is clear from the application note that
  * "9.6 kilobytes" == 9600 bytes.
  */
 static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 {
-	return 9600;
+	/* max mtu = 9600 - ETH_HLEN - ETH_FCS_LEN */
+	return 9582;
 }
 
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
-- 
2.34.1

