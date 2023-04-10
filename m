Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43206DCD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJWjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDJWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:39:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6091BF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g5so9090090wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681166346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2w9r/FCSQOhLas4fRq9UxlUyxuMVk8X58MVQxfpTJY=;
        b=qgUiirriVGu7ZTWcizKlhTrvCVkKMTVcuahYo/fWk86tr/5Mgb2EeTrIDJ0GjBvcCW
         JiQrRDBs2nv+Gp54bItYKqJOqXu4v5BssEQSHsFTu/NR2/l0TY4pKKWBf/6BWoNsMxO0
         Li7LYx6r9FzhoPFoXGvrqt+0IcJ6RqFGtcJX7L1ZDoy3fBYGyPgotTfJKh8WdMj5UWnI
         CwaEyVqz/CPyu0rFJ9FPZp6CnWr5hcLaPT/rlOYJyexpe9buQN+llXpnXzXBDWbrddWG
         +X1x/12gIpo8wsaM6riuoH9YxVkne2OwgpmQB/zOFdhe4uJINP+IJ135yPVjBypp93oK
         0A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2w9r/FCSQOhLas4fRq9UxlUyxuMVk8X58MVQxfpTJY=;
        b=mB4QSGGBGtuJtAYopC8YD236oqXTUIvvqf9FFqtX2r/wKpUOjmu1fmnNPQKYUew5V2
         HoCLrGF6SeYN1X6xPTv4AyK24+UWiIwbALPA+NzzlnNzJDpQoWjGu9nRG6my3tsSBQco
         DFnQj7HsxXiLqJTgaPoFlJ62BEsjaUT4eC4BRWafsEkhNAuhmeUEbIilfK6DbTtHaX/i
         2FMhwWBuQH5Sv86ijIZrcVuPlS8FWT2bHXCIXjyhf4vBhfzv0QAKRbQbWiS6LQw+poz/
         gOMWnViJgvVbscOZANqACy9Nvnh7rCXR39s+vu70Ex6XhCXEwQHcQ2M60aCq9Jm6gERx
         DcXg==
X-Gm-Message-State: AAQBX9fzVahe1COWSJK5IDwrLXwU1qsnKm2gpInrsxD6ROyStFj+0QQ3
        WOXJiW30MbXlZtWLg4XibgsAAJJ6HRwlHg==
X-Google-Smtp-Source: AKy350YR9fr6IYcnFe1oSanOl6H+YPUhDRizE112VA61/3/A/9UbnKcTLtOq4N8oFX8K3PspiyZPBQ==
X-Received: by 2002:a5d:61c2:0:b0:2ee:c582:a67d with SMTP id q2-20020a5d61c2000000b002eec582a67dmr524431wrv.31.1681166346742;
        Mon, 10 Apr 2023 15:39:06 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id m14-20020a5d6a0e000000b002f01cb41b0bsm5093614wru.60.2023.04.10.15.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:39:06 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/3] ASoC: cs4271: flat regcache, trivial simplifications
Date:   Tue, 11 Apr 2023 00:39:01 +0200
Message-Id: <20230410223902.2321834-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Switch to REGCACHE_FLAT, the whole overhead of RBTREE is not worth it
  with non sparse register set in the address range 1..7.
- Move register width to central location

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/codecs/cs4271-i2c.c | 1 -
 sound/soc/codecs/cs4271-spi.c | 1 -
 sound/soc/codecs/cs4271.c     | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.c
index 0e8a7cf0da50..4033be1c3bc1 100644
--- a/sound/soc/codecs/cs4271-i2c.c
+++ b/sound/soc/codecs/cs4271-i2c.c
@@ -17,7 +17,6 @@ static int cs4271_i2c_probe(struct i2c_client *client)
 
 	config = cs4271_regmap_config;
 	config.reg_bits = 8;
-	config.val_bits = 8;
 
 	return cs4271_probe(&client->dev,
 			    devm_regmap_init_i2c(client, &config));
diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.c
index 7ef0a66b7778..4feb80436bd9 100644
--- a/sound/soc/codecs/cs4271-spi.c
+++ b/sound/soc/codecs/cs4271-spi.c
@@ -17,7 +17,6 @@ static int cs4271_spi_probe(struct spi_device *spi)
 
 	config = cs4271_regmap_config;
 	config.reg_bits = 16;
-	config.val_bits = 8;
 	config.read_flag_mask = 0x21;
 	config.write_flag_mask = 0x20;
 
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 2021cf442606..188b8b43c524 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -689,8 +689,8 @@ const struct regmap_config cs4271_regmap_config = {
 
 	.reg_defaults = cs4271_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs4271_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
-
+	.cache_type = REGCACHE_FLAT,
+	.val_bits = 8,
 	.volatile_reg = cs4271_volatile_reg,
 };
 EXPORT_SYMBOL_GPL(cs4271_regmap_config);
-- 
2.40.0

