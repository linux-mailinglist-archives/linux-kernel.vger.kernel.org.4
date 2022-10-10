Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A45FA452
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJJTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:47:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27C5245F;
        Mon, 10 Oct 2022 12:47:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f9so14381144ljk.12;
        Mon, 10 Oct 2022 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAk45lvdMHJqkvDklkuRT7/4DO0ZDJi7M0Bz6hxlLqo=;
        b=PGnRVNt2Qlo/0D8HazGQTpRYD4WY+6Vu8rT8pxLldsfanDXUuPpz4iwGSB9mg9G8WS
         wORr6RAWEoDE0iUvjPIYrK+IzP4o0TfrErmVlgsPdUHZZhv3SjPmJB3HfJXO8KNhra0A
         uzPX6jIbBtPEBU+KtxAQ0UPWQuzecH6i0lJ0rzhQKFhIW1FsIqmPc6+OtrQIEF9CBJSc
         BValavp+JJV9Dc8+tn5kTSbVapo8dKW/mk7/ItruRTiQQipRJFFEbfpcfVKSeOXePCom
         IhA5fsxEJ1WVqdJmCf4GJ8ZCeoFXS7+5MirP43VB21slbwX0hqWB0TGudQnX7w7UL5Hm
         egOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAk45lvdMHJqkvDklkuRT7/4DO0ZDJi7M0Bz6hxlLqo=;
        b=VTYjiMWpjz0VO69pL3L7+X9XLeFq0xZxwB2rYiQ9t1pDrhORXlkd1D4D3nkIHMDl+W
         8yGJyk93iC7NJukD4r+Udpv6DnnWfLK5G3G3U+zQnXAitgKRH5pkpS72HWWZPTEurKdH
         hFqQl/4WjrfIAqovd2y1g9x+YUEYmQvbJ6UHXLn3Q18s5JFJMvs5ll2HnDQ9iQtEYoiO
         7yIg/cmkH1ysF3pWprqF/EvBnJqqXAwE0eJskOfrNk/hfZrj2ecyD/ltdvRzXYR2rv4P
         AuS1Ic6qwMj+5TW9Bh7PKQC1rdbE7bN4mbk5Fqe/kojikXMH/dJ0cJpIuTV4IenfRqbv
         D1qQ==
X-Gm-Message-State: ACrzQf14/0XGR/uXh4V4iwCNyHa60BuNtOOxlwY7ZPnAnF5od/8PGbOv
        W5rCs2DnU60lajZDNhDI4GA=
X-Google-Smtp-Source: AMsMyM4qxSQM+MdqG9uy9SuTj6+lBSRBInXcCXGqVKWqQw0Q40m4PpNUN1t3XJ+NjDn3jHUKOvebbw==
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id m4-20020a2ea884000000b0025dd8a2d18cmr6911644ljq.305.1665431218817;
        Mon, 10 Oct 2022 12:46:58 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v19-20020a05651203b300b0048af397c827sm1525780lfp.218.2022.10.10.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:46:58 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3911: mask out device ID in debug prints
Date:   Mon, 10 Oct 2022 21:46:54 +0200
Message-Id: <20221010194654.676525-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Device ID should not be included when printing register.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 2c1af11a621f..a71df9f3ab29 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -59,6 +59,7 @@
 
 #define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 6) | (1 << 0)) & 0xff)
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
+#define MCP3911_REG_MASK		GENMASK(4, 1)
 
 #define MCP3911_NUM_CHANNELS		2
 #define MCP3911_NUM_SCALES		6
@@ -94,8 +95,8 @@ static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
 
 	be32_to_cpus(val);
 	*val >>= ((4 - len) * 8);
-	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
-		reg >> 1);
+	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%lx\n", *val,
+		FIELD_GET(MCP3911_REG_MASK, reg));
 	return ret;
 }
 
-- 
2.37.1

