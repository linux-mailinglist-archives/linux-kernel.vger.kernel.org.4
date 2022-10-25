Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0F60CBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJYMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJYMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6D17A959;
        Tue, 25 Oct 2022 05:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633C3618F6;
        Tue, 25 Oct 2022 12:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14463C433D6;
        Tue, 25 Oct 2022 12:22:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WO1e5oJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666700519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZKJWuEIeuKvDUZQNV7Smz75T6WROuu6Yr001YKXCbo=;
        b=WO1e5oJROkFlQEDo4omTNY1UKBt7//EgstbWIjEpSV7b7Mvf3s5U/yAGhB84jeo0QDl699
        jQgzD0XB6RKgkOff4bTSHpB+dz//GusPzz50WqYg+JBH78qH6ePZiDfAdXliafi5uk/RKn
        q3or7vKA/mdYQBKkK1HeeWGk2Nas1NM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ba7e1585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 12:21:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] staging: rtl8192e: remove bogus ssid character sign test
Date:   Tue, 25 Oct 2022 14:21:50 +0200
Message-Id: <20221025122150.583617-1-Jason@zx2c4.com>
In-Reply-To: <Y1e+SmS3O2ZaPVoe@kroah.com>
References: <Y1e+SmS3O2ZaPVoe@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error triggers on some architectures with unsigned `char` types:

drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'

But actually, the entire test is bogus, as ssids don't have any sign
validity rules like that. So just remove this check look all together.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Remove ssid sign test entirely rather than casting to `s8 *`.

 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index f9589c5b62ba..1e5ad3b476ef 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -439,7 +439,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 			union iwreq_data *wrqu, char *extra)
 {
 
-	int ret = 0, len, i;
+	int ret = 0, len;
 	short proto_started;
 	unsigned long flags;
 
@@ -455,13 +455,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 		goto out;
 	}
 
-	for (i = 0; i < len; i++) {
-		if (extra[i] < 0) {
-			ret = -1;
-			goto out;
-		}
-	}
-
 	if (proto_started)
 		rtllib_stop_protocol(ieee, true);
 
-- 
2.38.1

