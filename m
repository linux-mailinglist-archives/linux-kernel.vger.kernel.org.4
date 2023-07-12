Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7F7505C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjGLLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjGLLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B54173C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0586176F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2981C433C7;
        Wed, 12 Jul 2023 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689160583;
        bh=g/lPF2Q6+m6/l+Vx14cbdCbMEjLRayxLuCbkQ3L/E34=;
        h=From:Date:Subject:To:Cc:From;
        b=JXmeMNc2ZfRO6RJZHPsaMPpw6zfp/m2jhTAOPuPnx23tpedMf5elkyZ4AQ0Z37GYB
         gk4ykvYRNzG80qHVGNsLKDNZ9M7kbfw9BUl3MO18Se8TmOgCb5Tz8kuA7P1D6636bV
         lUvg1awyEPzaVgxfkFQX4E6OUwz2Av59zviDD/iohxxvRonT/cNFMkNtBtDibot5qZ
         mV3oPsrOjwMhy/4XECSAMWh84G2uY++VmZBAjRNQDUrmYPVz5zRvjiradMN2BJFea+
         ZGcOWFNNgI6iaobJFp96Pk30IkdMVwgs0y6Pd2DkipiNMDCvnOv2qsxbQl7PHGWMXP
         HS6lWtK/j3lUA==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 12:16:16 +0100
Subject: [PATCH] net: dsa: ar9331: Use explict flags for regmap single
 read/write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH+LrmQC/x3MPQqAMAxA4atIZgP9QbReRRxCjTWDVVoRQXp3i
 +M3vPdC5iScYWxeSHxLliNW6LYBv1EMjLJUg1HGql4NGPlCupy1GhOHnU5Uhv1qvCbqHNTuTLz
 K8z+nuZQPul2Sd2MAAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=broonie@kernel.org;
 h=from:subject:message-id; bh=g/lPF2Q6+m6/l+Vx14cbdCbMEjLRayxLuCbkQ3L/E34=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrouDI8NOyrqsGzEeJY8gLZvKVkGeyDh1eRn7D
 gnHa3W5eNaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK6LgwAKCRAk1otyXVSH
 0DrSB/9YctZRnKrg48Um3Nbv5sWzZro0vuiwu8xyWEE9gd03Ohv61ZKNzHw95j2r6EbV9ICcNfq
 X3VNlijIZStMAl7QDEPia74ODIozDSk7HTVHmLOFWYD79LpNxmvuyq8KSTFM1eHDQdxT5NGMTnr
 ab1iPhE25QqfZzvTrtWO7vnhge43bJsYu49HNcp0i7iWhcrlU1F0dpjXzykI8MZE/N6ogUE0+dO
 0T6Rk520nmTuu5a4IaYjHK9b0bHGRgy7syE4wXK3syPspVDs8WTg8LqQzj57kgFK6wAVlVqg62d
 CzsNwXfT4Ksa4fNMlM3X5n8M+zBFk0uUhP9XJ9UrQxYuKU/0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The at9331 is only able to read or write a single register at once.  The
driver has a custom regmap bus and chooses to tell the regmap core about
this by reporting the maximum transfer sizes rather than the explicit
flags that exist at the regmap level.  Since there are a number of
problems with the raw transfer limits and the regmap level flags are
better integrated anyway convert the driver to use the flags.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/dsa/qca/ar9331.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index b2bf78ac485e..3b0937031499 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -1002,6 +1002,8 @@ static const struct regmap_config ar9331_mdio_regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = AR9331_SW_REG_PAGE,
+	.use_single_read = true,
+	.use_single_write = true,
 
 	.ranges = ar9331_regmap_range,
 	.num_ranges = ARRAY_SIZE(ar9331_regmap_range),
@@ -1018,8 +1020,6 @@ static struct regmap_bus ar9331_sw_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.read = ar9331_mdio_read,
 	.write = ar9331_sw_bus_write,
-	.max_raw_read = 4,
-	.max_raw_write = 4,
 };
 
 static int ar9331_sw_probe(struct mdio_device *mdiodev)

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230708-net-at9331-regmap-02ecf2c1aa59

Best regards,
-- 
Mark Brown <broonie@kernel.org>

