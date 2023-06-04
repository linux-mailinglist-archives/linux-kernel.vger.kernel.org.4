Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996672183C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjFDPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFDPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:42:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D5D3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:42:36 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5psGqNLaQt9zc5psGqXS2j; Sun, 04 Jun 2023 17:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685893355;
        bh=KSBCYH83xSlnxT9AqAr79v1PKm1DqpwXR0ggzhv2kFU=;
        h=From:To:Cc:Subject:Date;
        b=ZnL1ytK8458koQso49BCpWyOcEi755OnD8/aYZ70UWHbQUaXQ+XkwqFZLGG5+hG3Z
         yaXTsYtK78QlhCXUpeznPk5AA2jU+eMpncJPkdKMUeAq8OcE53BPbyQ+T7f6CiQ7YP
         zaQ6Wn66OPz1XYNoYQZH1LfM5PZRmm/Xg+BUaWjIxN9fHA97i0qZD7zpcpg7E+8+LX
         UULF2+Wtpp9xj9ZFJyAa0pMqitEleMxEPKAUnIVNlsEpfr3PmbaXLiDiLnHrLjkNkk
         Z6TIBh6/JrK674jq06KhMIcKUqxWNsn5aFWtT93SOOx+NN4lk8Ao7QlFbeKf9msp5Y
         m4SnGCinLe35A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 17:42:35 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Helge Deller <deller@gmx.de>, Imre Deak <imre.deak@nokia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Helt <krzysztof.h1@wp.pl>,
        Juha Yrjola <juha.yrjola@solidboot.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] video: fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
Date:   Sun,  4 Jun 2023 17:42:28 +0200
Message-Id: <f17221571f619c0829db56354f2b74d22f6702a7.1685893329.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'mipid_detect()' fails, we must free 'md' to avoid a memory leak.

Fixes: 66d2f99d0bb5 ("omapfb: add support for MIPI-DCS compatible LCDs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index e4a7f0b824ff..a0fc4570403b 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -571,11 +571,15 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	r = mipid_detect(md);
 	if (r < 0)
-		return r;
+		goto free_md;
 
 	omapfb_register_panel(&md->panel);
 
 	return 0;
+
+free_md:
+	kfree(md);
+	return r;
 }
 
 static void mipid_spi_remove(struct spi_device *spi)
-- 
2.34.1

