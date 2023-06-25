Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35673D0A9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFYLyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFYLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:54:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C717E74;
        Sun, 25 Jun 2023 04:54:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b466744368so33275421fa.0;
        Sun, 25 Jun 2023 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694087; x=1690286087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6QUBDRqa2Wrr4CQ5qPtzCdJP57iv7TLCuj/rtuOYPQ=;
        b=dk2KLS6Js8BYTMjIFK6RLM6Jxr02D5lf1hgbdwTvfH7L6x3QMcNi8bwZVJkIwFMogc
         kpcEkkLyqOOJ0UZMQPbz/kot0ibOC7h8tfuP3ynrJLm8tTRuLhQvwai6WEYeBQEW1sSn
         kzyBv0zKjM9aQdtn9W7E8mq/gftSHBCWvpw8UTCOo2xfilWLfhPJGyx0sl6lyjDjBito
         K8tc6Y+MDztbmwJhIiyHaPUs/GwycnYWMYzkBHFpxHlqA1fcxUUoGfLPV2VUTUvr2mvO
         0QIs9jEtLCBlronpOkQzghKBrpL7vYQmd7v2e4DQsDQaELecUu2u+NfQ5cYkhN5LL0mG
         nQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694087; x=1690286087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6QUBDRqa2Wrr4CQ5qPtzCdJP57iv7TLCuj/rtuOYPQ=;
        b=Kt6Brzihjmlg9nlRN2kLmIh8xX0LezXidxnNZpQBY4GdxSv1i1hgCUsnVO6LoYYC2o
         Njab4pyyuoIdJFPfOsviROhqM6R9CgZi0BA9Wi+5ahWyw+Sb3wTQZ1YnBmno3iplu9jc
         JvGlUjjJi0MPCgjgmMGc+rMdeZQ8reVtNGaiayYobm9uWN3VmwV9Gr+e4gOxysOTnyAc
         vJoukf/Zhm09zl2ddNOuTAMMi1I9tosk9OSP/ZOZmPBq7byTa2T8oToSZrJJYgqkziXu
         d/qT2kZmwDWn5v/MXyFq7BS/LKPOpfQHG5b/9HsDxKz/5LrqxxjODAA73X36jGf62cOG
         XUIw==
X-Gm-Message-State: AC+VfDz2xuR5aj0jeviHXrEbEyWwtRuzXRyPxLe7O8t1f669qewIyKWb
        euJfeNTRHk0Pt15Bjes+aCdQaH98oA6G9Q==
X-Google-Smtp-Source: ACHHUZ7+M8ECB7lsgkgBNWrO5HgnfjjxTOyiGJRySCO0rV4Hoc+QnZVXcDpOQIbRB4CIpYAJ4Odjuw==
X-Received: by 2002:a2e:9c82:0:b0:2b4:6678:da57 with SMTP id x2-20020a2e9c82000000b002b46678da57mr14500983lji.6.1687694087138;
        Sun, 25 Jun 2023 04:54:47 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:46 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date:   Sun, 25 Jun 2023 13:53:36 +0200
Message-Id: <20230625115343.1603330-1-paweldembicki@gmail.com>
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

This commit switches delay loop to read_poll_timeout macro durring
Arbiter empty check in adjust link function.

As Russel King suggested:

"This [change] avoids the issue that on the last iteration, the code reads
the register, test it, find the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait."

It also remove one short msleep delay.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae55167ce0a6..bea5ec7a89fd 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -780,7 +780,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -795,19 +795,16 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					1000, 10000, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-- 
2.34.1

