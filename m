Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7174AFCB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGGL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGGL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:29:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC31FF7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:29:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fba86f069bso2808497e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688729352; x=1691321352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/IkVrANo5V+6KbogXND3G9qj24ymppZG2x92JBd8fA=;
        b=TGbDnU0V5OSi5aJv5zVgszPi8eMlDFMVf9JujSQeTOFLfRZjFWRyXjL96K7HHyUPa7
         u6uUIxvCcUfnavDyCyJgg4AlVQAx3RVh1pZcMUAj76czksVmsSfEMg/umAxxSmBPPk7/
         +3+YtNg3EQJ3WeL9POTfwQd9SCNfklXlVd1bFhVI7Z0tGXBvbv0nd3V1jRl8/iNZCKYW
         oQnEZJ1IKZTBmn9YU89qFdNZp32Wype2e+0s8vjZMdGGGW3QgIikvAxOhsb79Wv3eOag
         WYq50K7Occ6UTIn/YzpFxf8XV8HJjc853NQYhiLTx+haiEnu5UAd7UWv2kz6IYTG4gPL
         cUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729352; x=1691321352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/IkVrANo5V+6KbogXND3G9qj24ymppZG2x92JBd8fA=;
        b=lA4Ja8gqJQzV3Zu3pMldZt/qKN075TBnCbS8uLocHT3zVOpqFxnZhzH/J0I6XpAB34
         btgDFKYdV/0tuAbXQViVkD131NURiQG6QnLQF7bivA31OFn2mY3ha1AzIMkDe/31RUCj
         R3tFIqiVT5YPWZd9NnUU3LqY+dRM/SwcRwDiiu4dMuTke5BO7w7A0OuWJEnv+OTbHoik
         O9+EVX+bMKMGBHYhwHzZg1jUEFcj9Yz6u340LhvP8ZPER3guE1uGqX3aY3x5RSN+KSmO
         AtgbsmdwKmIH/YYB/94y6dgVwjzidxh7AAhPpNLByAyCDYWcEP11+H0WdgV4LdZAbULE
         6E5g==
X-Gm-Message-State: ABy/qLZl8FppCQ2rcyAupiwjk2RJ8ANswhLK0xlXf2dHRGHQNyFD3Gsa
        Fjb/uq/2uv6a/6XNJqfFZCrwIg==
X-Google-Smtp-Source: APBJJlEXoytbdsvnJ6LABV+dK/wkY3qxuE2U9JcLRiBBgON5XUBntE5iUeTQf8zFf0+1ZxlJNu8+XA==
X-Received: by 2002:a05:6512:78c:b0:4fb:835a:8486 with SMTP id x12-20020a056512078c00b004fb835a8486mr3652176lfr.32.1688729351869;
        Fri, 07 Jul 2023 04:29:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4ed0000000b0031411e46af3sm4198260wrv.97.2023.07.07.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:29:10 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:29:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bus: moxtet: uninitialized data in output_write()
Message-ID: <ce0c38ef-0300-4633-a82e-1327eb7ae7ba@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't check the return from simple_write_to_buffer() to see how
many bytes were initialized.  The only thing we can say for sure is that
the first byte is initialized.

There is no need to use the simple_write_to_buffer() function because
partial writes are not supported.  Even if the user passes in a
different value for *ppos, we still use dummy = 0 as the starting point.
So replace the simple_write_to_buffer() with copy_from_user().  I
added a check for if (*ppos != 0) so that it's more clear that
partial writes are not supported.

Fixes: 5bc7f990cd98 ("bus: Add support for Moxtet bus")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The simple_write_to_buffer() is not simple at all and creates a lot of
bugs, but the nice thing about it is that it takes "sizeof(hex)" as
an argument.

However, the "len > 2 * moxtet->count + 1" means that we can't overflow.
And if moxtet->count were wrong it would lead to issues later anyway.

 drivers/bus/moxtet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..42453518400a 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -513,16 +513,16 @@ static ssize_t output_write(struct file *file, const char __user *buf,
 	struct moxtet *moxtet = file->private_data;
 	u8 bin[TURRIS_MOX_MAX_MODULES];
 	u8 hex[sizeof(bin) * 2 + 1];
-	ssize_t res;
-	loff_t dummy = 0;
 	int err, i;
 
+	if (*ppos != 0)
+		return -EINVAL;
+
 	if (len > 2 * moxtet->count + 1 || len < 2 * moxtet->count)
 		return -EINVAL;
 
-	res = simple_write_to_buffer(hex, sizeof(hex), &dummy, buf, len);
-	if (res < 0)
-		return res;
+	if (copy_from_user(hex, buf, len))
+		return -EFAULT;
 
 	if (len % 2 == 1 && hex[len - 1] != '\n')
 		return -EINVAL;
-- 
2.39.2

