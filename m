Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3660680C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJTSQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:16:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E319A237;
        Thu, 20 Oct 2022 11:16:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bp11so302551wrb.9;
        Thu, 20 Oct 2022 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYS57kbtnP2/fRI2CTwvWkjaPlMYUwgmjlFT7Zs/ZZ8=;
        b=Z7ga7HW9P3XtQeUJAm9VHZlcx5ER8rXy+Mu6Sj+WRJCboJ2eMU0FEgUV1ZSCEmJwHm
         UkwLVrpUSO2ImZb71U9MmoZgA8YtgjlVcgl71iFZhCeVrXsrLNLfbVJ6PgJOyhX+6FbK
         KfFQSxnlyadPPCljWSd2pJu5gzbEOHpOiy3iDE0L9zHjNuTkN+exeScMwDxaC1a+pQ1W
         Oy5i0dcKfGdiVpftrHAh2aKP5OG/iUulNVyBdDZwOrxMgr5nDu0aP8G3/MGAmkdUNSFy
         ym+Mx9X5URnFecDnt6tnb+0m51JCRC4nzm1EjCMXrwYx6SN2uwqBQUQReV5b4Pt0Pmqs
         FxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYS57kbtnP2/fRI2CTwvWkjaPlMYUwgmjlFT7Zs/ZZ8=;
        b=CcJwXbfGhLYYnMg55WOAvwqFu7TMw5R+VWyHT1KrxmSqfUJbesx5VPyu7hYUhN74L+
         eonU+wFOE/eRN/zr+nRozZQcz4ZQwYjigqawKHSgG5tqYqM/ggUgzzfLRmbQUkIgKXuR
         XsgfhjHHFSxaJbQlmpTAMJNu5OYDBnqwcK8PHJh+dGEdba6RwUb61O3P08HfOJJMimEY
         0QpAf5YsGaQidLenY/xHVB1eTAiH1muRyXkHg0g5UXw8qSH27SGX8lquj8db8B+K0a9c
         WPvqdCyZNCZT0NvWMftRILIbKkp999iEzjFqzXRhWNY15QkP0IqW5flIE1rMccgK9A3v
         jl7g==
X-Gm-Message-State: ACrzQf3iY0XcZmJJnXsY0RHo9PsIiOoy5izxHA5K8z8+VkgGVKt0sKSH
        MT+SqzVUfd3m9MpPAe5VsKRxJlcM8XbGEEYg
X-Google-Smtp-Source: AMsMyM7Tso9oo87DGyuobdDUbONRldLQHNzQyOTlX6prD5GyV/YlaPvggr2XUQkIFgo5ZpSUq5LbBw==
X-Received: by 2002:a5d:6a0f:0:b0:236:39b0:1346 with SMTP id m15-20020a5d6a0f000000b0023639b01346mr2642043wru.131.1666289803806;
        Thu, 20 Oct 2022 11:16:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c15d500b003b4e009deb2sm239548wmf.41.2022.10.20.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:16:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tps6507x-ts: remove variable loops
Date:   Thu, 20 Oct 2022 19:16:42 +0100
Message-Id: <20221020181642.24417-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable loops is being incremented but is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 357a3108f2e5..f48871767763 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -119,7 +119,6 @@ static s32 tps6507x_adc_conversion(struct tps6507x_ts *tsc,
 static s32 tps6507x_adc_standby(struct tps6507x_ts *tsc)
 {
 	s32 ret;
-	s32 loops = 0;
 	u8 val;
 
 	ret = tps6507x_write_u8(tsc,  TPS6507X_REG_ADCONFIG,
@@ -141,7 +140,6 @@ static s32 tps6507x_adc_standby(struct tps6507x_ts *tsc)
 		ret = tps6507x_read_u8(tsc, TPS6507X_REG_INT, &val);
 		if (ret)
 			return ret;
-		loops++;
 	}
 
 	return ret;
-- 
2.37.3

