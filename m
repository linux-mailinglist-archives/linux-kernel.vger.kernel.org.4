Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB072ABF6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjFJN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjFJN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939F3A89;
        Sat, 10 Jun 2023 06:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0B8617A4;
        Sat, 10 Jun 2023 13:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99078C4339B;
        Sat, 10 Jun 2023 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405563;
        bh=nGgQ2U6sOgfurOnXkfOYxv8XjhCIq+uw7Nj7HixHdvs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iryQZ9JS/ZuDREToF7hvMh8qUd/wgp3JJQwmhOXjuRj0+JTjseQLuTHjU0bwFJsbL
         65UjY7B2GhR+Y9p+B32YOAcWZPEA9Eh76Km0FDcqA68CTAA0JrNmeJLSU7+Zf1PLA4
         +IrC1AMU9dlUUJfFtTfwXo44nGceQI8Xk0Ea0xTCInJiHvsJxOvRuK7mNDCvIDEdjC
         QaptFuXEC8viNTUMKCJaiZPJwHCE/hL+8Am2v8lsxH/Z7ENaxz3pNvRvbIl4g8qxeX
         rF8XltDvZ4kM2t8HzM57RkfXXN/0YVNlsiNrgSZCHyG7XPdXJko6tIk04tfj/UpxTz
         885gq0AFmYhBg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:11 +0100
Subject: [PATCH 5/5] hwmon: (tmp464) Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-hwmon-maple-v1-5-8edacce86b28@kernel.org>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
In-Reply-To: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nGgQ2U6sOgfurOnXkfOYxv8XjhCIq+uw7Nj7HixHdvs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGxbMjF6EKW5qf3MBUs6ZfaTqh4udP6TdzWdfEk
 OXeesUeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBsQAKCRAk1otyXVSH0LWQB/
 wNCS81zo1NKTu5Xwj7rdOPFGjgnn0WIGUzv208OZ6XkMSUm9yn3QdfHmnFE9zqpruZXXPbB5uXPhmv
 iQ3SDS0cV8Tg//SdpGljK/SbyNUux92yTfQoSY1EFtyaSjsSGwFVAz6guHK0ZxU/lf+lmoLIqlVkPx
 8AM/Kmp6reXoBEJmvFBDVXm0mRPzJavvPfR1OnuNzdbZfv3FteCb6u7C/ZMXdRTKSGTN970TAuvywZ
 967LfqQrq45gmmJDpFooK/t6foxbRtAOpgJ9b5oCB+7AxBFOwVO/ktJ3XQXfFzaDco9gIk56aPh+A1
 cGkNZhFE6NuNpQSJdP+M8DV0xGChHd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tmp464 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwmon/tmp464.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
index 9213a493a590..ef50f43d12e6 100644
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -644,7 +644,7 @@ static const struct regmap_config tmp464_regmap_config = {
 	.max_register = TMP464_DEVICE_ID_REG,
 	.volatile_reg = tmp464_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.30.2

