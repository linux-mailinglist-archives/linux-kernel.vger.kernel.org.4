Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A26AE5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCGQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:05:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E57B11A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:03:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h8so14576362plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678205030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7hLcya3bsLv//yf0JprtSrDFewhrMQT5YQLYtI/Y+8=;
        b=HhlJAwr8DqmGWUQSQKG77Mn/Gh6yYYR1j2fGKcMErDoLU/2WO4w78tvQGmo8qzz+Bd
         z+vLe76wWlESF6KvD5zv8SeC+NAvZI2OhNtVa9jLuWq4nDxOG0mZ08GuWIQ40j0ve47d
         wCNyjXMH15KF/Lpl90NsfZWOhDLQT55jBjeZV/k5txBnAGDsY8KeEu55sl6W4ZjYnJzp
         PJilrxuNUwsZ1en+/W/K3Dx1Nuza0C8iW4/1LFjiIRH4BesAKN2JMUmORh0abKLxfa8O
         9FUU+5gIIQldomfJ4kYWMctWkgmHx1rBLoa3jLT643ykt0S5GIx5oKwqmS3Exzn5j4tf
         xmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7hLcya3bsLv//yf0JprtSrDFewhrMQT5YQLYtI/Y+8=;
        b=6aEoTReDOEU07fi6+LPFviwSgmw8irLwYkX/JpobGkcNmuGeg4Ruq/5PJHFmEn0okr
         6ZBfc1krUn6QG/O7qnWS6MWBc3RCsWxj8uIw2ASkgMXnkWK8e04ouyjxb/EeJld+4Hb1
         Ob0oZ4vuzSIXIsEyeRecwpADzc1kDS4AJtWJN0+WDaow08f/2IqKhRvM9+NJ0C3XLu8r
         kE4TCOitmHvLOvpLNxuArmO0imhICeF4i4XUWyvNON1jEYFLKtjL4BtTjRWu2BG39lT6
         r2BSstItHUtTO4Xz+xyWXzujtO/NuUA/LVInxHQ8gxBc+ANd1+v+PCMmPM7yafPSsi6A
         jSnw==
X-Gm-Message-State: AO0yUKVP0XmW6dYf7FNQucS6tPbN9BSyOuVe0hBow3NM/my9NGQCMYai
        M5w8x5WDUDH13thAqsW6kefbOQ==
X-Google-Smtp-Source: AK7set8Q11G93VM5gWqdl9WiAdklDxZlW9kQBcrDhnVNMiGKZchmSzF3+ndLqHk5ffFXVnShE9uXAA==
X-Received: by 2002:a05:6a20:8e0a:b0:c7:af88:3c8f with SMTP id y10-20020a056a208e0a00b000c7af883c8fmr19601953pzj.25.1678205030119;
        Tue, 07 Mar 2023 08:03:50 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m3-20020a635803000000b00502fdc69b97sm7900009pgb.67.2023.03.07.08.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Mar 2023 08:03:49 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, snild@sony.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Stable@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] maple_tree: Fix the error of mas->min/max in mas_skip_node()
Date:   Wed,  8 Mar 2023 00:03:40 +0800
Message-Id: <20230307160340.57074-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment of mas->min and mas->max is wrong. mas->min and mas->max
should represent the range of the current node. After mas_ascend()
returns, mas-min and mas->max already represent the range of the current
node, so we should delete these assignments of mas->min and mas->max.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f5bee48de569..d4ddf7f8adc7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5157,9 +5157,6 @@ static inline bool mas_rewind_node(struct ma_state *mas)
  */
 static inline bool mas_skip_node(struct ma_state *mas)
 {
-	unsigned long *pivots;
-	enum maple_type mt;
-
 	if (mas_is_err(mas))
 		return false;
 
@@ -5173,14 +5170,7 @@ static inline bool mas_skip_node(struct ma_state *mas)
 			mas_ascend(mas);
 		}
 	} while (mas->offset >= mas_data_end(mas));
-
-	mt = mte_node_type(mas->node);
-	pivots = ma_pivots(mas_mn(mas), mt);
-	mas->min = pivots[mas->offset] + 1;
 	mas->offset++;
-	if (mas->offset < mt_slots[mt])
-		mas->max = pivots[mas->offset];
-
 	return true;
 }
 
-- 
2.20.1

