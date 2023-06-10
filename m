Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4572ABF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjFJN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjFJN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5073A8D;
        Sat, 10 Jun 2023 06:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5CF46179A;
        Sat, 10 Jun 2023 13:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4ACC4339B;
        Sat, 10 Jun 2023 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405559;
        bh=5l57cI7jkc52r50JcXZZD4F9M596Z9aSvVS5JrHnoV4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CliqY9vRUuthQ5LzyxOBIGgo8MatrnW1jSOmptCa+vAFTSEQRbOgstbW6HMXiPFMq
         ohG1zM/hbNcGkFcmymeMmVn1ImsvK84AHNc/kPijWP5EovW+aWYtNJ7AELzkJpaJdV
         rxHB/tB9QFetxx1ZzCwbZs6nVcAa7dUB8VDpANMaobOpAMo4Swb2ks7opVUl8poNdY
         hZzwiyP2H+YYb4nxXfq835gdeNwaoP1AcIKuMeyN3xxdFR3KK98I3zgO+JP62SwRvF
         huOaJl28bJAyKgk/YB4SSupcYb3QBsxPcA5wZbBAifL2K7ekF24B+x97aOblE3Uybi
         XpMC3iiOaZJfg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:08 +0100
Subject: [PATCH 2/5] hwmon: (lm95245) Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-hwmon-maple-v1-2-8edacce86b28@kernel.org>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
In-Reply-To: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5l57cI7jkc52r50JcXZZD4F9M596Z9aSvVS5JrHnoV4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGvUVs2g4WIkEpOp6p1b7hDvZSwzbjPjaZYR1Zg
 YSigMx2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBrwAKCRAk1otyXVSH0Ll/B/
 wKUJ0OFkBeu+ZKS3KERZxP8xC1SQzF4pw1we9DVxTS4XgI52zDsnASrUPvJ0yABBYZA/6HWy/3nNDj
 x2yRrqgWVuQTwEr6cSWH57ml+I70GdnXWpmIv+/fUNxa92+unebOGA6PKncolc0U7AwC+SYDSJMaP5
 5gYBpE+OIa+BZLjiq1zmbVcMnNkcliWx0DymW5DVZbhDW0+5sRC3LVwcvt80pSbqwcdcQo7lVzXc7t
 oFN3JjWWUney6RLq5M1hnVLp7RUNWBGAP9rwduCsgIEmvBf20xDA+fYnx8njpwKpFgT5I2p8qqrpBc
 brG0aSBm5jLMexTQMGMNHWiw+X0w8K
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

The lm95245 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwmon/lm95245.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 4236d1e0544d..a7dc84e997f1 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -518,7 +518,7 @@ static const struct regmap_config lm95245_regmap_config = {
 	.val_bits = 8,
 	.writeable_reg = lm95245_is_writeable_reg,
 	.volatile_reg = lm95245_is_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.30.2

