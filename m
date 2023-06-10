Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBD72ABF2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjFJN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjFJN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB843A8D;
        Sat, 10 Jun 2023 06:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2532C61780;
        Sat, 10 Jun 2023 13:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A0BC433EF;
        Sat, 10 Jun 2023 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405557;
        bh=r2nZ+Dp5sLB+eA2+ktaJ93Xu1HnbfaQUAPVK/Aud2iE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nUx9mJ4eUlXfKpFAatGtm+sNNM1mf5QQloEupuf9ddoeAY2eCPA+r5fKhW35vjnH6
         NPdgyRVk1a4uW8H2LBrXVTXzHwBCQU+E3fSPQ3o6WTMZftkf+6iWW8RqrrkqgnU/H6
         UuRimpEb8ohhwIwBLlJ4g63BL9ILE064JWZahTAS3fXwy37jzhYnoenLXV3Qusc2jI
         uVgw5fBEs8Dlzsgoh5u5TJl/k17p5wMJliCA5N4lAxdZ+6wEn5kfMM3C0t8HN0d1P6
         zaKOScarcEQiJQWJIeWfvwtWNTBXe4OsuLHi/CvHpPdMoFKvbNQO8OVyiaSA0ifOBN
         McLs+vCWBqtXA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:07 +0100
Subject: [PATCH 1/5] hwmon: (lm75) Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-hwmon-maple-v1-1-8edacce86b28@kernel.org>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
In-Reply-To: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=broonie@kernel.org;
 h=from:subject:message-id; bh=r2nZ+Dp5sLB+eA2+ktaJ93Xu1HnbfaQUAPVK/Aud2iE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGuxKafR5J8kRn/CCg71JhC2O2o3IhKMIxFtTwP
 MmKmSA+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBrgAKCRAk1otyXVSH0BZDB/
 wJDok0Ddrw5mpOlUX1+wCJxWxRu9mdEdi2H9gkKz0ng6HcP7byldpJJlWlmEKM/yudAUw+65GzQyc9
 Lkvlz80FV3n7KEOkJ+TVEBf+3g5YiDIivT6bFySeXck0h54P/F5ocpJSLIu6yU6qFb68FdF4xm9ksx
 S/Q5rMzF+/M8O22+kmexktizPvOvBaz5Fs4AgXUoVbgXYUrO5yPzIWnBgxw3Xzl3WcWf08o/vbwKIe
 XDcJDnoMN4zlrT/fQMp+o+gohtP8pqPwjDZadrqfIEDXjL4yTOub5nAl1w9kO1MYx8sCKX0Ri509fs
 rpmw7GXVpZvD3g66pmsuXCsM1jXfb1
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

The lm75 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index dbb99ea4a0ec..ab73b9af5c71 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -548,7 +548,7 @@ static const struct regmap_config lm75_regmap_config = {
 	.writeable_reg = lm75_is_writeable_reg,
 	.volatile_reg = lm75_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.30.2

