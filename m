Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D972ABF9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjFJN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjFJN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D133A8D;
        Sat, 10 Jun 2023 06:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 389926179A;
        Sat, 10 Jun 2023 13:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E8DC4339C;
        Sat, 10 Jun 2023 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405560;
        bh=aKWsL4ECyqcmN6JQLOkqn2y3wjAwvw15X4tmDYG1cmk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Or3v0zE4LVnq4+lIz22hJSzEQGRwvH+DUjoo834Qh9W8uTnRV0XGI35NHN4EZ6BRV
         5HN41BKPw9Dp4ZhQ4/y5rB/gbgWOLEqU6zr+iV5fcXnzXlxrPKw4kUlKHcrCrzxfMS
         OakdL34XnU0XPrS3XKgF8xWSdISp5mZTSe8SIQDonk7PC6NM5BrJjKhmM9JSD96CY1
         H6C9E0m0xVK6pIaY0tI2Ei36eTSU6fPlEHqS20D6aCw4Q0OpwmosbAquNs0Rbcntjc
         JaS18np8nSOSnZIuqnlfYvRk+4wtz/UOsPLrJ3MOXr2BObFvbAMVw6IHyAfleUAoO2
         EDxkkHlOL/3LQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:09 +0100
Subject: [PATCH 3/5] hwmon: (tmp102) Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-hwmon-maple-v1-3-8edacce86b28@kernel.org>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
In-Reply-To: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aKWsL4ECyqcmN6JQLOkqn2y3wjAwvw15X4tmDYG1cmk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGw+Wu/kMGPB79DzCuk8i1ecoP5dwc+GusPmpHI
 2IvFaIaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBsAAKCRAk1otyXVSH0ATZB/
 0R+IoB3Ea1JwMNtY0T5G3gOk9yj/NOkMgDg6lN6drA1N6j1Iov0nssWcnaXpkh4ZBF8psQ3UMfe/Ez
 kHSGxOGuguwVuSzEYSLS791+v+lRvrMFMtGIXW1RD8ZrysYPcoinzQvwiPsWmL1FL9da58wiEpolV7
 ZOEXJ5z0GbCcS9KrBQhghcqHBv8MM8nvpiEKSnlAMWxnmfHIIvsQWwXvLwhIML1/2S75p4lEvRZyoY
 TQJ+L3cO2Ia7eMvFkMB1nE0BLxY0ntoGF/fp8MV1zuFjjkDVc3kxf2YpyNR/hSaq5rY7LLGdwuhRtd
 hbEI6CxmeBK103FTGZWCyCZHp5T+9U
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tmp102 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwmon/tmp102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index e271556efe0b..9563e1328b74 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -184,7 +184,7 @@ static const struct regmap_config tmp102_regmap_config = {
 	.writeable_reg = tmp102_is_writeable_reg,
 	.volatile_reg = tmp102_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.30.2

