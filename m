Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC760B45B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJXRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiJXRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:38:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8893341F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q1so9036358pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K/W/tGQbEGTcjFYFF7obhZCetWTg/joFwdMrcbbg88=;
        b=h/ytl5e9/k/342yB1H8BeaL02HxFJn4GIfjrkkGet6ZLG4cPmCYS/DpaC6IXsHL+CF
         Dqi4snGmU88lbGI0yHxHTbbvOMuiht6icq3YEZzVWdCQhtsW7U7x/xCJt2ThlpE5kCpa
         Ai42HwHKaNshye+8lyPpeRjxySViQ+q8azKSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6K/W/tGQbEGTcjFYFF7obhZCetWTg/joFwdMrcbbg88=;
        b=Il9EaMoTwJSi+spYhN9sFPMGvPSEGGuAp/EmmwuCUAQPdcMO0qB8CCPQ/+AHEtKCFb
         M1DykAqNn+K3iICO/xbRqnLxu1ohN6im2Ftu3QGbA5x0GifybuKGGB/xuagFj0RdcSFg
         FnAzulVHwzi/49H9mPDM/dd3c8u5Rv09fPD/x/4Zk5Z3Jz0nVTGPE+n1JB4lAfZMmVHF
         rw9yI9m5BmVLfw2Kf4LRkk+qfaDFRm9VGfhkSBuzAVR+FCrG9AlXF6G877RP42CwS/a7
         rzlQEMwWzSYYiK+BQG7p4RpRUSUJZtqt1e4zD4eqNHY3U+A1EMR/nS3wX5tFoPnl+o1b
         FB6g==
X-Gm-Message-State: ACrzQf1PieDyh7a0bF+vn3cE24qzOaXmeVkT51KOWEuyT9d3D8tDrs49
        rkkcOn4DjtnFy9uGsc2cLvrmwqNJ3BGxHQ==
X-Google-Smtp-Source: AMsMyM6r66uB7r6D2ptdiXjTVDlaxnxa9zKkBZ7u4HiaYC5rYlVx5f3Cp2DY+F+I/EBCylyyXNBZBg==
X-Received: by 2002:a05:6a00:1799:b0:56c:1495:70bc with SMTP id s25-20020a056a00179900b0056c149570bcmr119687pfg.12.1666627961483;
        Mon, 24 Oct 2022 09:12:41 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:40 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 6/6] zsmalloc: make sure we select best zspage size
Date:   Tue, 25 Oct 2022 01:12:13 +0900
Message-Id: <20221024161213.3221725-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently decide the best zspage size by looking at
used percentage value. This is not exactly enough as
zspage usage percentage calculation is not accurate.

For example, let's look at size class 208

pages per zspage       wasted bytes         used%
       1                   144               96
       2                    80               99
       3                    16               99
       4                   160               99

We will select 2 page per zspage configuration, as it
is the first one to reach 99%. However, 3 pages per
zspage wastes less memory. Hence we need to also consider
wasted space metrics when device zspage size.

Additionally, rename max_usedpc_order because it does
not hold zspage order, it holds maximum pages per-zspage
value.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 40a09b1f63b5..5de56f4cd16a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -775,8 +775,9 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
 static int get_pages_per_zspage(struct zs_pool *pool, int class_size)
 {
 	int i, max_usedpc = 0;
-	/* zspage order which gives maximum used size per KB */
-	int max_usedpc_order = 1;
+	/* zspage size which gives maximum used size per KB */
+	int pages_per_zspage = 1;
+	int min_waste = INT_MAX;
 
 	for (i = 1; i <= pool->max_pages_per_zspage; i++) {
 		int zspage_size;
@@ -788,14 +789,19 @@ static int get_pages_per_zspage(struct zs_pool *pool, int class_size)
 
 		if (usedpc > max_usedpc) {
 			max_usedpc = usedpc;
-			max_usedpc_order = i;
+			pages_per_zspage = i;
 		}
 
 		if (usedpc == 100)
 			break;
+
+		if (waste < min_waste) {
+			min_waste = waste;
+			pages_per_zspage = i;
+		}
 	}
 
-	return max_usedpc_order;
+	return pages_per_zspage;
 }
 
 static struct zspage *get_zspage(struct page *page)
-- 
2.38.0.135.g90850a2211-goog

