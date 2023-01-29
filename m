Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D667FDF2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjA2Jn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjA2Jnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:43:52 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BA23326;
        Sun, 29 Jan 2023 01:43:32 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A38ABCDE1D;
        Sun, 29 Jan 2023 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674985371; bh=R9ZNv09De8WL7qrMjmRnJkXWIPy46lSI3OBIO9SIMXw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ivN5DlAay/Hh9eYY92OY3MiwQqPK1AZ7vS/IK61LJjgNMI6thBRPgHCA5D2b+LGxb
         NCP0ts+2Ma8ytP9ZE8hebnc0y2dqimIG9T1O2LB7pBlym9mAsv//tZwbr8Tv2F2zez
         96/JiNP5DRVYD1P0FPccJPzeXtv3wLVLO9bQL0pI=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 29 Jan 2023 10:42:35 +0100
Subject: [PATCH 1/4] media: i2c: ov2685: Make reset gpio optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v1-1-f281bd49399c@z3ntu.xyz>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=R9ZNv09De8WL7qrMjmRnJkXWIPy46lSI3OBIO9SIMXw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj1j+Xi0vA9+m7kad3e3/xYUSgehrk6D7zWpUwkTFv
 iITbT3KJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9Y/lwAKCRBy2EO4nU3XVoIVD/
 983IJ5BCQZ0Uw820dThLSGKfcgcUMb1aHUe5yyai4hN92eHKNAfpkEN9h2/xtYCW8CyTfzEci07FYv
 eONEJWos9uWfzxoC4juKEhAJ70KMPOicze6zCVX+c5++oEht045JWULh/9rjM+Sk2qHalWwOHTlQ+H
 N6FKv7Ya1eJtzzhvr5SuOf0DqpF+NXcqQmVKtmAQ1BuvAo1LV+PGDWElLi9lvOAREJmRelQMMScgtS
 nKJPSdGI+jvd+hER+/qTvvbm67Q6GSi7YsnFKUIcgFFe72yzqQ5IpEARyPpKqqcZ3y4E4nMU/NLYrz
 bWO4JtHyAM5866EX81uL5JYoziFPSgq62Exf7Fa4FdgUuieAMAD8ARKg+Muz/2yH5CmvlkH71VuvTh
 sp2MLlk9ekO4bPGVSJUkLUXU5Fd75XSiDxCnk0DZAis+nnDJNHAcjgZo1T1rdzbu5iwh2fWh5qT8P6
 /oqjc49GMZljZxcVNFMeJRmrXGkjgb6hJgCPYDv7vhP7483tr+qNeyll/h8eJrtVzfakw8xll78lGV
 +kD2QuDihaxxWxXwI5cZHMOzuptkpo5NM9jPEHYGE7pKKzBDX9IH34XmymTO7TfvEcNobxkt8UnqHf
 ZSZ4R4C8RXog4eSqzxviCtVhPEHd+KVCsttRqp/rrOl+C1W6nSjYBMJyJHLQ==
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

In some setups XSHUTDOWN is connected to DOVDD when it's unused,
therefore treat the reset gpio as optional.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index a3b524f15d89..a422f4c8a2eb 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -734,7 +734,7 @@ static int ov2685_probe(struct i2c_client *client,
 	if (clk_get_rate(ov2685->xvclk) != OV2685_XVCLK_FREQ)
 		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
 
-	ov2685->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ov2685->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ov2685->reset_gpio)) {
 		dev_err(dev, "Failed to get reset-gpios\n");
 		return -EINVAL;

-- 
2.39.1

