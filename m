Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7165BFD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIULrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiIULqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:46:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F595690
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j24so6154037lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KBC4n7oWzkTEp7l49syMVK2MtMfoljE2pLWVkSUsJt0=;
        b=cLI04QQDrnEii5mcgBRkJD92HGxTm/c57U5vILXvr/Ay3GzZv5d3PH5AQgA5g7MkjX
         rGdtSXZz+j14nbM1bNwyfi/JwR98MQ984Ul/eDrnPrhDSd3I+S4ugUUqc2Uwi5IJEP8O
         +EAAyLhe/V3O7hMwtruzO3dGKpHYkUmysY5iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KBC4n7oWzkTEp7l49syMVK2MtMfoljE2pLWVkSUsJt0=;
        b=TI6qAJigP/mTOouAXkgYYpBXJYjyiM5f7bbFdoShUWTe3r1iGGUrgw6aaPUZzgtKcl
         OL1egExUjS9TbFwUN1aUYzu04+GS0KC1r6sJqCJcO9fTda4cCJt2A0GBZprbw8e3NrXL
         jFJoMHoI9E9V9iqwGdhc3TUNecuvluOa0xbExL+8goXIh5ovHypVcWJdafIFr5TZZ4gW
         QAyulQ12OpzMQCjiZEEj8F46eFu0LtIKZ7fIWHwV++9ztbHMygV11jzFfdV6VdorviBO
         gbL7RtzwgEX9+oC8ilCo3ZrdTDXmTmH8GZPlbRU64feN11d84OZTfq3ztpOHNLTXIA7b
         VNHw==
X-Gm-Message-State: ACrzQf2SWs6Z9sE6CmTUZLFaKmFDaVqqaTScT5aF9zXfHumsCqxBayUR
        L/uPiP9SBM+P/kQj4ei08Xo3/SNlBpnIrW3Q
X-Google-Smtp-Source: AMsMyM7zz6magFFPeGZp4KTAakylZUbXWhn84Q39/+/bKO6XAJqwjbfS0xoLJG9fwNE30HDFlpBKww==
X-Received: by 2002:a2e:8349:0:b0:26c:4311:9b84 with SMTP id l9-20020a2e8349000000b0026c43119b84mr7168500ljh.152.1663760797228;
        Wed, 21 Sep 2022 04:46:37 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] rtc: isl12022: use %ptR
Date:   Wed, 21 Sep 2022 13:46:20 +0200
Message-Id: <20220921114624.3250848-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code and make the output format consistent with other RTC
drivers by standardizing on using the %ptR printf extension.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 7efe23fa74df..d396d6076db5 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -141,11 +141,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(buf[ISL12022_REG_MO] & 0x1F) - 1;
 	tm->tm_year = bcd2bin(buf[ISL12022_REG_YR]) + 100;
 
-	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
-		"mday=%d, mon=%d, year=%d, wday=%d\n",
-		__func__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 	return 0;
 }
@@ -158,11 +154,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
-	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
-		"mday=%d, mon=%d, year=%d, wday=%d\n",
-		__func__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
 	if (!isl12022->write_enabled) {
 
-- 
2.37.2

