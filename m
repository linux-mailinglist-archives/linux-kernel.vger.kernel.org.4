Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984527145EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjE2IDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjE2ICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:02:49 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B9CA;
        Mon, 29 May 2023 01:02:43 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685347362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqUKIWMaVniJ4Gjl5hNG4cyAnuaYWu6qgOZ97jOF9QM=;
        b=TlX157l9s11kbP1sDyHwtFGWPNrTYUZmZw+GTu9Cq729/lKYHEVQQUUBiy36b3JfIluibf
        Wd/DwxBTUdRdxvQJ0zAbhAvc8QpUQVQHzvW7TadUR4Umo6S06oohNq7DJEzPH4vfb4xYs+
        boJ2UP7Xg4nZUfzmQ8IDA52CPMgpW0LnfdMAI7Z4nca51qTM3gT+rkKn0qJuj/kZ2iA+0n
        TOV3SWQ6E+Ym5d6vI85Kyf1f8gINgnZZBaBvlMTvcBjpM/bq0pyQ1Yyht5rE856pj0so3d
        zHN5+C9vvm0mxaSubr7xJVFh5C/46zQsH7RC97o+uQr7f7lJ6gxZKnR/lcyiaw==
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD3D860010;
        Mon, 29 May 2023 08:02:40 +0000 (UTC)
From:   =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net-next v4 5/7] net: dsa: mv88e6xxx: fix 88E6393X family internal phys layout
Date:   Mon, 29 May 2023 10:02:44 +0200
Message-Id: <20230529080246.82953-6-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529080246.82953-1-alexis.lothore@bootlin.com>
References: <20230529080246.82953-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

88E6393X/88E6193X/88E6191X switches have in fact 8 internal PHYs, but those
are not present starting at port 0: supported ports go from 1 to 8

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes since v3:
- fix SoB
- fix typo in commit message

Changes since v2:
- add reviewed-by tags
---
 drivers/net/dsa/mv88e6xxx/chip.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c967259fcadd..d3d861e55fe0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6047,7 +6047,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.name = "Marvell 88E6191X",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 9,
+		.num_internal_phys = 8,
+		.internal_phys_offset = 1,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6070,7 +6071,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.name = "Marvell 88E6193X",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 9,
+		.num_internal_phys = 8,
+		.internal_phys_offset = 1,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6389,7 +6391,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.name = "Marvell 88E6393X",
 		.num_databases = 4096,
 		.num_ports = 11,	/* 10 + Z80 */
-		.num_internal_phys = 9,
+		.num_internal_phys = 8,
+		.internal_phys_offset = 1,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
-- 
2.40.1

