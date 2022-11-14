Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B37628274
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiKNOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKNOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:25:51 -0500
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 06:25:50 PST
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097C332;
        Mon, 14 Nov 2022 06:25:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668435040; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=apHDiiwYXYvUFTkgwJPwrDjZkNQQhU5pRiqQzE0P654pbcKIQIxavf6mnse8OtdS1Y23dX3VkSc7ig46Uo3C0ka+VQJ4FCzYE4SCWwRaFonmyK7TUF0J4lxLQ6YqkJRTDmGC7lvDb+BuKDAcXQAKu16732aED+2nlJ3dqQ30xxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1668435040; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Obamzi7+h416URfz7TCOzXR/hOBh/eTAtx+Zw3J7MNk=; 
        b=fa7qkLlgeEvgoiwJzHaMiUiv1o1VZgA2BGxmSmP+VrTShLD/tzeUG5AWUme7LQZ4UtN4OuGsogYnRrsgWWPxl4MQFWe8TIsEU0fQ01HodgXBSdrf0TflJy6wj46BNZcCikztU/1ivhrpVE4f08ZZ7pKiNlffIo0zzpG2OYtR75A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1668435038060533.7770069828593; Mon, 14 Nov 2022 06:10:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 06:10:38 -0800
From:   Elijah Conners <business@elijahpepe.com>
To:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-pm" <linux-pm@vger.kernel.org>
Cc:     "mszyprowski" <m.szyprowski@samsung.com>
Message-ID: <184767a4f60.d9a0c3da334147.3171681720569322283@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] drivers: undo simplify POWER_SUPPLY_PROP_ONLINE
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the work done by arturo182, the value of max17040() with LiPo
batteries will always be 1, even if it's not connected. This is
ambiguous and setting the return value to 1 presents complications for
anyone working with LiPo batteries, and does not result in significant
overhead.

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 drivers/power/supply/max17040_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index a9aef1e8b186..5284f2bf735c 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -217,7 +217,8 @@ static int max17040_get_version(struct max17040_chip *chip)
 
 static int max17040_get_online(struct max17040_chip *chip)
 {
-	return 1;
+	return chip->pdata && chip->pdata->battery_online ?
+		chip->pdata->battery_online() : 1;
 }
 
 static int max17040_get_of_data(struct max17040_chip *chip)
-- 
2.29.2.windows.2
