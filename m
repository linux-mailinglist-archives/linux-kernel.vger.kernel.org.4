Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E7741902
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjF1ToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjF1ToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:44:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DD1BE6;
        Wed, 28 Jun 2023 12:44:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f957a45b10so39308e87.0;
        Wed, 28 Jun 2023 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687981447; x=1690573447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24xzpN7HM7t7BscRHE2SgUACQ+eIA8sq8IN33K3tmOQ=;
        b=WODHj/yYpYvcJQVjjp07mXGyIyXIxAnE1y3kleyMU/+wK0u6GzGJ5IYJvZ49WjJJXG
         hMixzSrwu9JbRf9Ujwch7ub8/obzcnE5N33y8jjIuOdKdQFky22pQKevW2CC6blz/Ma+
         bDIhm8XS56ISmfuFjV61BT/98AUOOJ0RQL1f8TWUrWdH+iYlmRdM31YeT0/jpX3IQ+V1
         vAIL9wjb6JMLeZskH77MSHE6qBmeXbHjZAPW/BPpKqmLVZqbjaJJL6VVjd2xZywH5CuW
         BJU28FW4UJoU6vnIOYtJ7G7jJosBSdg41eFJtcoexLU5AiBMGLg/lKdUvW7vpwT5G1To
         wg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687981447; x=1690573447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24xzpN7HM7t7BscRHE2SgUACQ+eIA8sq8IN33K3tmOQ=;
        b=EQxGEe643WO5b9lHbsOqIlplkJD9nWe3AjI38nntm4ahj8mogrHjKANXKRcSkl6jED
         6X3suw6YY967TIO9ZOGkr28kJDjCGUEDKVsOSE+4rweXVkdyPNgbxnTAWPEyG3pakXgT
         hEC1ggsnehln6gMyZSn/nBfgpllmoW1UOFJbIsZ2WmxlUkaoPY1w5X0ontO082T/8Z4z
         ANYCPIHjB1TTs2HdhaHTWToSmprI8Mj3bNXaB1juwTg0dgYglpcTS4VKIK5qu6YhaKQq
         no/qK3+qTnIJnAnOULxoE5JKwHsY8DWOQg/B1YtE7lEacAbDT1ZOlM18svhmwCH1k8yH
         fkpg==
X-Gm-Message-State: ABy/qLYQJ3IQbsRUBz0HUlUEmRC9GMJSHD62htFBP6XOLg2VUMgEqc+A
        2xcnAmJzrABRp4DgGieIopzIvYIGMSXDiA==
X-Google-Smtp-Source: APBJJlFSUHsJAN2mbCaOU0cBBFdkIkZMd/h4saQH5B9IruyRKs57bLyadu4DN0LdTjo8BOGyFmb8/A==
X-Received: by 2002:a05:6512:3194:b0:4fb:99c6:8533 with SMTP id i20-20020a056512319400b004fb99c68533mr85285lfe.33.1687981447038;
        Wed, 28 Jun 2023 12:44:07 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id q6-20020ac246e6000000b004fb915e8b93sm355434lfo.201.2023.06.28.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:44:02 -0700 (PDT)
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
Subject: [PATCH] net: dsa: vsc73xx: fix MTU configuration
Date:   Wed, 28 Jun 2023 21:43:27 +0200
Message-Id: <20230628194327.1765644-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Switch in MAXLEN register stores the maximum size of a data frame.
The MTU size is 18 bytes smaller than the frame size.

The current settings are causing problems with packet forwarding.
This patch fixes the MTU settings to proper values.

Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
In my first attempt, I sent it to net-next [0], but I was asked to resend
it to net.

[0]https://lore.kernel.org/netdev/20230625115343.1603330-7-paweldembicki@gmail.com/

 drivers/net/dsa/vitesse-vsc73xx-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae55167ce0a6..ef1a4a7c47b2 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1025,17 +1025,17 @@ static int vsc73xx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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
+	return 9600 - ETH_HLEN - ETH_FCS_LEN;
 }
 
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
-- 
2.34.1

