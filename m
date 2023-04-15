Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDFA6E328F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDOQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDOQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:50:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89BF469B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:49:59 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nj64psmg4JwBhnj64pAfJN; Sat, 15 Apr 2023 18:49:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681577397;
        bh=PSevjxPblNgenbQKclhvbfNSF7IweMAlAYEf2CBuRgI=;
        h=From:To:Cc:Subject:Date;
        b=KKGBIGhD9lXBIwFZeZKGre86PbiDCK6j+Dc/9AfqcRqevTt08PxsIxkG0YWZBgALF
         m4swg+MURqZ4W3QDjAxj8djlx7WOggTXQcUsFcM/ZA5Xg1zXw5VioEk3+XN6FwjXLY
         rEgqcwnTTYsgO7WldbFrn5ppOtoOfNrV2c6bI7lkecNsjk3aQF/85YAoUyxZNw1uRF
         g/Hr3VeabifR3/dI5L7oe/cIjC6cFfZm6FUbbu8mePCtVmwX/hNOofAjndYipu8kKw
         sC7dYiDBPzz4JLOEE06Q5HBwwSjGy+99Gr5l7KL49hNOqNk6dDiq7l4bm1NhQKrsnt
         O0mQEbg9FaBuw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 18:49:57 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: rk817: Simplify an error message
Date:   Sat, 15 Apr 2023 18:49:55 +0200
Message-Id: <a9c0820c5af6b315ef3b3c2fd8d7be44008b0086.1681577370.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/rk817_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 1a2143641e66..8328bcea1a29 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1134,7 +1134,7 @@ static int rk817_charger_probe(struct platform_device *pdev)
 					    &bat_info);
 	if (ret) {
 		return dev_err_probe(dev, ret,
-				     "Unable to get battery info: %d\n", ret);
+				     "Unable to get battery info\n");
 	}
 
 	if ((bat_info->charge_full_design_uah <= 0) ||
-- 
2.34.1

