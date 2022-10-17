Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50732601199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJQOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CFC67C99
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:53:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a67so16368678edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhVV/J8FqMZJSl3JLrYPvHzM0WqDA/VczwIl8A3roZY=;
        b=ogcKAH8XXSikjmWWNA8FA8ylFT1NMJBrvD1RUcvZWQm53rDA4FtXlvNMZIVaSTYQ4M
         +qDz32Mm1JI3x4O4Ta0CjRyBgsZWeluHSnvgFZGvIkLd4qUNp7V8PrOnOjvUOhYSY8L/
         OYDjRXUxmULH6fXf3A1wGOCe/PBgEfInhwihJgSFXN2wOsY8JgAnezknwog6io8H7LAh
         QWIS+4yiTgS3chhDacf7LfeBd/r96CaHWGz7xM1vBOKUw++sMO6uEpRlhXV3nTFLyLa/
         /xkdXZYQcc99OZtmnlMq8D6GkMbPjAGVRobdqno07ubP73j088+7Ojwh+OOr9CiGPUMC
         Z6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhVV/J8FqMZJSl3JLrYPvHzM0WqDA/VczwIl8A3roZY=;
        b=TPzNN3VDuaXS4lDvVzzBg3GHbEvsKMwSNkZBqOv79o5cS9DaGfVXLFn9j1DYd7gQwE
         N/aw5vc8r3c6SFT7gepArqxchDJvN1SSZYezS7kPKRzxKHC6kniWk+IhoAj1Sg5695In
         bAlXmcadQ2eJfQMl85BzbatfixRgXOiHPKSSL4VhbEZlGF1WlLT+kC96m15ZQlKPVLa8
         RJncLwnehL2brSWNHFxjFftG/fn6uBazclTFEZVNUeD1Og9LGo1GQJEwKFZ2BgpxzudZ
         2s1MIlfyPwhllIWmQYu++YyrRbzlXaTocj0/xBYHnOXN3hQCFHrP9FTmnWFi3fi8iOks
         cUgw==
X-Gm-Message-State: ACrzQf1P8VHccTTqv5glQ4cc8tBt37Jt0CohHkBTIV0ilU0ahTxbEsyX
        O2l1fdIu2T9wyFOQx0fKcclf4mw2sRwMZA==
X-Google-Smtp-Source: AMsMyM4wjpBDWpJSk020Zp8p8/I2eF2XTpW+sczRo9STwoPma9N/cCIxw3UXvVpCdpBEFih9qi0cfA==
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id eb11-20020a0564020d0b00b00458a2444e99mr10679974edb.46.1666018378864;
        Mon, 17 Oct 2022 07:52:58 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b0073c80d008d5sm6084809ejb.122.2022.10.17.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:52:58 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] llist: Avoid extra memory read in llist_add_batch
Date:   Mon, 17 Oct 2022 16:52:26 +0200
Message-Id: <20221017145226.4044-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

try_cmpxchg implicitly assigns old head->first value to "first" when
cmpxchg fails. There is no need to re-read the value in the loop.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 lib/llist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/llist.c b/lib/llist.c
index 7d78b736e8af..6e668fa5a2c6 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -26,10 +26,10 @@
 bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
 		     struct llist_head *head)
 {
-	struct llist_node *first;
+	struct llist_node *first = READ_ONCE(head->first);
 
 	do {
-		new_last->next = first = READ_ONCE(head->first);
+		new_last->next = first;
 	} while (!try_cmpxchg(&head->first, &first, new_first));
 
 	return !first;
-- 
2.37.3

