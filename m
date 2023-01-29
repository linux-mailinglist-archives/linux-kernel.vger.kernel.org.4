Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D967FDEC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjA2JnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjA2Jm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:42:58 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E206EA2;
        Sun, 29 Jan 2023 01:42:53 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DA49CCDE29;
        Sun, 29 Jan 2023 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674985372; bh=fIplo9JpImpQeisw7bapzCgXeb9xPVwhFZKge8ht7KI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=PAjFT6mwjS3L63nLMj10WYEUkN6ll5AQt/IXGx9zhBGCAMY7TUoZiYvqDmZ8eeJhX
         rbF8T3QfrTBf8d/CNrsNSuKi73B+OFlRqJVSXMWbF3gg3m8nhNv+gRUPxA7UHez2gJ
         G05jw65ZTIAMg/zrkpfTy7pIpkOU9OLfrlUlOE2s=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 29 Jan 2023 10:42:36 +0100
Subject: [PATCH 2/4] media: i2c: ov2685: Add print for power on write
 failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v1-2-f281bd49399c@z3ntu.xyz>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=fIplo9JpImpQeisw7bapzCgXeb9xPVwhFZKge8ht7KI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj1j+YkQM6n+QsokVKigwFK5cBsCkYGjl+8gx6I8bu
 mnqR84qJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9Y/mAAKCRBy2EO4nU3XVtWbEA
 CFHa4eVdFWJ8fw5jhJA6GUKKjvGnkKmp8SPepUjCxRSp9SWvzZG4B+Am4tgUAjz303KwyiYd4CEetP
 Qhd5pPtPWmq+lxt39gc7nltKjLAwqktTtOrH3F3gytBi9+6cozRA9BFxlNknhGXWxa8ipGge41NC0r
 01OIpLD+LWRCMUdUs8XzzOV/3+M5a+Yk0z7vNPM7b/IZvwyjIF3Q3VUM1PgJi4rX/71+ZZQJtByJUU
 oY0NJRMThJmIWu9ez69YQI5f8jtuLE+0o4yiuTEyFH7/ShdILqfmGMeBn+H0UFASF75p8DSonirkZr
 +67nc3SR15+azeZPYP7nChALEaN+nW7nv5u5a2keQ/AVAkKyEV7pgm30+Or1Aa5UivFQirbTdod951
 7S1mwnCj6Nh7Z7pOynxvP1F9+mRUj54sWiMmCUqHay1SP+ZuvmJghCnWgkNe7YdJKXuec7UMqK3LKj
 wHgDqsC00j7L+bcg5yWDIUfqvAgv7dethCmvKqSAPYZTHqt/vJSGeCMs5C1OrnRM1yIfgOjUoNUeKQ
 mpg82wl6evHnTZVKYYQJP1QOZvDb5LcRomULoVjeCyn2czk+s5H241OgvHlq2SYEufGsj8yKtqTpZ+
 zwsXfkNdfS7Cm+JfgRUaTP+w/KXWS24yarh5RKm1LLCwcxN2p8C0YdFmASLg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sensor doens't power up correctly, for example due to incorrect
devicetree description, the power up i2c writes will fail.

Add an error print for this situation.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index a422f4c8a2eb..844a91dbc8e5 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -419,8 +419,10 @@ static int __ov2685_power_on(struct ov2685 *ov2685)
 	 * writing register before .s_stream() as a workaround
 	 */
 	ret = ov2685_write_array(ov2685->client, ov2685->cur_mode->reg_list);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "Failed to set regs for power on\n");
 		goto disable_supplies;
+	}
 
 	return 0;
 

-- 
2.39.1

