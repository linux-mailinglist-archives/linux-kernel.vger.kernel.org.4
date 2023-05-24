Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613FF70EBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjEXDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbjEXDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE9E54
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae4c5e12edso3553435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898007; x=1687490007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho+8AxwCMUO1UZDPlZ+RxzprWSmT0wiRibYRYtQid4k=;
        b=kvoX8rfQyN2AB0Gr43+8rZLVHFEmrrDTqutZAx5YmjW/kGuQGJ0PYvltnv5oe+C2Dz
         5qJCza00ybILWo0O75SnzamE/deaG5NaRNh5OG1IFwsc87i9gFW9INu037TjJF1yAJNr
         iKqeDs5Fp+AscJaCq4eKX+NBdfovr1pTO1C+zYi0UA+vOAW7Uvs4emRsWyygLkp27mAF
         Fbpqj8PxnSGvAO2m8iSuM2zxRZIZL0nARH7uV4WpbZ5mrUUSxTHDwmBAevUUz6oEWcPc
         IrnFnja7kLA1sl5ZZz0CUVqI6joBnhibcFuTnaVKHI+e0tnVt9HoS5U4VDbwvQOLyBDy
         AVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898007; x=1687490007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho+8AxwCMUO1UZDPlZ+RxzprWSmT0wiRibYRYtQid4k=;
        b=GrilAXFPEmLJMdshvD6+IT5nGfwZ5n+sF45Ycpic/wJJS9aihtu2IhOsuW9q5JjJYa
         cEEQ1CfN50yKBG0iqQczzfT8wtOJx3ygmJvQhi0H/xPPDzS987Fs1mF6bsjTAlFiTD04
         EJUvVgYd1k+T/k0ZZRORqoBpm7pGitmU4Vas0xOn4+FPQn4w+vDYHPoK7azfrAiTCPQi
         Ih6UmqJTYA3a0UNEyZn6JInKb8uySI4JYq+uGw2qXfm79mHKQDVnEDmyV0gzRecTW6X+
         2qSJNc+JbINxRCUMfr/x+mwUQEXfT/PZ5NK/12fh4mchnpYGKt1mN2skRvHuztaoh967
         QSXg==
X-Gm-Message-State: AC+VfDyQuF9jnSZBtr9j3zdC/F5QF2I4nUCJHr5Vl+PcqgyONHLgfwOL
        bBX4ETpFl3bA3IUvtsOj028mRg==
X-Google-Smtp-Source: ACHHUZ7oy2RxbbH2OVgkUE1oxd5jsYJ5LwKzXtkdSfTzpZc/wJao3zk8Xe6ywUfA6Pp9flLwKPR0+w==
X-Received: by 2002:a17:903:2287:b0:1ad:b5f4:dfd5 with SMTP id b7-20020a170903228700b001adb5f4dfd5mr19242735plh.32.1684898007229;
        Tue, 23 May 2023 20:13:27 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:27 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 05/10] maple_tree: Make the code symmetrical in mas_wr_extend_null()
Date:   Wed, 24 May 2023 11:12:42 +0800
Message-Id: <20230524031247.65949-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just make the code symmetrical to improve readability.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 41a105e76e22..e6e42e1ba44c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4264,19 +4264,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
-	if (mas->last < wr_mas->end_piv && !wr_mas->slots[wr_mas->offset_end])
+	if (!wr_mas->slots[wr_mas->offset_end]) {
+		/* If this one is null, the next and prev are not */
 		mas->last = wr_mas->end_piv;
-
-	/* Check next slot(s) if we are overwriting the end */
-	if ((mas->last == wr_mas->end_piv) &&
-	    (wr_mas->node_end != wr_mas->offset_end) &&
-	    !wr_mas->slots[wr_mas->offset_end + 1]) {
-		wr_mas->offset_end++;
-		if (wr_mas->offset_end == wr_mas->node_end)
-			mas->last = mas->max;
-		else
-			mas->last = wr_mas->pivots[wr_mas->offset_end];
-		wr_mas->end_piv = mas->last;
+	} else {
+		/* Check next slot(s) if we are overwriting the end */
+		if ((mas->last == wr_mas->end_piv) &&
+		    (wr_mas->node_end != wr_mas->offset_end) &&
+		    !wr_mas->slots[wr_mas->offset_end + 1]) {
+			wr_mas->offset_end++;
+			if (wr_mas->offset_end == wr_mas->node_end)
+				mas->last = mas->max;
+			else
+				mas->last = wr_mas->pivots[wr_mas->offset_end];
+			wr_mas->end_piv = mas->last;
+		}
 	}
 
 	if (!wr_mas->content) {
-- 
2.20.1

